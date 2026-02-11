//
//  ContentView.swift
//  AlNaham
//
//  Created by ruam on 10/08/1447 AH.
//

//import SwiftUI
//import AudioToolbox
//
//struct ContentView: View {
//    @State private var isMusicOn = false
//
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("play sound ")
//                .font(.headline)
//            Button(action: {
//                SoundManager.shared.playImportedSound(named: "LoadingScreenSound")
//            }){
//                Text("Play")
//            }
//            Toggle("BGM", isOn: $isMusicOn)
//                .onChange(of: isMusicOn) {
//                    newValue in
//                    SoundManager.shared.toggleBackgroundMusic(isOn: newValue)
//                }
//        }
//        .padding()
//    }
//}
//
//#Preview {
//    ContentView()
//}
import SwiftUI

struct ContentView: View {

    @AppStorage("isLoadingSoundOn") private var isLoadingSoundOn: Bool = true

    var body: some View {
        VStack(spacing: 20) {

            Text("Loading Sound")
                .font(.headline)

            Toggle("Sound", isOn: $isLoadingSoundOn)
                .onChange(of: isLoadingSoundOn) { newValue in
                    if newValue {
                        SoundManager.shared.resumeImportedSound()
                    } else {
                        SoundManager.shared.pauseImportedSound()
                    }
                }
        }
        .padding()
        .onAppear {
            SoundManager.shared.playImportedSound(
                named: "LoadingScreenSound"
            )
        }
    }
    
    // MARK: - Button
//    VStack {
//        Spacer().frame(height: 400)
//
//        Button("لنبحر") {
//            SoundManager.shared.stopImportedSound()
//            print("Tapped")
//        }
//        .frame(width: 146, height: 47)
//        .font(.system(size: 18, weight: .medium))
//        .foregroundColor(.white)
//        .background(Color.onSurface)
//        .cornerRadius(24)
//        .opacity(buttonIn ? 1 : 0)
//        .offset(y: buttonIn ? 0 : 20)
//
//        Spacer()
//    }
//    .onAppear {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            withAnimation(.easeOut(duration: 0.1)) {
//                buttonIn = true
//            }
//        }
//    }
//}
//// MARK: - Sound starts here
//.onAppear {
//    SoundManager.shared.playImportedSound(
//        named: "LoadingScreenSound"
//    )
//}
}
//
//#Preview {
//    ContentView()
//}
