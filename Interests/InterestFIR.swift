//
//  InterestFIR.swift
//  CompassIO
//
//  Created by LogicAppSourceIO on 21/02/17.
//  Copyright © 2017 LogicAppSourceIO. All rights reserved.
//

import Foundation
import UIKit


class InterestFIR {
    
    
    //LATER MODIFICATION SAME TPYE IS NOT ACAIVLE . UIIMAGE AND INT CANNORT CONVERT TO TYPE INT () FIREBASE
    
    //MARK: - Public API 
    private var _caption: String!
    private var _title: String!
    private var _description: String!
    private var _numberOfMembers: Int!
    private var _numberOfPosts: Int!
    private var _featuredImage: UIImage!
    private var _postKey: String!
    
    
    var caption: String {
        return _caption
    }
    
    var title: String {
        return _title
    }
    
    var description: String {
        return _description
    }
    
    var numberOfMembers: Int {
        return _numberOfMembers
    }
    
    var numberOfPosts: Int {
        return _numberOfPosts
    }

 
    
    var featuredImage: UIImage {
        return _featuredImage
    }
    
    var postKey: String {
        return _postKey
    }
    
    //numberOfMembers: Int, numberOfPosts: Int, featuredImage: UIImage,
    init(caption: String, title: String, description: String, postKey: String,numberOfMembers: Int, numberOfPosts: Int, featuredImage: UIImage  ) {
        
        self._caption = caption
        self._title = title
        self._description = description
        self._numberOfMembers = numberOfMembers
        self._numberOfPosts = numberOfPosts
        self._featuredImage =  featuredImage
        
    }
    
    init(postKey: String, postData: Dictionary<String, AnyObject> ) {
        self._postKey = postKey
        
        if let caption = postData["caption"] as? String {
            self._caption = caption
        }
        
        if let title = postData["title"] as? String {
            self._title = title
        }
        
        if let description = postData["description"] as? String {
            self._description = description
        }
        
        if let numberOfMembers = postData["numberOfMembers"] as? Int {
            self._numberOfMembers = numberOfMembers
        }
        
        if let numberOfPosts = postData["numberOfPosts"] as? Int {
            self._numberOfPosts = numberOfPosts
        }
    }
    
    
    
    
    
    
    
    
    
    
    
}
