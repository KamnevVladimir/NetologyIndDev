import UIKit

class PostPresenter: FeedViewOutput {
    var navigationController: UINavigationController?
    
    func showPost() {
        let postViewController = PostViewController()
        navigationController?.pushViewController(postViewController, animated: true)
    }
}
