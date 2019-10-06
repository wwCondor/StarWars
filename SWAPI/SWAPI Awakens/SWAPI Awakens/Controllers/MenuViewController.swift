//
//  MenuViewController.swift
//  SWAPI Awakens
//
//  Created by Wouter Willebrands on 22/09/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var menuViewObject: UIView?
    
    var itemSelected: ItemSelected? // This holds the selected item for the different catagories

    @IBOutlet weak var backgroundView: UIImageView!
    
    // Menu
    @IBOutlet var menuView: UIView!
    
    // the menu buttons
    @IBOutlet weak var characterButton: UIButton!
    @IBOutlet weak var vehicleButton: UIButton!
    @IBOutlet weak var starshipButton: UIButton!
    
    // which are contained in
    @IBOutlet weak var menuSelectionStack: UIStackView!
    

    @IBAction func selectItem(_ sender: UIButton) {
        
        sender.pulsate() // This calls the pulse method which makes the button pulse when pressed

        switch sender {
        case characterButton: itemSelected = ItemSelected.characters
        case vehicleButton: itemSelected = ItemSelected.vehicles
        case starshipButton: itemSelected = ItemSelected.starships
        default:
            break
        }
        
        performSegue(withIdentifier: "informationSegue", sender: self)

    }
    
    // This handles passing information from the menuViewcontroller over to the informationViewcontroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Here we make sure the selected Item gets transfered to the InformationViewController
        if segue.identifier == "informationSegue" {
            let destinationViewController = segue.destination as? InformationViewController
            destinationViewController?.selectedItem = itemSelected
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MenuSelectionStack/backgroundView start faded out
        menuSelectionStack.alpha = 0
        backgroundView.alpha = 0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // MenuSelectionStack/backgroundView fade in from black
        self.menuSelectionStack.quickFadeIn()
        self.backgroundView.quickFadeIn()
        
    }
    
    
}
