//
//  SingleWeatherView.swift
//  WeatherApp
//
//  Created by Ulixe on 23/11/24.
//

import SwiftUI

struct SingleWeatherView: View {
    
    let weather: Weather
    @Binding var newWeatherCityPresented: Bool
    @Binding var selectedMetric: Metric

    var body: some View {
        VStack(alignment: .leading) {
            Divider()
            HStack {
                Text(weather.location.country.lowercased())
                Spacer()
                Text(weather.location.localtime)
            }
            .padding(.top, 16)
            .font(.callout)
            
            HStack {
                Text(weather.location.name.lowercased())
                Spacer()
                HStack {
                    Text(selectedMetric == .celsius ? "\(weather.currentWeather.tempC.description)°" : "\(weather.currentWeather.tempF.description)°")
                    Image(systemName: weather.currentWeather.weatherIcon)
                }
            }
            .font(.title2)
            .fontWeight(.semibold)
        }.background(.white)
    }
}
