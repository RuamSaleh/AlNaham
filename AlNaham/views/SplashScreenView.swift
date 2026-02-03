//
//  SplashScreenView.swift
//  AlNaham
//
//  Created by ruam on 14/08/1447 AH.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var animateSea = false
    @State private var cloudsIn = false
    @State private var shipIn = false
    
    var body: some View {
        ZStack {
            ZStack {
                Image("cloudL")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 426)
                    .offset(x: cloudsIn ? -12 : 400)
                
                Image("cloudR")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 426)
                    .offset(x: cloudsIn ? 12 : -400)
            }
            .padding(.top, 59)
            .onAppear {
                withAnimation(.easeOut(duration: 1)) {
                    cloudsIn = true
                }
            }
       
            ZStack {
                Image("sea")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 852, height: 393)
                    .offset(y: animateSea ? 226 : 400)             }
            
            .onAppear {
                withAnimation(.easeOut(duration: 1)) {
                    animateSea = true
                }
            }
            
            Image("ship")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 426)
                .offset(x: shipIn ? -120 : -900, y: 150)
                .onAppear {
                    withAnimation(.easeOut(duration: 1)) {
                        shipIn = true
                    }
                }
        }
    }
    
    struct SplashScreenView_Previews: PreviewProvider {
        static var previews: some View {
            SplashScreenView()
        }
    }
}
