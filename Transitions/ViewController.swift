//
//  ViewController.swift
//  Transitions
//
//  Created by Oskars Liukis on 3/9/16.
//  Copyright © 2016 OL. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let animatorInteractor = SlideAnimatorInteractor()
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        animatorInteractor.presentingViewController = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = getRandomColor()
    }
    
    func getRandomColor() -> UIColor{
        let randomRed:CGFloat = CGFloat(drand48())
        let randomGreen:CGFloat = CGFloat(drand48())
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    // MARK: IBAction
    
    @IBAction func pushController(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyboard.instantiateViewControllerWithIdentifier("ViewController")
        nextViewController.view.addGestureRecognizer(animatorInteractor.gestureRecognizer)
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
        return SlideInAnimator()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SlideOffAnimator()
    }
    
    func interactionControllerForPresentation(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return animatorInteractor.interactionInProgress ? animatorInteractor : nil;
    }
    
    func interactionControllerForDismissal(animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return animatorInteractor.interactionInProgress ? animatorInteractor : nil;
    }
}

