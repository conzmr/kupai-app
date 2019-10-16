//
//  SignupCell.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 10/7/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import UIKit

class SignupCell: UICollectionViewCell {
    
    @IBOutlet weak var signupDataView: UIView!
    @IBOutlet weak var signupDataLineView: UIView!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var alreadyHasAccountButton: UIButton!
    weak var delegate: ViewControllerDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
        
        //Without this, cannot interact with content
        self.contentView.isUserInteractionEnabled = false
        
    }
    
    @IBAction func signUp(_ sender: Any) {
        delegate?.finishSigningIn()
    }
    @IBAction func redirectToLogin(_ sender: Any) {
        delegate?.backToLogin()
    }
    
    
}
