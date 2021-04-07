//
//  ErrorsAlertController.swift
//  Navigation
//
//  Created by Tsar on 07.04.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class ErrorsAlertController: UIAlertController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let action = UIAlertAction(title: "Понятно", style: .default, handler: nil)
        addAction(action)
    }

}
