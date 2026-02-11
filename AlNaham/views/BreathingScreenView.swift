//
//  BreathingScreenView.swift
//  AlNaham
//
//  Created by Nouf Alshawoosh on 04/02/2026.
//

import SwiftUI

struct BreathingScreenView: View {
    @State var wiggleDark = false
    @State var driftDark: CGFloat = -670
    @State var wiggleLight = false
    @State var driftLight: CGFloat = -142.5
    @State var showDark = true
    @State var showLight = false
    @State var opacityDark = 0.0
    @State var opacityLight = 0.0
    @State var moveBoat = false
    
    @State var moveSea = false
    
    var body: some View {
        ZStack {
            Color(.background).ignoresSafeArea()
            
            ZStack {
                Image("sea")
                    .resizable()
                    .offset(x: moveSea ? 0.6 : -0.8 , y: 160)
                    .animation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true), value: moveSea)
            }
            
            
            Image("NahamOnlyOnBoat")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .offset(y: moveBoat ? 10 : 30)
                .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: moveBoat)
                .overlay {
                    if showLight {
                        Image("LightClouds")
                            .resizable()
                            .frame(width: 800, height: 800)
                            .offset(x: driftLight + (wiggleLight ? 20 : 30), y: -100)
                            .opacity(opacityLight)
                    }
                    
                    if showDark {
                        Image("DarkClouds1")
                            .offset(x: driftDark + (wiggleDark ? 20 : 30), y: -105)
                            .opacity(opacityDark)
                        
                        Image("DarkClouds1")
                            .offset(x: -driftDark + (wiggleDark ? 30 : 20), y: 90)
                            .opacity(opacityDark)
                    }
                }
                .onAppear {
                    
                    withAnimation(.easeIn(duration: 2)) {
                        opacityDark = 1.0
                        moveBoat = true
                        moveSea = true
                    }
                    
                    withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                        wiggleDark = true
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5){
                        showLight = true
                        withAnimation(.easeIn(duration: 2)) {
                            opacityLight = 1.0
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                                wiggleLight = true
                            }
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                        withAnimation(.easeOut(duration: 4)) {
                            driftDark = -1200
                            opacityDark = 0.0
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                            showDark = false
                        }
                    }
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 15) {
                        withAnimation(.easeOut(duration: 2)) {
                            opacityLight = 0.0
                        }
                    }
                    
                } // end of onAppear
        } // end of ZStack
    }
}


#Preview {
    BreathingScreenView()
}
