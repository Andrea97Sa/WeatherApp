//
//  ContentView.swift
//  WeatherApp
//
//  Created by Ulixe on 23/11/24.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var homeViewModel = HomeViewModel(dataProvider: NetworkManger.shared)
    @StateObject private var router = Router()
    @State private var newWeatherCityPresented = false
    
    init(homeViewModel: HomeViewModel) {
        _homeViewModel = StateObject(wrappedValue: homeViewModel)
    }
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            List {
                switch homeViewModel.viewState {
                case .success:
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
                case .loading:
                    ProgressView()
                case .failure(let error):
                    Text(error)
                case .empty:
                    Text("No cities added yet")
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
                        newWeatherCityPresented.toggle()
                    })
                }
            }
            .refreshable {
                var currentCities = [Weather]()
                for city in homeViewModel.weatherCities ?? [] {
                    currentCities.append(city)
                }
                await homeViewModel.refreshWeatherData(by: currentCities)
            }
            .navigationDestination(for: Weather.self, destination: { weather in
                WeatherDetailView(router: router, weather: weather)
            })
        }
        .sheet(
            isPresented: $newWeatherCityPresented,
            content: {
                AddWeatherView(newWeatherCityPresented: $newWeatherCityPresented, homeViewModel: homeViewModel)
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
    HomeView(homeViewModel: HomeViewModel(dataProvider: MockedDataManager.shared))
}
