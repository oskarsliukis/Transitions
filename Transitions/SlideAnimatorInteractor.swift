//
//  SlideAnimatorInteractor.swift
//  Transitions
//
//  Created by Oskars Liukis on 3/9/16.
//  Copyright © 2016 OL. All rights reserved.
//

import UIKit

class SlideAnimatorInteractor: UIPercentDrivenInteractiveTransition {
    let gestureRecognizer = UIPanGestureRecognizer()
    var interactionInProgress = false
    weak var presentingViewController: UIViewController?
    
    override init() {
        super.init()
        gestureRecognizer.addTarget(self, action: "handlePan:")
    }
    
    func handlePan(recognizer: UIPanGestureRecognizer) {
        
        let translation = recognizer.translationInView(recognizer.view)
        let percentage = fabs(translation.x / CGRectGetWidth(recognizer.view!.bounds))
        
        let velocity = recognizer.velocityInView(recognizer.view).x
        
        var shouldComplete = false
        
        if (velocity > 400) {
            shouldComplete = true
        }
        if (percentage > 0.5) {
            shouldComplete = true
        }
        if (percentage < 0.1 && velocity > 350) {
            shouldComplete = true
        }
        
        switch recognizer.state {
        case .Began:
            interactionInProgress = true
            presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        case .Changed:
            updateInteractiveTransition(percentage * 0.3)
        case .Ended:
            interactionInProgress = false
            if (shouldComplete) {
                completionSpeed = 0.9
                finishInteractiveTransition()
            } else {
                completionSpeed = 0.2
                cancelInteractiveTransition()
            }
        case .Cancelled:
            completionSpeed = 0.2
            interactionInProgress = false
            cancelInteractiveTransition()
        default:
            break
        }
    }
}