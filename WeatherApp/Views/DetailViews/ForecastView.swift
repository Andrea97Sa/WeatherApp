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
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 32) {
                if let hours = weather.forecast.forecastday.first?.hour {
                    ForEach(hours, id: \.id) { hour in
                        VStack(alignment: .leading) {
                            Text(hour.time.suffix(5).prefix(2))
                            Text(selectedMetric == .celsius ?  "\(hour.tempC.description)°" : "\(hour.tempF.description)°")
                                .fontWeight(.bold)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ForecastView(weather: MockedDataManager.shared.mockWeather, selectedMetric: .constant(.celsius))
}
