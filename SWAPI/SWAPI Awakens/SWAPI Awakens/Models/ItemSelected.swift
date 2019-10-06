//
//  ItemSelected.swift
//  SWAPI Awakens
//
//  Created by Wouter Willebrands on 16/04/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

// The different Items catagories that can be selected. When an item is selected we'll use the rawValue to set the textLabel
// Used for Header textLabel
enum ItemSelected: String {
    case characters = "Characters"  // Character instead of people (See Character.swift for reasoning)
    case vehicles = "Vehicles"
    case starships = "Starships"
    
    // this is added to be able to use the rawValue
    var stringValue: String {
        switch self {
        case .characters: return "Characters"
        case .vehicles: return "Vehicles"
        case .starships: return "Starships"
        }
    }
        
}
