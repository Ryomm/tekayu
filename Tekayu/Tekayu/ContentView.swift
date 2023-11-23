//
//  ContentView.swift
//  Tekayu
//

import SwiftUI
import AudioToolbox
import Haptics
import Vibrate

struct ContentView: View {
    @State var isValidSoft: Bool = false
    @State var isValidHard: Bool = false
    
    private var hapticController = HapticsController()
    private var vibrateController = VibrateController()
    
    
    
    var body: some View {
        VStack(spacing: 250) {
            Image("tekayu")
            HStack(spacing: 100) {
                Button(action: {
                    isValidSoft.toggle()
                    if isValidSoft {
                        hapticController.play()
                        
                    } else {
                        hapticController.stop()
                    }
                }) {
                    VStack{
                        if isValidSoft {
                            Image(systemName: "hand.raised.slash")
                                .imageScale(.large)
                                .foregroundColor(.accentColor)
                        } else {
                            Image(systemName: "hand.raised")
                                .imageScale(.large)
                                .foregroundColor(.accentColor)
                        }
                        Text("よわめ")
                    }
                }
                .disabled(isValidHard)
                Button(action: {
                    isValidHard.toggle()
                    if isValidHard {
                        vibrateController.play()
                        
                    } else {
                        vibrateController.stop()
                    }
                }) {
                    VStack{
                        if isValidHard {
                            Image(systemName: "hand.raised.slash")
                                .imageScale(.large)
                                .foregroundColor(.accentColor)
                        } else {
                            Image(systemName: "hand.raised")
                                .imageScale(.large)
                                .foregroundColor(.accentColor)
                        }
                        Text("つよめ")
                    }
                }
                .disabled(isValidSoft)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
