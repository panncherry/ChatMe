//
//  ChatViewController.swift
//  ChatMe
//
//  Created by Pann Cherry on 9/28/18.
//  Copyright © 2018 Pann Cherry. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var chatMessageField: UITextField!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var sendButton: UIButton!
    
    var messages: String!
    
    var parseMessages: [PFObject] = []
    
    var refreshControl: UIRefreshControl!
    
    var alertController: UIAlertController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = 100
        
        refreshControl = UIRefreshControl()
        tableView.insertSubview(refreshControl, at: 0)
        
        sendButton.isEnabled = false
        chatMessageField.addTarget(self, action: #selector(ChatViewController.textDidChange(_:)), for: .editingChanged)
        logOutAlert()
        refreshScreen()
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(refreshScreen), userInfo: nil, repeats: true)
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parseMessages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        cell.messageView.layer.cornerRadius = 10
        cell.messageView.clipsToBounds = true
        let message = parseMessages[indexPath.row]
        cell.messageLabel.text = message["text"] as? String
        if let user = message["user"] as? PFUser {
            cell.userNameLabel.text = user.username
        } else {
            cell.userNameLabel.text = "Anonymous"
        }
        return cell
        
    }
    
    
    @IBAction func sendMsgButton(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        
        if let currentUser = PFUser.current() {
            chatMessage["user"] = currentUser
        }
        
        chatMessage["text"] = chatMessageField.text ?? ""
        
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("Message sent successfully.")
                self.chatMessageField.text = ""
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
    
    @objc func textDidChange(_ textField: UITextField){
        if(chatMessageField.text?.isEmpty)!{
            sendButton.isEnabled = false
        }
        else{
            sendButton.isEnabled = true
        }
    }
    
    
    func fetchMessages(){
        let query = PFQuery(className: "Message")
        query.addDescendingOrder("createdAt")
        query.includeKey("user")
        
        query.findObjectsInBackground(){
            (messages: [PFObject]?, error: Error?) in
            if error == nil {
                if let messages = messages {
                    self.parseMessages = messages
                }
            } else {
                print("Problem fetching message: \(error!.localizedDescription)")
            }
        }
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
        
    }
    
    
    @objc func refreshScreen() {
        fetchMessages()
    }
    
    
    @IBAction func logOutButton(_ sender: Any) {
        PFUser.logOut()
        present(alertController, animated: true)
    }
    
    
    func logOutAlert() {
        alertController = UIAlertController(title: "", message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
        
        let logoutButton = UIAlertAction(title: "Logout", style: .destructive) { (action) in
            self.view.window!.rootViewController?.presentedViewController?.dismiss(animated: true, completion: nil)
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
        }
        alertController.addAction(logoutButton)
        alertController.addAction(cancelButton)
    }
    
}
