//
//  InfoViewControllerExtension.swift
//  SWAPI Awakens
//
//  Created by Wouter Willebrands on 02/10/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import UIKit

// this extension holds all the methods related to the Picker
extension InformationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: Picker Delegate methods
       
       // Number of colums of data
       func numberOfComponents(in pickerView: UIPickerView) -> Int {
           
           return 1 // This is one column, cause we want to select on the Character/Vehicle/Starship
       }
       
       // Number of rows of data: this should be the resource array count
       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           // First we make sure a selection has been made
           guard let itemSelected = selectedItem else { return 0 }
           // If a selection has been made we need to unwrap the optional array of characters
           switch itemSelected {
           case .characters:
               guard let numberOfRows = allCharacters?.count else {
                   return 0
               }
               return numberOfRows
           case .vehicles:
               guard let numberOfRows = allVehicles?.count else {
                   return 0
               }
               return numberOfRows
           case .starships:
               guard let numberOfRows = allStarships?.count else {
                   return 0
               }
               return numberOfRows
           }
    
       }
       
       // Data being returned for each column
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           
           guard let itemSelected = selectedItem else { return nil }

           switch itemSelected {
           case .characters:
               guard let data = allCharacters else {
                   return nil }
               return data[row].name
           case .vehicles:
              guard let data = allVehicles else {
                   return nil }
               return data[row].name
           case .starships:
               guard let data = allStarships else {
                   return nil }
               return data[row].name
           }
       }
       
       // This part updates the selected categories 
       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
           
           guard let itemSelected = selectedItem else { return }
           
           switch itemSelected {
           case .characters:
               guard let data = allCharacters else {
                   return
               }
               unitsLabel.text = "cm"
               updateCharacterData(with: data[row])
           case .vehicles:
               guard let data = allVehicles else {
                   return
               }
               creditLabel.text = "GC"
               unitsLabel.text = "m"
               updateVehicleData(with: data[row])

           case .starships:
               guard let data = allStarships else {
                   return
               }
               creditLabel.text = "GC"
               unitsLabel.text = "m"
               updateStarshipData(with: data[row])
           }
       }
       
       // MARK: Picker Customization
       func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
           // this adds customization to the Picker
           
           var label: UILabel
           
           // Here we unwrap the optional
           if let view = view as? UILabel {
               label = view
           } else {
               label = UILabel()
           }
           
           label.textColor = UIColor(named: "HothBlue")
           label.textAlignment = .center
           label.font = UIFont(name: "System", size: 20)
       
           if let itemSelected = selectedItem {
               switch itemSelected {
               case .characters:
                   if let characters = allCharacters {
                       label.text = characters[row].name
                   }
                   
               case .vehicles:
                   if let vehicles = allVehicles {
                       label.text = vehicles[row].name
                   }
                   
               case .starships:
                   if let starships = allStarships {
                       label.text = starships[row].name
                   }
               }
           }
           
           return label
       }
    
}
