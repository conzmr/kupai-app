//
//  LoginViewController.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 10/6/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var loginDataView: UIView!
    @IBOutlet weak var loginDataLineView: UIView!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var redirectToAdminLoginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var bottomLineView: UIView!
    @IBOutlet weak var orLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //dividing height between two allow us to have perfect circle
        logoImageView.layer.cornerRadius = logoImageView.bounds.height / 2
        logoImageView.clipsToBounds = true
        
        
        loginDataView.layer.borderColor = tertiaryColor.cgColor
        loginDataView.layer.borderWidth = 1
        loginDataView.layer.cornerRadius = 3
        loginDataView.clipsToBounds = true
        
        loginButton.backgroundColor = primaryColor
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.layer.cornerRadius = 3
        loginButton.clipsToBounds = true
        
        redirectToAdminLoginButton.setTitleColor(primaryColor, for: .normal)
        
        signupButton.backgroundColor = secondaryColor
        signupButton.setTitleColor(primaryColor, for: .normal)
        signupButton.layer.cornerRadius = 3
        signupButton.clipsToBounds = true
        
        loginDataLineView.backgroundColor = tertiaryColor
        bottomLineView.backgroundColor = tertiaryColor
        
        
    }
    
}
