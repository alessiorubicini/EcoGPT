//
//  AppearanceSettingsView.swift
//  EcoGPT
//
//  Created by Alessio Rubicini on 28/04/25.
//

import Foundation
import SwiftUI

struct AppearanceSettingsView: View {
    @ObservedObject var settings: SettingsModel
    
    var body: some View {
        Form {
            Section("Menu Bar") {
                Toggle("Show in Menu Bar", isOn: $settings.showInMenuBar)
            }
        }
        .padding()
    }
}
