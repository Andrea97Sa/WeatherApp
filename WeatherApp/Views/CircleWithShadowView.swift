//
//  CircleWithShadowView.swift
//  WeatherApp
//
//  Created by Ulixe on 25/11/24.
//

import SwiftUI

struct CircleWithShadowView: View {
    
    let gradientColorsArray: [Color]
    
    var body: some View {
        Circle()
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: gradientColorsArray),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .blur(radius: 30)
            .frame(width: UIScreen.main.bounds.width)
    }
}


#Preview {
    let color = [Color(uiColor: UIColor(red: 0.161, green: 0.161, blue: 0.161, alpha: 1)),
                 Color(uiColor: UIColor(red: 0.111, green: 0.125, blue: 0.124, alpha: 1)),
     Color(uiColor: UIColor(red: 0.169, green: 0.239, blue: 0.576, alpha: 0.3))]
    CircleWithShadowView(gradientColorsArray: color)
}
