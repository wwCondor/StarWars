//  This version
//  ViewController.swift
//  SWAPI Awakens
//
//  Created by Wouter Willebrands on 02/04/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var splashView: UIView!
    
    // background view
    @IBOutlet weak var backgroundView: UIImageView!
    
    // splash entry button
    @IBOutlet weak var awakenAPIButton: UIButton!
    
    // view that holds the logo animation
    @IBOutlet weak var logoImageView: UIImageView!
    
    // This stores the array of logo images for the animation
    var logoImages: [UIImage] = []
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "menuSegue" {
            if identifier != "menuSegue" {
                return false
            }
        }

        return true
    }
    
    @IBAction func awakenButton(_ sender: UIButton) {

        // MARK: - Custom Alert Test
//        errorAlert(description: SwapiError.invalidData.localizedDescription) // test
        
    }
       
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Logo Animation
        // Here we create an instance of the logo animation class to make it available in the viewController
        let logoAnimation = LogoAnimation()
        
        // At splash screen an animated logo UIImageView is visible
        logoImages = logoAnimation.createLogoArray(total: 11, imagePrefix: "SWLogo") // Also see LogoAnimation.swift
        logoAnimation.animate(imageView: logoImageView, images: logoImages)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // awakenAPIButton and Logo start with alpha "0"
        awakenAPIButton.alpha = 0
        logoImageView.alpha = 0
        
        // awakenPAIButton starts outside top border of view
        awakenAPIButton.center.y  -= view.bounds.height
        
        // logo animation starts outside bottom border of view
        logoImageView.center.y += view.bounds.height
        
        // MARK: Button and Logo Fade Ins
        // This fades in the "Awaken" Button by animating its alpha back from value "0" to "1.0"
        awakenAPIButton.slowFadeIn()
        logoImageView.slowFadeIn()
        
        // MARK: Button and Logo Slide into View Animations
        // This animates the button and logo animation into view at splash
        
        UIView.animate(withDuration: 3.0,
                       delay: 0.0,
                       options: [.curveEaseOut],
                       animations: {
                        self.awakenAPIButton.center.y += self.view.bounds.height
                        self.logoImageView.center.y -= self.view.bounds.height
        },
                       completion: nil)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
  
    }

}

