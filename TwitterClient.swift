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

    class var sharedInstance : TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
}
