//
//  EmissionIntensity.swift
//  AIcology
//
//  Created by Alessio Rubicini on 28/04/25.
//

import Foundation

/// Enum representing grid emission intensity.
enum EmissionIntensity {
    
    case realistic  // Assumes greener energy mix
    case conservative // Assumes dirtier energy mix

    /// Emission factor in grams of CO₂ per kilowatt-hour (gCO₂/kWh)
    var gramsCO2PerKWh: Double {
        switch self {
        case .realistic:
            return 200.0  // Example: renewables-heavy data center
        case .conservative:
            return 400.0  // Example: world average fossil-heavy
        }
    }
}
