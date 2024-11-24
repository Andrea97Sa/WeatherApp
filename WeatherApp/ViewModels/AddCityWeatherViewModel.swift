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
    
    
    
}
