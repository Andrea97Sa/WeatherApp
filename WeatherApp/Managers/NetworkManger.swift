//
//  NetworkManger.swift
//  WeatherApp
//
//  Created by Ulixe on 23/11/24.
//

import Foundation
import Alamofire

class NetworkManger: DataProviderProtocol {
    
    static let shared = NetworkManger()
    
    let baseHost = "https://api.weatherapi.com/v1"
    let apiKeyParameter = "88d7f08069f54cbf870104542242311"
    
    
    func fetch<T: Decodable>(_ url: URLConvertible, as type: T.Type, parameter: Parameters? = nil) async throws -> DataResponse<T, AFError> {
        do {
            let finalUrl = try baseHost + url.asURL().path()
            return await AF.request(finalUrl, parameters: parameter).serializingDecodable().response
        } catch {
            throw error
        }
    }
    
    
    func fetchWeatherData(by cityName: String? = nil, by position: Position? = nil) async throws -> Weather? {
        var parameters: Parameters = ["key": apiKeyParameter]
        if let cityName {
            parameters["q"] = cityName
        } else if let position {
            parameters["q"] = "\(position.latitude),\(position.longitude)"
        }
        
        let url = "/current.json"
        let weather = try await self.fetch(url, as: Weather.self, parameter: parameters).result.get()
        return weather
    }
}
