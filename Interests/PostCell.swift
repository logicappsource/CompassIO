//
//  PostCell.swift
//  CompassIO
//
//  Created by LogicAppSourceIO on 21/02/17.
//  Copyright © 2017 LogicAppSourceIO. All rights reserved.
//

import UIKit
import Firebase


class PostCell: UITableViewCell { //Configured in the feedvc
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var postImg: UIImageView!
    @IBOutlet weak var caption: UITextView!
    @IBOutlet weak var likesLbl: UILabel!
    @IBOutlet weak var likeImg: UIImageView!
    
    var post: PostFIRFeed!
    var likesRef: FIRDatabaseReference!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //Initialization code
        
    }
    
    
    func configureCell(post: PostFIRFeed, img: UIImage? = nil) {
        self.post = post
        self.caption.text = post.caption
        self.likesLbl.text = "\(post.likes)"

        
        
        //Download image //check if cache first //Use GUARD?
        //Dont load first 2 image.
        //"Object postImg/C331AF98-9D6F-4908-BF1F-0AF759944E9D does not exist."
        //("Object postImg/CFE70F72-C481-45F4-8793-163674ADB666 does not exist.")
        
        if img != nil {
            self.postImg.image = img
            
        } else { //NEver executes this line
            print("palle:fail")
            
                let ref = FIRStorage.storage().reference(forURL: post.imageUrl)
                ref.data(withMaxSize: 2 * 1024 * 1024, completion: { (data, error) in
                    
                    if error != nil {
                        print("palle: Unable to download iamge from Firebase storage \(error?.localizedDescription)") //Error msg = Object missing
                        
                    }else {
                        print("palle: Image downloaded from firebase")
                        if let imgData = data {
                            if let img = UIImage(data: imgData) {
                                    self.postImg.image = img
                                    FeedVC.imageCache.setObject(img, forKey: post.imageUrl as NSString ) //uden NSSTring  CACHING
                             }
                          }
                        }
                    })
                }
            }
    
    
        }


