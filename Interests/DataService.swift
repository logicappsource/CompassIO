//
//  DataService.swift
//  CompassIO
//
//  Created by LogicAppSourceIO on 19/02/17.
//  Copyright © 2017 LogicAppSourceIO. All rights reserved.
//

import Foundation
import Firebase

//Global
let DB_BASE = FIRDatabase.database().reference()

class DataService {
    
    static let ds = DataService()
    private var _REF_BASE = DB_BASE
    private var _REF_POSTS = DB_BASE.child("posts")
    private var _REF_USERS = DB_BASE.child("users")
    private var _REF_INTERESTS = DB_BASE.child("Interest")
    
    var REEF_BASE: FIRDatabaseReference {
        return _REF_BASE
    }
    
    var REF_POSTS: FIRDatabaseReference {
        return _REF_POSTS
    }
    
    var REF_USERS: FIRDatabaseReference {
        return _REF_USERS
    }
    
    var REF_INTERESTS: FIRDatabaseReference {
        return _REF_INTERESTS
    }
    
    func createFirbaseUser(uid: String, userData: Dictionary<String, String>) {
          REF_USERS.child(uid).updateChildValues(userData)
    }
    
    
    
}
