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
    
    var messages: String!
    
    var parseMessages: [PFObject] = []
    
    @objc var refresh: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = 100
        
        refresh = UIRefreshControl()
        tableView.insertSubview(refresh, at: 0)
        refresh = UIRefreshControl()
        tableView.insertSubview(refresh, at: 0)
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(toRefresh), userInfo: nil, repeats: true)

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parseMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.orange
        cell.selectedBackgroundView = backgroundView
        //code to set the color of all cells
        cell.contentView.backgroundColor = UIColor.init(red: 134, green: 214, blue: 148, alpha: 1)
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
    
    @objc func onTimer() {
        // Add code to be run periodically
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
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
        
    }
    
    @objc func toRefresh() {
        fetchMessages()
        self.tableView.reloadData()
    }
    
    
    @IBAction func onLogOut(_ sender: Any) {
    }
    
}
