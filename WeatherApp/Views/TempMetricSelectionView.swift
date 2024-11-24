//
//  TempMetricSelectionView.swift
//  WeatherApp
//
//  Created by Ulixe on 24/11/24.
//

import SwiftUI

struct TempMetricSelectionView: View {
    
    @Binding var selectedMetric: Metric
    
    var body: some View {
        HStack {
            Button(action: {
                withAnimation {
                    selectedMetric = .celsius
                }
            }, label: {
                Text("°C")
                    .underline(selectedMetric == .celsius)
            }).buttonStyle(.plain)
            
            Button(action: {
                withAnimation {
                    selectedMetric = .farhenheit
                }
            }, label: {
                Text("°F")
                    .underline(selectedMetric == .farhenheit)
            }).buttonStyle(.plain)
        }
    }
}
