//
//  ChatCell.swift
//  ChatMe
//
//  Created by Pann Cherry on 9/28/18.
//  Copyright © 2018 Pann Cherry. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var messageLabel: UILabel!
        
    @IBOutlet weak var msgBackgroundView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
