//
//  InformationViewController.swift
//  SWAPI Awakens
//
//  Created by Wouter Willebrands on 22/09/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var backgroundView: UIImageView!
    
    // return to main menu
    @IBOutlet weak var dismissButton: UIButton!
    
    // conversion button
    @IBOutlet weak var convertButton: UIButton!
    
    // Information Labels
    @IBOutlet weak var headerTitleLabel: UILabel!
    @IBOutlet weak var subheaderLabel: UILabel!
    
    // All individual labels that hold item and value for item information
    @IBOutlet weak var bornLabel: UILabel!
    @IBOutlet weak var homeLabel: UILabel!
    @IBOutlet weak var heightLabel: UILabel!
    @IBOutlet weak var eyesLabel: UILabel!
    @IBOutlet weak var hairLabel: UILabel!
    
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var planetLabel: UILabel!
    @IBOutlet weak var heightValueLabel: UILabel!
    @IBOutlet weak var eyeColorLabel: UILabel!
    @IBOutlet weak var hairColorLabel: UILabel!
    
    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var unitsLabel: UILabel!
    
    @IBOutlet weak var smallestLabel: UILabel!
    @IBOutlet weak var largestLabel: UILabel!
    
    @IBOutlet weak var smallestItemLabel: UILabel!
    @IBOutlet weak var largestItemLabel: UILabel!
    
    @IBOutlet weak var associatedVehicleDataLabel: UILabel!
    @IBOutlet weak var associatedStarshipDataLabel: UILabel!
    
    @IBOutlet weak var picker: UIPickerView!
    
    // Not sure if  these outlets are used
    @IBOutlet weak var informationOverviewStack: UIStackView! // the main information overview stack
    @IBOutlet weak var associatedStack: UIStackView! // associated vehicles/starships stack

    var selectedItem: ItemSelected? // This is where we store the selection
    
    var conversionRate: Double = 2.0 // Used to convert between GC and USD
        
    let client = Client() // Here we create an instance of client object
    
    var allCharacters: [Character]?
    var allVehicles: [Vehicle]?
    var allStarships: [Starship]?
    
    var filteredCharacterData: [Character]?
    var filteredVehicleData: [Vehicle]?
    var filteredStarshipData: [Starship]?
    
    @IBAction func dismissCurrentSelectionButton(_ sender: UIButton) {
        
        sender.pulsate() // This calls the pulse method which makes the button pulse when pressed
        
        // Here we dismiss the informationViewController 
        dismiss(animated: true, completion: nil)
        
    }
    
    // MARK: Clear Label Data
    
    // This method sets the label content to "-" in case a character has no value for the label
    func clearLabelData() {
        yearLabel.text = "-"
        planetLabel.text = "-"
        heightValueLabel.text = "-"
        eyeColorLabel.text = "-"
        hairColorLabel.text = "-"
        
        associatedVehicleDataLabel.text = "-"
        associatedStarshipDataLabel.text = "-"
        
    }

    // MARK: Get Data
    // With the data we fill the labels for the initial load, before interaction with picker
    func getData(forSelection: ItemSelected) {
        
        // When obtaining data we start the activity indicator
        let activityAnimationToggle = activityIndicator
        activityAnimationToggle?.startAnimating()
        
        // First we check wether a selection has been made
        guard let menuSelection = selectedItem else { return }
        // MARK: HERE
        switch menuSelection {
        case .characters:
            // We call the method to fetch all characters
            Client.fetchCharacters { (characters, error) in
                DispatchQueue.main.async {
                    //  First we check wether we have characters
                    guard let characters = characters else {
                        self.errorAlert(description: CharacterError.noCharacters.localizedDescription)
                        return
                    }
                    
                    self.allCharacters = characters // When we do we assign them to the character array
                    self.updateCharacterData(with: characters[0]) // Update character data for the first character
                    
                    self.picker.reloadAllComponents() // And reload the picker

                    Client.getHomeworld(for: characters[0]) { (planet, error) in
                        DispatchQueue.main.async {
                            guard let planet = planet else {
                                self.errorAlert(description: CharacterError.noPlanet.localizedDescription)
                                return
                            }
                            
                            self.planetLabel.text = planet.name
                        }
                        
                    }
                    
                    Client.getAssociatedVehicle(for: characters[0]) { (vehicle, error) in
                        DispatchQueue.main.async {
                            guard let vehicle = vehicle else {
                                self.errorAlert(description: CharacterError.noAssociatedVehicles.localizedDescription)
                                return
                            }
                            self.associatedVehicleDataLabel.text = vehicle.name
                        }
                    }
                    
                    Client.getAssociatedStarship(for: characters[0]) { (starship, error) in
                        DispatchQueue.main.async {
                            guard let starship = starship else {
                                self.errorAlert(description: CharacterError.noAssociatedStarships.localizedDescription)
                                return
                            }
                            self.associatedStarshipDataLabel.text = starship.name
                        }
                    }
                    
                    activityAnimationToggle?.stopAnimating() // stop the activity indicator
                }
            }
             
        case ItemSelected.vehicles:
            // We call the method to fetch all vehicles
            Client.fetchVehicles { (vehicles, error) in
                DispatchQueue.main.async {
                    //  First we check wether we have vehicles
                    guard let vehicles = vehicles else {
                        self.errorAlert(description: VehicleError.noVehicles.localizedDescription)
                        return
                    }
                    
                    self.allVehicles = vehicles // When we do we assign them to the vehicle array
                    self.updateVehicleData(with: vehicles[0]) // Update character data for the first vehicle
                    
                    self.picker.reloadAllComponents() // And reload the picker

                    activityAnimationToggle?.stopAnimating() // stop the activity indicator
                }
            }
            
        case ItemSelected.starships:
            // We call the method to fetch all starships
            Client.fetchStarships { (starships, error) in
                DispatchQueue.main.async {
                    //  First we check wether we have starship
                    guard let starships = starships else {
                        self.errorAlert(description: StarshipError.noStarships.localizedDescription)
                        return
                    }
                    
                    self.allStarships = starships // When we do we assign them to the character array
                    self.updateStarshipData(with: starships[0]) // Update character data for the first character
                    
                    self.picker.reloadAllComponents() // And reload the picker
 
                    activityAnimationToggle?.stopAnimating() // stop the activity indicator
                }
            }
        }
    }
    
    // MARK: Update Labelinformation Content Methods
    func updateCharacterData(with character: Character) {
        clearLabelData()
        
        // We unwrap each optional before updating the label content
        guard let characterName = character.name else {
            self.errorAlert(description: CharacterError.noName.localizedDescription)
            return
        }
        self.subheaderLabel.text = characterName
        
        Client.getHomeworld(for: character) { (planet, error) in
            DispatchQueue.main.async {
                if let planet = planet {
                    self.planetLabel.text = planet.name
                } else {
                    self.errorAlert(description: CharacterError.noPlanet.localizedDescription)
                }
            }
        }
        
        guard let birthYear = character.birthYear else {
            self.errorAlert(description: CharacterError.noBirthYear.localizedDescription)
            return
        }
        self.yearLabel.text = birthYear
        
        guard let characterHeight = character.height else {
            self.errorAlert(description: CharacterError.noHeight.localizedDescription)
            return
        }
        self.heightValueLabel.text = "\(characterHeight)"
        
        guard let eyeColor = character.eyeColor else {
            self.errorAlert(description: CharacterError.noEyeColor.localizedDescription)
            return
        }
        self.eyeColorLabel.text = eyeColor
        
        guard let hairColor = character.hairColor else {
            self.errorAlert(description: CharacterError.noHairColor.localizedDescription)
            return
        }
        self.hairColorLabel.text = hairColor
        
        guard let allCharacters = self.allCharacters else { return }
        let sortedCharacters = Client.findShortestAndTallestCharacter(characters: allCharacters)
        self.smallestItemLabel.text = sortedCharacters.0?.name
        self.largestItemLabel.text = sortedCharacters.1?.name
        
        Client.getAssociatedVehicle(for: character) { (vehicle, error) in
            DispatchQueue.main.async {
                if let vehicle = vehicle {
                    self.associatedVehicleDataLabel.text = vehicle.name
                } else {
                    self.errorAlert(description: CharacterError.noAssociatedVehicles.localizedDescription)
                }
            }
        }
            
        Client.getAssociatedStarship(for: character) { (starship, error) in
            DispatchQueue.main.async {
                if let starship = starship {
                    self.associatedStarshipDataLabel.text = starship.name
                } else {
                    self.errorAlert(description: CharacterError.noAssociatedStarships.localizedDescription)
                }
            }
        }
        
    }
    
    func updateVehicleData(with vehicle: Vehicle) {
        clearLabelData()
        DispatchQueue.main.async {
            // We unwrap each optional before updating the label content
            guard let vehicleName = vehicle.name else {
                self.errorAlert(description: VehicleError.noName.localizedDescription)
                return
            }
            self.subheaderLabel.text = vehicleName
            
            guard let vehicleModel = vehicle.model else {
                self.errorAlert(description: VehicleError.noModel.localizedDescription)
                return
            }
            self.yearLabel.text = vehicleModel
            
            guard let costInCredeits = vehicle.costInCredits else {
                self.errorAlert(description: VehicleError.noCost.localizedDescription)
                return
            }
            self.planetLabel.text = "\(costInCredeits)"
            
            guard let lenghtInMeters = vehicle.length else {
                self.errorAlert(description: VehicleError.noLenght.localizedDescription)
                return
            }
            self.heightValueLabel.text = "\(lenghtInMeters)"
            
            guard let vehicleClass = vehicle.vehicleClass else {
                self.errorAlert(description: VehicleError.noClass.localizedDescription)
                return
            }
            self.eyeColorLabel.text = vehicleClass
            
            guard let crew = vehicle.crew else {
                self.errorAlert(description: VehicleError.noCrew.localizedDescription)
                return
            }
            self.hairColorLabel.text = crew
            
            guard let allVehicles = self.allVehicles else { return }
            let sortedVehicles = Client.findShortestAndLongestVehicle(vehicles: allVehicles)
            self.smallestItemLabel.text = sortedVehicles.0?.name
            self.largestItemLabel.text = sortedVehicles.1?.name
            
        }
    }
    
    func updateStarshipData(with starship: Starship) {
        clearLabelData()
        DispatchQueue.main.async {
            // We unwrap each optional before updating the label content
            guard let starshipName = starship.name else {
                self.errorAlert(description: StarshipError.noName.localizedDescription)
                return
            }
            self.subheaderLabel.text = starshipName
            
            guard let starshipModel = starship.model else {
                self.errorAlert(description: StarshipError.noModel.localizedDescription)
                return
            }
            self.yearLabel.text = starshipModel
            
            guard let costInCredeits = starship.costInCredits else {
                self.errorAlert(description: StarshipError.noCost.localizedDescription)
                return
            }
            self.planetLabel.text = "\(costInCredeits)"
            
            guard let lenghtInMeters = starship.length else {
                self.errorAlert(description: StarshipError.noLenght.localizedDescription)
                return
            }
            self.heightValueLabel.text = "\(lenghtInMeters)"
            
            guard let starshipClass = starship.starshipClass else {
                self.errorAlert(description: StarshipError.noClass.localizedDescription)
                return
            }
            self.eyeColorLabel.text = starshipClass
            
            guard let crew = starship.crew else {
                self.errorAlert(description: StarshipError.noCrew.localizedDescription)
                return
            }
            self.hairColorLabel.text = crew
            
            guard let allStarships = self.allStarships else { return }
            let sortedStarships = Client.findShortestAndLongestStarship(starships: allStarships)
            self.smallestItemLabel.text = sortedStarships.0?.name
            self.largestItemLabel.text = sortedStarships.1?.name
        }
    }
    
    // MARK: Update Informationlabel Methods
    func updateInformationLabels(updateFor: ItemSelected) {
        guard let menuSelection = selectedItem else { return }
        
        smallestItemLabel.text = "-"
        largestItemLabel.text = "-"
    
        switch menuSelection {
        case .characters:
            headerTitleLabel.text = ItemSelected.characters.stringValue
            bornLabel.text = "Born"
            homeLabel.text = "Home"
            heightLabel.text = "Height"
            eyesLabel.text = "Eyes"
            hairLabel.text = "Hair"
            
            smallestLabel.text = "Shortest"
            largestLabel.text = "Tallest"
            
            // When Character is selected in menu the "associated with" labels will be used
            associatedStack.isHidden = false
            creditLabel.isHidden = true
            unitsLabel.text = "cm" // Default is centimers
            
            associatedVehicleDataLabel.text = "-"
            associatedStarshipDataLabel.text = "-"
            
        case .vehicles:
            headerTitleLabel.text = ItemSelected.vehicles.stringValue
            bornLabel.text = "Make"
            homeLabel.text = "Cost"
            heightLabel.text = "Lenght"
            eyesLabel.text = "Class"
            hairLabel.text = "Crew"
            
            smallestLabel.text = "Shortest"
            largestLabel.text = "Longest"
            
            // When Vehicle is selected in menu the "associated with" labels will be hidden
            associatedStack.isHidden = true
            creditLabel.isHidden = false
            
//            creditLabel.text = "GC"
            unitsLabel.text = "m" // Default is meters
            
        case .starships:
            headerTitleLabel.text = ItemSelected.starships.stringValue
            bornLabel.text = "Make"
            homeLabel.text = "Cost"
            heightLabel.text = "Lenght"
            eyesLabel.text = "Class"
            hairLabel.text = "Crew"
            
            smallestLabel.text = "Shortest"
            largestLabel.text = "Longest"
            
            // When Starship is selected in menu the "associated with" labels will be hidden
            associatedStack.isHidden = true
            creditLabel.isHidden = false
            
//            creditLabel.text = "GC"
            unitsLabel.text = "m" // Default is meters

        }
        
    }
    
    // MARK: Convert Button
    @IBAction func convertButton(_ sender: UIButton) {

        guard let menuSelection = selectedItem else { return }
        guard let value = Double(heightValueLabel.text!) else { return } // Check if label has content

        switch menuSelection {
        case .characters:
            if unitsLabel.text == "cm" {
                // If it == "cm" we do something and then set it to "inch"
                let inches = value / 2.54
                heightValueLabel.text = String(format: "%.2f", inches)
                unitsLabel.text = "inch"
            } else if unitsLabel.text == "inch" {
                // If it == "inch" we do something and then set it to "cm"
                let centimers = value * 2.54
                heightValueLabel.text = String(format: "%.0f", centimers)
                unitsLabel.text = "cm"
            }
            
            // When the button has been clicked the label content will fade out and, once converted, the new content will fade in
            self.heightValueLabel.customFadeOut(0.3, delay: 0) { (finished: Bool) -> Void in
                self.heightValueLabel.customFadeIn(0.3, delay: 0)
            }
            self.unitsLabel.customFadeOut(0.3, delay: 0) { (finished: Bool) -> Void in
                self.unitsLabel.customFadeIn(0.3, delay: 0)
            }
            
            return
        case .vehicles:
            
            // Convert credits
            if creditLabel.text == "GC" {
                // If cost != "unknown" we can convert
                if planetLabel.text != "unknown" {
                    guard let cost = Double(planetLabel.text!) else { return }
                    let USDollars = cost / conversionRate
                    planetLabel.text = String(format: "%.0f", USDollars)
                    creditLabel.text = "USD"
                } else {
                    creditLabel.text = "USD"
                }
            } else if creditLabel.text == "USD" {
                if planetLabel.text != "unknown" {
                    guard let cost = Double(planetLabel.text!) else { return }
                    let galacticCredits = cost * conversionRate
                    planetLabel.text = String(format: "%.0f", galacticCredits)
                    creditLabel.text = "USD"
                    creditLabel.text = "GC"
                } else {
                    creditLabel.text = "GC"
                }
            }
            
            // Convert length
            if unitsLabel.text == "m" {
                // If it == "cm" we do something and then set it to "inch"
                let ft = value * 3.28
                heightValueLabel.text = String(format: "%.2f", ft)
                unitsLabel.text = "ft"
            } else if unitsLabel.text == "ft" {
                // If it == "inch" we do something and then set it to "cm"
                let meters = value / 3.28
                heightValueLabel.text = String(format: "%.1f", meters)
                unitsLabel.text = "m"
            }
            
            // Fades the label, that changed due to exchange rate input, out then in again
            self.creditLabel.customFadeOut(0.3, delay: 0) { (finished: Bool) -> Void in
                self.creditLabel.customFadeIn(0.3, delay: 0)
            }
            self.planetLabel.customFadeOut(0.3, delay: 0) { (finished: Bool) -> Void in
                self.planetLabel.customFadeIn(0.3, delay: 0)
            }

            self.unitsLabel.customFadeOut(0.3, delay: 0) { (finished: Bool) -> Void in
                self.unitsLabel.customFadeIn(0.3, delay: 0)
            }
            self.heightValueLabel.customFadeOut(0.3, delay: 0) { (finished: Bool) -> Void in
                self.heightValueLabel.customFadeIn(0.3, delay: 0)
            }
            return
        case .starships:
            
            if creditLabel.text == "GC" {
                // If cost != "unknown" we can convert
                if planetLabel.text != "unknown" {
                    guard let cost = Double(planetLabel.text!) else { return }
                    let USDollars = cost / conversionRate
                    planetLabel.text = String(format: "%.0f", USDollars)
                    creditLabel.text = "USD"
                } else {
                    creditLabel.text = "USD"
                }
            } else if creditLabel.text == "USD" {
                if planetLabel.text != "unknown" {
                    guard let cost = Double(planetLabel.text!) else { return }
                    let galacticCredits = cost * conversionRate
                    planetLabel.text = String(format: "%.0f", galacticCredits)
                    creditLabel.text = "USD"
                    creditLabel.text = "GC"
                } else {
                    creditLabel.text = "GC"
                }
            }
            
            if unitsLabel.text == "m" {
                // If it == "cm" we do something and then set it to "inch"
                let ft = value * 3.28
                heightValueLabel.text = String(format: "%.0f", ft)
                unitsLabel.text = "ft"
            } else if unitsLabel.text == "ft" {
                // If it == "inch" we do something and then set it to "cm"
                let meters = value / 3.28
                heightValueLabel.text = String(format: "%.2f", meters)
                unitsLabel.text = "m"
            }
            
            // Fades the label, that changed due to exchange rate input, out then in again
            self.creditLabel.customFadeOut(0.3, delay: 0) { (finished: Bool) -> Void in
                self.creditLabel.customFadeIn(0.3, delay: 0)
            }
            self.planetLabel.customFadeOut(0.3, delay: 0) { (finished: Bool) -> Void in
                self.planetLabel.customFadeIn(0.3, delay: 0)
            }

            self.unitsLabel.customFadeOut(0.3, delay: 0) { (finished: Bool) -> Void in
                self.unitsLabel.customFadeIn(0.3, delay: 0)
            }
            self.heightValueLabel.customFadeOut(0.3, delay: 0) { (finished: Bool) -> Void in
                self.heightValueLabel.customFadeIn(0.3, delay: 0)
            }
            return
        }
        
    }
    
    // MARK: Exchange rate input
    @objc func launchConversionRateEditor(sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: nil, message: "Here you can change the conversion rate used to convert between Galactic Credits and US Dollars.", preferredStyle: .alert)
        alert.addTextField { (textfield) in
            textfield.placeholder = "Enter a number"
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let setRate = UIAlertAction(title: "Set Rate", style: .default) { action -> Void in
            
            guard let textField = alert.textFields?.first, let input = textField.text else { return }
            
            guard let number = Double(input) else {
                self.errorAlert(description: ConversionError.invalidInput.localizedDescription)
                return
            }
            
            if number <= 0 {
                self.errorAlert(description: ConversionError.negativeOrZero.localizedDescription)
            } else {
                self.conversionRate = number
            }
        }

        alert.addAction(setRate)
        alert.addAction(cancel)
        
        present(alert, animated: true, completion: nil)
        
    }

    func setupLabelTap() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(launchConversionRateEditor))
        self.creditLabel.isUserInteractionEnabled = true
        self.creditLabel.addGestureRecognizer(tap)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearLabelData()
        setupLabelTap()
        
        // First we make sure we have an item selected if not we return
        guard let selection = selectedItem else { return }
        
        // This hides the "associated with" information labels when not needed
        if selectedItem != ItemSelected.characters {
            associatedStack.isHidden = true
        } else if selectedItem == ItemSelected.characters {
            associatedStack.isHidden = false
        }
    
        // If we have a selection we can use that to retrieve the information
        getData(forSelection: selection)
        
        // And use it to update the labels
        updateInformationLabels(updateFor: selection)

        // Sets this ViewController instance as the delegate for the Picker
        self.picker.delegate = self
        // and datasource of the picker
        self.picker.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}
