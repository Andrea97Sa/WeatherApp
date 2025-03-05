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
    
    func push(to view: AppRoute) {
        navigationPath.append(view)
    }
    
    func pop() {
        navigationPath.removeLast()
    }
    
    func popToRoute() {
        navigationPath = NavigationPath()
    }
}

enum AppRoute {
    case details(Weather)
}

extension AppRoute: Hashable {
    static func == (lhs: AppRoute, rhs: AppRoute) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    
    func hash(into hasher: inout Hasher) {
        
        switch self {
        case .details(let item):
            hasher.combine(item)
        }
    }
}
