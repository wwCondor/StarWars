//
//  SWAPIError.swift
//  SWAPI Awakens
//
//  Created by Wouter Willebrands on 01/05/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

enum SwapiError: Error {
    case requestFailed
    case responseUnsuccessful(statuscode: Int)
    case invalidData
    case jsonConversionFailure(message: String)
    case invalidUrl
    case jsonParsingFailure(message: String)
}

extension SwapiError: LocalizedError {
    public var localizedDescription: String {
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

