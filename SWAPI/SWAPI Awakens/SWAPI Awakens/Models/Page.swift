//
//  Characters.swift
//  SWAPI Awakens
//
//  Created by Wouter Willebrands on 28/09/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

// This generic handles the pages containing items of selected category where:
// Parameter T (Which will be Character, Vehicles, Starship or Planets) conforms to Codable
// Page object conforms to Codable
struct Page<T: Codable>: Codable {

    let count: Int? // The total number of items for each specific selection
    let results: [T]? // The items array on this page
    let next: URL? // The optional URL for next page
    let previous: URL? // The optional URL for previous page
}
