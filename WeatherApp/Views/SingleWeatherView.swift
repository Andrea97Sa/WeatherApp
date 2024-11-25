//
//  SingleWeatherView.swift
//  WeatherApp
//
//  Created by Ulixe on 23/11/24.
//

import SwiftUI

struct SingleWeatherView: View {
    
    let weather: Weather
    @Binding var selectedMetric: Metric

    var body: some View {
        VStack(alignment: .leading) {
            Divider()
            HStack {
                Text(weather.location.country.lowercased())
                Spacer()
                Text(weather.location.localtime.formatted(date: .omitted, time: .shortened))
            }
            .padding(.top, 16)
            .font(.customThin())
            HStack {
                Text(weather.location.name.lowercased())
                Spacer()
                HStack {
                    Text(selectedMetric == .celsius ? "\(weather.currentWeather.tempC.description)°" : "\(weather.currentWeather.tempF.description)°")
                    Image(systemName: weather.currentWeather.weatherIcon)
                }
            }
            .font(.customRegular())
        }.background(Color.accentColor)
    }
}
