//
//  ButtonPulseExtension.swift
//  SWAPI Awakens
//
//  Created by Wouter Willebrands on 02/04/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

// This button extension handles the pulse animation when a buttons is pressed 
extension UIButton {
    
    func pulsate() {
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.2 // Specifies the basic duration of the animation, in seconds.
        pulse.fromValue = 0.99 // Defines the value the receiver uses to start interpolation.
        pulse.toValue = 1.01 // Defines the value the receiver uses to end interpolation.
        pulse.autoreverses = true // Determines if the receiver plays in the reverse upon completion.
        pulse.repeatCount = 2.0 // Determines the number of times the animation will repeat.
        pulse.initialVelocity = 0.5 // The initial velocity of the object attached to the spring.
        pulse.damping = 4.0 // Defines how the spring’s motion should be damped due to the forces of friction.

        layer.add(pulse, forKey: nil)
    }
}

