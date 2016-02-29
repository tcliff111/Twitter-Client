//
//  ProfileViewController.swift
//  Twitter Client
//
//  Created by Thomas Clifford on 2/27/16.
//  Copyright © 2016 Thomas Clifford. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var user: User?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var ownerAvatar: UIImageView!
    @IBOutlet weak var ownerName: UILabel!
    @IBOutlet weak var ownerUsername: UILabel!
    @IBOutlet weak var tweetNumber: UILabel!
    @IBOutlet weak var followerNumber: UILabel!
    @IBOutlet weak var followingNumber: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if user == nil {
            user = User.currentUser
        }
        
        if let avatarURL = user!.profileURL {
            ownerAvatar.setImageWithURL(avatarURL)
        }
        ownerName.text = user!.name
        ownerUsername.text = "@\(user!.username!)"
        followerNumber.text = "\(user!.followerNumber) Followers"
        followingNumber.text = "\(user!.followingNumber) Following"
        tweetNumber.text = "\(user!.tweetsNumber) Tweets"

        
        
//        headerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier("ProfileHeader")
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DetailsViewCell", forIndexPath: indexPath)
        
        return cell
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        if let avatarURL = user!.profileURL {
            ownerAvatar.setImageWithURL(avatarURL)
        }
        ownerName.text = user!.name
        ownerUsername.text = "@\(user!.username!)"
        
        
        let numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        
        followerNumber.text = "\(numberFormatter.stringFromNumber(user!.followerNumber)!) Followers"
        followingNumber.text = "\(numberFormatter.stringFromNumber(user!.followingNumber)!) Following"
        tweetNumber.text = "\(numberFormatter.stringFromNumber(user!.tweetsNumber)!) Tweets"
    }
    
//    func dequeueReusableHeaderFooterViewWithIdentifier(identifier: String) -> UITableViewHeaderFooterView? {
//        return
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
