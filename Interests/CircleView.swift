//
//  CircleView.swift
//  CompassIO
//
//  Created by LogicAppSourceIO on 21/02/17.
//  Copyright © 2017 LogicAppSourceIO. All rights reserved.
//

import UIKit

class CircleView: UIImageView {
    
    override func layoutSubviews() {
        layer.cornerRadius = self.frame.width / 2
        clipsToBounds = true
        
        
    }
}
