//
//  SlideInAnimator.swift
//  Project
//
//  Created by Oskars Liukis on 8/12/15.
//  Copyright (c) 2015 OL. All rights reserved.
//

import Foundation
import UIKit

class SlideOffAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var direction: Direction = Direction.Y
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.4
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        
        let contextView = transitionContext.containerView()
        let finalFrame = transitionContext.finalFrameForViewController(toVC)
        
        contextView?.addSubview(toVC.view)
        toVC.view.transform = CGAffineTransformMakeScale(0.9, 0.9)
        fromVC.view.layer.zPosition = 1
        toVC.view.layer.zPosition = 0
        toVC.view.alpha = 0.8
        
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            switch (self.direction) {
            case .X:
                fromVC.view.frame = CGRectMake(fromVC.view.frame.size.width, 0, fromVC.view.frame.size.width, fromVC.view.frame.size.height)
            case .Y:
                fromVC.view.frame = CGRectMake(0, fromVC.view.frame.size.height, fromVC.view.frame.size.width, fromVC.view.frame.size.height)
            }
            
            
            toVC.view.transform=CGAffineTransformMakeScale(1, 1)
            toVC.view.frame=finalFrame
            toVC.view.alpha = 1
            
            }) { (finished) -> Void in
                transitionContext.completeTransition(true)
        }
    }
}
