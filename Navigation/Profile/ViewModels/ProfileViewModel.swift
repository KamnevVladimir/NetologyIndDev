import UIKit

protocol ProfileViewOutput: class {
    var profileModel: ProfileModel { get }
    var onCellTap: (() -> Void)? { get set }
    var numberOfSections: Int { get }
    func onTableViewTap(indexPath: IndexPath)
    func getNumbersOfRows(section: Int) -> Int
    func getPost(indexPath: IndexPath) -> ProfilePost
}

class ProfileViewModel: ProfileViewOutput {
    weak var viewInput: ProfileViewInput?
    
    var profileModel: ProfileModel {
        return ProfileModel()
    }
    
    var numberOfSections: Int {
        return profileModel.posts.count
    }
    
    var onCellTap: (() -> Void)?
    
    func onTableViewTap(indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            onCellTap?()
            fallthrough
        case 1:
            viewInput?.deselectCell(indexPath: indexPath)
        default:
            return
        }
    }
    
    func getNumbersOfRows(section: Int) -> Int {
        profileModel.posts[section].count
    }
    
    func getPost(indexPath: IndexPath) -> ProfilePost {
        let post = profileModel.posts[indexPath.section][indexPath.row]
        
        return post
    }
    
    
}

