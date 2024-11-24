//
//  WeatherDetailView.swift
//  WeatherApp
//
//  Created by Ulixe on 24/11/24.
//

import SwiftUI

struct WeatherDetailView: View {
    
    var weather: Weather
    
    var body: some View {
        VStack(alignment: .leading, spacing: 48) {
            TemperatureView(weather: weather)
            Divider()
            MultipleInfoView(weather: weather)
            Divider()
            
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    VStack(alignment: .leading) {
                        Text("time")
                        Text("temp")
                    }
                }
            }
            Spacer()

        }.padding(.horizontal)
    }
}
#Preview {
    WeatherDetailView(weather: MockedDataManager.shared.mockWeather)
}


struct TemperatureView: View {
    
    let weather: Weather
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(weather.location.name)
            HStack(alignment: .center) {
                Text("\(weather.currentWeather.tempC.description)°")
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
                        Text("\(weather.currentWeather.feelsLike.description)°")
                            .fontWeight(.bold)
                    }
                }
            }
        }
    }
}

struct MultipleInfoView: View {
    
    let weather: Weather
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 24) {
                    Text("High")
                    WeatherInfoView(weather: weather, weatherInfoType: .humidity)
                    WeatherInfoView(weather: weather, weatherInfoType: .uv)
                    
                }
                Spacer()
                VStack(alignment: .leading, spacing: 24) {
                    Text("Low")
                    WeatherInfoView(weather: weather, weatherInfoType: .wind)
                    WeatherInfoView(weather: weather, weatherInfoType: .pressure)
                }
            }
        }
    }
}
