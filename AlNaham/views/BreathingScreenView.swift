//
//  BreathingScreenView.swift
//  AlNaham
//
//  Created by Nouf Alshawoosh on 04/02/2026.
//

import SwiftUI

struct BreathingScreenView: View {
    @State var move = false
    var body: some View {
        ZStack {
            Color("Background")
                .ignoresSafeArea()
            
            
            Image("NahamOnBoat")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()

                .overlay{
                    
                    Image("DarkClouds1")
                        .border(.red)
                        .offset(x: move ? 8 : 0, y: -102)
                        .animation(.easeInOut(duration: 1).repeatForever(autoreverses: true), value: move)
                        .onAppear(){
                            move = true
                        }
                    
                }
            
            
        } // end of ZStack
        
    }
}



#Preview {
    BreathingScreenView()
}
