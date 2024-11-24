//
//  AddWeatherView.swift
//  WeatherApp
//
//  Created by Ulixe on 23/11/24.
//

import SwiftUI

struct AddWeatherView: View {
    
    @Binding var newWeatherCityPresented: Bool
    @ObservedObject var homeViewModel: HomeViewModel
    @StateObject private var addCityWeatherViewModel = AddCityWeatherViewModel(dataProvider: NetworkManger.shared)
    
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
                switch addCityWeatherViewModel.viewState {
                case .loading:
                    ProgressView()
                case .success:
                    ForEach(addCityWeatherViewModel.cityNames, id: \.id) { city in
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
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    AddButtonView(disabled: addCityWeatherViewModel.selectedCity == nil) {
                        Task { await homeViewModel.fetchWeatherData(by: addCityWeatherViewModel.selectedCity?.name)
                            newWeatherCityPresented.toggle()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    AddWeatherView(newWeatherCityPresented: .constant(false), homeViewModel: HomeViewModel(dataProvider: MockedDataManager.shared))
}
