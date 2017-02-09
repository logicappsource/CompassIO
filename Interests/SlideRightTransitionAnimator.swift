//
//  SlideRightTransitionAnimator.swift
//  CompassIO
//
//  Created by LogicAppSourceIO on 08/02/17.
//  Copyright © 2017 LogicAppSourceIO. All rights reserved.
//

import UIKit

class SlideRightTransitionAnimator: NSObject
{
    var duration = 1.0
    var isPresenting = false
}

extension SlideRightTransitionAnimator : UIViewControllerAnimatedTransitioning
{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // get reference to our fromView, toView and the container view
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        let container = transitionContext.containerView  // the view acts as the super view for the view in the transition
        
        // set up the transform we will use in the animation
        let offScreenLeft = CGAffineTransform(translationX: -container.frame.width, y: 0) // shift the whole view to the left, off screen
        //        let offScreenRight = CGAffineTransformMakeTranslation(container.frame.width, 0) // shift to the right
        let minimize = CGAffineTransform(scaleX: 0, y: 0) // the matrix to scale the x/y coordinate by provided factor
        //        let offScreenDown = CGAffineTransformMakeTranslation(0, container.frame.height) // how much to move the x/y axis
        let shiftDown = CGAffineTransform(translationX: 0, y: 15)
        let scaleDown = shiftDown.scaledBy(x: 0.8, y: 0.8)
        
        // make the toView off screen
        if isPresenting {
            let minimizeAndOffScreenLeft = minimize.concatenating(offScreenLeft)
            toView.transform = minimizeAndOffScreenLeft
        }
        
        // add both views to the container view
        if isPresenting {
            // if we are presenting, toView should be placed on top of fromView
            container.addSubview(fromView)
            container.addSubview(toView)
        } else {
            // dismiss, reverse the transition
            container.addSubview(toView)
            container.addSubview(fromView)
        }
        
        // perform the animation
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.4, options: [], animations: { () -> Void in
            
            if self.isPresenting {
                // take the toView to the main screen
                fromView.transform = scaleDown
                fromView.alpha = 0.5
                toView.transform = CGAffineTransform.identity
            } else {
                // dismissing
                // fromView is now the detail view to be dismissed
                fromView.transform = offScreenLeft
                toView.alpha = 1.0
                toView.transform = CGAffineTransform.identity
            }
            
        }) { (finished) -> Void in
            
            // we now complete the transition
            transitionContext.completeTransition(true)
        }
    }
}

extension SlideRightTransitionAnimator : UIViewControllerTransitioningDelegate
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


























