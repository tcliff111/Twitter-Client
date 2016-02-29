//
//  User.swift
//  Twitter Client
//
//  Created by Thomas Clifford on 2/19/16.
//  Copyright © 2016 Thomas Clifford. All rights reserved.
//

import UIKit

class User: NSObject {
    

    var name: String?
    var username: String?
    var profileURL: NSURL?
    var tagline: String?
    var followerNumber: Int = 0
    var followingNumber: Int = 0
    var tweetsNumber: Int = 0

    
    var dictionary: NSDictionary?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        name = dictionary["name"] as? String
        username = dictionary["screen_name"] as? String
        let profileURLString = dictionary["profile_image_url_https"] as? String
        if let profileURLString = profileURLString {
            profileURL = NSURL(string: profileURLString)
        }
        tagline = dictionary["description"] as? String
        followerNumber = (dictionary["followers_count"] as? Int) ?? 0
        followingNumber = (dictionary["friends_count"] as? Int) ?? 0
        tweetsNumber = (dictionary["statuses_count"] as? Int) ?? 0

        
    }
    
    static let userDidLogOutNotification = "UserDidLogout"
    static var _currentUser: User?
    
    class var currentUser: User? {
        set(user) {
            _currentUser = user
            let defaults = NSUserDefaults.standardUserDefaults()
        
            if let user = user {
                let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                defaults.setObject(data, forKey: "currectUserData")
            }
            else {
                defaults.setObject(nil, forKey: "currectUserData")
            }
        
            defaults.synchronize()
        }
        get {
            if(_currentUser == nil) {
                let defaults = NSUserDefaults.standardUserDefaults()
                let data = defaults.objectForKey("currectUserData") as? NSData
                
                if let data = data {
                    let dictionary = try! NSJSONSerialization.JSONObjectWithData(data, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
    }
    
}
