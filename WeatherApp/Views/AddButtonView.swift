//
//  AddButtonView.swift
//  WeatherApp
//
//  Created by Ulixe on 24/11/24.
//

import SwiftUI

struct AddButtonView: View {
    
    let disabled: Bool
    let action: () -> ()
    
    init(disabled: Bool? = false, action: @escaping () -> ()) {
        self.disabled = disabled ?? false
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            Text("add")
                .font(.customThin())
                .underline()
        }.disabled(disabled)
        .buttonStyle(.plain)
    }
}

