//
//  DataProviderProtocol.swift
//  WeatherApp
//
//  Created by Ulixe on 23/11/24.
//

import Foundation


protocol DataProviderProtocol {
    func fetchWeatherData(by cityName: String?, by position: Position?) async throws -> Weather?
}
