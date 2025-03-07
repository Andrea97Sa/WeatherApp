//
//  AddWeatherView.swift
//  WeatherApp
//
//  Created by Ulixe on 23/11/24.
//

import SwiftUI

struct AddWeatherView: View {
    
    @ObservedObject var homeViewModel: HomeViewModel
    @StateObject private var addCityWeatherViewModel = AddCityWeatherViewModel(dataProvider: NetworkManger.shared)
    @FocusState private var isTextFieldFocused: Bool
    @Binding var newWeatherCityPresented: Bool

    var body: some View {
        NavigationStack {
            VStack {
                Text("what is the weather like in...")
                    .font(.title3)
                    .fontWeight(.thin)
                Text("today?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                TextField("enter city name...", text: $addCityWeatherViewModel.searchText)
                    .textFieldStyle(.roundedBorder)
                    .disableAutocorrection(true)
                    .focused($isTextFieldFocused)
                switch addCityWeatherViewModel.viewState {
                case .loading:
                    ProgressView()
                case .success:
                    ForEach(addCityWeatherViewModel.filteredCityNames(existingWeather: homeViewModel.weatherCities), id: \.id) { city in
                        LazyVStack(alignment: .leading, spacing: 16) {
                            HStack {
                                Text("\(city.name), \(city.region), \(city.country)")
                                if addCityWeatherViewModel.selectedCity?.id == city.id {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }.onTapGesture {
                            addCityWeatherViewModel.selectedCity = city
                        }
                    }
                case .failure(let error):
                    Text(error)
                case .empty:
                    EmptyView()
                }
            }.onReceive(addCityWeatherViewModel.$searchText.debounce(for: RunLoop.SchedulerTimeType.Stride(0.5), scheduler: RunLoop.main)) { searchTerm in
                guard searchTerm.count >= 3 else {
                    addCityWeatherViewModel.cityNames.removeAll()
                    addCityWeatherViewModel.selectedCity = nil
                    return }
                Task { await addCityWeatherViewModel.fetchCityNames() }
            }
            .onAppear {
                addCityWeatherViewModel.searchText = ""
                isTextFieldFocused = true
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    AddButtonView(disabled: addCityWeatherViewModel.selectedCity == nil) {
                        if let selectedCity = addCityWeatherViewModel.selectedCity {
                            let position = Position(latitude: selectedCity.lat, longitude: selectedCity.lon)
                            Task {
                                await homeViewModel.fetchWeatherData(by: position)
                                newWeatherCityPresented.toggle()
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AddWeatherView(homeViewModel: HomeViewModel(dataProvider: MockedDataManager.shared), newWeatherCityPresented: .constant(false))
}
