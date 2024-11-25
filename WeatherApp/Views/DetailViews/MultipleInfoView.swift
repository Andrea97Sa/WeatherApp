//
//  MultipleInfoView.swift
//  WeatherApp
//
//  Created by Ulixe on 24/11/24.
//

import SwiftUI

struct MultipleInfoView: View {
    
    let weather: Weather
    @Binding var selectedMetric: Metric

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 24) {
                    if let day = weather.forecast.forecastday.first?.day {
                        HStack {
                            Image(systemName: "arrow.up")
                            Text(selectedMetric == .celsius ?  "\(day.maxtempC.description)°" : "\(day.maxtempF.description)°")
                                .font(.customRegular())
                        }
                    }
                    WeatherInfoView(weather: weather, weatherInfoType: .humidity)
                    WeatherInfoView(weather: weather, weatherInfoType: .uv)
                    
                }
                Spacer()
                VStack(alignment: .leading, spacing: 24) {
                    if let day = weather.forecast.forecastday.first?.day {
                        HStack {
                            Image(systemName: "arrow.down")
                            Text(selectedMetric == .celsius ?  "\(day.mintempC.description)°" : "\(day.mintempF.description)°")
                                .font(.customRegular())
                        }
                    }
                    WeatherInfoView(weather: weather, weatherInfoType: .wind)
                    WeatherInfoView(weather: weather, weatherInfoType: .pressure)
                }
            }
        }
    }
}
