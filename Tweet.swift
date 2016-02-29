//
//  Tweet.swift
//  Twitter Client
//
//  Created by Thomas Clifford on 2/20/16.
//  Copyright © 2016 Thomas Clifford. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    
    var tweetText: String?
    var ownerName: String?
    var ownerUsername: String?
    var ownerAvatarURL: NSURL?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoriteCount: Int = 0
    var user_id: String?
    var id: Int = 0
    
    init(dictionary: NSDictionary) {
        tweetText = dictionary["text"] as? String
        id = (dictionary["id"] as? Int) ?? 0
        let user = dictionary["user"] as? NSDictionary
        if let user = user {
            ownerName = user["name"] as? String
            ownerUsername = "@\(user["screen_name"] as! String)"
            let ownerAvatarURLString = user["profile_image_url"] as? String
            if let ownerAvatarURLString = ownerAvatarURLString {
                ownerAvatarURL = NSURL(string: ownerAvatarURLString)
            }
            user_id = user["id_str"] as? String
        }
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoriteCount = (dictionary["favorite_count"] as? Int) ?? 0
        
        let dateString = dictionary["created_at"] as? String
        
        if let dateString = dateString {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(dateString)
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        return tweets
    }
    
}
