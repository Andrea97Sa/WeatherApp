//
//  Router.swift
//  WeatherApp
//
//  Created by Ulixe on 24/11/24.
//

import SwiftUI

class Router: ObservableObject {
    
    static let shared = Router()
    
    @Published var navigationPath = NavigationPath()
}
