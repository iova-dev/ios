//
//  Promise.swift
//  Lova
//
//  Created by Ramon Geronimo on 2/13/19.
//  Copyright © 2019 ErespiStudios. All rights reserved.
//

import Foundation
import UIKit

extension LovaAPIClient {
    
    func create(post: Promise, view: UIViewController, completion: ((Error?) -> Void)?) {
       
//         Building the url for entry point
                var urlComponents = URLComponents()
                urlComponents.scheme = "https"
                urlComponents.host = "lova-backend.herokuapp.com"
                urlComponents.path = "/api/promise/"
                guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
//        guard let uid = UserDefaults.standard.string(forKey: "uid") else {return}
        
//        guard let url = URL(string: "http://localhost:4040/api/user/\(uid)/promise/\(count)") else {
//            fatalError("Could not create URL from components")
//        }
        
        // Specify this request as being a POST method
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Include in the header that our request HTTP body will be JSON encoded
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        // Encode POST struct into JSON data
        let encoder = JSONEncoder()
        do {
            let jsonData = try encoder.encode(post)            // Set request's HTTP body
            request.httpBody = jsonData
            print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
        } catch {
            completion?(error)
        }
        
        // Create and run URLSession data task with JSON encoded POST request
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { responseData, response, responseError in
            
            DispatchQueue.main.async {
                guard responseError == nil else {
                    completion?(responseError)
                    return
                }
                
                
                
                
                // API respond
                if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
                    print("Added promise successfully")
                    print(utf8Representation)
                    view.navigationController?.popViewController(animated: true)
                } else {
                    print("no readable data received in response")
                }
            }
        }
        task.resume()
    }
    
    
    func get(completion: @escaping (Data?) -> ()) {

        //         Building the url for entry point
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "lova-backend.herokuapp.com"
        urlComponents.path = "/api/promise/"
        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        //        guard let uid = UserDefaults.standard.string(forKey: "uid") else {return}
        
        //        guard let url = URL(string: "http://localhost:4040/api/user/\(uid)/promise/\(count)") else {
        //            fatalError("Could not create URL from components")
        //        }
        
        // Specify this request as being a POST method
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // Include in the header that our request HTTP body will be JSON encoded
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        
        
       
        
        // Create and run URLSession data task with JSON encoded POST request
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { responseData, response, responseError in
            guard let responseData = responseData  else {return}
            
            DispatchQueue.main.async {
                guard responseError == nil else {
                    print("error: ")
                    return
                }
                
                // Decode POST struct into JSON data
                let decoder = JSONDecoder()
                do {
                    let jsonData =  try decoder.decode([Promise].self, from: responseData)         // Set request's HTTP body
                    completion(responseData)
//                    request.httpBody = jsonData
                    print("jsonData: ", String(data: request.httpBody!, encoding: .utf8) ?? "no body data")
                } catch {
                    print(error)
                }
                
            }
        }
        task.resume()
    }

}
