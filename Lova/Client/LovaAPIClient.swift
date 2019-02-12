//
//  LovaAPIClient.swift
//  Lova
//
//  Created by Ramon Geronimo on 2/7/19.
//  Copyright © 2019 ErespiStudios. All rights reserved.
//

import Foundation
import UIKit

class LovaAPIClient {
    var login: LoginViewController?
    var register: RegisterViewController?
    var cookie = [String]()
    
    func login(post: User, view: UIViewController, completion: ((Error?) -> Void)?) {
        // Building the url for entry point
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "lova-backend.herokuapp.com"
//        urlComponents.path = "/api/auth/\(Route.login)"
//        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        
        guard let url = URL(string: "http://localhost:4040/api/auth/login") else {
            fatalError("Could not create URL from components")
        }
        
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
                
                // Cookie value array
                guard let cookie = HTTPCookieStorage.shared.cookies?.map({$0.value}) else {
                    return
                }
                
                // API respond
                if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
                    if cookie == [] {
                        print("response: ", utf8Representation)
                        let defaults = UserDefaults.standard
                        defaults.set(false, forKey: "isUserLoggedIn")
                        return
                    } else {
                        let defaults = UserDefaults.standard
                        defaults.set(true, forKey: "isUserLoggedIn")
                        print("login...")
                        print(UserDefaults.standard.bool(forKey: "isUserLoggedIn"))
                        self.cookie = cookie
                        view.dismiss(animated: true, completion: nil)
                        
                    }
                } else {
                    print("no readable data received in response")
                }
            }
        }
        task.resume()
    }
    
    func logout(completion: ((Error?) -> Void)?) {
        // Building the url for entry point
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "lova-backend.herokuapp.com"
//        urlComponents.path =  "/api/auth/\(Route.logout)"
//        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
//
        
        guard let url = URL(string: "http://localhost:4040/api/auth/logout") else {
            fatalError("Could not create URL from components")
        }
        
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
            
            guard responseError == nil else {
                completion?(responseError)
                return
            }
            
            // Cookie value array
            guard let cookie = HTTPCookieStorage.shared.cookies?.map({$0.value}) else {
                return
            }
            
            // API respond
            if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
                guard let httpResponse = response as? HTTPURLResponse else {
                    return
                }
                if httpResponse.statusCode == 200 {
                    
                    print("response: ", utf8Representation)
                    let defaults = UserDefaults.standard
                    defaults.set(false, forKey: "isUserLoggedIn")
                    print("Cookie: ", cookie)
                   
                } else {
                    print("Logout Unsuccesful")
                    let defaults = UserDefaults.standard
                    defaults.set(true, forKey: "isUserLoggedIn")
                    print("Cookie: ", cookie)
                }
            } else {
                print("no readable data received in response")
            }
        }
        task.resume()
    }
    
    func signup(post: User, view: UIViewController, completion: ((Error?) -> Void)?) {
        // Building the url for entry point
        
//        var urlComponents = URLComponents()
//        urlComponents.scheme = "https"
//        urlComponents.host = "lova-backend.herokuapp.com"
//        urlComponents.path = "/api/auth/\(Route.signup)"
//        guard let url = urlComponents.url else { fatalError("Could not create URL from components") }
        
        
        guard let url = URL(string: "http://localhost:4040/api/auth/signup") else {
            fatalError("Could not create URL from components")
        }

        print("""
            
            
            URL: \(url)
            
            
            
            """)
        
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
            let jsonData = try encoder.encode(post)
            // Set request's HTTP body
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
                
                // Cookie value array
                guard let cookie = HTTPCookieStorage.shared.cookies?.map({$0.value}) else {
                    return
                }
                
                // API respond
                if let data = responseData, let utf8Representation = String(data: data, encoding: .utf8) {
                    if cookie == [] {
                        print("response: ", utf8Representation)
                        let defaults = UserDefaults.standard
                        defaults.set(false, forKey: "isUserLoggedIn") // TODO: Error handling signup error.
                        return
                    } else {
                        let defaults = UserDefaults.standard
                        defaults.set(true, forKey: "isUserLoggedIn")//sets the user status
                        self.register?.delegate?.registerButtonPressed(email: self.register?.emailTxtBox.text ?? "")
                        self.cookie = cookie
                        view.dismiss(animated: true, completion: nil)
                        
                    }
                } else {
                    print("no readable data received in response")
                }
            }
        }
        task.resume()
    }
}
