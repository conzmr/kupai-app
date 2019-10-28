//
//  ProfileController.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 10/13/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import UIKit

class ProfileController: UIViewController {
    
    @IBOutlet weak var bottomLineSeparator: UIView!
    @IBOutlet weak var logoutButton: UIButton!
    override func viewDidLoad() {
        bottomLineSeparator.backgroundColor = tertiaryColor
        logoutButton.backgroundColor = quaternaryColor
        logoutButton.setTitleColor(.gray, for: .normal)
        logoutButton.layer.cornerRadius = 3
        logoutButton.clipsToBounds = true
    }
    
}
