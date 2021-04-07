//
//  ViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

final class FeedViewController: UIViewController {
    weak var coordinator: FeedFlowCoordinator?
    
    private lazy var postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show post", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(postButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
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
        setupLayouts()
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
    
    private func setupLayouts() {
        postButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupViews() {
        view.backgroundColor = UIColor.systemGreen
        view.addSubview(postButton)
    }
    
    @objc private func postButtonTapped() {
        // Задание 1
        /// Обработка через do-catch с вызовом алерта
        do {
            let post = try PostLoad.openPost()
            coordinator?.showPostVC(post: post)
        } catch PostErrors.notFound {
            let alertVC = ErrorsAlertController(title: "Непревзойдённая магия", message: "Ваш пост, он куда-то подевался", preferredStyle: .alert)
            present(alertVC, animated: true)
        } catch {
            let alertVC = ErrorsAlertController(title: "Вы открыли новый вид ошибки!", message: "Лучше забудьте, что вы сюда нажали и не нажимайте больше", preferredStyle: .alert)
            present(alertVC, animated: true)
        }
    }
}

