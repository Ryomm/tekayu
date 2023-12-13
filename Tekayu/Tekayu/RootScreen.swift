//
//  ContentView.swift
//  Tekayu
//

import SwiftUI

struct RootScreen: View {
    @State var isValidHaptics: Bool = false
    @State var isValidAudioVibrate: Bool = false
    
    private var viewModel = TekayuViewModelImpl()
    
    var body: some View {
        VStack(spacing: 100) {
            if isValidAudioVibrate {
                Image("tekayu")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else if isValidHaptics {
                Image("tekayunaikamo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Image("tekayunai")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            HStack(spacing: 100) {
                Button(action: {
                    if isValidAudioVibrate {
                        isValidAudioVibrate = false
                        viewModel.stopAudioVibrate()
                    }
                    
                    isValidHaptics.toggle()
                    if isValidHaptics {
                        viewModel.playHaptics()
                    } else {
                        viewModel.stopHaptics()
                    }
                }) {
                    VStack{
                        if isValidHaptics {
                            Image(systemName: "hand.raised")
                                .imageScale(.large)
                        } else {
                            Image(systemName: "hand.raised.slash")
                                .imageScale(.large)
                        }
                        Text("よわめ")
                    }
                    .foregroundStyle(isValidHaptics ? Color.accentColor : Color.gray)
                }

                Button(action: {
                    if isValidHaptics {
                        isValidHaptics = false
                        viewModel.stopHaptics()
                    }
                    
                    isValidAudioVibrate.toggle()
                    if isValidAudioVibrate {
                        viewModel.playAudioVibrate()
                    } else {
                        viewModel.stopAudioVibrate()
                    }
                }) {
                    VStack{
                        if isValidAudioVibrate {
                            Image(systemName: "hand.raised")
                                .imageScale(.large)
                        } else {
                            Image(systemName: "hand.raised.slash")
                                .imageScale(.large)
                        }
                        Text("つよめ")
                    }
                    .foregroundStyle(isValidAudioVibrate ? Color.accentColor : Color.gray)
                }
            }
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        RootScreen()
    }
}
#endif
