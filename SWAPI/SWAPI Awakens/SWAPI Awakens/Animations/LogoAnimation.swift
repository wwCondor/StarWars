//
//  LogoAnimation.swift
//  SWAPI Awakens
//
//  Created by Wouter Willebrands on 01/05/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation
import UIKit

// This object takes care of the logo animation
class LogoAnimation {
    
    // This creates an array of images that is used for the UIImageView animation
    func createLogoArray(total: Int, imagePrefix: String) -> [UIImage] {
        
        // Create empty array to hold the images
        var logoArray: [UIImage] = []
        
        // Loop through images and add them to array
        for imageCount in 1...total {
            let imageName = "\(imagePrefix)\(imageCount)"
            let image = UIImage(named: imageName)! // can force unwrap as all images are hardcoded in app
            logoArray.append(image)
        }
        
        return logoArray
    }
    
    // This animates the logo images for splash view and loops them
    func animate(imageView: UIImageView, images: [UIImage]) {
        imageView.animationImages = images // array of images we iterate through
        imageView.animationDuration = 1.5 // duration of entire animation
        imageView.animationRepeatCount = 0 // if set at zero (or not set at all) it loops forever
        imageView.startAnimating()
    }
    
}
