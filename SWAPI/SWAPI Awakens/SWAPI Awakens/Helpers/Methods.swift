//
//  Methods.swift
//  SWAPI Awakens
//
//  Created by Wouter Willebrands on 11/11/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

struct Method {
    static func removeInvalidCharacters(string: String?) -> String {
        if let string = string {
            
            let digiSet = CharacterSet.decimalDigits
            let number = String(string.unicodeScalars.filter { digiSet.contains($0) })
            return number
            
        } else {
            return ""
        }
    }
}
