//
//  VehicleDataManager.swift
//  SWAPI Awakens
//
//  Created by Wouter Willebrands on 02/10/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

extension Client {
    
    // MARK: Vehicle Typealiases
    typealias VehicleCompletionHandler = ([Vehicle]?, Error?)-> Void
    typealias VehiclePagesCompletionHandler = ([Page<Vehicle>]?, Error?)-> Void

    // MARK: Vehicle Data Methods
       
    // this method finds the shortest and longest vehicles
    static func findShortestAndLongestVehicle(vehicles: [Vehicle]) -> (Vehicle?, Vehicle?) {
        // First we need to get rid of the vehicles with starships "unknown"
        let filteredVehicles = vehicles.filter { $0.length != "unknown" }
        
        // Then we sort them according to height (Note: we swap Int for Double here, since in contrast to character height, lenght is in Double)
        let sortedVehicles = filteredVehicles.sorted(by: { if let length1 = Double($0.length!), let length2 = Double($1.length!) {
            return length1 > length2
            }
            return true
        })
        
        // Then we take the shortest and longest vehicles from that array
        let longest = sortedVehicles.first
        let shortest = sortedVehicles.last
        
        return (shortest, longest)
    }
    
    static func fetchVehicles(completion: @escaping VehicleCompletionHandler) {
        var allVehicles = [Vehicle]()
        getAllVehicles { (vehiclePages, error) in
            // first we check wether have pages
            if let vehiclePages = vehiclePages {
                // If we have pages we check for each page if it contains results
                for vehiclePage in vehiclePages {
                    guard let vehicleArray = vehiclePage.results else {
                        print("Unable to obtain vehicle array from pages")
                        completion(nil, error)
                        return
                    }
                    // If it does, each character inside results will be added to an array
                    for vehicle in vehicleArray {
                        var vehicleDuplicates = [Vehicle]()
                        if !allVehicles.contains(vehicle) {
                            allVehicles.append(vehicle)
                            print("***")
                            print("\(vehicle)) added, \(allVehicles.count) vehicles in array")
                        } else {
                            vehicleDuplicates.append(vehicle)
                        }
                    }
                    completion(allVehicles, error)
                }
            } else if let error = error {
                print(error)
                completion(nil, error)
            }
        }
    }
    
    static func getAllVehicles(completion: @escaping VehiclePagesCompletionHandler) {
        guard let url = URL(string: "vehicles/", relativeTo: baseURL) else {
            completion(nil, SwapiError.invalidUrl)
            return
        }
        let allData = [Page<Vehicle>]()
        Client.getAllResourcePages(url: url, pages: allData, completionHandler: completion)
    }
    
}
