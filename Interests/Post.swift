//
//  Post.swift
//  Interests
//
//  Created by Duc Tran on 6/13/15.
//  Copyright © 2015 Developer Inspirus. All rights reserved.
//


import UIKit

class Post
{
    static let className = "Post"
    
    // Properties
    var id: String
    var user: User
    var createdAt: String
    var postImage: UIImage!     // can be nil
    var postText: String
    var numberOfLikes: Int = 0
    
    var userDidLike = false
    
    // use this interestId to query for posts
    let interestId: String
    
    // we will query the comments of this post using the postId
    
    init(postId: String, author: User, createdAt: String, postImage: UIImage!, postText: String, numberOfLikes: Int, interestId: String, userDidLike: Bool)
    {
        self.id = postId
        self.user = author
        self.createdAt = createdAt
        self.postImage = postImage      // can be nil
        self.postText = postText
        self.numberOfLikes = numberOfLikes
        self.interestId = interestId    // this allows to initialize roomId but cannot ever change anymore
        self.userDidLike = userDidLike
    }
    
    // sample hard-coded data
    
    static let allPosts = [
        Post(postId: "p1", author: User.allUsers()[0], createdAt: "today", postImage: UIImage(named: "p2")!, postText: "We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea", numberOfLikes: 12, interestId: "r1", userDidLike: true),
        Post(postId: "p2", author: User.allUsers()[0], createdAt: "today", postImage: UIImage(named: "p3")!, postText: "Little Bites of Cocoa is a new site with daily Cocoa tips by Jake Marsh. All of his tips use Swift so far and he's doing a great job posting new tips every other day.", numberOfLikes: 19, interestId: "r1", userDidLike: false),
        Post(postId: "p3", author: User.allUsers()[0], createdAt: "today", postImage: nil, postText: "Little Bites of Cocoa is a new site with daily Cocoa tips by Jake Marsh. All of his tips use Swift so far and he's doing a great job posting new tips every other day.", numberOfLikes: 19, interestId: "r1", userDidLike: false),
        Post(postId: "p4", author: User.allUsers()[0], createdAt: "today", postImage: nil, postText: "Little Bites of Cocoa is a new site with daily Cocoa tips by Jake Marsh. All of his tips use Swift so far and he's doing a great job posting new tips every other day.", numberOfLikes: 19, interestId: "r1", userDidLike: true),
        Post(postId: "p5", author: User.allUsers()[0], createdAt: "today", postImage: UIImage(named: "p4")!, postText: "Little Bites of Cocoa is a new site with daily Cocoa tips by Jake Marsh. All of his tips use Swift so far and he's doing a great job posting new tips every other day.", numberOfLikes: 19, interestId: "r1", userDidLike: false),
        Post(postId: "p6", author: User.allUsers()[0], createdAt: "today", postImage: UIImage(named: "p5")!, postText: "Little Bites of Cocoa is a new site with daily Cocoa tips by Jake Marsh. All of his tips use Swift so far and he's doing a great job posting new tips every other day.", numberOfLikes: 19, interestId: "r2", userDidLike: false),
        Post(postId: "p7", author: User.allUsers()[0], createdAt: "today", postImage: nil, postText: "We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea", numberOfLikes: 12, interestId: "r2", userDidLike: true),
        Post(postId: "p8", author: User.allUsers()[0], createdAt: "today", postImage: UIImage(named: "p6")!, postText: "Little Bites of Cocoa is a new site with daily Cocoa tips by Jake Marsh. All of his tips use Swift so far and he's doing a great job posting new tips every other day.", numberOfLikes: 19, interestId: "r2", userDidLike: false),
        Post(postId: "p9", author: User.allUsers()[0], createdAt: "today", postImage: nil, postText: "Little Bites of Cocoa is a new site with daily Cocoa tips by Jake Marsh. All of his tips use Swift so far and he's doing a great job posting new tips every other day.", numberOfLikes: 19, interestId: "r2", userDidLike: false),
        Post(postId: "p10", author: User.allUsers()[0], createdAt: "today", postImage: UIImage(named: "p7")!, postText: "Little Bites of Cocoa is a new site with daily Cocoa tips by Jake Marsh. All of his tips use Swift so far and he's doing a great job posting new tips every other day.", numberOfLikes: 19, interestId: "r2", userDidLike: false)
    ]
}

