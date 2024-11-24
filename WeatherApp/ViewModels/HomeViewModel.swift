//
//  File.swift
//  WeatherApp
//
//  Created by Ulixe on 23/11/24.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var weather: Weather?
    @Published var weatherCities: [Weather]?
    
    let dataProvider: DataProviderProtocol
    
    init(dataProvider: DataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    @MainActor func fetchWeatherData(by cityName: String? = nil, by position: Position? = nil) async {
        do {
            if let cityName {
                guard let newWeather = try await dataProvider.fetchWeatherData(by: cityName, by: nil) else { return }
                self.weatherCities?.append(newWeather)
            } else if let position  {
                guard let newWeather = try await dataProvider.fetchWeatherData(by: nil, by: position) else { return }
                self.weatherCities = [newWeather]
        }
        } catch {
            debugPrint("Error fetching weather data: \(error)")
        }
    }
}
