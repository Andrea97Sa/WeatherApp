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
}

enum ViewState {
    case loading
    case success
    case failure(error: String)
    case empty
}
