//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Ulixe on 24/11/24.
//

import SwiftUI

struct ForecastView: View {
    
    let weather: Weather
    @Binding var selectedMetric: Metric
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 32) {
                    if let hours = weather.forecast.forecastday.first?.hour {
                        ForEach(hours, id: \.id) { hour in
                            VStack(alignment: .leading) {
                                Text(hour.time.formatted(.dateTime.hour(.twoDigits(amPM: .wide))))
                                    .font(.customThin())
                                Text(selectedMetric == .celsius ? "\(hour.tempC.description)°" : "\(hour.tempF.description)°")
                                    .font(.customRegular())
                            }
                            .id(hour.id)
                        }
                    }
                }
            }
            .onAppear {
                if let hours = weather.forecast.forecastday.first?.hour,
                   let currentHourIndex = hours.firstIndex(where: {
                       $0.time.formatted(.dateTime.hour()) == Date().formatted(.dateTime.hour())
                   }) {
                    withAnimation {
                        proxy.scrollTo(hours[currentHourIndex].id, anchor: .center)
                    }
                }
            }
        }
    }
}

#Preview {
    ForecastView(weather: MockedDataManager.shared.mockWeather, selectedMetric: .constant(.celsius))
}
