//
//  ProfileController.swift
//  kupai
//
//  Created by Constanza Madrigal Reyes on 10/13/19.
//  Copyright © 2019 Constanza Madrigal Reyes. All rights reserved.
//

import SwiftUI

class ProfileController: UIViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var bottomLineSeparator: UIView!
    @IBOutlet weak var logoutButton: UIButton!
    
    @ObservedObject var userVM = UserViewModel()
    
    override func viewDidLoad() {
        bottomLineSeparator.backgroundColor = tertiaryColor
        logoutButton.backgroundColor = quaternaryColor
        logoutButton.setTitleColor(.gray, for: .normal)
        logoutButton.layer.cornerRadius = 3
        logoutButton.clipsToBounds = true
        
        nameLabel.text = UserDefaults.standard.string(forKey: "name")
        emailLabel.text = UserDefaults.standard.string(forKey: "email")
    }
    
    @IBAction func logout(_ sender: Any) {
        self.logoutButton.loadingIndicator(true)
        userVM.logoutUser(completion: { (res) in
            self.logoutButton.loadingIndicator(false)
            self.redirectToLogin()
            switch res {
            case .success(_):
                print("LOGOUT SUCCESS")
            case .failure(let err):
                print("LOGOUT FAILED", err)
            }
        })
    }
    
    func redirectToLogin() {
        DispatchQueue.main.async {
            let appDelegate = UIApplication.shared.delegate! as! AppDelegate
            let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "LoginViewControllerId")
            appDelegate.window?.rootViewController = initialViewController
            appDelegate.window?.makeKeyAndVisible()
            self.dismiss(animated: true, completion: nil)
        }
    }
}
