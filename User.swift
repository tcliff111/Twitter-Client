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
    
    init(dictionary: NSDictionary) {
        name = dictionary["name"] as? String
        username = dictionary["screen_name"] as? String
        let profileURLString = dictionary["profile_image_url_https"] as? String
        if let profileURLString = profileURLString {
            profileURL = NSURL(string: profileURLString)
        }
        tagline = dictionary["description"] as? String
    }
    
}
