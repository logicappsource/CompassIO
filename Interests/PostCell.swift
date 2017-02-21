//
//  PostCell.swift
//  CompassIO
//
//  Created by LogicAppSourceIO on 21/02/17.
//  Copyright © 2017 LogicAppSourceIO. All rights reserved.
//

import UIKit
import Firebase

class PostCell: UITableViewCell {
    
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
    
    
    func configureCell(post: PostFIRFeed) {
        self.post = post
        self.caption.text = post.caption
        //self.likesLbl.text = "\(post.likes)"
        
        
    }
    
    
}
