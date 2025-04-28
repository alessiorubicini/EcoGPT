//
//  SettingsView.swift
//  EcoGPT
//
//  Created by Alessio Rubicini on 28/04/25.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var settings = SettingsModel()
    
    var body: some View {
        TabView {
            GeneralSettingsView(settings: settings)
                .tabItem {
                    Label("General", systemImage: "gear")
                }
            
            AppearanceSettingsView(settings: settings)
                .tabItem {
                    Label("Appearance", systemImage: "paintbrush")
                }
            
            ExplanationSettingsView()
                .tabItem {
                    Label("About", systemImage: "info.circle")
                }
        }
        .frame(width: 700, height: 300)
    }
}



