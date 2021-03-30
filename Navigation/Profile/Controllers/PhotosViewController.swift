import UIKit
import SnapKit


final class PhotosViewController: UIViewController {
    weak var coordinator: ProfileFlowCoordinator?
    private var output: PhotosViewOutput
    private var timer: Timer?
    
    private lazy var timerLabel: UILabel = {
        let label = UILabel()
        label.text = "Экран закроется через: \(count) секунд"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .darkGray
        return label
    }()
    private var count = 10
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PhotosCollectionViewCell.self,
                                forCellWithReuseIdentifier: String(describing: PhotosCollectionViewCell.self))
        return collectionView
    }()
    
    init(viewModel output: PhotosViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) in PhotosViewController was called")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "MemeCats Gallery"
        setupViews()
        setupLayouts()
        setupTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        timer?.invalidate()
    }
    
    private func setupViews() {
        view.addSubviews(collectionView, timerLabel)
    }
    
    private func setupLayouts() {
        timerLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.centerX.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(timerLabel.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupTimer() {
        timer = Timer(timeInterval: 1, repeats: true) {[weak self] _ in
            guard let self = self else { return }
            
            if self.count > 0 {
                self.timerLabel.text = "Экран закроется через: \(self.count) секунд"
                self.count -= 1
            } else if self.count == 0 {
                self.coordinator?.popVC()
            }
        }
        // Заметили, что при режиме .default RunLoop не реагирует на timer, когда RunLoop переходит в режим event tracking.
        // Ставим режим common, который группирует режимы default, modal, event tracking.
        RunLoop.current.add(timer!, forMode: .common)
    }
}

extension PhotosViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return output.getSectionsCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return output.getPhotosCount(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self), for: indexPath) as! PhotosCollectionViewCell
        cell.image = output.getPhotos(section: indexPath.section)[indexPath.item]
        return cell
    }
    
    
}
extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = view.bounds.width
        return CGSize(width: (width - 8 * 4) / 3,
                      height: (width - 8 * 4) / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
