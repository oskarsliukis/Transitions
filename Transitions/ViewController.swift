//
//  ViewController.swift
//  Transitions
//
//  Created by Oskars Liukis on 3/9/16.
//  Copyright © 2016 OL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBAction func pushController(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyboard.instantiateViewControllerWithIdentifier("ViewController")
        nextViewController.transitioningDelegate = self
        presentViewController(nextViewController, animated: true, completion: nil)
    }
    
    @IBAction func popController(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    // MARK: UIViewControllerTransitioningDelegate
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = SlideInAnimator()
        animator.direction = Direction.Y
        return animator
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let animator = SlideOffAnimator()
        animator.direction = Direction.Y
        return animator
    }
}

