//
//  ChatCell.swift
//  ChatMe
//
//  Created by Pann Cherry on 9/28/18.
//  Copyright © 2018 Pann Cherry. All rights reserved.
//

import UIKit
import Foundation

class ChatCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var messageView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
