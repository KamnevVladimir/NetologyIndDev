//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

final class FeedViewController: UIViewController {
    weak var coordinator: FeedFlowCoordinator?
    let post: Post = Post(title: "Пост")
    var onTap: (() -> Void)?
    var output: FeedViewOutput
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        output = PostPresenter()
        onTap = output.showPost
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        print(type(of: self), #function)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(type(of: self), #function)
        
        title = "Feed"
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(type(of: self), #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(type(of: self), #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(type(of: self), #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(type(of: self), #function)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print(type(of: self), #function)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print(type(of: self), #function)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "post" else {
            return
        }
        guard let postViewController = segue.destination as? PostViewController else {
            return
        }
        postViewController.post = post
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.systemGreen
        
        output.navigationController = navigationController
        
        let feedContainerView = FeedContainerView(frame: view.frame)
        feedContainerView.onTap = onTap
        view.addSubview(feedContainerView)
    }
    
    @objc private func postButtonTapped() {
        coordinator?.showPostVC(post: post)
    }
}

protocol FeedViewOutput: class {
    var navigationController: UINavigationController? { get set }
    func showPost()
}
