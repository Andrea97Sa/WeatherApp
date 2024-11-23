//
//  MockedDataManager.swift
//  WeatherApp
//
//  Created by Ulixe on 23/11/24.
//

import Foundation

class MockedDataManager: DataProviderProtocol {
    
    static let shared = MockedDataManager()
    
    let mockWeatherResponse = Weather(
        location: WeatherLocation(
            name: "Position",
            region: "",
            country: "Polen",
            lat: 53.9833,
            lon: 23.5,
            localtime: Date().description
        ),
        main: CurrentWeather(
            lastUpdated: Date().description,
            tempC: 1.1,
            tempF: 34.0,
            isDay: 1,
            condition: WeatherCondition(
                text: "Partly cloudy",
                icon: "//cdn.weatherapi.com/weather/64x64/day/116.png",
                code: 1003
            )
        )
    )

    
    func fetchWeatherData(by cityName: String? = nil, by position: Position? = nil) async throws -> Weather? {
        return mockWeatherResponse
    }
    
    
}
