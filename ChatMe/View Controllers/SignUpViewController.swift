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
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func registerUser(_ sender: Any) {
        let newUser = PFUser()
        newUser.email = emailTextField.text
        newUser.username = userNameTextField.text
        newUser.password = passwordTextField.text
        
        newUser.signUpInBackground{(success: Bool
            , error: Error?) in
            if success {
                print("Created a new user!!")
                self.view.window!.rootViewController?.presentedViewController?.dismiss(animated: true, completion: nil)
                self.newUserCreatedAlert(title: "Congrats!", message: "Created a new user.")
                
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
    
    func alert(title: String, message: String){
        let alert = UIAlertController(title: "Error", message: "Bad or missing username.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
        userNameTextField.text = ""
        passwordTextField.text = ""
        emailTextField.text = ""
    }
    
    func userTakenAlert(title: String, message: String){
        let alert = UIAlertController(title: "Error", message: "Username is already taken. OR Account already exists for this email address.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
        userNameTextField.text = ""
        passwordTextField.text = ""
        emailTextField.text = ""
    }
    
    func passwordRequiredAlert(title: String, message: String){
        let alert = UIAlertController(title: "Error", message: "Password is required.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
        userNameTextField.text = ""
        passwordTextField.text = ""
        emailTextField.text = ""
    }
    
    func accountExistAlert(title: String, message: String){
        let alert = UIAlertController(title: "Error", message: "Account already exists for this email address.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
        userNameTextField.text = ""
        passwordTextField.text = ""
        emailTextField.text = ""
    }
    
    func newUserCreatedAlert(title: String, message: String){
        let alert = UIAlertController(title: "Congratulations!!!", message: "Your account is created.", preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(defaultAction)
        self.present(alert, animated: true, completion: nil)
        userNameTextField.text = ""
        passwordTextField.text = ""
        emailTextField.text = ""
    }
    
    
    @IBAction func closeButton(_ sender: Any) {
        self.view.window!.rootViewController?.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func onTappedDimissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
}