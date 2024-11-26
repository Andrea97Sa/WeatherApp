//
//  ForecastView.swift
//  WeatherApp
//
//  Created by Ulixe on 24/11/24.
//

import SwiftUI

struct ForecastView: View {
    
    @StateObject var forecastViewModel: ForecastViewModel
    @Binding var selectedMetric: Metric
    
    init(weather: Weather, selectedMetric: Binding<Metric>) {
        self._forecastViewModel = StateObject(wrappedValue: ForecastViewModel(weather: weather))
        self._selectedMetric = selectedMetric
    }
    
    var body: some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 32) {
                    if let hours = forecastViewModel.weather.forecast.forecastday.first?.hour {
                        ForEach(hours, id: \.id) { hour in
                            VStack(alignment: .leading) {
                                Text(hour.time.formatted(.dateTime.hour(.twoDigits(amPM: .wide))))
                                    .font(.customThin())
                                Text(forecastViewModel.getSelectedMetricTemp(hour: hour, selectedMetric: selectedMetric))
                                    .font(.customRegular())
                                    .foregroundStyle(forecastViewModel.checkHourIsPast(hour: hour) ? Color.gray : Color.blackDark)
                                    .underline(forecastViewModel.checkHourIsCurrent(hour: hour))
                            }
                            .id(hour.id)
                        }
                    }
                }
            }
            .onAppear {
                if let hours = forecastViewModel.weather.forecast.forecastday.first?.hour {
                    proxy.scrollTo(hours[forecastViewModel.getCurrentHourIndex(by: hours)].id, anchor: .center)
                }
            }
        }
    }
}

#Preview {
    ForecastView(weather: MockedDataManager.shared.mockWeather, selectedMetric: .constant(.celsius))
}
