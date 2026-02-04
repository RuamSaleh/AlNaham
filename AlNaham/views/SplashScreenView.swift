//
//  SplashScreenView.swift
//  AlNaham
//
//  Created by ruam on 14/08/1447 AH.


import SwiftUI

struct SplashScreenView: View {
    @State private var cloudsIn = false
    @State private var seaIn = false
    @State private var shipIn = false
    @State private var buttonIn = false
    
    private let cloudWidth: CGFloat = 426
    private let seaSize = CGSize(width: 852, height: 393)
    private let topPadding: CGFloat = 59
    
    var body: some View {
        ZStack {
            // Clouds
            ZStack {
                Image("cloudL")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: cloudWidth)
                    .offset(x: cloudsIn ? -12 : 400)
                
                Image("cloudR")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: cloudWidth)
                    .offset(x: cloudsIn ? 12 : -400)
            }
            .padding(.top, topPadding)
            .onAppear {
                withAnimation(.easeOut(duration: 2)) {
                    cloudsIn = true
                }
            }
            // Sea
            Image("sea")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: seaSize.width, height: seaSize.height)
                .offset(y: seaIn ? 226 : 400)
                .onAppear {
                    withAnimation(.easeOut(duration: 0.5)) {
                        seaIn = true
                    }
                }
            // Ship
            Image("ship")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: cloudWidth)
                .offset(x: shipIn ? -120 : -900, y: 150)
                .onAppear {
                    withAnimation(.easeOut(duration: 2)) {
                        shipIn = true
                    }
                }
            // Button
            VStack {
                Spacer().frame(height: 400)
                Button("لنبحر") {
                    print("Tapped")
                }
                .frame(width: 146, height: 47)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white)
                .background(Color.onSurface)
                .cornerRadius(24)
                .opacity(buttonIn ? 1 : 0)
                .offset(y: buttonIn ? 0 : 20)
                Spacer()
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.easeOut(duration: 0.1)) {
                        buttonIn = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
