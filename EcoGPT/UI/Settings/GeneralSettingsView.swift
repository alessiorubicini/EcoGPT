//
//  GeneralSettingsView.swift
//  EcoGPT
//
//  Created by Alessio Rubicini on 28/04/25.
//

import Foundation
import SwiftUI

struct GeneralSettingsView: View {
    
    @ObservedObject var settings: SettingsModel
    
    var body: some View {
        Form {
            Section("AI Model") {
                /*Picker("Default Model", selection: $settings.selectedModel) {
                    ForEach(GPTModel.allCases, id: \.self) { model in
                        Text(model.rawValue).tag(model)
                    }
                }
                
                Picker("Emission Intensity", selection: $settings.selectedIntensity) {
                    ForEach(EmissionIntensity.allCases, id: \.self) { intensity in
                        Text(intensity.rawValue).tag(intensity)
                    }
                }*/
            }
            
            Section("Updates") {
                Toggle("Auto Update", isOn: $settings.autoUpdate)
                if settings.autoUpdate {
                    HStack {
                        Text("Update Interval")
                        Slider(value: $settings.updateInterval, in: 1...60, step: 1)
                        Text("\(Int(settings.updateInterval))s")
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .padding()
    }
}
