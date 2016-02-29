//
//  TwitterClient.swift
//  Twitter Client
//
//  Created by Thomas Clifford on 2/16/16.
//  Copyright © 2016 Thomas Clifford. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterBaseURL = NSURL(string: "https://api.twitter.com")
let twitterConsumerKey = "BIw1sqsZivcvg7VSmltpEm24x"
let twitterConsumerSecret = "SwBD43ByAHtUMFe9aiqcCa45itshXTOKaj2zqrwzKD40ZAFLoH"

class TwitterClient: BDBOAuth1SessionManager {


    static let sharedInstance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func login(success: () -> (), failure: (NSError) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "twitterCPThomas://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
            UIApplication.sharedApplication().openURL(authURL!)
            
            
            }) { (error: NSError!) -> Void in
            self.loginFailure?(error)
        }
    }
    
    func handleOpenURL(url: NSURL) {
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: { (accessToken:BDBOAuth1Credential!) -> Void in
            
            self.currentAccount({ (user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
            }, failure: { (error: NSError) -> () in
                self.loginFailure?(error)
            })
            
            
            }) { (error: NSError!) -> Void in
                print("ERROR: " + error.localizedDescription)
                self.loginFailure?(error)
        }
    }
    
    func homeTimeline(success: ([Tweet])->(), failure: (NSError)->()) {
        GET("1.1/statuses/home_timeline.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries)
            success(tweets)
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    func currentAccount(success: (User)->(), failure: (NSError)->()) {
        GET("1.1/account/verify_credentials.json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let dictionary = response as! NSDictionary
            let user = User(dictionary: dictionary)
            success(user)
            
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogOutNotification, object: nil)
    }
    
    func retweet(tweet: Tweet, success: ()->()) {
        let id = tweet.id
        POST("1.1/statuses/retweet/\(id).json", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("retweeted")
            tweet.retweetCount++
            success()
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Error: \(error.localizedDescription)")
        }
    }
    
    func favorite(tweet: Tweet, success: ()->()) {
        let id = tweet.id
        POST("/1.1/favorites/create.json?id=\(id)", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("favorited")
            tweet.favoriteCount++
            success()
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Error: \(error.localizedDescription)")
        }
    }
    
    func  tweet(text: String, sender: UIViewController, success: ()->()) {
        let params = ["status": text]
        POST("/1.1/statuses/update.json", parameters: params, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            print("tweeted")
            
            success()
            }) { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Error: \(error.localizedDescription)")
        }
    }
    
    func getUser(id: String, success: (user: User?)->()) {
        GET("1.1/users/lookup.json?user_id=\(id)", parameters: nil, progress: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) -> Void in
            let array = response as! NSArray
            let dictionary = response![0] as! NSDictionary
            let user = User(dictionary: dictionary)
            success(user: user)
            }, failure: { (task: NSURLSessionDataTask?, error: NSError) -> Void in
                print("Error: \(error.localizedDescription)")
        })
    }
}
