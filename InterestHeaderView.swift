//
//  InterestHeaderView.swift
//  CompassIO
//
//  Created by LogicAppSourceIO on 01/02/17.
//  Copyright © 2017 LogicAppSourceIO. All rights reserved.
//
import UIKit

protocol InterestHeaderViewDelegate {
    func closeButtonClicked()
}

class InterestHeaderView: UIView
{
    // MARK: - Public API
    var interest: Interest! {
        didSet {
            updateUI()
        }
    }
    
    
    var delegate: InterestHeaderViewDelegate! 
    
    fileprivate func updateUI()
    {
        backgroundImageView?.image! = interest.featuredImage
        interestTitleLabel?.text! = interest.title
        numberOfMembersLabel.text! = "\(interest.numberOfMembers)"
        numberOfPostsLabel.text! = "\(interest.numberOfPosts)"
        pullDownToCloseLabel.text! = "Pull down to close"
        pullDownToCloseLabel.isHidden = true
    }
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var interestTitleLabel: UILabel!
    @IBOutlet weak var numberOfMembersLabel: UILabel!
    @IBOutlet weak var numberOfPostsLabel: UILabel!
    @IBOutlet weak var pullDownToCloseLabel: UILabel!
    @IBOutlet weak var closeButtonBackgroundView: UIView!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        closeButtonBackgroundView.layer.cornerRadius = closeButtonBackgroundView.bounds.width / 2
        closeButtonBackgroundView.layer.masksToBounds = true
    }
}





