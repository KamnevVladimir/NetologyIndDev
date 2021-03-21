//
//  PostViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {
    weak var coordinator: FeedFlowCoordinator?
    var post: Post?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = post?.title
        
        setupNavBar()
        setupViews()
    }
    
    private func setupNavBar() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    private func setupViews() {
        view.backgroundColor = .systemRed
    }
    
    @objc private func addButtonTapped() {
        present(InfoViewController(), animated: true)
    }
}
