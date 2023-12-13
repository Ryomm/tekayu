//
//  TekayuViewModel.swift
//  Tekayu
//

import Foundation
import CoreHaptics
import AudioToolbox
import Combine

protocol TekayuViewModel {
    func playHaptics()
    func stopHaptics()
    func playAudioVibrate()
    func stopAudioVibrate()
}

final class TekayuViewModelImpl: TekayuViewModel {
    
    private var engine: CHHapticEngine!
    private var supportsHaptics: Bool = false
    
    // Haptic pattern player
    private var player: CHHapticAdvancedPatternPlayer?
    
    // Haptic event parameter
    private let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
    private let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
    
    // Propery for Audio Vibrate
    private let sound = SystemSoundID(kSystemSoundID_Vibrate)
    
    init() {
        // Check the device to support Haptics
        self.supportsHaptics = CHHapticEngine.capabilitiesForHardware().supportsHaptics
        
        // Create Haptics Engine
        guard self.supportsHaptics else {
            print("Error: This device does not support CoreHaptics")
            return
        }

        do {
            self.engine = try CHHapticEngine()
            try self.engine.start()
        } catch {
            print("Error \(error)")
        }
    }
    
    /// Start to play haptics
    public func playHaptics() {
        guard supportsHaptics else { return }
        print("playHaptics")
        
        do {
            try engine.start()
            
            let pattern = try createHapticsPattern()
            
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
    public func stopHaptics() {
        guard supportsHaptics else { return }
        print("stopHaptics")
        engine.stop()
    }
    
    /// Create haptics pattern
    private func createHapticsPattern() throws -> CHHapticPattern {
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
    
    /// Start to play vibrate of AudioServices
    public func playAudioVibrate() {
        print("playAudioVibrate")
        // set callback method
        AudioServicesAddSystemSoundCompletion(sound, nil, nil, { (sound, nil) -> Void in
            AudioServicesPlaySystemSound(sound)
        }, nil)
        
        AudioServicesPlaySystemSound(SystemSoundID(sound))
    }
    
    /// Stop to play vibrate of AudioServices
    public func stopAudioVibrate() {
        print("stopAudioVibrate")
        print()
        AudioServicesRemoveSystemSoundCompletion(sound)
    }
}
