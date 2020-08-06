//
//  NetworkWorker.swift
//  Monocar Routes
//
//  Created by Vadym on 05.08.2020.
//  Copyright © 2020 Vadym. All rights reserved.
//

import Foundation

protocol NetworkWorkerProtocol {
    var scheme: String {get}
    var host: String {get}
    var requiredPath: String {get}
    
    func urlComponents(urlPath: String, queryItems: [URLQueryItem]?) -> URL?
    func apiRequest(requestURL: URL, requestMethod: String?, _ comletion: @escaping (Data) -> Void)
}

class NetworkWorker: NetworkWorkerProtocol {
    
    internal let scheme = "https"
    internal let host = "europe-west3-fb-monocar.cloudfunctions.net"
    internal let requiredPath = "/"
    
    func urlComponents(urlPath: String, queryItems: [URLQueryItem]?) -> URL? {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = "\(requiredPath)\(urlPath)"
        components.queryItems = queryItems
        
        guard let requestURL = components.url else { return nil }
        
        return requestURL
    }
    
    func apiRequest(requestURL: URL, requestMethod: String?, _ comletion: @escaping (Data) -> Void) {
        
        var request = URLRequest(url: requestURL)
        request.httpMethod = requestMethod
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print(error)
                return
            }
            
            guard let response = response as? HTTPURLResponse else { return }
            guard let data = data else { return }
            
            switch response.statusCode {
            case 200 ... 299:
                comletion(data)
            default:
                return
            }
        }.resume()
    }
}
