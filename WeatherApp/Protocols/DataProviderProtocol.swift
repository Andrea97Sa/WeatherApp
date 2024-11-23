//
//  DataProviderProtocol.swift
//  WeatherApp
//
//  Created by Ulixe on 23/11/24.
//

import Foundation


protocol DataProviderProtocol {
    func fetchWeatherData() async throws -> WeatherData
}
