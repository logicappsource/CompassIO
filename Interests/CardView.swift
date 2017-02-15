//
//  CardView.swift
//  CompassIO
//
//  Created by LogicAppSourceIO on 15/02/17.
//  Copyright © 2017 LogicAppSourceIO. All rights reserved.
//

import UIKit

class CardView: UIView {
    
    var cornerRadius: CGFloat = 3.0
    var shadowWidth: CGFloat = 0
    var shadowHeight: CGFloat = 1.0
    var shadowOpacity: Float = 0.2
    var shadowColor: UIColor = UIColor.black
    
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = false
        
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: shadowWidth, height: shadowHeight)
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
    
    required init(coder aDecoder : NSCoder) {
        super.init(coder: aDecoder)!
    }
    
}
