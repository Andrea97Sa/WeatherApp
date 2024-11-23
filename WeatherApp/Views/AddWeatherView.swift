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
                TextField("wnter city name", text: $searchText)
                    .textFieldStyle(.roundedBorder)
                Text("today")
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        guard !searchText.isEmpty else { return }
                        Task { await homeViewModel.fetchWeatherData(by: searchText) }
                        newWeatherCityPresented.toggle()
                    }, label: {
                        Text("add")
                    })
                }
            }
        }
    }
}
