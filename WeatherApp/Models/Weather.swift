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
    let feelsLike: Double
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
        case feelsLike = "feelslike_c"
        case humidity = "humidity"
        case wind = "wind_kph"
        case pressure = "pressure_mb"
        case uv = "uv"
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
