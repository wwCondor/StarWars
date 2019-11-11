//
//  NewClient.swift
//  SWAPI Awakens
//
//  Created by Wouter Willebrands on 28/09/2019.
//  Copyright © 2019 Studio Willebrands. All rights reserved.
//

import Foundation

class Client {
    
    // The base URL for the different selections
    static var baseURL: URL = {
        return URL(string:"https://swapi.co/api/")!
    }()
    
    // The decoder has been modified to take into account snake_case
    static let decoder: JSONDecoder = {
        let results = JSONDecoder()
        results.keyDecodingStrategy = .convertFromSnakeCase
        return results
    }()
        
    // An object that coordinates a group of related network data transfer tasks set to .default
    static let session = URLSession(configuration: .default)
    
    // MARK: Reusable Client
     
    // The total datapool for each selection consist of several pages
    // To retrieve all data we iterate tthrough the pages by checking if next is not nil
    static func getAllResourcePages<T>(url: URL, pages: [Page<T>], completionHandler completion: @escaping ([Page<T>]?, Error?) -> Void) {
        var allData = pages
        Client.getResourcePage(url: url) { (page: Page<T>?, error: Error?) in
            if let page = page {
                allData.append(page)
                // Now we appened one page, if there is a "next" page we will repeat this process
                if let next = page.next {
                    Client.getAllResourcePages(url: next, pages: allData, completionHandler: completion)
                    // If there is no "next" it means we have obtained all the data pages
                } else {
                    completion(allData, nil)
                }
            } else if let error = error {
                print(error)
                completion(nil, error)
            }
            
        }
    }
    
    // Here we retrieve one page of data from the API
    static func getResourcePage<T>(url: URL, completionHandler completion: @escaping (Page<T>?, Error?) -> Void) {
     
        let request = URLRequest(url: url)
        
        let task = Client.session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let data = data {
                    
                    guard let httpResponse = response as? HTTPURLResponse else {
                        completion(nil, SwapiError.requestFailed)
                        return
                    }
                    
                    if 200...299 ~= httpResponse.statusCode {
//                        print("Status Code: \(httpResponse.statusCode)")
                        
                        do {
                            let results = try Client.decoder.decode(Page<T>.self, from: data)
                            //                            print(results)
                            completion(results, nil)
                        } catch let error {
//                            print(error)
                            completion(nil, error)
                        }
                        
                    } else {
                        completion(nil, SwapiError.invalidData)
                    }
                    
                } else if let error = error {
                    completion(nil, error)
                }
            }
        }
        task.resume()
    }
}

