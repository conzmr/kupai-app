//
//  SignupCell.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 10/7/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import UIKit

class SignupCell: UICollectionViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var signupDataView: UIView!
    @IBOutlet weak var signupDataLineView: UIView!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var alreadyHasAccountButton: UIButton!
    weak var delegate: ViewControllerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupAddTargetIsNotEmptyTextFields()
        signupDataView.layer.borderColor = tertiaryColor.cgColor
        signupDataView.layer.borderWidth = 1
        signupDataView.layer.cornerRadius = 3
        signupDataView.clipsToBounds = true
        
        signupButton.backgroundColor = primaryColor
        signupButton.setTitleColor(.white, for: .normal)
        signupButton.layer.cornerRadius = 3
        signupButton.clipsToBounds = true
        
        signupDataLineView.backgroundColor = tertiaryColor
        
        alreadyHasAccountButton.setTitleColor(primaryColor, for: .normal)
        
        userTextField.delegate = self
        passwordTextField.delegate = self
        
        //Without this, cannot interact with content
        self.contentView.isUserInteractionEnabled = false
        
    }
    
    func setupAddTargetIsNotEmptyTextFields() {
        signupButton.isEnabled = false
        signupButton.alpha = 0.5
        userTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty),
                                    for: .editingChanged)
        passwordTextField.addTarget(self, action: #selector(textFieldsIsNotEmpty),
                                     for: .editingChanged)
    }
    
    @objc func textFieldsIsNotEmpty(sender: UITextField) {
        sender.text = sender.text?.trimmingCharacters(in: .whitespaces)
        guard
            let email = userTextField.text, !email.isEmpty,
            let password = passwordTextField.text, !password.isEmpty
//            let confirmPassword = confimPasswordUserTextField.text,
//            password == confirmPassword
            else
        {
            self.signupButton.isEnabled = false
            self.signupButton.alpha = 0.5
            return
        }
        // enable okButton if all conditions are met
        signupButton.isEnabled = true
        signupButton.alpha = 1.0
    }
    
    @IBAction func signUp(_ sender: Any) {
        delegate?.createUser(email: userTextField.text!, password: passwordTextField.text!)
    }
    
    @IBAction func redirectToLogin(_ sender: Any) {
        delegate?.backToLogin()
    }
    
    
}
