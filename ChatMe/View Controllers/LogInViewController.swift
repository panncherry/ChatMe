
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
    
    // MARK: IBOutlets
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    // MARK: - IBActions
    /*:
     # Log In
     * Check user credits
     * Display error alert if user credis are incorrect
     */
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
    
    /*:
     # Dismiss Keyboard
     * On tap, dismiss keyboard
     */
    @IBAction func onTappedDismissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    //MARK: - Helper Functions
    /*:
     # Log In Error Alert
     */
    func loginErrorAlert(){
        let alert = UIAlertController(title: "Login Error", message: "Hmm..something went wrong. or Username/Email is missing.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
        userNameTextField.text = ""
        passwordTextField.text = ""
    }
}
