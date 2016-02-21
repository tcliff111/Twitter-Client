//
//  TweetTableViewCell.swift
//  Twitter Client
//
//  Created by Thomas Clifford on 2/20/16.
//  Copyright © 2016 Thomas Clifford. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var tweetText: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
