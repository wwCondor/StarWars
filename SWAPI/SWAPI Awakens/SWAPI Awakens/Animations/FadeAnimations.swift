//
//  FadeAnimation.swift
//  SWAPI Awakens
//
//  Created by Wouter Willebrands on 23/09/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    // This fade in is used to fade in objects in the viewDidAppear sections in the intial viewController
    func slowFadeIn() {
        UIView.animate(withDuration: 3.0, delay: 0.3, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: nil)
    }
    
    // This fade in is used to fade in objects in the other viewControllers
    func quickFadeIn() {
        UIView.animate(withDuration: 1.5, delay: 0.3, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: nil)
    }
    
    func quickFadeOut() {
        UIView.animate(withDuration: 1.5, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.alpha = 0.0
        }, completion: nil)
    }

}

// Here we have an extension that allows fade in or out with customizalbility for the duration
extension UIView {
    func customFadeIn(_ duration: TimeInterval = 3.0, delay: TimeInterval = 0.3, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
        }, completion: completion)  }
    
    func customFadeOut(_ duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
    
}
