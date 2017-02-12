//
//  PopTransitionAnimator.swift
//  CompassIO
//
//  Created by LogicAppSourceIO on 10/02/17.
//  Copyright © 2017 LogicAppSourceIO. All rights reserved.
//

import UIKit

class PopTransitionAnimator: NSObject {
    
    var duration = 1.0
    public var isPresenting = false
}



extension PopTransitionAnimator: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
}

extension PopTransitionAnimator: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        let containerView = transitionContext.containerView
        
        // transforms 
        let minimize = CGAffineTransform(scaleX: 0, y: 0)
        let offScreenDown = CGAffineTransform(translationX: 0, y: containerView.frame.height)
        let shiftDown  = CGAffineTransform(translationX: 0,y: 15)
        let scaleDown = shiftDown.scaledBy(x: 0.95, y: 0.95)
        
        toView.transform = minimize
        
        if(isPresenting) {
            containerView.addSubview(fromView)
            containerView.addSubview(toView)
        } else {
            containerView.addSubview(toView)
            containerView.addSubview(fromView)
        }
        
        
      UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.75, options: [], animations: { 
        
        if self.isPresenting {
            fromView.transform = scaleDown
            fromView.alpha = 0.5
            toView.transform = CGAffineTransform.identity
        }else {
                fromView.transform = offScreenDown
            toView.alpha = 1.0
            toView.transform = CGAffineTransform.identity
        }
        
        }) { (finished) in
            transitionContext.completeTransition(true)
        }
        
        
        
    }
}
