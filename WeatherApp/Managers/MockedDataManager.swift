//
//  MockedDataManager.swift
//  WeatherApp
//
//  Created by Ulixe on 23/11/24.
//

import Foundation

class MockedDataManager: DataProviderProtocol {
    
    static let shared = MockedDataManager()
    
    let mockWeather = Weather(
        location: WeatherLocation(
            name: "San Francisco",
            region: "California",
            country: "USA",
            lat: 37.7749,
            lon: -122.4194,
            localtime: "2024-11-24 10:00"
        ),
        currentWeather: CurrentWeather(
            lastUpdated: "2024-11-24 09:30",
            tempC: 15.0,
            tempF: 59.0,
            isDay: 1,
            feelsLike: 14.5,
            humidity: 80.0,
            wind: 25.0,
            pressure: 1013.0,
            uv: 3.0,
            condition: WeatherCondition(
                text: "Partly Cloudy",
                code: 1003
            )
        ),
        forecast: Forecast(
            forecastday: [
                ForecastDay(
                    date: "2024-11-24",
                    day: Day(
                        maxtempC: 16.2,
                        maxtempF: 61.1,
                        mintempC: 12.3,
                        mintempF: 54.2,
                        dailyChanceOfRain: 97,
                        condition: WeatherCondition(
                            text: "Moderate Rain",
                            code: 1189
                        )
                    ),
                    hour: [
                        Hour(
                            time: "2024-11-24 00:00",
                            tempC: 14.5,
                            tempF: 58.1,
                            isDay: 0,
                            condition: WeatherCondition(
                                text: "Light Drizzle",
                                code: 1153
                            ),
                            humidity: 90,
                            feelslikeC: 12.2,
                            feelslikeF: 53.9,
                            chanceOfRain: 100,
                            uv: 0.0
                        ),
                        Hour(
                            time: "2024-11-24 01:00",
                            tempC: 14.9,
                            tempF: 58.8,
                            isDay: 0,
                            condition: WeatherCondition(
                                text: "Patchy Rain Nearby",
                                code: 1063
                            ),
                            humidity: 86,
                            feelslikeC: 12.7,
                            feelslikeF: 54.8,
                            chanceOfRain: 85,
                            uv: 0.0
                        )
                    ]
                )
            ]
        )
    )


    func fetchWeatherData(by cityName: String? = nil, by position: Position? = nil) async throws -> Weather? {
        return mockWeather
    }
    
    
}
