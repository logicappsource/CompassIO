//
//  PostTableViewCell.swift
//  CompassIO
//
//  Created by LogicAppSourceIO on 01/02/17.
//  Copyright © 2017 LogicAppSourceIO. All rights reserved.
//

import UIKit
import Foundation
import Firebase

class PostTableViewCell: UITableViewCell { //SHould be edited
    
    
    //UI Button -> Action Code
    
    
    
 
    // MARK: - Public API 
    var post: Post! {
        didSet{
            updateUI()
        }
    }
    
    
    @IBOutlet weak var userProfileImageView: UIImageView!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton! // DESIgnable button
    @IBOutlet weak var commentButton: UIButton! //Designable BUtton
    
   
   /*Implement data to ui from existing db fir reference*/
    var psot: PostFIRFeed!
    var likesRef: FIRDatabaseReference!
    
    
    
    

    
    // MARK: - Private 
    private var currentUserDidLike: Bool = false
    
    
    
    private func updateUI () {
        
        userProfileImageView?.image = post.user.profileImage
        userNameLabel?.text = post.user.fullName
        createdAtLabel?.text = post.createdAt
        postImageView?.image = post.postImage
        postTextLabel?.text = post.postText
        
        // Rounded post image view,  profile image 
        postImageView?.layer.cornerRadius = 5.0
        postImageView?.layer.masksToBounds = true
        
        userProfileImageView?.layer.cornerRadius = userProfileImageView.bounds.width  / 2
        userProfileImageView?.layer.masksToBounds = true
        
        likeButton.setTitle("👻 \(post.numberOfLikes) Likes", for: .normal)
        
        configureButtonAppearance()
    }
    
    //Spring or designable button errror with weak . ->
    private func configureButtonAppearance () {
        /*
        likeButton.cornerRadius = 3.0
        likeButton.borderWidth = 2.0
        likeButton.borderColor = UIColor.lightGrayColor()
        
        commentButton.cornerRadius = 3.0
        commentButton.borderWidth = 2.0
        commentButton.borderColor = UIColor.lightGrayColor()
        */
        
    }
    
    @IBAction func likeButtonClicked(_ sender: UIButton) {
        
        post.userDidLike = !post.userDidLike
        if (post.userDidLike) {
            post.numberOfLikes += 1
            
        }else {
            post.numberOfLikes -= 1
        }
        
           self.likeButton.setTitle("👻 \(post.numberOfLikes) Likes", for: .normal)
        
            currentUserDidLike = post.userDidLike
        
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
    //Designable butn 
    @IBAction func commentButtonClicked(sender: UIButton){
        
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
    
    
    
}
