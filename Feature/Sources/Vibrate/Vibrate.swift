//
//  Vibrate.swift
//  Tekayu
//

import Foundation
import AudioToolbox

class VibrateController {
    private let sound = SystemSoundID(kSystemSoundID_Vibrate)
    
    public func play() {
        // set callback method
        AudioServicesAddSystemSoundCompletion(sound, nil, nil, { (sound, nil) -> Void in
            AudioServicesPlaySystemSound(sound)
        }, nil)
        
        AudioServicesPlaySystemSound(SystemSoundID(sound))
    }
    
    public func stop() {
        AudioServicesRemoveSystemSoundCompletion(sound)
    }
}
