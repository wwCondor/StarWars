//
//  Planets.swift
//  SWAPI Awakens
//
//  Created by Wouter Willebrands on 23/04/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

// Planet object
struct Planet: Decodable, Equatable {
    let name: String // The planet that this person was born on or inhabits.
    let url: URL
}
