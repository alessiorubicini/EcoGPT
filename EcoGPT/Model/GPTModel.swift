//
//  ModelType.swift
//  EcoGPT
//
//  Created by Alessio Rubicini on 28/04/25.
//

import Foundation

/// Enum representing the GPT model type.
enum GPTModel: Identifiable, CaseIterable {
    case gpt3
    case gpt35Turbo
    case gpt4
    case gpt4Turbo
    case gpt4o
    case gpt4oMini

    var id: String { String(describing: self) }
    
    var displayName: String {
        switch self {
        case .gpt3:
            return "GPT-3"
        case .gpt35Turbo:
            return "GPT-3.5 Turbo"
        case .gpt4:
            return "GPT-4"
        case .gpt4Turbo:
            return "GPT-4 Turbo"
        case .gpt4o:
            return "GPT-4o"
        case .gpt4oMini:
            return "GPT-4o Mini"
        }
    }
    
    /// Estimated energy consumption multiplier relative to GPT-3 baseline.
    var energyMultiplier: Double {
        switch self {
        case .gpt3:
            return 1.0    // Baseline
        case .gpt35Turbo:
            return 0.7    // More efficient
        case .gpt4:
            return 4.0    // Heavier
        case .gpt4Turbo:
            return 1.5    // Lighter than GPT-4
        case .gpt4o:
            return 0.75   // More efficient than GPT-4 Turbo
        case .gpt4oMini:
            return 0.3    // Significantly more efficient
        }
    }
}
