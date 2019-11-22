//
//  LoginViewController.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 10/6/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import SwiftUI

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var loginDataView: UIView!
    @IBOutlet weak var loginDataLineView: UIView!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var bottomLineView: UIView!
    @IBOutlet weak var orLabel: UILabel!
    
    var userVM = UserViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if(userVM.isUserLoggedIn()) {
            if (userVM.isUserType("ADMIN")) {
                redirectAdmin()
            } else {
                redirectInsideApp()
            }
        }
        //KEYBOARD SET UP
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        //COMPONENTS SET UP
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
        
        signupButton.backgroundColor = secondaryColor
        signupButton.setTitleColor(primaryColor, for: .normal)
        signupButton.layer.cornerRadius = 3
        signupButton.clipsToBounds = true
        
        loginDataLineView.backgroundColor = tertiaryColor
        bottomLineView.backgroundColor = tertiaryColor

    }
    
    @IBAction func doLogin(_ sender: Any) {
        login()
    }
    
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func login(){
        guard let email = userTextField.text,  userTextField.text?.count != 0 else {
            self.showAlert(title: "Empty email", message: "Please enter your email")
            return
        }
        guard let password = passwordTextField.text,  passwordTextField.text?.count != 0 else {
            self.showAlert(title: "Empty password", message: "Please enter your password")
            return
        }
        if(email.count > 0  && password.count > 0){
            loginButton.loadingIndicator(true)
            userVM.authenticateUser(email: email, password: password, completion: { (res) in
                self.loginButton.loadingIndicator(false)
                switch res {
                case .success(let user):
                    if user.type == "ADMIN" {
                        self.redirectAdmin()
                    } else {
                        self.redirectInsideApp()
                    }
                case .failure(let err):
                    print("LOGGIN FAILED", err)
                    self.showAlert(title: "Error de autenticación", message: "Correo o contraseña incorrectos")
                }
            })
        }
    }
    
    func redirectInsideApp() {
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate! as! AppDelegate
            let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "MainTabControllerId")
            appDelegate.window?.rootViewController = initialViewController
            appDelegate.window?.makeKeyAndVisible()
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func redirectAdmin() {
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate! as! AppDelegate
            let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "AdminController")
            appDelegate.window?.rootViewController = initialViewController
            appDelegate.window?.makeKeyAndVisible()
            self.dismiss(animated: true, completion: nil)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userTextField {
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        }else if textField == passwordTextField {
            textField.resignFirstResponder()
            login()
        }
        return true
    }
    
}
