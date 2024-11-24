//
//  ExtractedView.swift
//  WeatherApp
//
//  Created by Ulixe on 24/11/24.
//


import SwiftUI

struct RefreshWeatherListButton: View {
    
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        Button(action: {
            Task { await homeViewModel.refreshCurrentWeatherData(by: homeViewModel.weatherCities) }
        }, label: {
            Image(systemName: "arrow.circlepath")
        }).buttonStyle(.plain)
    }
}
