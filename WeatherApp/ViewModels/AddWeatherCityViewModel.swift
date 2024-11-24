//
//  AddWeatherCityViewModel.swift
//  WeatherApp
//
//  Created by Ulixe on 24/11/24.
//

import Foundation

class AddWeatherCityViewModel: ObservableObject {
    
    @Published var cityNames: [String] = []
    let dataProvider: DataProviderProtocol

    init(dataProvider: DataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    func fetchCityNames() {
        
        
        
    }
    
    
}
