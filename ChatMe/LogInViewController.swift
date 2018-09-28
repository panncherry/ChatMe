
//
//  LogInViewController.swift
//  ChatMe
//
//  Created by Pann Cherry on 9/27/18.
//  Copyright © 2018 Pann Cherry. All rights reserved.
//

import UIKit
import Parse

class LogInViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onLogIn(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: userNameTextField.text!, password: passwordTextField.text!) { (user: PFUser?, error: Error?) in
            if user == nil {
                print("Username/email is required.")
                self.loginErrorAlert()
            }
            if user != nil {
                print("You are logged in.")
                self.userNameTextField.text = ""
                self.passwordTextField.text = ""
                self.performSegue(withIdentifier: "logInSegue", sender: nil)
            }
            
        }
    }
    
    func loginErrorAlert(){
        let alert = UIAlertController(title: "Login Error", message: "Hmm..something went wrong. or Username/Email is missing.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
        userNameTextField.text = ""
        passwordTextField.text = ""
    }
    
    @IBAction func onTappedDismissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
}
