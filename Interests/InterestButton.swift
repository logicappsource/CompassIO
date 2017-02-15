//
//  InterestButton.swift
//  CompassIO
//
//  Created by LogicAppSourceIO on 15/02/17.
//  Copyright © 2017 LogicAppSourceIO. All rights reserved.
//

import UIKit

class InterestButton: UIButton {

        // MARK: - Public API
    var color = UIColor.lightGray {
        didSet {
            borderColor = self.color.cgColor
            self.layer.borderColor = self.borderColor
            buttonTintColor = self.color
            self.tintColor = buttonTintColor
            
        }
    }
    
    // MARK: - Private 
    private var borderWidth: CGFloat = 2.0
    private var cornerRadius: CGFloat = 3.0
    private var buttonTintColor: UIColor = UIColor.lightGray
    private var borderColor: CGColor = UIColor.lightGray.cgColor
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        borderColor = self.color.cgColor
        buttonTintColor = self.color
        
        layer.borderColor = self.borderColor
        layer.borderWidth = self.borderWidth
        layer.cornerRadius = self.cornerRadius
        layer.masksToBounds = true
        self.tintColor = buttonTintColor
        
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    
    
    
    
    
}
