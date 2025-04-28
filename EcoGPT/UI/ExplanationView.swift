//
//  ExplanationView.swift
//  EcoGPT
//
//  Created by Alessio Rubicini on 28/04/25.
//

import SwiftUI

struct ExplanationView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("How We Estimate Your Carbon Footprint")
                    .font(.title2)
                    .bold()
                
                Spacer()
                
                Button {
                    isPresented = false
                } label: {
                    Image(systemName: "xmark.circle.fill")
                }

            }
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Footprint Estimation")
                    .font(.headline)
                
                Text("""
                EcoGPT estimates the carbon footprint of your ChatGPT prompts based on:
                
                • The number of tokens in your prompt
                • The AI model you're using (GPT-3.5 or GPT-4)
                • The energy consumption of data centers
                • The carbon intensity of the electricity grid
                
                Our calculations are based on published research and industry standards for AI model inference.
                """)
                .font(.body)
                
                Divider()
                
                Text("Emission Intensity")
                    .font(.headline)
                
                Text("""
                Emission intensity refers to how we account for the carbon intensity of the electricity grid:
                
                • Realistic: Uses average carbon intensity of global data centers
                • Conservative: Uses higher carbon intensity values to account for worst-case scenarios
                
                Choose 'Realistic' for everyday use, and 'Conservative' when you want to be extra cautious about your environmental impact.
                """)
                .font(.body)
            }
            
            Spacer()
        }
        .padding()
        .frame(width: 500, height: 400)
    }
}

#Preview {
    ExplanationView(isPresented: .constant(true))
} 
