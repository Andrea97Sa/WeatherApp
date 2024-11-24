//
//  ContentView.swift
//  WeatherApp
//
//  Created by Ulixe on 23/11/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var homeViewModel = HomeViewModel(dataProvider: NetworkManger.shared)
    @StateObject private var router = Router()
    @State private var newWeatherCityPresented = false
    @State private var searchText: String = ""
    
    init(homeViewModel: HomeViewModel) {
        _homeViewModel = StateObject(wrappedValue: homeViewModel)
    }
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            List {
                if let weatherCities = homeViewModel.weatherCities {
                    ForEach(weatherCities, id: \.self) { city in
                        SingleWeatherView(weather: city, newWeatherCityPresented: $newWeatherCityPresented)
                            .listRowSeparator(.hidden)
                            .onTapGesture {
                                router.navigationPath.append(city)
                            }
                    }.onDelete { offsets in
                        homeViewModel.weatherCities?.remove(atOffsets: offsets)
                    }
                }
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("today")
                        .font(.system(size: 40))
                        .fontWeight(.bold)
                }
                ToolbarItem(placement: .topBarTrailing) {
                    AddButtonView(action: {
                        searchText = ""
                        newWeatherCityPresented.toggle()
                    })
                }
            }
            .refreshable {
                for city in homeViewModel.weatherCities ?? [] {
                    await homeViewModel.fetchWeatherData(by: city.location.name)
                }
            }
            .navigationDestination(for: Weather.self, destination: { weather in
                WeatherDetailView(router: router, weather: weather)
            })
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
