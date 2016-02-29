//
//  ComposeViewController.swift
//  Twitter Client
//
//  Created by Thomas Clifford on 2/28/16.
//  Copyright © 2016 Thomas Clifford. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var characterCount: UILabel!
    var initialText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textView.delegate = self
        textView.becomeFirstResponder()
        textView.text = initialText
        characterCount.text = String(140-textView.text.characters.count)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textViewDidChange(textView: UITextView) {
        let count = textView.text.characters.count
        if(count>140) {
            let text = textView.text
            let index = text.endIndex.advancedBy(140-count)
            textView.text = text.substringToIndex(index)
        }
        let count2 = textView.text.characters.count + 0
        characterCount.text = String(140-count2)
    }
    @IBAction func onTweet(sender: AnyObject) {
        let text = textView.text
        if(text.characters.count > 0) {
            TwitterClient.sharedInstance.tweet(text, sender: self, success: { () -> () in
                self.performSegue()
            })
        }
    }
    func performSegue() {
        performSegueWithIdentifier("returnHome", sender: self)
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
