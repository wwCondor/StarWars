//
//  StarshipDataManager.swift
//  SWAPI Awakens
//
//  Created by Wouter Willebrands on 02/10/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

extension Client {

    // MARK: Starship Typealiases
    typealias StarshipCompletionHandler = ([Starship]?, Error?)-> Void
    typealias StarshipPagesCompletionHandler = ([Page<Starship>]?, Error?)-> Void

    // MARK: Starship Data Methods
    
    // This method removes invalid starship lengths (in this case containing "'")
    private static func removeInvalidLengths(starships: [Starship]) -> [Starship] {
        
        var validStarships: [Starship] = []
        for starship in starships {
            if starship.length?.contains(",") == false {
                validStarships.append(starship)
            }
        }
        return validStarships
    }
    
    // This method finds the shortest and longest starships
    static func findShortestAndLongestStarship(starships: [Starship]) -> (Starship?, Starship?) {
        // First we need to get rid of the starships with length "unknown"
        let filteredStarships = starships.filter { $0.length != "unknown" }
        
        // Remove invalid lengths
        let validStarships = removeInvalidLengths(starships: filteredStarships)

        // Then we sort them according to height (Note: we swap Int for Double here, since in contrast to character height, lenght is in Double)
        let sortedStarships = validStarships.sorted(by: { if let length1 = Double($0.length!), let length2 = Double($1.length!) {
            return length1 > length2
            }
            return true
        })
        
        // Then we take the shortest and longest starships from that array
        let longest = sortedStarships.first
        let shortest = sortedStarships.last
        
        return (shortest, longest)
    }
    
    
    static func fetchStarships(completion: @escaping StarshipCompletionHandler) {
        var allStarships = [Starship]()
        getAllStarships { (starshipPages, error) in
            // first we check wether have pages
            if let starshipPages = starshipPages {
                // If we have pages we check for each page if it contains results
                for starshipPage in starshipPages {
                    guard let starshipArray = starshipPage.results else {
//                        print("Unable to obtain starship array from pages")
                        completion(nil, error)
                        return
                    }
                    // If it does, each character inside results will be added to an array
                    for starship in starshipArray {
                        var starshipDuplicates = [Starship]()
                        if !allStarships.contains(starship) {
                            allStarships.append(starship)
//                            print("***")
//                            print("\(String(describing: starship.name)) added, \(allStarships.count) starships in array")
                        } else {
                            starshipDuplicates.append(starship)
                        }
                    }
                    completion(allStarships, error)
                }
            } else if let error = error {
                print(error)
                completion(nil, error)
            }
        }
    }

    static func getAllStarships(completion: @escaping StarshipPagesCompletionHandler) {
        guard let url = URL(string: "starships/", relativeTo: baseURL) else {
            completion(nil, SwapiError.invalidUrl)
            return
        }
        let allData = [Page<Starship>]()
        Client.getAllResourcePages(url: url, pages: allData, completionHandler: completion)
    }

}
