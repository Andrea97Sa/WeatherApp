//
//  ContentView.swift
//  WeatherApp
//
//  Created by Ulixe on 23/11/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var router: Router
    @StateObject private var homeViewModel = HomeViewModel(dataProvider: NetworkManger.shared)
    @State private var newWeatherCityPresented = false
    @State var selectedMetric: Metric = .celsius
    
    var body: some View {
        NavigationStack(path: $router.navigationPath) {
            VStack{
                switch homeViewModel.viewState {
                case .success:
                    List {
                        if let weatherCities = homeViewModel.weatherCities {
                            ForEach(weatherCities, id: \.self) { city in
                                SingleWeatherView(weather: city, selectedMetric: $selectedMetric)
                                    .listRowSeparator(.hidden)
                                    .onTapGesture {
                                        router.push(to: .details(city))
                                    }
                            }.onDelete { offset in
                                homeViewModel.deleteWeatherCity(at: offset)
                            }
                        }
                    }
                    //MARK: - List Setup
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                    //MARK: - Push Navigation
                    .navigationDestination(for: AppRoute.self, destination: { route in
                        switch route {
                        case .details(let city):
                            WeatherDetailView(selectedMetric: $selectedMetric, weather: city)
                        }
                    })
                case .loading:
                    ProgressView()
                case .failure(let error):
                    Text(error)
                case .empty:
                    Text("no cities added yet")
                }
            }
            //MARK: - NavigationBar setup
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("today")
                        .font(.customTitle())
                }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 12) {
                        TempMetricSelectionView(selectedMetric: $selectedMetric)
                        RefreshWeatherListButton(homeViewModel: homeViewModel)
                        AddButtonView(action: {
                            newWeatherCityPresented.toggle()
                        })
                    }
                }
            }
            //MARK: - Modal Navigation
            .sheet(
                isPresented: $newWeatherCityPresented,
                content: {
                    AddWeatherView(newWeatherCityPresented: $newWeatherCityPresented, homeViewModel: homeViewModel)
                })
            .onReceive(LocationManager.shared.$userLocation, perform: { userLocation in
                Task { await homeViewModel.fetchLocationByUserPosition(userLocation: userLocation) }
            })
        }
        
    }
}

#Preview {
    HomeView()
}
