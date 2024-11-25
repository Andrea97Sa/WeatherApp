//
//  WeatherLocation.swift
//  WeatherApp
//
//  Created by Ulixe on 24/11/24.
//

import Foundation

struct WeatherLocation: Codable, Hashable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let localtime: Date
    
    enum CodingKeys: String, CodingKey {
        case name
        case region
        case country
        case lat
        case lon
        case localtime
    }
}
