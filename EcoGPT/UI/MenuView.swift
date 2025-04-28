//
//  MenuView.swift
//  EcoGPT
//
//  Created by Alessio Rubicini on 28/04/25.
//

import SwiftUI

struct MenuView: View {
    
    @ObservedObject var monitor: AccessibilityMonitor
    @ObservedObject var calculator: FootprintCalculator
    
    @State private var iconColor: Color = .green
    @Binding var co2Emissions: String
    @Binding var selectedModel: GPTModel
    @Binding var selectedIntensity: EmissionIntensity
    @Binding var equivalentImpact: String
    
    @State private var lowerBound: String = "0.0g"
    @State private var upperBound: String = "0.0g"
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Status indicator
            HStack {
                Text("Estimated Impact")
                    //.font(.headline)
                
                Spacer()
                
                Text("\(co2Emissions) CO2")
                    .font(.headline)
                
                Circle()
                    .fill(iconColor)
                    .frame(width: 20, height: 20)
            }
            
            // Uncertainty interval
            HStack {
                Text("Range:")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Text("\(lowerBound) - \(upperBound)")
                    .font(.subheadline)
            }
            
            // Equivalent impact
            Text("Equivalent to: \(equivalentImpact)")
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            Divider()
            
            // Model selection
            Picker("Model", selection: $selectedModel) {
                ForEach(GPTModel.allCases) { model in
                    Text(model.displayName).tag(model)
                }
            }
            .pickerStyle(.menu)
            .onChange(of: selectedModel) { _, _ in
                if let text = monitor.lastCapturedText {
                    updateImpact(for: text)
                }
            }
            
            // Intensity selection
            Picker("Emission Intensity", selection: $selectedIntensity) {
                Text("Realistic").tag(EmissionIntensity.realistic)
                Text("Conservative").tag(EmissionIntensity.conservative)
            }
            .pickerStyle(.menu)
            .onChange(of: selectedIntensity) { _, _ in
                if let text = monitor.lastCapturedText {
                    updateImpact(for: text)
                }
            }
            
            Divider()
            
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            .buttonStyle(.automatic)
            .padding(.vertical, 5)
        }
        .padding()
        .onChange(of: monitor.lastCapturedText) { _, newText in
            if let text = newText {
                updateImpact(for: text)
            }
        }
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
            lowerBound = String(format: "%.1fmg", estimate.lowerBound * 1000)
            upperBound = String(format: "%.1fmg", estimate.upperBound * 1000)
        } else {
            co2Emissions = String(format: "%.2fg", estimate.representativeValue)
            lowerBound = String(format: "%.2fg", estimate.lowerBound)
            upperBound = String(format: "%.2fg", estimate.upperBound)
        }
        
        // Update icon color based on emissions
        if estimate.representativeValue < 0.1 {
            iconColor = .green
        } else if estimate.representativeValue < 0.5 {
            iconColor = .yellow
        } else {
            iconColor = .red
        }
    }
}

#Preview {
    MenuView(
        monitor: AccessibilityMonitor(),
        calculator: FootprintCalculator(),
        co2Emissions: .constant("0.0g"),
        selectedModel: .constant(.gpt4),
        selectedIntensity: .constant(.realistic),
        equivalentImpact: .constant("Sending a simple email")
    )
}

