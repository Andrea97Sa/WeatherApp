//
//  ContentView.swift
//  WeatherApp
//
//  Created by Ulixe on 23/11/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var homeViewModel = HomeViewModel(dataProvider: MockedDataManager.shared)
    @State private var path: NavigationPath = NavigationPath()
    @State private var newWeatherCityPresented = false
    @State private var searchText: String = ""
    
    init(homeViewModel: HomeViewModel) {
        _homeViewModel = StateObject(wrappedValue: homeViewModel)
    }
    
    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                if let weatherCities = homeViewModel.weatherCities {
                    LazyVStack {
                        ForEach(weatherCities, id: \.self) { city in
                            SingleWeatherView(weather: city, newWeatherCityPresented: $newWeatherCityPresented)
                                .onTapGesture {
                                    path.append(city)
                                }
                        }
                        Spacer()
                    }
                }
            }
            .padding(.horizontal)
            .frame(maxWidth: .infinity, alignment: .leading)
            .navigationTitle("today")
            .navigationDestination(for: Weather.self, destination: { weather in
                WeatherDetailView(weather: weather)
            })
        }.toolbar {
            ToolbarItem(placement: .bottomBar) {
                AddButtonView(action: {
                    newWeatherCityPresented.toggle()
                })
            }
        }
        .sheet(
            isPresented: $newWeatherCityPresented,
            content: {
                AddWeatherView(searchText: $searchText, newWeatherCityPresented: $newWeatherCityPresented, homeViewModel: homeViewModel)
            })
        .onReceive(LocationManager.shared.$userLocation, perform: { userLocation in
            if let userLocation = userLocation {
                let currentPosition = Position(latitude: userLocation.latitude, longitude: userLocation.longitude)
                Task { await homeViewModel.fetchWeatherData(by: nil, by: currentPosition) }
            }
        })
    }
}

#Preview {
    ContentView(homeViewModel: HomeViewModel(dataProvider: MockedDataManager.shared))
}
