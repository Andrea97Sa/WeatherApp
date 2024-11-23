//
//  ContentView.swift
//  WeatherApp
//
//  Created by Ulixe on 23/11/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var homeViewModel = HomeViewModel(dataProvider: NetworkManger.shared)
    @State private var path: NavigationPath = NavigationPath()
    @State private var newWeatherCityPresented = false
    @State private var searchText: String = ""
    
    init(homeViewModel: HomeViewModel) {
        _homeViewModel = StateObject(wrappedValue: homeViewModel)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Button(action: {
                    if let userLocation = LocationManager.shared.userLocation {
                        let currentPosition = Position(latitude: userLocation.latitude, longitude: userLocation.longitude)
                        Task { await homeViewModel.fetchWeatherData(by: nil, by: currentPosition) }
                    }
                }, label: {
                    Text("Find my location")
                }).navigationTitle("today")
                if let weatherCities = homeViewModel.weatherCities {
                    LazyVStack {
                        ForEach(weatherCities, id: \.self) { city in
                            SingleWeatherView(weather: city, newWeatherCityPresented: $newWeatherCityPresented)
                        }
                    }
                    Spacer()
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }.toolbar {
            ToolbarItem(placement: .bottomBar) {
                Button {
                    newWeatherCityPresented.toggle()
                } label: {
                    Image(systemName: "plus.circle")
                }.buttonStyle(.plain)
            }
        }
        .sheet(
            isPresented: $newWeatherCityPresented,
            onDismiss: {
                guard !searchText.isEmpty else { return }
                Task { await homeViewModel.fetchWeatherData(by: searchText) }
            },
            content: {
                AddWeatherView(searchText: $searchText, newWeatherCityPresented: $newWeatherCityPresented, homeViewModel: homeViewModel)
                
            })
        .task {
            if let userLocation = LocationManager.shared.userLocation {
                let currentPosition = Position(latitude: userLocation.latitude, longitude: userLocation.longitude)
                Task { await homeViewModel.fetchWeatherData(by: nil, by: currentPosition) }
            }
        }
    }
}

#Preview {
    ContentView(homeViewModel: HomeViewModel(dataProvider: MockedDataManager.shared))
}




