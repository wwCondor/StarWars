//
//  SWAPIError.swift
//  SWAPI Awakens
//
//  Created by Wouter Willebrands on 01/05/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

// General API related errors
enum SwapiError: Error {
    case requestFailed
    case responseUnsuccessful(statuscode: Int)
    case invalidData
    case jsonConversionFailure(message: String)
    case invalidUrl
    case jsonParsingFailure(message: String)
}

extension SwapiError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed"
        case .responseUnsuccessful: return "Response Unsuccesful"
        case .invalidData: return "Invalid Data"
        case .jsonConversionFailure: return "JSON Conversion Failed"
        case .invalidUrl: return "Invalid URL"
        case .jsonParsingFailure: return "JSON Parsing Failed"
        }
    }
}

// Errors associated with characters
enum CharacterError: Error {
    case noCharacters
    
    case noName
    case noPlanet
    case noBirthYear
    case noHeight
    case noEyeColor
    case noHairColor

    case noAssociatedVehicles
    case noAssociatedStarships

}

extension CharacterError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .noCharacters : return "Unable to obtain characters. Please check your internet connection."
            
        case .noName: return "Unable to obtain character name. Please check your internet connection."
        case .noPlanet: return "Unable to obtain home planet. Please check your internet connection."
        case .noBirthYear: return "Unable to obtain character birth year. Please check your internet connection."
        case .noHeight: return "Unable to obtain character height. Please check your internet connection."
        case .noEyeColor: return "Unable to obtain character eye color. Please check your internet connection."
        case .noHairColor: return "Unable to obtain character hair color. Please check your internet connection."
            
        case .noAssociatedVehicles: return "Unable to obtain associated vehicles. Please check your internet connection."
        case .noAssociatedStarships: return "Unable to obtain associated starships. Please check your internet connection."
        }
    }
}

// Errors associated with vehicles
enum VehicleError: Error {
    case noVehicles
    
    case noName
    case noModel
    case noCost
    case noLenght
    case noClass
    case noCrew
    
}

extension VehicleError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .noVehicles: return "Unable to obtain vehicles. Please check your internet connection."
            
        case .noName: return "Unable to obtain vehicle name. Please check your internet connection."
        case .noModel: return "Unable to obtain vehicle model. Please check your internet connection."
        case .noCost: return "Unable to obtain vehicle cost. Please check your internet connection."
        case .noLenght: return "Unable to obtain vehicle lenght. Please check your internet connection."
        case .noClass: return "Unable to obtain vehicle class. Please check your internet connection."
        case .noCrew: return "Unable to obtain vehicle crew. Please check your internet connection."

        }
    }
}

// Errors associated with vehicles
enum StarshipError: Error {
    case noStarships
    
    case noName
    case noModel
    case noCost
    case noLenght
    case noClass
    case noCrew
}

extension StarshipError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .noStarships : return "Unable to obtain starships. Please check your internet connection."
            
        case .noName: return "Unable to obtain starship name. Please check your internet connection."
        case .noModel: return "Unable to obtain starship model. Please check your internet connection."
        case .noCost: return "Unable to obtain starship cost. Please check your internet connection."
        case .noLenght: return "Unable to obtain starship lenght. Please check your internet connection."
        case .noClass: return "Unable to obtain starship class. Please check your internet connection."
        case .noCrew: return "Unable to obtain starship crew. Please check your internet connection."
        }
    }
}


enum ConversionError: Error {
    case invalidInput
    case negativeOrZero

}

extension ConversionError: LocalizedError {
    var localizedDescription: String {
        switch self {
        case .invalidInput: return "Please enter a valid integer"
        case .negativeOrZero: return "Conversion rate input may not be zero or negative"

        }
    }
}

