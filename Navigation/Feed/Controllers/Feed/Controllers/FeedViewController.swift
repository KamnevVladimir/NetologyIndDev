//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import SnapKit

final class FeedViewController: UIViewController {
    // MARK: - Stored properties
    weak var coordinator: FeedFlowCoordinator?
    private var service = DocumentsService.shared
    let post: Post = Post(title: "Пост")
    
    // MARK: - States
    public struct ViewState {
        enum State {
            case loading
            case error(FeedError)
            case loaded([File])
        }
        
        struct FeedError {
            let desc      : String
            let onReload  : (() -> ())
        }
        
        struct File {
            let name: String
        }
        
        static let initial = State.loading
    }
    
    public var viewState: ViewState.State = ViewState.initial {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - UI elements
    private lazy var postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show post", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(postButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var reloadButton: UIButton = {
        let button = UIButton(type: .system)
        button.isHidden = true
        button.setTitle("Повторить загрузку", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(reloadHandler), for: .touchUpInside)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .clear
        tableView.delegate        = self
        tableView.dataSource      = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "FeedCell")
        return tableView
    }()
    
    private lazy var imagePicker: UIImagePickerController = {
        let imagePicker           = UIImagePickerController()
        imagePicker.delegate      = self
        imagePicker.sourceType    = .photoLibrary
        return imagePicker
    }()
    
    private var files: [String]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print(type(of: self), #function)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Feed"
        
        setupViews()
        setupLayouts()
        setupNavBar()
        loadFiles()
    }
    
    // MARK: - Setups
    private func setupLayouts() {
        postButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        reloadButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        
        tableView.snp.makeConstraints { make in
            make.width.bottom.equalToSuperview()
            make.top.equalTo(postButton.snp.bottom)
        }
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.systemGreen
        view.addSubviews(postButton,
                         reloadButton,
                         tableView)
    }
    
    private func setupNavBar() {
        let photoButton = UIBarButtonItem(title: "Добавить фотографию", style: .plain, target: self, action: #selector(photoHandler))
        photoButton.setTitleTextAttributes([.font:UIFont.systemFont(ofSize: 12)], for: .normal)
        photoButton.setTitleTextAttributes([.font:UIFont.systemFont(ofSize: 12)], for: .selected)
        navigationItem.leftBarButtonItem = photoButton
    }
    
    // MARK: Private methods
    private func loadFiles() {
        service.getNames { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error)     :
                let feedError  = ViewState.FeedError(desc: error.rawValue, onReload: self.loadFiles)
                self.viewState = ViewState.State.error(feedError)
            case .success(let fileNames) :
                let files = fileNames.map {
                    return ViewState.File(name: $0)
                }
                self.viewState = ViewState.State.loaded(files)
            }
        }
    }
    
    private func saveImage(_ image: UIImage) {
        if let error = service.save(image) {
            let feedError = ViewState.FeedError(desc: error.rawValue, onReload: loadFiles)
            viewState = ViewState.State.error(feedError)
            return
        }
        loadFiles()
    }
    
    private func deleteFile(name: String) {
        if let error = service.deleteFile(name: name) {
            let feedError = ViewState.FeedError(desc: error.rawValue, onReload: loadFiles)
            viewState = ViewState.State.error(feedError)
            return
        }
        loadFiles()
    }
    
    // MARK: - Handlers
    @objc private func postButtonTapped() {
        coordinator?.showPostVC(post: post)
    }
    
    @objc
    private func reloadHandler() {
        if case .error(let error) = viewState {
            error.onReload()
        }
    }
    
    @objc
    private func photoHandler() {
        present(imagePicker, animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension FeedViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            let error = ViewState.FeedError(desc: "Не загрузилось фото. Вернуться к списку файлов можно по кнопке", onReload: loadFiles)
            viewState = ViewState.State.error(error)
            return
        }
        saveImage(image)
        dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
}

// MARK: - UITableViewDelegate
extension FeedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return .none
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return .zero
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch viewState {
        case .loaded(let files):
            if editingStyle == .delete {
                deleteFile(name: files[indexPath.row].name)
            }
        default:
            return
        }
    }
}

// MARK: - UITableViewDataSource
extension FeedViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewState {
        case .error, .loading:
            return 1
        case .loaded(let files):
            return files.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath)
        switch viewState {
        case .error:
            cell.textLabel?.text  = "Ошибка !"
            postButton.isHidden   = true
            reloadButton.isHidden = false
        case .loading:
            postButton.isHidden   = true
            reloadButton.isHidden = false
            
            let spinner = UIActivityIndicatorView(style: .gray)
            spinner.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 70)
            spinner.startAnimating()
            cell.backgroundView   = spinner
        case .loaded(let files):
            cell.textLabel?.text  = files[indexPath.row].name
            postButton.isHidden   = false
            reloadButton.isHidden = true
        }
        return cell
    }
}
