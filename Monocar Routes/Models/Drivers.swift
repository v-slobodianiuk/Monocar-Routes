//
//  DriversModel.swift
//  Monocar Routes
//
//  Created by Vadym on 06.08.2020.
//  Copyright © 2020 Vadym. All rights reserved.
//

import Foundation

struct Drivers {
    var result: [Driver]
    
    init(dictionary: Dictionary<String, Any>?) {
        result = []
        guard let dictionary = dictionary else { return }
        for (_, value) in dictionary["results"] as! Dictionary<String, Dictionary<String, Any>> {
            result.append(Driver(dictionary: value))
        }
    }
}

struct PointDropoff {
    let latitude: Double
    let longitude: Double
}

struct PointPickup {
    let latitude: Double
    let longitude: Double
}

struct Driver {
    var point_dropoff: PointDropoff
    var point_pickup: PointPickup
    let route_main: String
    
    let picture_url: String
    let name: String
    let is_driver: Bool
    let rating: Double
    let dt_start: Int
    let cost_per_seat: Int
    let seats_count: Int
    
    init(dictionary: [String: Any]) {
        
        let point_pickup_dict = dictionary["point_pickup"] as? [String: Double] ?? [:]
        self.point_pickup = PointPickup(latitude: point_pickup_dict["latitude"] ?? 0, longitude: point_pickup_dict["longitude"] ?? 0)
        
        let point_dropoff_dict = dictionary["point_dropoff"] as? [String: Double] ?? [:]
        self.point_dropoff = PointDropoff(latitude: point_dropoff_dict["latitude"] ?? 0, longitude: point_dropoff_dict["longitude"] ?? 0)
        
        self.route_main = dictionary["route_main"] as? String ?? ""
        
        self.picture_url = dictionary["picture_url"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        self.is_driver = dictionary["is_driver"] as? Bool ?? false
        self.rating = dictionary["rating"] as? Double ?? 0.0
        self.dt_start = dictionary["dt_start"] as? Int ?? 0
        self.cost_per_seat = dictionary["cost_per_seat"] as? Int ?? 0
        self.seats_count = dictionary["seats_count"] as? Int ?? 0
    }
}
