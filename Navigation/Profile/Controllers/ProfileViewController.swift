import UIKit
import SnapKit

protocol ProfileViewInput: class {
    func deselectCell(indexPath: IndexPath)
    func refreshData()
}

final class ProfileViewController: UIViewController {
    weak var coordinator: ProfileFlowCoordinator?
    private var output: ProfileViewOutput
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)

        tableView.backgroundColor = UIColor(red: 242, green: 242, blue: 247)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileMainTableViewCell.self, forCellReuseIdentifier: String(describing: ProfileMainTableViewCell.self))
        tableView.register(ProfileStackTableViewCell.self, forCellReuseIdentifier: String(describing: ProfileStackTableViewCell.self))
        tableView.register(ProfileTableHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: ProfileTableHeaderView.self))
        
        return tableView
    }()
    
    private lazy var containerView = UIView()
    
    init(viewModel output: ProfileViewOutput) {
        self.output = output
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) in ProfileViewController called")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 242, green: 242, blue: 247)
        hideKeyboardWhenTappedAround()
        refreshData()
        setupViews()
        setupLayouts()
    }
    
    private func setupViews() {
        view.addSubviews(tableView)
        tableView.addSubview(containerView)
    }
    
    private func setupLayouts() {
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.safeAreaLayoutGuide.snp.edges)
        }
        
        containerView.snp.makeConstraints { (make) in
            make.edges.equalTo(tableView)
        }
    }
    
    func setupAvatarImage() -> UIImage? {
        print(output.getAvatarImage())
        return output.getAvatarImage()
    }
}

//MARK: - TableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        output.onTableViewTap(indexPath: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 0:
            return 8
        default:
            return .zero
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard section == 0 else { return .zero }
        return tableView.sectionHeaderHeight
    }
}

//MARK: - TableViewDataSource
extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return output.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.getNumbersOfRows(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = output.getPost(indexPath: indexPath)
        
        switch indexPath.section {
        case 0:

            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfileStackTableViewCell.self)) as! ProfileStackTableViewCell
            cell.takeStackImage(post: post)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfileMainTableViewCell.self)) as! ProfileMainTableViewCell
           
            cell.takePost(post: post)
            return cell
        }
    }
    
    /// Кастомный Header для таблицы
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: ProfileTableHeaderView.self)) as! ProfileTableHeaderView
        headerView.controller = self
        return headerView
    }
}

extension ProfileViewController: ProfileViewInput {
    func deselectCell(indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func refreshData() {
        tableView.reloadData()
    }
}


