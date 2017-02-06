//
//  Comment.swift
//  ProjectInterest
//
//  Created by Duc Tran on 6/3/15.
//  Copyright (c) 2015 Developer Inspirus. All rights reserved.
//

import UIKit

class Comment
{
    var id: String = ""
    var createdAt: String = "today"
    let postId: String
    let user: User
    var commentText: String
    var numberOfLikes: Int
    
    init(id: String, createdAt: String, postId: String, author: User, commentText: String, numberOfLikes: Int)
    {
        self.id = id
        self.createdAt = createdAt
        self.postId = postId
        self.user = author
        self.commentText = commentText
        self.numberOfLikes = numberOfLikes
    }

    // dummy data 💩
    static func allComments() -> [Comment]
    {
        return [
            Comment(id: "c1", createdAt: "May 21", postId: "p1", author: User.allUsers()[0], commentText: "Hello I love this post! Isn't this a nice comment? Blehhhh 😜", numberOfLikes: 21),
            Comment(id: "c2", createdAt: "May 21", postId: "p1", author: User.allUsers()[0], commentText: "Hello I love this post! Isn't this a nice comment? Blehhhh 😜", numberOfLikes: 21),
            Comment(id: "c3", createdAt: "May 21", postId: "p1", author: User.allUsers()[0], commentText: "Hello I love this post! Isn't this a nice comment? Blehhhh 😜", numberOfLikes: 21),
            Comment(id: "c4", createdAt: "May 21", postId: "p1", author: User.allUsers()[0], commentText: "Hello I love this post! Isn't this a nice comment? Blehhhh 😜", numberOfLikes: 21),
            Comment(id: "c5", createdAt: "May 21", postId: "p1", author: User.allUsers()[0], commentText: "Hello I love this post! Isn't this a nice comment? Blehhhh 😜", numberOfLikes: 21)
        ]
    }
}
