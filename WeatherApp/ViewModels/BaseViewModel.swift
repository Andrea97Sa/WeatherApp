//
//  Untitled.swift
//  WeatherApp
//
//  Created by Ulixe on 24/11/24.
//

import Foundation

class BaseViewModel: ObservableObject {
    
    @Published var viewState: ViewState = .empty
    let dataProvider: DataProviderProtocol
    
    init(dataProvider: DataProviderProtocol) {
        self.dataProvider = dataProvider
    }
    
    enum ViewState {
        case loading
        case success
        case failure(error: String)
        case empty
    }
}

enum APIError: Error {
    case apiKeyNotProvided
    case queryParameterMissing
    case invalidRequestURL
    case locationNotFound
    case invalidAPIKey
    case quotaExceeded
    case apiKeyDisabled
    case resourceAccessDenied
    case invalidJsonBody
    case tooManyLocations
    case internalError

    var errorCode: Int {
        switch self {
        case .apiKeyNotProvided: return 1002
        case .queryParameterMissing: return 1003
        case .invalidRequestURL: return 1005
        case .locationNotFound: return 1006
        case .invalidAPIKey: return 2006
        case .quotaExceeded: return 2007
        case .apiKeyDisabled: return 2008
        case .resourceAccessDenied: return 2009
        case .invalidJsonBody: return 9000
        case .tooManyLocations: return 9001
        case .internalError: return 9999
        }
    }

    var message: String {
        switch self {
        case .apiKeyNotProvided: return "API key not provided."
        case .queryParameterMissing: return "Parameter 'q' not provided."
        case .invalidRequestURL: return "API request URL is invalid."
        case .locationNotFound: return "No location found matching parameter 'q'."
        case .invalidAPIKey: return "API key provided is invalid."
        case .quotaExceeded: return "API key has exceeded calls per month quota."
        case .apiKeyDisabled: return "API key has been disabled."
        case .resourceAccessDenied: return "API key does not have access to the resource. Check your subscription plan."
        case .invalidJsonBody: return "JSON body passed in bulk request is invalid. Ensure it is valid JSON with UTF-8 encoding."
        case .tooManyLocations: return "JSON body contains too many locations for a bulk request. Keep it below 50."
        case .internalError: return "Internal application error."
        }
    }
}
