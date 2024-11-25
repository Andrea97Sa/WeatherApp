//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Ulixe on 25/11/24.
//

import Foundation


class ForecastViewModel: ObservableObject {
    
    @Published var weather: Weather
    @Published var selectedMetric: Metric
    
    init(weather: Weather, selectedMetric: Metric) {
        self.weather = weather
        self.selectedMetric = selectedMetric
    }
    
    func getSelectedMetricTemp(hour: Hour) -> String {
        return selectedMetric == .celsius ? "\(hour.tempC.description)°" : "\(hour.tempF.description)°"

    }

}
