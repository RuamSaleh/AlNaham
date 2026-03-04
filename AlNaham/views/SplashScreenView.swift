//
//  SplashScreenView.swift
//  AlNaham
//
//  Created by ruam on 14/08/1447 AH.

import SwiftUI
import AudioToolbox

struct SplashScreenView: View {
    @State private var cloudsIn = false
    @State private var seaIn = false
    @State private var shipIn = false
    @State private var buttonIn = false

    var body: some View {
        GeometryReader { geo in
            let screenWidth = geo.size.width
            let screenHeight = geo.size.height
            ZStack {
                Color.background.ignoresSafeArea()
                ZStack {
                    Image("cloudL")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: screenWidth * 1.1)
                        .offset(x: cloudsIn ? -screenWidth * 0.0 : screenWidth)
                    Image("cloudR")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: screenWidth * 1.1)
                        .offset(x: cloudsIn ? screenWidth * 0.0 : -screenWidth)
                }
                Image("sea")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: screenWidth, height: screenHeight * 0.5)
                    .offset(y: seaIn ? screenHeight * 0.2 : screenHeight)
                Image("ship")
                    .resizable()
                    .scaledToFit()
                    .frame(width: screenWidth * 1)
                    .offset(x: shipIn ? -screenWidth * 0.3 : -screenWidth, y: screenHeight * 0.15)
                VStack {
                    Spacer()
                    NavigationLink {
                        StartJourney()
                    } label: {
                        Text(LocalizedStringKey("لنبحر"))
                            .frame(width: 146, height: 47)
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.white)
                            .background(Color.darkGreen)
                            .cornerRadius(24)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        SoundManager.shared.crossfade(
                            to: "ES_Calm Waves Lapping Against Rocks, Sea, Seagulls In Background, Foam Details - Epidemic Sound",
                            duration: 3
                        )
                    })
                    .opacity(buttonIn ? 1 : 0)
                    .offset(x: -20, y: buttonIn ? -screenHeight * 0.18 : 20)
                    Spacer()
                }
                
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.easeOut(duration: 1)) {
                        cloudsIn = true
                    }
                    withAnimation(.easeOut(duration: 1.5)) {
                        seaIn = true
                    }
                    withAnimation(.easeOut(duration: 2)) {
                        shipIn = true
                    }
                    withAnimation(.easeIn(duration: 2)) {
                        buttonIn = true
                    }
                    SoundManager.shared.playLoop(named: "LoadingScreenSound", volume: 1)
                }}
            
        }.environment(\.layoutDirection, .leftToRight)
        
    }
}

#Preview {
    NavigationStack {
        SplashScreenView()
    }
}
