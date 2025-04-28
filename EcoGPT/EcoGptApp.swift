//
//  AIcologyApp.swift
//  AIcology
//
//  Created by Alessio Rubicini on 26/04/25.
//

import SwiftUI

@main
struct EcoGptApp: App {
    
    @StateObject private var monitor = AccessibilityMonitor()
    @StateObject private var calculator = FootprintCalculator()
    @State private var iconColor = Color.green
    @State private var co2Emissions = "0.0g"
    @State private var selectedModel: GPTModel = .gpt4
    @State private var selectedIntensity: EmissionIntensity = .realistic
    @State private var equivalentImpact = "Sending a simple email"
    
    var body: some Scene {
        MenuBarExtra {
            MenuView(
                monitor: monitor,
                calculator: calculator,
                iconColor: $iconColor,
                co2Emissions: $co2Emissions,
                selectedModel: $selectedModel,
                selectedIntensity: $selectedIntensity,
                equivalentImpact: $equivalentImpact
            )
        } label: {
            HStack(spacing: 4) {
                Image(systemName: "leaf.fill")
                    .foregroundColor(iconColor)
                Text("\(co2Emissions) CO2")
                    .font(.system(size: 11))
            }
        }
        .menuBarExtraStyle(.window)
        .onChange(of: monitor.lastCapturedText, { oldValue, newValue in
            if let text = newValue {
                updateImpact(for: text)
            }
        })
    }
    
    private func updateImpact(for text: String) {
        let estimate = calculator.calculateFootprint(
            for: text,
            model: selectedModel,
            emissionIntensity: selectedIntensity
        )
        
        // Update the CO2 display
        if estimate.representativeValue < 0.01 {
            let mg = estimate.representativeValue * 1000
            co2Emissions = String(format: "%.1fmg", mg)
        } else {
            co2Emissions = String(format: "%.2fg", estimate.representativeValue)
        }
        
        // Update icon color based on emissions
        if estimate.representativeValue < 0.1 {
            iconColor = .green
        } else if estimate.representativeValue < 0.5 {
            iconColor = .yellow
        } else {
            iconColor = .red
        }
        
        // Update equivalent impact
        equivalentImpact = calculator.impactEquivalent(for: estimate.representativeValue)
    }
}
