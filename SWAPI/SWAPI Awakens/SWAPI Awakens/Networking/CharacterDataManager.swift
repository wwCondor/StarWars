//
//  CharacterDataManager.swift
//  SWAPI Awakens
//
//  Created by Wouter Willebrands on 02/10/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

// This extension of Client handles the methods for the Character data the clean up the Client
extension Client {
    
    // MARK: Character Typealiases
    typealias CharacterCompletionHandler = ([Character]?, Error?)-> Void
    typealias CharacterPagesCompletionHandler = ([Page<Character>]?, Error?)-> Void

    
    // MARK: Character Data Methods
    // This method finds the shortest and tallest characters
    static func findShortestAndTallestCharacter(characters: [Character]) -> (Character?, Character?) {
        
        // First we need to get rid of the characters with height "unknown"
        let filteredCharacters = characters.filter { $0.height != "unknown" }
        
        // Then we sort them according to height
        let sortedCharacters = filteredCharacters.sorted(by: { if let height1 = Int($0.height!), let height2 = Int($1.height!) {
            return height1 > height2
            }
            return true
        })
        
        // Then we take the shortest and longest characters from that array
        let tallest = sortedCharacters.first
        let shortest = sortedCharacters.last
        
        return (shortest, tallest)
    }
    
    // This method gets the associated vehicle
    static func getAssociatedVehicle(for character: Character, completion: @escaping (Vehicle?, Error?)-> Void) {
        if let firstVehicleUrl = character.vehicles?.first {
            let request = URLRequest(url: firstVehicleUrl)

            let task = session.dataTask(with: request) { data, response, error  in
                if let data = data  {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(nil, SwapiError.requestFailed)
                        return
                    }

                    if httpResponse.statusCode == 200 {
                        do {
                            let vehicle = try self.decoder.decode(Vehicle.self, from: data)
                            completion(vehicle, nil)
                        } catch let error {
                            completion(nil, error)
                        }
                    } else {
                        completion(nil, SwapiError.invalidData)
                    }
                } else if let error = error {
                    completion(nil, error)
                }
            }
            task.resume()
        }
    }
    
    // This method gets the associated starship
    static func getAssociatedStarship(for character: Character, completion: @escaping (Starship?, Error?)-> Void) {
        if let firstStarshipUrl = character.starships?.first {
            let request = URLRequest(url: firstStarshipUrl)

            let task = session.dataTask(with: request) { data, response, error  in
                if let data = data  {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(nil, SwapiError.requestFailed)
                        return
                    }

                    if httpResponse.statusCode == 200 {
                        do {
                            let starship = try self.decoder.decode(Starship.self, from: data)
                            completion(starship, nil)
                        } catch let error {
                            completion(nil, error)
                        }
                    } else {
                        completion(nil, SwapiError.invalidData)
                    }
                } else if let error = error {
                    completion(nil, error)
                }
            }
            task.resume()
        }
    }
    
    // Gets the homeworld planet
    static func getHomeworld(for character: Character, completion: @escaping (Planet?, Error?)-> Void) {
        if let homeworldUrl = character.homeworld {
            let request = URLRequest(url: homeworldUrl)

            let task = session.dataTask(with: request) { data, response, error  in
                if let data = data  {
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(nil, SwapiError.requestFailed)
                        return
                    }

                    if httpResponse.statusCode == 200 {
                        do {
                            let planet = try self.decoder.decode(Planet.self, from: data)
                            completion(planet, nil)
                        } catch let error {
                            completion(nil, error)
                        }
                    } else {
                        completion(nil, SwapiError.invalidData)
                    }
                } else if let error = error {
                    completion(nil, error)
                }
            }
            task.resume()
        }
    }
    
    static func fetchCharacters(completion: @escaping CharacterCompletionHandler) {
        var allCharacters = [Character]()
        getAllCharacters { (characterPages, error) in
            // first we check wether have pages
            if let characterPages = characterPages {
                // If we have pages we check for each page if it contains results
                for characterPage in characterPages {
                    guard let characterArray = characterPage.results else {
//                        print("Unable to obtain character array from pages")
                        completion(nil, error)
                        return
                    }
                    // If it does, each character inside results will be added to an array
                    for character in characterArray {
                        var characterDuplicates = [Character]()
                        if !allCharacters.contains(character) {
                            allCharacters.append(character)
//                            print("***")
//                            print("\(String(describing: character.name)) added to array; total: \(allCharacters.count)")
                        } else {
                            characterDuplicates.append(character)
                        }
                    }
                    completion(allCharacters, error)
                }
            } else if let error = error {
//                print(error)
                completion(nil, error)
            }
        }
    }
    
    static func getAllCharacters(completion: @escaping CharacterPagesCompletionHandler) {
        guard let url = URL(string: "people/", relativeTo: baseURL) else {
            completion(nil, SwapiError.invalidUrl)
            return
        }
        let allData = [Page<Character>]()
        Client.getAllResourcePages(url: url, pages: allData, completionHandler: completion)
    }
}
