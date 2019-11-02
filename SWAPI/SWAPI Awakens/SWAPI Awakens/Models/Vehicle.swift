//
//  Vehicles.swift
//  SWAPI Awakens
//
//  Created by Wouter Willebrands on 23/04/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

struct Vehicle: Codable, Equatable {
    // The basic vehicle properties that will be displayed in the vehicle overview
    let name: String? // Name ship goes in subheader textLabel
    
    let model: String?
    let costInCredits: String?
    let length: String? // This needs conversion from metric to English
    let vehicleClass: String?
    let crew: String?
    
    let url: URL?
}

