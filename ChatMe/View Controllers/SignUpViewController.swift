//
//  SignUpViewController.swift
//  ChatMe
//
//  Created by Pann Cherry on 9/27/18.
//  Copyright © 2018 Pann Cherry. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - IBActions
    /*:
     # Sign Up
     * Create an account with user inputs
     */
    @IBAction func registerUser(_ sender: Any) {
        let newUser = PFUser()
        newUser.email = emailTextField.text
        newUser.username = userNameTextField.text
        newUser.password = passwordTextField.text
        
        newUser.signUpInBackground{(success: Bool
            , error: Error?) in
            if success {
                print("Created a new user!!")
                self.newUserCreatedAlert(title: "Congratulations!", message: "Your account has been successfully created.")
            } else {
                print(error?.localizedDescription as Any)
                if error?._code == 200 {
                    print("Bad or missing username.")
                    self.alert(title: "Error", message: "Bad or missing username.")
                }
                if error?._code == 201 {
                    print("Password is required.")
                    self.passwordRequiredAlert(title: "Error", message: "Password is required")
                }
                if error?._code == 202 {
                    print("User name is already taken!")
                    self.userTakenAlert(title: "Error", message: "Username is already taken. or Account already exists for this email address.")
                }
                if error?._code == 203 {
                    print("Account already exists for this email address.")
                    self.userTakenAlert(title: "Error", message: "Account already exists for this email address.")
                }
            }
        }
    }
    
    /*:
     # Dismiss Current ViewController
     * On tap of close button, dismiss current viewController
     */
    @IBAction func closeButton(_ sender: Any) {
        self.view.window!.rootViewController?.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    /*:
     # Dismiss Keyboard
     * On tap anywhere on viewController, dismiss keyboard
     */
    @IBAction func onTappedDimissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    // MARK: - Helper Functions
    func alert(title: String, message: String){
        displayAlert(title: "Error", message: "Bad or missing username.")
        clearTextFields()
    }
    
    func userTakenAlert(title: String, message: String){
        displayAlert(title: "Error", message: "Username is already taken. OR Account already exists for this email address.")
        clearTextFields()
    }
    
    func passwordRequiredAlert(title: String, message: String){
        displayAlert(title: "Error", message: "Password is required.")
        clearTextFields()
    }
    
    func accountExistAlert(title: String, message: String){
        displayAlert(title: "Error", message: "Account already exists for this email address.")
        clearTextFields()
    }
    
    func newUserCreatedAlert(title: String, message: String){
        displayAlert(title: "Congratulations!!!", message: "Your account is created.")
        clearTextFields()
    }
    
    private func clearTextFields() {
        userNameTextField.text = ""
        passwordTextField.text = ""
        emailTextField.text = ""
    }
}

// Extension
extension UIViewController {
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true) {
             self.view.window!.rootViewController?.presentedViewController?.dismiss(animated: true, completion: nil)
        }
    }
    
}
