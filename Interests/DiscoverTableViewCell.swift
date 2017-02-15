//
//  DiscoverTableViewCell.swift
//  CompassIO
//
//  Created by LogicAppSourceIO on 15/02/17.
//  Copyright © 2017 LogicAppSourceIO. All rights reserved.
//

import UIKit

class DiscoverTableViewCell: UITableViewCell {
    
    
    // MARK - Public API 
    var interest: Interest! {
        didSet{
            updateUI()
        }
    }
    
    
    @IBOutlet weak var backgroundViewWithShadow: CardView!
    @IBOutlet weak var interestTitleLabel: UILabel!
    @IBOutlet weak var joinButton: InterestButton!
    @IBOutlet weak var interestFeaturedImage: UIImageView!
    @IBOutlet weak var interestDescriptionLabel:UILabel!
    
    func updateUI () {
        interestTitleLabel.text! = interest.title
        interestFeaturedImage.image! = interest.featuredImage
        interestDescriptionLabel.text! = interest.description
        
        joinButton.setTitle("📌", for: .normal)
        
        
    }
    
    @IBAction func joinButtonClicked (sender: InterestButton){
        
    }

    

    
}
