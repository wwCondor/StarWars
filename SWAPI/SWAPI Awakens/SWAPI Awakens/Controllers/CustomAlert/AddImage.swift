//
//  AlertImage.swift
//  SWAPI Awakens
//
//  Created by Wouter Willebrands on 07/05/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation
import UIKit

// Here we create an extension for the UIAlertController that handles customisation by adding an image
extension UIAlertController {
    
    func addImage(image: UIImage) {
        let maxSize = CGSize(width: 245, height: 300) // Sets maximum size for alert
        let imageSize = image.size // This holds the size of the image
        
        var ratio: CGFloat! // variable that holds the ratio
        
        // Depending on image orientation (landscape vs portrait we have different ways of dealing with it)
        if imageSize.width > imageSize.height {
            ratio = maxSize.width / imageSize.width
        } else {
            ratio = maxSize.height / imageSize.height
        }
        
        let scaledSize = CGSize(width: imageSize.width * ratio, height: imageSize.height * ratio)
        
        // This is the custom method "resize" for resizing the image used in the alert message
        var resizedImage = image.resize(scaledSize) // This is a variable since we make changes to our image
        
        // For "portrait" images we want to center it
        if (imageSize.height > imageSize.width) {
            let leading = (maxSize.width - resizedImage.size.width) / 2
            resizedImage = resizedImage.withAlignmentRectInsets(UIEdgeInsets(top: 0, left: -leading, bottom: 0, right: 0))
        }
        
        let imageAction = UIAlertAction(title: "", style: .default, handler: nil)
        
        imageAction.isEnabled = false // This makes sure users cannot click the image
        
        // Next we set the value for the key to "image" and
        imageAction.setValue(resizedImage.withRenderingMode(.alwaysOriginal), forKey: "image")
        self.addAction(imageAction)
    }
    
//    func addImageView(image: UIImage) -> UIImageView {
//
//        let imageView = UIImageView.
//
//        return imageView
//    }
    
//    func addImageView(image: UIImage) -> UIImageView {
//        
//        let errorImage = UIImage(named: "yediTrick")
//        
//        let imageViewSize = errorImage?.size
//        
//        return imageViewSize
//        
//    }
}
