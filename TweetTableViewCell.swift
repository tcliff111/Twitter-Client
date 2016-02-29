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
    @IBOutlet weak var ownerName: UILabel!
    @IBOutlet weak var ownerUsername: UILabel!
    @IBOutlet weak var timeAgo: UILabel!
    @IBOutlet weak var ownerAvatar: UIImageView!
    @IBOutlet weak var favoriteImage: UIImageView!
    @IBOutlet weak var retweetImage: UIImageView!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!
    @IBOutlet weak var replyImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

}
