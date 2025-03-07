//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Ulixe on 24/11/24.
//

import SwiftUI

struct CurrentWeather: Codable, Hashable {
    let lastUpdated: Date
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
        case 1000: isDay == 1 ? "sun.max.fill" : "moon.fill"
        case 1003: isDay == 1 ? "cloud.sun.fill" : "cloud.moon.fill"
        case 1006: "cloud.fill"
        case 1135: "cloud.fog.fill"
        case 1183: "cloud.rain.fill"
        case 1195: "cloud.bolt.rain.fill"
        default:
            "sun.max.circle"
        }
    }
    
    var weatherGradient: [Color] {
        switch self.condition.code {
        case 1000: isDay == 1 ?
            [Color(uiColor: UIColor(red: 0.6, green: 1, blue: 1, alpha: 1)),
             Color(uiColor: UIColor(red: 0.6, green: 0.878, blue: 1, alpha: 1)),
             Color(uiColor: UIColor(red: 0.98, green: 0.761, blue: 0.98, alpha: 0.3))] :
            [Color(uiColor: UIColor(red: 0.212, green: 0.078, blue: 0.18, alpha: 1)),
             Color(uiColor: UIColor(red: 0.451, green: 0.592, blue: 0.922, alpha: 1)),
             Color(uiColor: UIColor(red: 0.169, green: 0.239, blue: 0.576, alpha: 0.3))]
        case 1003: isDay == 1 ?
            [Color(uiColor: UIColor(red: 0.6, green: 1, blue: 1, alpha: 1)),
             Color(uiColor: UIColor(red: 0.6, green: 0.878, blue: 1, alpha: 1)),
             Color(uiColor: UIColor(red: 0.98, green: 0.761, blue: 0.98, alpha: 0.3))] :
            [Color(uiColor: UIColor(red: 0.212, green: 0.078, blue: 0.18, alpha: 1)),
             Color(uiColor: UIColor(red: 0.451, green: 0.592, blue: 0.922, alpha: 1)),
             Color(uiColor: UIColor(red: 0.169, green: 0.239, blue: 0.576, alpha: 0.3))]
        case 1006, 1195, 1135, 1183: [Color(uiColor: UIColor(red: 0.161, green: 0.161, blue: 0.161, alpha: 1)),
                    Color(uiColor: UIColor(red: 0.111, green: 0.125, blue: 0.124, alpha: 1)),
                    Color(uiColor: UIColor(red: 0.169, green: 0.239, blue: 0.576, alpha: 0.3))]
        default:
            isDay == 1 ?
            [Color(uiColor: UIColor(red: 0.6, green: 1, blue: 1, alpha: 1)),
             Color(uiColor: UIColor(red: 0.6, green: 0.878, blue: 1, alpha: 1)),
             Color(uiColor: UIColor(red: 0.98, green: 0.761, blue: 0.98, alpha: 0.3))] :
            [Color(uiColor: UIColor(red: 0.212, green: 0.078, blue: 0.18, alpha: 1)),
             Color(uiColor: UIColor(red: 0.451, green: 0.592, blue: 0.922, alpha: 1)),
             Color(uiColor: UIColor(red: 0.169, green: 0.239, blue: 0.576, alpha: 0.3))]
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
