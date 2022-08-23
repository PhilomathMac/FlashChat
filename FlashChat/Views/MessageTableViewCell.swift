//
//  MessageTableViewCell.swift
//  FlashChat
//
//  Created by McKenzie Macdonald on 8/23/22.
//

import UIKit

class MessageTableViewCell: UITableViewCell {

    @IBOutlet var messageBubble: UIView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var rightImageView: UIImageView!
    
    override func awakeFromNib() {
        // Nib is an old name for .xib
        // Similar to viewDidLoad - called when the cell is created
        super.awakeFromNib()
        
        messageBubble.layer.cornerRadius = messageBubble.frame.height / 5
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
