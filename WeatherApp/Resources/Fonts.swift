//
//  Fonts.swift
//  WeatherApp
//
//  Created by Ulixe on 25/11/24.
//

import SwiftUI

extension Font {
    static func customTitle() -> Font {
        return Font.system(size: 40, weight: .bold)
    }
    static func customLargeTitle() -> Font {
        return Font.system(size: 80, weight: .bold)
    }
    static func customRegular() -> Font {
        return Font.system(size: 22, weight: .semibold)
    }
    static func customThin() -> Font {
        return Font.system(size: 16, weight: .thin)
    }
}
