//
//  HapticController.swift
//  Tekayu
//

import Foundation
import CoreHaptics

class HapticsController {
    private var engine: CHHapticEngine!
    
    private var supportsHaptics: Bool = false
    
    // Haptic pattern player
    private var player: CHHapticAdvancedPatternPlayer?
    
    // Haptic event parameter
    let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
    let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
    
    init() {
        // Check the device to support Haptics
        supportsHaptics = CHHapticEngine.capabilitiesForHardware().supportsHaptics
        
        // Create Haptics Engine
        guard supportsHaptics else {
            print("Error: This device does not support CoreHaptics")
            return
        }
        do {
            engine = try CHHapticEngine()
            try engine.start()
        } catch {
            print("Error \(error)")
        }
    }
    
    /// Start to play haptics
    public func play() {
        guard supportsHaptics else { return }
        
        do {
            try engine.start()
            
            let pattern = try createPattern()
            
            // create Haptics player
            player = try engine.makeAdvancedPlayer(with: pattern)
            player?.loopEnabled = true
            
            // 再生
            try player!.start(atTime: CHHapticTimeImmediate)
            
        } catch let error {
            print("Haptic Playback Error: \(error)")
        }
    }
    
    /// Stop to play haptics
    public func stop(){
        guard supportsHaptics else { return }
        
        engine.stop()
    }
    
    // HapticPatternの作成
    private func createPattern() throws -> CHHapticPattern {
        do {
            var eventList: [CHHapticEvent] = []
            
            eventList.append(CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0))
            
            // Create Haptics Pattern
            let pattern = try CHHapticPattern(events: eventList, parameters: [])
            
            return pattern
        } catch let error {
            throw error
        }
    }
}
