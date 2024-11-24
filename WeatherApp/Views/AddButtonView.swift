//
//  AddButtonView.swift
//  WeatherApp
//
//  Created by Ulixe on 24/11/24.
//

import SwiftUI

struct AddButtonView: View {
    
    let action: () -> ()
    
    var body: some View {
        Button {
            action()
        } label: {
            Text("add")
                .underline()
        }.buttonStyle(.plain)
    }
}

