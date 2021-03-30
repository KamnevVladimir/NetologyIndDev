//
//  InfoViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit
import SnapKit

final class InfoViewController: UIViewController {

    private lazy var alertButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show alert", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.addTarget(self, action: #selector(alertButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupLayouts()
    }
    
    private func setupLayouts() {
        alertButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func setupViews() {
        view.backgroundColor = .systemYellow
        view.addSubview(alertButton)
    }
    
    @objc private func alertButtonTapped() {
        let alertController = UIAlertController(title: "Удалить пост?", message: "Пост нельзя будет восстановить", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .default) { _ in
            print("Отмена")
        }
        let deleteAction = UIAlertAction(title: "Удалить", style: .destructive) { _ in
            print("Удалить")
        }
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
