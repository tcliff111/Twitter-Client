//
//  TweetsViewController.swift
//  Twitter Client
//
//  Created by Thomas Clifford on 2/20/16.
//  Copyright © 2016 Thomas Clifford. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var tweets = [Tweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let client = TwitterClient.sharedInstance
        
        client.homeTimeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            
            }) { (error: NSError) -> () in
                print("Error: \(error.localizedDescription)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return tweets.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetTableViewCell", forIndexPath: indexPath) as! TweetTableViewCell
        let tweet = self.tweets[indexPath.row]
        cell.tweetText.text = tweet.tweetText
        cell.ownerName.text = tweet.ownerName
        cell.ownerUsername.text = tweet.ownerUsername
        let imageURL = tweet.ownerAvatarURL
        if let imageURL = imageURL {
            cell.ownerAvatar.setImageWithURL(imageURL)
        }

        var numberFormatter = NSNumberFormatter()
        numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
        
        cell.retweetCount.text = numberFormatter.stringFromNumber(tweet.retweetCount)
        cell.favoriteCount.text = numberFormatter.stringFromNumber(tweet.favoriteCount)
        
        let usDateFormat = NSDateFormatter.dateFormatFromTemplate("MMddyyyy", options: 0, locale: NSLocale(localeIdentifier: "en-US"))
        let format = NSDateFormatter()
        format.dateFormat = usDateFormat
 
        cell.timeAgo.text = format.stringFromDate(tweet.timestamp!)
        
        
        let retweetTap = UITapGestureRecognizer(target: self, action:"retweetDetected:")
        retweetTap.numberOfTapsRequired = 1
        cell.retweetImage.userInteractionEnabled = true
        cell.retweetImage.addGestureRecognizer(retweetTap)
        
        let favoriteTap = UITapGestureRecognizer(target: self, action:"favoriteDetected:")
        favoriteTap.numberOfTapsRequired = 1
        cell.favoriteImage.userInteractionEnabled = true
        cell.favoriteImage.addGestureRecognizer(favoriteTap)

        return cell
    }
    
    func retweetDetected(sender: UITapGestureRecognizer) {
        let point = sender.view
        let mainCell = point?.superview
        let main = mainCell?.superview
        let cell: TweetTableViewCell = main as! TweetTableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        
        
        let tweet = tweets[(indexPath?.row)!]

        TwitterClient.sharedInstance.retweet(tweet) { () -> () in
            self.tableView.reloadData()
        }
        
    }
    
    func favoriteDetected(sender: UITapGestureRecognizer) {
        let point = sender.view
        let mainCell = point?.superview
        let main = mainCell?.superview
        let cell: TweetTableViewCell = main as! TweetTableViewCell
        let indexPath = tableView.indexPathForCell(cell)
    
        
        let tweet = tweets[(indexPath?.row)!]
        
        TwitterClient.sharedInstance.favorite(tweet) { () -> () in
            self.tableView.reloadData()
        }
        
    }
    
    @IBAction func onLogout(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
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
