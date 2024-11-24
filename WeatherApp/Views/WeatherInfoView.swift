//
//  WeatherInfoView.swift
//  WeatherApp
//
//  Created by Ulixe on 24/11/24.
//

import SwiftUI

struct WeatherInfoView: View {
    
    let weather: Weather
    let weatherInfoType: WeatherInfoType
    
    var body: some View {
        switch weatherInfoType {
        case .humidity: return
            HStack {
                Text("humidity")
                Text("\(weather.currentWeather.humidity.description) \(weatherInfoType.unitMeasure)")
                    .fontWeight(.bold)
            }
        case .wind: return
            HStack {
                Text("wind")
                Text("\(weather.currentWeather.wind.description) \(weatherInfoType.unitMeasure)")
                    .fontWeight(.bold)
            }
        case .uv: return
            HStack {
                Text("uv")
                Text("\(weather.currentWeather.uv.description) \(weatherInfoType.unitMeasure)")
                    .fontWeight(.bold)
            }
        case .pressure: return
            HStack {
                Text("pressure")
                Text("\(weather.currentWeather.pressure.description) \(weatherInfoType.unitMeasure)")
                    .fontWeight(.bold)
            }
        }
        
    }
}

enum WeatherInfoType {
    case humidity
    case wind
    case uv
    case pressure
    
    var title: String {
        switch self {
        case .humidity: return "Humidity"
        case .wind: return "Wind"
        case .uv: return "UV"
        case .pressure: return "Pressure"
        }
    }
    var unitMeasure: String {
        switch self {
        case .humidity:  "%"
        case .wind:  "m/s"
        case .uv:  ""
        case .pressure: "mb"
        }
    }
}

#Preview {
    WeatherInfoView(weather: MockedDataManager.shared.mockWeather, weatherInfoType: .humidity)
}

