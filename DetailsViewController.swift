//
//  DetailsViewController.swift
//  Twitter Client
//
//  Created by Thomas Clifford on 2/25/16.
//  Copyright © 2016 Thomas Clifford. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    var indexPath: NSIndexPath?
    var id: Int = 0
    var tweet: Tweet?
    
    @IBOutlet weak var ownerAvatar: UIImageView!
    @IBOutlet weak var ownerName: UILabel!
    @IBOutlet weak var ownerUsername: UILabel!
    @IBOutlet weak var tweetText: UILabel!
    @IBOutlet weak var retweetCount: UILabel!
    @IBOutlet weak var favoriteCount: UILabel!
    @IBOutlet weak var favoriteIcon: UIImageView!
    @IBOutlet weak var retweetIcon: UIImageView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tweet = tweet {
            tweetText.text = tweet.tweetText
            retweetCount.text = String(tweet.retweetCount)
            favoriteCount.text = String(tweet.favoriteCount)
            ownerName.text = tweet.ownerName
            ownerUsername.text = tweet.ownerUsername
            ownerAvatar.setImageWithURL(tweet.ownerAvatarURL!)
        }
        
        let retweetTap = UITapGestureRecognizer(target: self, action:"retweetDetected:")
        retweetTap.numberOfTapsRequired = 1
        retweetIcon.userInteractionEnabled = true
        retweetIcon.addGestureRecognizer(retweetTap)
        
        let favoriteTap = UITapGestureRecognizer(target: self, action:"favoriteDetected:")
        favoriteTap.numberOfTapsRequired = 1
        favoriteIcon.userInteractionEnabled = true
        favoriteIcon.addGestureRecognizer(favoriteTap)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func retweetDetected(sender: UITapGestureRecognizer) {
        TwitterClient.sharedInstance.retweet(tweet!) { () -> () in
            self.retweetCount.text = String(self.tweet!.retweetCount)
        }
    }
    
    func favoriteDetected(sender: UITapGestureRecognizer) {
        TwitterClient.sharedInstance.favorite(tweet!) { () -> () in
            self.favoriteCount.text = String(self.tweet!.favoriteCount)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
