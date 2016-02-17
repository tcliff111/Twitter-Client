//
//  ViewController.swift
//  Twitter Client
//
//  Created by Thomas Clifford on 2/16/16.
//  Copyright © 2016 Thomas Clifford. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login(sender: AnyObject) {
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: ""), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
            print("Nice man")
            }) { (NSError!) -> Void in
            print("you suck")
        }
    }

}

