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
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "null"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var periodLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Период обращения планеты Татуин еще неизвестен"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupLayouts()
        loadPost()
        loadPlanetPeriod()
    }
    
    private func setupViews() {
        view.backgroundColor = .systemYellow
        view.addSubviews(alertButton,
                         titleLabel,
                         periodLabel)
    }
    
    private func setupLayouts() {
        alertButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(alertButton.snp.bottom).inset(-20)
            make.width.equalToSuperview()
        }
        
        periodLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).inset(-20)
            make.width.equalToSuperview()
        }
    }
    
    private func loadPost() {
        let urlString = NetworkURLs.post.rawValue
        NetworkService.fetchPost(with: urlString) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.titleLabel.text = error.localizedDescription
            case .success(let post):
                self.titleLabel.text = post.title
            }
        }
    }
    
    private func loadPlanetPeriod() {
        let urlString = NetworkURLs.planet.rawValue
        NetworkService.fetchPlanet(with: urlString) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.periodLabel.text = error.localizedDescription
            case .success(let planet):
                self.periodLabel.text = "Период обращения планеты Татуин = " + planet.orbitalPeriod + " суток"
            }
        }
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
