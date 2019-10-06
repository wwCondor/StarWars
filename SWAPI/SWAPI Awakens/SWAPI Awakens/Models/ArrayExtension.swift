//
//  ArrayExtension.swift
//  SWAPI Awakens
//
//  Created by Wouter Willebrands on 01/10/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

// This will be used to check wether a resource is already inside an array before appending 
extension Array where Element: Equatable {
    mutating func removeDuplicates() {
        var result = [Element]()
        for value in self {
            if !result.contains(value) {
                result.append(value)
            }
        }
        self = result
    }
}
