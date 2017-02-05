// ActionButton.swift
//
// The MIT License (MIT)
//
// Copyright (c) 2015 ActionButton
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

typealias ActionButtonItemAction = (ActionButtonItem) -> Void

public class ActionButtonItem: NSObject {
    
    var action: ActionButtonItemAction?
    var view: UIView!
    var text: String {
        get {
            return self.label.text!
        }
        
        set {
            self.label.text = newValue
        }
    }
    
    private var label: UILabel!
    private var button: UIButton!
    private var image: UIImage!
    private var labelBackground: UIView!
    private let viewSize = CGSize(width: 200, height: 35)
    private let buttonSize = CGSize(width: 35, height: 35)
    private let backgroundInset = CGSize(width: 10, height: 10)
    
    public init(title optionalTitle: String?, image: UIImage?) {
        super.init()
        
        self.view = UIView(frame: CGRect(origin: CGPointZero, size: self.viewSize))
        self.view.alpha = 0
        self.view.userInteractionEnabled = true
        self.view.backgroundColor = UIColor.clearColor()
        
        self.button = UIButton(type: .Custom) as UIButton
        self.button.frame = CGRect(origin: CGPoint(x: self.viewSize.width - self.buttonSize.width, y: 0), size: buttonSize)
        self.button.layer.shadowOpacity = 1
        self.button.layer.shadowRadius = 2
        self.button.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.button.layer.shadowColor = UIColor.grayColor().CGColor
        self.button.addTarget(self, action: "buttonPressed:", forControlEvents: .TouchUpInside)

        if let unwrappedImage = image {
            self.button.setImage(unwrappedImage, forState: .Normal)
        }
                
        if let text = optionalTitle where text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet()).isEmpty == false {
            self.label = UILabel()
            self.label.font = UIFont(name: "HelveticaNeue-Medium", size: 13)
            self.label.textColor = UIColor.darkGrayColor()
            self.label.textAlignment = .Right
            self.label.text = text
            self.label.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector("labelTapped:")))
            self.label.sizeToFit()
            
            self.labelBackground = UIView()
            self.labelBackground.frame = self.label.frame
            self.labelBackground.backgroundColor = UIColor.whiteColor()
            self.labelBackground.layer.cornerRadius = 3
            self.labelBackground.layer.shadowOpacity = 0.8
            self.labelBackground.layer.shadowOffset = CGSize(width: 0, height: 1)
            self.labelBackground.layer.shadowRadius = 0.2
            self.labelBackground.layer.shadowColor = UIColor.lightGrayColor().CGColor
            
            // Adjust the label's background inset
            self.labelBackground.frame.size.width = self.label.frame.size.width + backgroundInset.width
            self.labelBackground.frame.size.height = self.label.frame.size.height + backgroundInset.height
            self.label.frame.origin.x = self.label.frame.origin.x + backgroundInset.width / 2
            self.label.frame.origin.y = self.label.frame.origin.y + backgroundInset.height / 2
            
            // Adjust label's background position
            self.labelBackground.frame.origin.x = CGFloat(130 - self.label.frame.size.width)
            self.labelBackground.center.y = self.view.center.y
            self.labelBackground.addSubview(self.label)
            
            // Add Tap Gestures Recognizer
            let tap = UITapGestureRecognizer(target: self, action: Selector("labelTapped:"))
            self.view.addGestureRecognizer(tap)
            
            self.view.addSubview(self.labelBackground)
        }
        
        self.view.addSubview(self.button)
    }
        
    // MARK: - Button Action Methods
    
    func buttonPressed(sender: UIButton) {
        if let unwrappedAction = self.action {
            unwrappedAction(self)
        }
    }
    
    // MARK: - Gesture Recognizer Methods
    func labelTapped(gesture: UIGestureRecognizer) {
        if let unwrappedAction = self.action {
            unwrappedAction(self)
        }
    }
}
