//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Ulixe on 23/11/24.
//

import Foundation

struct Weather: Codable, Hashable {
    static func == (lhs: Weather, rhs: Weather) -> Bool {
        lhs.id == rhs.id
    }
    
    let id = UUID()
    let location: WeatherLocation
    let currentWeather: CurrentWeather
    let forecast: Forecast
    
    enum CodingKeys: String, CodingKey {
        case location = "location"
        case currentWeather = "current"
        case forecast = "forecast"
    }
}

struct WeatherCondition: Codable, Hashable {
    let text: String
    let code: Int
}

struct Forecast: Codable, Hashable {
    let forecastday: [ForecastDay]
}

struct ForecastDay: Codable, Hashable {
    let date: String
    let day: Day
    let hour: [Hour]
    
    enum CodingKeys: String, CodingKey {
        case date
        case day
        case hour
    }
}

struct Day: Codable, Hashable {
    let maxtempC: Double
    let maxtempF: Double
    let mintempC: Double
    let mintempF: Double
    let dailyChanceOfRain: Int
    let condition: WeatherCondition

    enum CodingKeys: String, CodingKey {
        case maxtempC = "maxtemp_c"
        case maxtempF = "maxtemp_f"
        case mintempC = "mintemp_c"
        case mintempF = "mintemp_f"
        case dailyChanceOfRain = "daily_chance_of_rain"
        case condition
    }
}

struct Hour: Codable, Hashable {
    let id = UUID()
    let time: String
    let tempC: Double
    let tempF: Double
    let isDay: Int
    let condition: WeatherCondition
    let humidity: Int
    let feelslikeC: Double
    let feelslikeF: Double
    let chanceOfRain: Int
    let uv: Double
    
    enum CodingKeys: String, CodingKey {
        case time
        case tempC = "temp_c"
        case tempF = "temp_f"
        case isDay = "is_day"
        case condition
        case humidity
        case feelslikeC = "feelslike_c"
        case feelslikeF = "feelslike_f"
        case chanceOfRain = "chance_of_rain"
        case uv
    }
}
