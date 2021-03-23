import UIKit
import SnapKit

final class ProfileViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)

        tableView.backgroundColor = UIColor(red: 242, green: 242, blue: 247)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProfileTableViewCell.self, forCellReuseIdentifier: String(describing: ProfileTableViewCell.self))
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: String(describing: PhotosTableViewCell.self))
        tableView.register(ProfileTableHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: ProfileTableHeaderView.self))
        
        return tableView
    }()
    
    private lazy var containerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 242, green: 242, blue: 247)
        hideKeyboardWhenTappedAround()
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
    
    private func openPhotosViewController() {
        let viewController = PhotosViewController()
        navigationController?.pushViewController(viewController, animated: true)
    }
}

//MARK: - TableViewDelegate
extension ProfileViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            openPhotosViewController()
        default:
            tableView.deselectRow(at: indexPath, animated: true)
            return
        }
        
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
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return ProfilePosts.posts.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PhotosTableViewCell.self)) as! PhotosTableViewCell
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProfileTableViewCell.self)) as! ProfileTableViewCell
            
            cell.post = ProfilePosts.posts[indexPath.row]
            return cell
        }
    }
    
    /// Кастомный Header для таблицы
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 0 else { return nil }
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: ProfileTableHeaderView.self)) as! ProfileTableHeaderView
        return headerView
    }
}


