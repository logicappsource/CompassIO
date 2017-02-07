//
//  CommentTableViewCell.swift
//  CompassIO
//
//  Created by LogicAppSourceIO on 06/02/17.
//  Copyright © 2017 LogicAppSourceIO. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    
    // MARK: - Public API
    var comment: Comment! {
        didSet{
            updateUI()
        }
    }
    
    
  
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var commentTextLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton! //Deisgnable bnt
    // MARK: - Private
    private var currentUserDidLike: Bool = false
    
    
    private func updateUI () {
        
        userNameLabel?.text = comment.user.fullName
        commentTextLabel?.text = comment.commentText
        likeButton.setTitle("👻 \(comment.numberOfLikes) Likes", for: .normal)
        
        configureButtonAppearance()
    }
    
    //Spring or designable button errror with weak . ->
    private func configureButtonAppearance () {
        /*
         likeButton.cornerRadius = 3.0
         likeButton.borderWidth = 2.0
         likeButton.borderColor = UIColor.lightGrayColor()
         
         */
        
    }
    //Designable btn 
    @IBAction func likeButtonClicked(_ sender: UIButton) {
        
        comment.userDidLike = !comment.userDidLike
        if (comment.userDidLike) {
            comment.numberOfLikes += 1
            
        }else {
            comment.numberOfLikes -= 1
        }
        
        self.likeButton.setTitle("👻 \(comment.numberOfLikes) Likes", for: .normal)
        currentUserDidLike = comment.userDidLike
        
        changeLikeButtonColor()
        
        /*
         //Animation
         sender.animation = "pop"
         sender.curve = "spring"
         sender.duration = 1.6
         sender.damping = 0.1
         sender.velocity = 0.2
         sender.animate()
         */
        
    }
    
    //UI BUTTON - change to designable
    private func changeLikeButtonColor() {
        /*
         if currentUserDidLike {
         likeButton.borderColor = UIColor.redColor()
         likeButton.tintColor = UIColor.redColor()
         } else {
         likeButton.borderColor = UIColor.lightGrayColor()
         likeButton.tintColor = UIColor.lightGrayColor()
         }
         */
    }
    
    

}
