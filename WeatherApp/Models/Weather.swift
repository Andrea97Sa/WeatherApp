//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Ulixe on 23/11/24.
//

import Foundation

struct Weather: Codable, Hashable {
    static func == (lhs: Weather, rhs: Weather) -> Bool {
        lhs.location.name == rhs.location.name
    }
    
    
    let location: WeatherLocation
    let main: CurrentWeather
    
    enum CodingKeys: String, CodingKey {
        case location = "location"
        case main = "current"
    }
}

struct WeatherLocation: Codable, Hashable {
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
    let localtime: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case region
        case country
        case lat
        case lon
        case localtime
    }
}

struct CurrentWeather: Codable, Hashable {
    let lastUpdated: String
    let tempC: Double
    let tempF: Double
    let isDay: Int
    let condition: WeatherCondition

    enum CodingKeys: String, CodingKey {
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
    }
}

struct WeatherCondition: Codable, Hashable {
    let text: String
    let icon: String
    let code: Int
}


