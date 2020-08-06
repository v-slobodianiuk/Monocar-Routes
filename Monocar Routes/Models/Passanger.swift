//
//  Passanger.swift
//  Monocar Routes
//
//  Created by Vadym on 06.08.2020.
//  Copyright © 2020 Vadym. All rights reserved.
//

import Foundation

struct Passanger {
    let route: Route
    let start: Coordinates
    let end: Coordinates
    
    init(dictionary: Dictionary<String, Any>?) {
        self.route = Route(dictionary: dictionary?["route"] as? Dictionary<String, Any> ?? [:])
        self.start = Coordinates(dictionary: dictionary?["start"] as? Dictionary<String, Any> ?? [:])
        self.end = Coordinates(dictionary: dictionary?["end"] as? Dictionary<String, Any> ?? [:])
    }
}

struct Route {
    let polyline: String
    
    init(dictionary: Dictionary<String, Any>) {
        self.polyline = dictionary["polyline"] as? String ?? ""
    }
}

struct Geo {
    let latitude: Double
    let longitude: Double
    
    init(dictionary: [String: Double]) {
        self.latitude = dictionary["latitude"] ?? 0.0
        self.longitude = dictionary["longitude"] ?? 0.0
    }
}

struct Coordinates {
    let geo: Geo
    
    init(dictionary: Dictionary<String, Any>) {
        self.geo = Geo(dictionary: dictionary["geo"] as? Dictionary<String, Double> ?? [:])
    }
}
