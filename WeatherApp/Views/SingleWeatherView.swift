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
    
    var body: some View {
        VStack(alignment: .leading) {
            Divider()
            
            HStack {
                Text(weather.location.country.lowercased())
                Spacer()
                Text(Date().formatted(.dateTime))
            }
            .padding(.top, 16)
            .font(.callout)
            
            HStack {
                Text(weather.location.name.lowercased())
                Spacer()
                Text(weather.main.tempC.description)
            }
            .font(.title2)
            .fontWeight(.semibold)
            
        }
        .padding()
    }
}
