import UIKit

protocol ProfileViewOutput: class {
    var profileModel: ProfileModel { get }
    var onCellTap: (() -> Void)? { get set }
    func onTableViewTap(indexPath: IndexPath)
    func getNumberOfSections() -> Int
    func getNumbersOfRows(section: Int) -> Int
    func getPost(indexPath: IndexPath) -> (title: String, description: String, image: UIImage?, likes: Int, views: Int, imageStack: [UIImage?])
}

class ProfileViewModel: ProfileViewOutput {
    weak var viewInput: ProfileViewInput?
    
    var profileModel: ProfileModel {
        return ProfileModel()
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
    
    func getNumberOfSections() -> Int {
        profileModel.posts.count
    }
    
    func getNumbersOfRows(section: Int) -> Int {
        profileModel.posts[section].count
    }
    
    func getPost(indexPath: IndexPath) -> (title: String, description: String, image: UIImage?, likes: Int, views: Int, imageStack: [UIImage?]) {
        let post = profileModel.posts[indexPath.section][indexPath.row]
        let image = UIImage(named: post.image)
        let imageStackString = profileModel.posts[indexPath.section][indexPath.row].imageStack
        var imageStack = [UIImage?]()
        for imageString in imageStackString {
            imageStack.append(UIImage(named: imageString))
        }
        
        return (post.author, post.description, image, post.likes, post.views, imageStack)
    }
}

