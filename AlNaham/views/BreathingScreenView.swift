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
    @State var showFinishedPopup = false
    
    var body: some View {
        NavigationStack {
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
                        // start boat and sea animations
                        withAnimation(.easeIn(duration: 3)) {
                            moveBoat = true
                            moveSea = true
                        }
                        
                        // Dark Clouds -----------------------
                        withAnimation(.easeIn(duration: 3)) {
                            opacityDark = 1.0
                        }
                        
                        withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                            wiggleDark = true
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 170) {
                            withAnimation(.easeOut(duration: 10)) {
                                driftDark = -1200
                                opacityDark = 0.0
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                                showDark = false
                            }
                        }
                        
                        // Light Clouds -----------------------
                        DispatchQueue.main.asyncAfter(deadline: .now() + 180) {
                            showLight = true
                            withAnimation(.easeIn(duration: 3)) {
                                opacityLight = 1.0
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                                    wiggleLight = true
                                }
                            }
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 350) {
                            withAnimation(.easeOut(duration: 10)) {
                                driftLight = -1200
                                opacityLight = 0.0
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                                showLight = false
                            }
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 360) {
                            showFinishedPopup = true
                        }
                    }
                
                if showFinishedPopup {
                    Color.black.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            showFinishedPopup = false
                        }
                    
                    FinishedBreathingPopup(isPresented: $showFinishedPopup)
                        .transition(.scale.combined(with: .opacity))
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct FinishedBreathingPopup: View {
    @Binding var isPresented: Bool
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 34, style: .continuous)
                .fill(Color.surface)
                .padding(.horizontal, 20)
            
            VStack{
                HStack {
                    Spacer()
                    Button {
                        isPresented = false
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.primaryText)
                            .frame(width: 28, height: 28)
                    }
                }
                .padding(.horizontal, 34)
                .padding(.top, 12)
                
                Spacer().frame(height: 3)
                
                Text("مرسى الأمان!")
                    .font(.custom("Aref Ruqaa", size: 24))
                    .fontWeight(.semibold)
                    .foregroundColor(.primaryText)
                Spacer().frame(height: 24)
                
                Text("أتممت ٣٦ نفساً بنجاح!\nهذا الإيقاع المنضبط حفّز العصب الحائر لديك، مما خفض استجابة جسدك للتوتر وأعاد توازن مؤشراتك الحيوية بشكل فسيولوجي.")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.primaryText)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 27)
                Spacer().frame(height: 18)
                
                NavigationLink {
                    StartJourney()
                } label: {
                    Text("العودة للمرفأ")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 275, height: 48)
                        .background(
                            Capsule().fill(Color.darkGreen)
                        )
                }
                .simultaneousGesture(TapGesture().onEnded {
                    isPresented = false
                })
                .padding(.bottom, 22)
            }
        }
        .frame(width: 357, height: 354)
    }
}



#Preview {
    BreathingScreenView()
}
