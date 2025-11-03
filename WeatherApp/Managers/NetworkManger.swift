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
    
    let baseHost = "https://api.weatherapi.com/v1/"
    let apiKey = Bundle.main.infoDictionary?["ApiKey"] as? String
    
    let customDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        dateFormatter.locale = .current
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }()
    
    func fetch<T: Decodable>(_ url: URLConvertible, as type: T.Type, parameter: Parameters? = nil) async throws -> DataResponse<T, AFError> {
        do {
            let finalUrl = try baseHost + url.asURL().path()
            var parameters: Parameters? = parameter
            parameters?["key"] = apiKey
            return await AF.request(finalUrl, parameters: parameters).serializingDecodable(decoder: customDecoder).response
        } catch {
            throw error
        }
    }
    
    
    func fetchWeatherData(by position: Position) async throws -> Weather? {
        var parameters: Parameters = [
            "days": 1,
            "aqi": "no",
            "alerts": "no"
        ]
        
        parameters["q"] = "\(position.latitude),\(position.longitude)"
        
        let url = "forecast.json"
        let weather = try await self.fetch(url, as: Weather.self, parameter: parameters).result.get()
        return weather
    }
    
    
    func fetchCityName(by text: String) async throws -> [City] {
        let parameters: Parameters = [
            "q": text,
        ]
        
        let url = "search.json"
        let cities = try await self.fetch(url, as: [City].self, parameter: parameters).result.get()
        return cities
    }
}
