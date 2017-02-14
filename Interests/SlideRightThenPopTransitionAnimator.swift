//
//  SlideRightThenPopTransitionAnimator.swift
//  CompassIO
//
//  Created by LogicAppSourceIO on 14/02/17.
//  Copyright © 2017 LogicAppSourceIO. All rights reserved.
//

import UIKit

class SlideRightThenPopTransitionAnimator: NSObject {

    var duration = 0.6
    public var isPresenting = false
    
}


extension SlideRightThenPopTransitionAnimator : UIViewControllerTransitioningDelegate
{
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        isPresenting = false    // because we are dismissing
        return self
    }
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        isPresenting = true
        return self
    }
}


extension SlideRightThenPopTransitionAnimator: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)
        let containerView = transitionContext.containerView
        
        let offScreenLeft = CGAffineTransform(translationX: -containerView.frame.width, y: 0)
        let offScreenRight = CGAffineTransform(translationX: containerView.frame.width, y: 0)
        let minimize = CGAffineTransform(scaleX: 0.5,y: 0.5)
        let minimizeOffScreenLeft = offScreenLeft.concatenating(minimize) // maybe Reveres ofscreenleft - minimize
        
        if (isPresenting){
            toView?.transform = minimizeOffScreenLeft
        }
        
        if ( isPresenting) {
            containerView.addSubview(fromView!)
            containerView.addSubview(toView!)
            
        } else {
            containerView.addSubview(toView!)
            containerView.addSubview(fromView!)
        }
        
        
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.4, options: [], animations: { 
            
            let backToMainScreen = CGAffineTransform(translationX: 0,y: 0)
            
                if (self.isPresenting){
                    toView?.transform = minimize.concatenating(backToMainScreen)
                    fromView?.transform = offScreenRight
                } else {
                    fromView?.transform = minimize.concatenating(offScreenRight)
            }
            
            }, completion: nil)
        
        
        UIView.animate(withDuration: duration/2.0, delay: duration, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.4, options: [], animations: { 
            
            if (self.isPresenting) {
                toView?.transform = CGAffineTransform.identity
            } else {
                fromView?.transform = minimizeOffScreenLeft
                toView?.transform = CGAffineTransform.identity
            }
            
            }) { (finished) in
                if finished {
                    transitionContext.completeTransition(true)
                }
        }
        
    }
}
