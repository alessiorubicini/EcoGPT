//
//  FootprintEstimate.swift
//  EcoGPT
//
//  Created by Alessio Rubicini on 28/04/25.
//

import Foundation

struct FootprintEstimate {
    let centralValue: Double   // Estimated CO₂ emissions (grams)
    let lowerBound: Double     // Minimum estimated value
    let upperBound: Double     // Maximum estimated value
    
    /// A single representative value for easier usage (defaults to the central estimate).
    var representativeValue: Double {
        return centralValue
    }
}
