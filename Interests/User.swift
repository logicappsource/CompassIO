//
//  User.swift
//  Interests
//
//  Created by Duc Tran on 6/13/15.
//  Copyright © 2015 Developer Inspirus. All rights reserved.
//

import UIKit

class User
{
    var id: String
    var fullName: String
    var email: String
    var profileImage: UIImage!
    var interestId = [String]()
    
    init(id: String, fullName: String, email: String, profileImage: UIImage) {
        self.id = id
        self.fullName = fullName
        self.email = email
        self.profileImage = profileImage
    }
    
    // MARK: - Private
    
    class func allUsers() -> [User]
    {
        return [
            User(id: "u1", fullName: "Everlyn", email: "everlyn@developerinspirus.io", profileImage: UIImage(named: "profile1")!),
        ]
    }
}

