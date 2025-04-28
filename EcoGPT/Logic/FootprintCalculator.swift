//
//  FootprintCalculator.swift
//  EcoGPT
//
//  Created by Alessio Rubicini on 28/04/25.
//

import Foundation

/// Calculator class to estimate the carbon footprint of a ChatGPT prompt.
class FootprintCalculator: ObservableObject {

    // MARK: - Constants

    /// Energy consumption baseline per 1000 tokens for GPT-3, in kWh.
    private let baseEnergyConsumptionPerThousandTokens = 0.0002

    /// Average tokens per character.
    private let averageTokensPerCharacter = 0.25

    /// Assumed error margin (±20%).
    private let errorMarginPercent = 0.20

    // MARK: - Public Method

    /// Calculates the carbon footprint of a given prompt text, with an error range.
    ///
    /// - Parameters:
    ///   - prompt: The input text string.
    ///   - model: The GPT model used.
    ///   - emissionIntensity: The emission intensity setting (realistic or conservative).
    /// - Returns: FootprintEstimate struct containing central, lower, and upper bounds.
    func calculateFootprint(for prompt: String, model: GPTModel, emissionIntensity: EmissionIntensity) -> FootprintEstimate {
        // Step 1: Estimate number of tokens
        let estimatedTokens = estimateTokens(from: prompt)

        // Step 2: Estimate energy usage
        let energyUsedKWh = estimateEnergyUsage(tokens: estimatedTokens, model: model)

        // Step 3: Convert energy usage to CO₂ emissions
        let centralEmissions = energyUsedKWh * emissionIntensity.gramsCO2PerKWh

        // Step 4: Apply margin of error
        let lowerBound = centralEmissions * (1.0 - errorMarginPercent)
        let upperBound = centralEmissions * (1.0 + errorMarginPercent)

        return FootprintEstimate(
            centralValue: centralEmissions,
            lowerBound: lowerBound,
            upperBound: upperBound
        )
    }

    // MARK: - Private Helper Methods

    /// Estimates the number of tokens based on input text length.
    private func estimateTokens(from text: String) -> Int {
        let characterCount = text.count
        return Int(Double(characterCount) * averageTokensPerCharacter)
    }

    /// Estimates the energy usage based on tokens and model type.
    private func estimateEnergyUsage(tokens: Int, model: GPTModel) -> Double {
        let thousandsOfTokens = Double(tokens) / 1000.0
        let energyBaseline = baseEnergyConsumptionPerThousandTokens * thousandsOfTokens
        return energyBaseline * model.energyMultiplier
    }
    
    // MARK: - Equivalent Impact
    
    public func impactEquivalent(for emission: Double) -> String {
        switch emission {
        case ..<0.10:
            return "Sending a simple email"
        case 0.10..<0.20:
            return "Google search (1-2 queries)"
        case 0.20..<0.30:
            return "Sending an email with a small attachment"
        case 0.30..<0.50:
            return "Watching 1 minute of streaming video (SD)"
        case 0.50..<0.70:
            return "Watching 1 minute of streaming video (HD)"
        case 0.70..<1.00:
            return "Sending 1 minute of video via email"
        case 1.00..<2.00:
            return "Watching 10 minutes of streaming video (HD)"
        case 2.00..<5.00:
            return "Watching 1 hour of streaming video (HD)"
        default:
            return "Electricity for 1 hour of room lighting with an incandescent bulb"
        }
    }

}
