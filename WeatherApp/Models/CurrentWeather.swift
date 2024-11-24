//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Ulixe on 24/11/24.
//

import Foundation

struct CurrentWeather: Codable, Hashable {
    let lastUpdated: String
    let tempC: Double
    let tempF: Double
    let isDay: Int
    let feelsLikeC: Double
    let feelsLikeF: Double
    let humidity: Double
    let wind: Double
    let pressure: Double
    let uv: Double
    let condition: WeatherCondition
    
    var weatherIcon: String {
        switch self.condition.code {
        case 1000: "sun.max.fill"
        case 1003: "cloud.sun.fill"
        case 1006: "cloud.fill"
        case 1135: "cloud.fog.fill"
        case 1183: "cloud.rain.fill"
        case 1195: "cloud.bolt.rain.fill"
        default:
            "sun.max.circle"
        }
    }
    enum CodingKeys: String, CodingKey {
        case lastUpdated = "last_updated"
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case feelsLikeC = "feelslike_c"
        case feelsLikeF = "feelslike_f"
        case humidity = "humidity"
        case wind = "wind_kph"
        case pressure = "pressure_mb"
        case uv = "uv"
    }
}
