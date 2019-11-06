//
//  CharacterData.swift
//  SWAPI Awakens
//
//  Created by Wouter Willebrands on 14/04/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

// From each character within the Star Wars universe we are going to use the following data
// Note: Decided to go for "Character" instead of "People" for the class name as it contains individuals of which it might be debatable whether or not they are people... (e.g. robots/droids))
struct Character: Codable, Equatable {
    // The basic character properties that will be displayed in the character overview
    let name: String? // Name of the character
    let homeworld: URL? // This are stored as a planet URL
    let birthYear: String? // BBY or ABY - Before the Battle of Yavin or After the Battle of Yavin. The Battle of Yavin is a battle that occurs at the end of Star Wars episode IV: A New Hope. (Taken from SWAPI)
    
    let height: String? // Height of the person in centimeters (This also need conversion to English from metric)
    let eyeColor: String? // Will be unknow if not know or n/a if character doesn not have hair
    let hairColor: String? // Will be unknow if not known or n/a if the character does not have hair

    let vehicles: [URL]? // An array of vehicle URLs this character has piloted
    let starships: [URL]? // An array of starship URLs this character has piloted
}
   
