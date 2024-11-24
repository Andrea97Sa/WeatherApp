//
//  WeatherDetailView.swift
//  WeatherApp
//
//  Created by Ulixe on 24/11/24.
//

import SwiftUI

struct WeatherDetailView: View {
    
    @ObservedObject var router: Router
    @State var selectedMetric: Metric = .celsius
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
                    router.navigationPath.removeLast()
                }, label: {
                    Image(systemName: "arrow.left")
                }).buttonStyle(.plain)
            }
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    Button(action: {
                        selectedMetric = .celsius
                    }, label: {
                        Text("°C")
                            .underline(selectedMetric == .celsius)
                    }).buttonStyle(.plain)
                    
                    Button(action: {
                        selectedMetric = .farhenheit
                    }, label: {
                        Text("°F")
                            .underline(selectedMetric == .farhenheit)
                    }).buttonStyle(.plain)
                }
            }
        }
        .padding(.horizontal)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    WeatherDetailView(router: Router(), weather: MockedDataManager.shared.mockWeather)
}
