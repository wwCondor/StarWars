//
//  Starships.swift
//  SWAPI Awakens
//
//  Created by Wouter Willebrands on 23/04/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

// Starship object
struct Starship: Codable, Equatable {
    // The basic starship properties that will be displayed in the starship overview
    let name: String? // Name ship goes in subheader textLabel
    
    let model: String?
    let costInCredits: String? 
    let length: String? // This needs conversion from metric to English
    let starshipClass: String?
    let crew: String?
    
    let url: URL?
}
