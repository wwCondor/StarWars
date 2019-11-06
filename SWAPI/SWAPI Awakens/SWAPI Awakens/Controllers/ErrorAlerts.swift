//
//  ErrorAlerts.swift
//  SWAPI Awakens
//
//  Created by Wouter Willebrands on 13/04/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//


// Extension for ViewController that shows an alert when an error has occured
// Note: These need to be called wherever the error can occur
import Foundation
import UIKit

// Here we customized the default alert by writing custom methods for it
// Note: It could be, since this is not intended by Apple, this might not be possible in future like this
// A better approach would be to to create overlay view controller (next project)
extension InformationViewController {
    
    // This is the function that can be called when user needs to be alerted of an error
    func errorAlert(description: String) {
        
        // The errors have the title "SwapiError" of which each has its own localized description
        let alert = UIAlertController(title: "SwapiError", message: description, preferredStyle: .alert)
        
        let subView = alert.view.subviews.first! as UIView
        let alertContentView = subView.subviews.first! as UIView
        
        // Here we access the alertView backgroundColor to set its color
        alert.view.subviews.first?.subviews.first?.subviews.first?.backgroundColor = UIColor(named: "MeteoriteGray")
        
        alert.view.tintColor = UIColor(named: "HothBlue")
        
        alertContentView.layer.borderWidth = 2
        alertContentView.layer.cornerRadius = 10
        alertContentView.layer.borderColor = UIColor(named: "LogoGold")?.cgColor // This sets the border UIColor as a CGColor
        alertContentView.layer.cornerRadius = 10

        let errorImage = UIImage(named: "yediTrick")
        
        let imageView = UIImageView(image: errorImage)
        
        imageView.layer.cornerRadius = 10
        
        alert.addImage(image: errorImage!) // Image is hardcoded in app
        
        // Here we create a "confirm" action button so the user is able to dismiss the alert message
        let confirm = UIAlertAction(title: "This is not the error I'm looking for", style: .default) {
            (action) in alert.dismiss(animated: true, completion: nil).self
        }
        
        // Here we add the action to the alert message
        alert.addAction(confirm)
        
        // When presented the alert needs to be shown on the viewController
        self.present(alert, animated: true, completion: nil)

    }
    
}
