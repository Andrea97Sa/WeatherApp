//
//  File.swift
//  WeatherApp
//
//  Created by Ulixe on 23/11/24.
//

import Foundation
import CoreLocation

class HomeViewModel: BaseViewModel {
    
    @Published var weather: Weather?
    @Published var weatherCities: [Weather] = []
    
    @MainActor func fetchWeatherData(by cityName: String? = nil, by position: Position? = nil) async {
        do {
            self.viewState = .loading
            if let cityName {
                guard let newWeather = try await dataProvider.fetchWeatherData(by: cityName, by: nil) else { return }
                self.weatherCities.append(newWeather)
            } else if let position  {
                guard let newWeather = try await dataProvider.fetchWeatherData(by: nil, by: position) else { return }
                self.weatherCities = [newWeather]
            }
            self.viewState = .success
            
        } catch {
            self.viewState = .failure(error: error.localizedDescription)
            debugPrint("Error fetching weather data: \(error)")
        }
    }
    
    @MainActor func refreshWeatherData(by weathers: [Weather]) async {
        do {
            self.viewState = .loading
            self.weatherCities.removeAll()
            for weather in weathers {
                guard let newWeather = try await dataProvider.fetchWeatherData(by: weather.location.name, by: nil) else { return }
                self.weatherCities.append(newWeather)
            }
            self.viewState = .success
        } catch  {
            self.viewState = .failure(error: error.localizedDescription)
            debugPrint("Error refreshing weather data: \(error)")
        }
    }
    
    func deleteWeatherCity(at index: IndexSet) {
        self.weatherCities.remove(atOffsets: index)
    }
    
    func refreshCurrentWeatherData(by currentCities: [Weather]?) async {
        DispatchQueue.main.async {
            self.viewState = .loading
        }
        guard !weatherCities.isEmpty else {
            DispatchQueue.main.async {
                self.viewState = .empty
            }
            return }
        var currentCities = [Weather]()
        for city in weatherCities {
            currentCities.append(city)
        }
        await refreshWeatherData(by: currentCities)
    }
    
    func fetchLocationByUserPosition(userLocation: CLLocationCoordinate2D?) async {
        if let userLocation = userLocation {
            let currentPosition = Position(latitude: userLocation.latitude, longitude: userLocation.longitude)
            await fetchWeatherData(by: nil, by: currentPosition)
        }
    }
    
}

