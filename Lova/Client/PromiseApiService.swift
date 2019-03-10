//
//  PromiseApiService.swift
//  Lova
//
//  Created by Ramon Geronimo on 3/7/19.
//  Copyright © 2019 ErespiStudios. All rights reserved.
//

import Foundation

class PromiseApiService {
    
    var sources: [Promise] = []
    
    
    private let urlScheme = "https"
    private let baseURLString = "lova-backend.herokuapp.com"
    private let sourcesEndpoint = "/api/promise/"
    
    // For JSON Decoding - a Response object that conforms to Codable with SourceItem array as .source property
    private struct Response: Codable {
        let sources: [Promise]?
    }
    
    // Function that fetches all Source items from newsapi.org...
    func fetchSources() {
        
        //Set up URLSession, URL, and URLRequest
        let session = URLSession(configuration: .default)
        guard let url = URL(string: self.urlBuilder()!) else { return }
        let urlRequest = URLRequest(url: url)
        
        //Execute dataTask and call method to process sources
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, response, error) -> Void in
            
            if let data = data {
                DispatchQueue.main.async {
                    
                    self.processSourcesFetchRequest(data: data, error: error)
                    
                }
            }
        })
        task.resume()
        
    }
    
    // Function for validating response data exists or presenting HTTP error
    private func processSourcesFetchRequest(data: Data?, error: Error?) {
        
        // if data passed is nil, print error
        guard let jsonData = data else {
            print(error!)
            return
        }
        self.decodeSourceItems(fromJSON: jsonData)
    }
    
    // Function for decoding fetches all Source items from newsapi.org...
    func decodeSourceItems(fromJSON data: Data) {
        
        do {
            let decoder = JSONDecoder()
            
            let decodedResponseObject = try decoder.decode([Promise].self, from: data)
            
            DispatchQueue.main.async {
                self.sources = decodedResponseObject
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadTableView"), object: nil)
                
            }
        } catch let jsonError {
            print("Error: \(jsonError)")
            
        }
    }
    
    private func urlBuilder() -> String? {
        
        var components = URLComponents()
        components.scheme = urlScheme
        components.host = baseURLString
        components.path = sourcesEndpoint
        
        if let urlAsString = components.url?.absoluteString {
            let percentDecodedURL = urlAsString.decodeUrl()
            return percentDecodedURL
        } else {
            return "Invalid URL"
        }
    }
    
    func returnSources() -> [Promise]
    {
        return self.sources
    }
}

extension String
{
    func encodeUrl() -> String?
    {
        return self.addingPercentEncoding( withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
    }
    func decodeUrl() -> String?
    {
        return self.removingPercentEncoding
    }
}
