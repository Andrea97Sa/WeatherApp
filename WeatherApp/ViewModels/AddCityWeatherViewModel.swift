//
//  AddWeatherCityViewModel.swift
//  WeatherApp
//
//  Created by Ulixe on 24/11/24.
//

import Foundation

class AddCityWeatherViewModel: BaseViewModel {
    
    @Published var cityNames: [City] = []
    @Published var searchText: String = ""
    @Published var selectedCity: City? = nil
    
    @MainActor func fetchCityNames() async {
        do {
            self.viewState = .loading
            guard try await !dataProvider.fetchCityName(by: searchText).isEmpty else {
                self.viewState = .empty
                return
            }
            self.cityNames = try await dataProvider.fetchCityName(by: searchText)
            self.viewState = .success
            
        } catch {
            self.viewState = .failure(error: error.localizedDescription)
            debugPrint("Error fetching city names: \(error)")
        }
    }
    
    func filteredCityNames(existingWeather: [Weather]) -> [City] {
        return cityNames
            .filter({  !existingWeather
                    .compactMap({ $0.location.name + $0.location.region + $0.location.country })
            .contains($0.name + $0.region + $0.country ) })
    }
    
}
