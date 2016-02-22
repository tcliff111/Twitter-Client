//
//  ViewController.swift
//  Twitter Client
//
//  Created by Thomas Clifford on 2/16/16.
//  Copyright © 2016 Thomas Clifford. All rights reserved.
//

import UIKit
import BDBOAuth1Manager


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
        TwitterClient.sharedInstance.login({ () -> () in
            self.performSegueWithIdentifier("loginSegue", sender: nil)
            }) { (error: NSError) -> () in
                print("Error: \(error.localizedDescription)")
        }
        

    }

}

