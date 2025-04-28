import SwiftUI

class SettingsModel: ObservableObject {
    
    //@AppStorage("selectedModel") var selectedModel: GPTModel = .gpt4
    //@AppStorage("selectedIntensity") var selectedIntensity: EmissionIntensity = .realistic
    @AppStorage("showInMenuBar") var showInMenuBar: Bool = true
    @AppStorage("autoUpdate") var autoUpdate: Bool = true
    @AppStorage("updateInterval") var updateInterval: Double = 5.0
    
}
