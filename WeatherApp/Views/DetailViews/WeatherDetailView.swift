//
//  WeatherDetailView.swift
//  WeatherApp
//
//  Created by Ulixe on 24/11/24.
//

import SwiftUI

struct WeatherDetailView: View {
    @EnvironmentObject private var router: Router
    @Binding var selectedMetric: Metric

    var weather: Weather
    
    var body: some View {
        VStack(alignment: .leading, spacing: 48) {
            
            TemperatureView(weather: weather, selectedMetric: $selectedMetric)
            Divider()
            MultipleInfoView(weather: weather, selectedMetric: $selectedMetric)
            Divider()
            ForecastView(weather: weather, selectedMetric: $selectedMetric)
            Spacer()

        }.toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    router.pop()
                }, label: {
                    Image(systemName: "arrow.left")
                }).buttonStyle(.plain)
            }
            ToolbarItem(placement: .topBarTrailing) {
                TempMetricSelectionView(selectedMetric: $selectedMetric)
            }
        }
        .padding(.horizontal)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    WeatherDetailView(selectedMetric: .constant(.celsius), weather: MockedDataManager.shared.mockWeather)
}

