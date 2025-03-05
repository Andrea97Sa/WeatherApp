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
    
    
    @MainActor func fetchWeatherData(by cityName: String) async {
        do {
            self.viewState = .loading
                guard let newWeather = try await dataProvider.fetchWeatherData(by: cityName, by: nil) else { return }
                self.weatherCities.append(newWeather)
                persistWeatherCity(newWeather)
            self.viewState = .success
            } catch {
                self.viewState = .failure(error: error.localizedDescription)
                debugPrint("Error fetching weather data: \(error)")
            }
    }
    
    @MainActor func fetchWeatherData(by position: Position) async {
        do {
            self.viewState = .loading
            guard let newWeather = try await dataProvider.fetchWeatherData(by: nil, by: position) else { return }
            guard !weatherAlreadyExists(weather: newWeather) else { return }
                self.weatherCities.append(newWeather)
                persistWeatherCity(newWeather)
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
    
    func fetchPersistedWeatherData() async {
        await refreshWeatherData(by: UserDefaultsManager.shared.fetchArray(of: Weather.self, for: Constants.weatherDefaultsKey))
    }

    @MainActor func deleteWeatherCity(at index: IndexSet) {
        self.weatherCities.remove(atOffsets: index)
        UserDefaultsManager.shared.deleteElement(of: Weather.self, at: index, from: Constants.weatherDefaultsKey)
    }
    
    func refreshCurrentWeatherData(by currentCities: [Weather]?) async {
        await MainActor.run {
            self.viewState = .loading
        }
        guard !weatherCities.isEmpty else {
            await MainActor.run {
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
            await fetchWeatherData(by: currentPosition)
        }
    }
    
    func persistWeatherCity(_ weather: Weather) {
        UserDefaultsManager.shared.addElement(weather, to: Constants.weatherDefaultsKey)
    }
    
    private func weatherAlreadyExists(weather: Weather) -> Bool {
        let weathers = UserDefaultsManager.shared.fetchArray(of: Weather.self, for: Constants.weatherDefaultsKey)
        return weathers.contains(where: { $0.location.name == weather.location.name })
    }
}

