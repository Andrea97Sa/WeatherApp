//
//  TemperatureView.swift
//  WeatherApp
//
//  Created by Ulixe on 24/11/24.
//

import SwiftUI

struct TemperatureView: View {
    
    let weather: Weather
    @Binding var selectedMetric: Metric
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(weather.location.name)
            HStack(alignment: .center) {
                Text(selectedMetric == .celsius ?  "\(weather.currentWeather.tempC.description)°" : "\(weather.currentWeather.tempF.description)°")
                    .font(.system(size: 80))
                    .fontWeight(.bold)
                Spacer()
                VStack(alignment: .trailing, spacing: 32) {
                    HStack {
                        Image(systemName: weather.currentWeather.weatherIcon)
                        Text(weather.currentWeather.condition.text)
                    }
                    HStack(spacing: 4) {
                        Text("feels like")
                        Text(selectedMetric == .celsius ? "\(weather.currentWeather.feelsLikeC.description)°" : "\(weather.currentWeather.feelsLikeF.description)°")
                            .fontWeight(.bold)
                    }
                }
            }
        }
    }
}
