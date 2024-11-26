//
//  ForecastViewModel.swift
//  WeatherApp
//
//  Created by Ulixe on 25/11/24.
//

import SwiftUI

class ForecastViewModel: ObservableObject {
    
    let weather: Weather
    
    init(weather: Weather) {
        self.weather = weather
    }
    
    func getSelectedMetricTemp(hour: Hour, selectedMetric: Metric) -> String {
        return selectedMetric == .celsius ? "\(hour.tempC.description)°" : "\(hour.tempF.description)°"
    }
    
    func checkHourIsPast(hour: Hour) -> Bool {
        return hour.time.formatted(.dateTime.hour()) < weather.location.localtime.formatted(.dateTime.hour())
    }
    
    func checkHourIsCurrent(hour: Hour) -> Bool {
        return hour.time.formatted(.dateTime.hour()) == weather.location.localtime.formatted(.dateTime.hour())
    }
    
    func getCurrentHourIndex(by hours: [Hour]) -> Int {
        let currentHour = weather.location.localtime.formatted(.dateTime.hour())
        return hours.firstIndex(where: { $0.time.formatted(.dateTime.hour()) == currentHour }) ?? 0
    }


}
