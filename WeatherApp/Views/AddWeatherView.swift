//
//  AddWeatherView.swift
//  WeatherApp
//
//  Created by Ulixe on 23/11/24.
//

import SwiftUI

struct AddWeatherView: View {
    
    @Binding var searchText: String
    @Binding var newWeatherCityPresented: Bool
    @ObservedObject var homeViewModel: HomeViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("what is the weather like in...")
                    .font(.title3)
                    .fontWeight(.thin)
                TextField("enter city name...", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                Text("today?")
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    AddButtonView {
                        guard !searchText.isEmpty else { return }
                        Task { await homeViewModel.fetchWeatherData(by: searchText) }
                        newWeatherCityPresented.toggle()
                    }
                }
            }
        }
    }
}
#Preview {
    AddWeatherView(searchText: .constant(""), newWeatherCityPresented: .constant(false), homeViewModel: HomeViewModel(dataProvider: MockedDataManager.shared))
}
