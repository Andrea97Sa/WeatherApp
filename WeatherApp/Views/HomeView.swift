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
            VStack {
                switch homeViewModel.viewState {
                case .success:
                    List {
                        ForEach(homeViewModel.weatherCities, id: \.self) { city in
                            SingleWeatherView(weather: city, selectedMetric: $selectedMetric)
                                .listRowSeparator(.hidden)
                                .onTapGesture {
                                    router.push(to: .details(city))
                                }
                        }.onDelete { offset in
                            homeViewModel.deleteWeatherCity(at: offset)
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
                ToolbarItem(placement: .principal) {
                        Text("today")
                            .font(.customTitle()) // your custom font
                    }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 12) {
                        RefreshWeatherListButton(homeViewModel: homeViewModel)
                        TempMetricSelectionView(selectedMetric: $selectedMetric)
                        AddButtonView(action: {
                            newWeatherCityPresented.toggle()
                        })
                    }
                    .padding(.horizontal, 4)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            //MARK: - Modal Navigation
            .sheet(
                isPresented: $newWeatherCityPresented,
                content: {
                    AddWeatherView(homeViewModel: homeViewModel, newWeatherCityPresented: $newWeatherCityPresented)
                })
            .task {
                await homeViewModel.fetchPersistedWeatherData()
            }
            .onReceive(LocationManager.shared.$userLocation) { userLocation in
                Task { await homeViewModel.fetchLocationByUserPosition(userLocation: userLocation) }
            }
        }
    }
}

#Preview {
    HomeView()
}
