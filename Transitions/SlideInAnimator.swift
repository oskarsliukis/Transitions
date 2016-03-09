//
//  SlideInAnimator.swift
//  Project
//
//  Created by Oskars Liukis on 8/12/15.
//  Copyright (c) 2015 OL. All rights reserved.
//

import UIKit

class SlideInAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var direction: Direction = Direction.X
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let contextView = transitionContext.containerView()
        
        let finalFrame = transitionContext.finalFrameForViewController(toVC)
        
        switch(direction) {
        case Direction.Y:
            toVC.view.frame = CGRectMake(0, fromVC.view.bounds.size.height, finalFrame.size.width, finalFrame.size.height)
        case Direction.X:
            toVC.view.frame = CGRectMake(fromVC.view.bounds.size.height, 0, finalFrame.size.width, finalFrame.size.height)
        }
        
        contextView!.addSubview(toVC.view)
        
        fromVC.view.layer.zPosition = 0
        toVC.view.layer.zPosition = 1
        toVC.view.transform = CGAffineTransformMakeScale(0.9, 0.9)
        
    
        UIView.animateWithDuration(self.transitionDuration(transitionContext), delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            fromVC.view.transform=CGAffineTransformMakeScale(0.9, 0.9)
            fromVC.view.alpha = 0.8
        }) { (Bool) -> Void in
            
        }
        
        UIView.animateWithDuration(self.transitionDuration(transitionContext), delay: 0.2, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            toVC.view.transform = CGAffineTransformMakeScale(1, 1)
            toVC.view.frame = finalFrame
            }) { (Bool) -> Void in
                fromVC.view.alpha = 1
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
        
    }
}
