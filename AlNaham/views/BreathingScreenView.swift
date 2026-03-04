//
//  BreathingScreenView.swift
//  AlNaham
//
//  Created by Nouf Alshawoosh on 04/02/2026.
//

import SwiftUI

struct BreathingScreenView: View {
    @Environment(\.presentationMode) var presentationMode

    var sessionDuration: Int = 360
    var dismissToRoot: (() -> Void)? = nil

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
    @State private var timeRemaining: Int = 360
    @State private var countdownTimer: Timer?
    @State private var showProgressBar: Bool = false
    @State private var progressHideTask: DispatchWorkItem?

    private var darkCloudDriftTime: Double {
        switch sessionDuration {
        case 180: return 130
        case 540: return 390
        default:  return 170
        }
    }
    private var lightCloudAppearTime: Double {
        switch sessionDuration {
        case 180: return 140
        case 540: return 400
        default:  return 180
        }
    }
    private var lightCloudDriftTime: Double {
        switch sessionDuration {
        case 180: return 165
        case 540: return 520
        default:  return 350
        }
    }
    private var darkWiggleDuration: Double {
        switch sessionDuration {
        case 180: return 1.0
        default:  return 1.5
        }
    }
    private var lightWiggleDuration: Double {
        switch sessionDuration {
        case 180: return 1.2
        default:  return 1.5
        }
    }

    var body: some View {
        ZStack {
            Color(.background)
                .ignoresSafeArea()

            ZStack {
                Image("sea")
                    .resizable()
                    .offset(x: moveSea ? 0.6 : -0.8, y: 160)
                    .animation(.easeInOut(duration: 0.6).repeatForever(autoreverses: true), value: moveSea)
            }

            Image("NahamOnlyOnBoat")
                .resizable()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .ignoresSafeArea()
                .offset(y: moveBoat ? 3 : 45)
                .animation(.easeInOut(duration: 5).repeatForever(autoreverses: true), value: moveBoat)
                .overlay {
                    if showLight {
                        Image("LightCloud")
                            .resizable()
                            .frame(width: 800, height: 800)
                            .offset(x: (wiggleDark ? 0 : -10), y: -200)
                            .opacity(opacityLight)
                        
                        Image("LightCloud")
                            .resizable()
                            .frame(width: 800, height: 800)
                            .offset(x: (wiggleDark ? -190 : -180), y: -200)
                            .opacity(opacityLight)
                        
                        Image("LightCloud")
                            .resizable()
                            .frame(width: 800, height: 800)
                            .offset(x: (wiggleDark ? 100 : 110), y: -200)
                            .opacity(opacityLight)
                    }
                    if showDark {
                        Image("DarkCloud2")
                            .offset(x: (wiggleDark ? 170 : 180), y: -200)
                            .opacity(opacityDark)
                        Image("DarkCloud1")
                            .offset(x: (wiggleDark ? -70 : -80), y: -190)
                            .opacity(opacityDark)
                    }
                }
                .onAppear {
                    timeRemaining = sessionDuration
                    startCountdown()

                    withAnimation(.easeIn(duration: 3)) {
                        moveBoat = true
                        moveSea = true
                    }
                    withAnimation(.easeIn(duration: 3)) { opacityDark = 1.0 }
                    withAnimation(.easeInOut(duration: darkWiggleDuration).repeatForever(autoreverses: true)) {
                        wiggleDark = true
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + darkCloudDriftTime) {
                        withAnimation(.easeOut(duration: 10)) {
                            driftDark = -1200
                            opacityDark = 0.0
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 10) { showDark = false }
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + lightCloudAppearTime) {
                        showLight = true
                        withAnimation(.easeIn(duration: 3)) { opacityLight = 1.0 }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            withAnimation(.easeInOut(duration: lightWiggleDuration).repeatForever(autoreverses: true)) {
                                wiggleLight = true
                            }
                        }
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + lightCloudDriftTime) {
                        withAnimation(.easeOut(duration: 10)) {
                            driftLight = -1200
                            opacityLight = 0.0
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 10) { showLight = false }
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + Double(sessionDuration)) {
                        showFinishedPopup = true
                    }
                }

            // Full-screen tap layer — reveals progress bar, doesn't block toolbar
            Color.clear
                .contentShape(Rectangle())
                .ignoresSafeArea()
                .onTapGesture { revealProgressBar() }

            // Progress bar — pinned to top, tap to reveal
            VStack(spacing: 6) {
                Text("\(Int(Double(sessionDuration - timeRemaining) / Double(sessionDuration) * 100))%")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(Color(red: 229/255, green: 224/255, blue: 213/255))

                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(Color(red: 229/255, green: 224/255, blue: 213/255).opacity(0.5))
                        .frame(width: UIScreen.main.bounds.width - 60, height: 12)
                    Capsule()
                        .fill(Color(red: 61/255, green: 107/255, blue: 82/255))
                        .frame(width: max(0, CGFloat(sessionDuration - timeRemaining) / CGFloat(sessionDuration)) * (UIScreen.main.bounds.width - 60), height: 12)
                        .animation(.linear(duration: 1), value: timeRemaining)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            .padding(.top, 70)
            .opacity(showProgressBar ? 1 : 0)
            .animation(.easeInOut(duration: 0.4), value: showProgressBar)

            if showFinishedPopup {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                    .onTapGesture { showFinishedPopup = false }
                FinishedBreathingPopup(isPresented: $showFinishedPopup)
                    .transition(.scale.combined(with: .opacity))
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    countdownTimer?.invalidate()
                    SoundManager.shared.crossfade(to: "ES_Calm Waves Lapping Against Rocks, Sea, Seagulls In Background, Foam Details - Epidemic Sound", duration: 3)
                    if let dismissToRoot = dismissToRoot {
                        // Pop BreathingScreenView, then callback pops GuideView
                        presentationMode.wrappedValue.dismiss()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                            dismissToRoot()
                        }
                    } else {
                        presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.primaryText)
                        .fontWeight(.semibold)
                }
            }
        }
        .onAppear {
            SoundManager.shared.stopAll()
            SoundManager.shared.playLoop(named: "سفينة السكينه", volume: 1)
        }
        .onDisappear {
            countdownTimer?.invalidate()
            SoundManager.shared.crossfade(to: "ES_Calm Waves Lapping Against Rocks, Sea, Seagulls In Background, Foam Details - Epidemic Sound", duration: 3)
        }
    }

    private func startCountdown() {
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if timeRemaining > 0 { timeRemaining -= 1 }
            else { countdownTimer?.invalidate() }
        }
    }

    private func revealProgressBar() {
        progressHideTask?.cancel()
        withAnimation { showProgressBar = true }
        let task = DispatchWorkItem {
            withAnimation { showProgressBar = false }
        }
        progressHideTask = task
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: task)
    }
}

// MARK: - Finished Popup

struct FinishedBreathingPopup: View {
    @Binding var isPresented: Bool
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 34, style: .continuous)
                .fill(Color.surface)
                .padding(.horizontal, 20)

            VStack {
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

                Text("أتممت رحلتك بنجاح!\nهذا الإيقاع المنضبط حفّز العصب الحائر لديك، مما خفض استجابة جسدك للتوتر وأعاد توازن مؤشراتك الحيوية بشكل فسيولوجي.")
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
                        .background(Capsule().fill(Color.darkGreen))
                }
                .simultaneousGesture(TapGesture().onEnded {
                    isPresented = false
                    SoundManager.shared.crossfade(to: "ES_Calm Waves Lapping Against Rocks, Sea, Seagulls In Background, Foam Details - Epidemic Sound", duration: 2)
                })
                .padding(.bottom, 22)
            }
        }
        .frame(width: 357, height: 354)
    }
}

// MARK: - GuideView

struct GuideView: View {
    var sessionDuration: Int = 360
    var dismissToRoot: (() -> Void)? = nil

    @Environment(\.presentationMode) var presentationMode
    @State private var currentPage = 0
    @State private var nextPage: Int? = nil
    @State private var nextOpacity = 0.0
    @State private var isTransitioning = false
    @State private var navigateToBreathing = false

    private let totalPages = 5

    var body: some View {
        ZStack {
            Image("Guide\(currentPage + 1)")
                .resizable()
                .ignoresSafeArea()

            if let next = nextPage {
                Image("Guide\(next + 1)")
                    .resizable()
                    .ignoresSafeArea()
                    .opacity(nextOpacity)
            }

            switch currentPage {
            case 0:
                Text("")
                    .guideTextStyle()
                    .position(x: UIScreen.main.bounds.width / 2, y: 200)
            case 1:
                Text("اجعل حركة القارب دليلاً لأنفاسك")
                    .guideTextStyle()
                    .position(x: UIScreen.main.bounds.width / 2, y: 170)
                
                Text("خذ شهيقاً مع صعوده")
                    .guideTextStyle()
                    .position(x: UIScreen.main.bounds.width / 2, y: 320)
                
            case 2:
                Text("اجعل حركة القارب دليلاً لأنفاسك")
                    .guideTextStyle()
                    .position(x: UIScreen.main.bounds.width / 2, y: 170)
                
                Text("وزفيراً مع هدوئه")
                    .guideTextStyle()
                    .position(x: UIScreen.main.bounds.width / 2, y: 320)
            case 3:
                Text("إذا أردت المغادرة، يمكنك إنهاء الجلسة في أي وقت عبر زر العودة في الأعلى.")
                    .guideTextStyle()
                    .frame(width: 300)
                    .position(x: UIScreen.main.bounds.width / 2, y: 170)
            case 4:
                Text("اضغط الشاشة لرؤية مدى تقدمك في الرحلة")
                    .guideTextStyle()
                    .position(x: UIScreen.main.bounds.width / 2, y: 170)
            default:
                EmptyView()
            }

            Color.clear
                .contentShape(Rectangle())
                .ignoresSafeArea()
                .onTapGesture {
                    guard currentPage >= 1, !isTransitioning else { return }
                    advancePage()
                }

            NavigationLink(destination: BreathingScreenView(
                sessionDuration: sessionDuration,
                dismissToRoot: {
                    presentationMode.wrappedValue.dismiss()
                }
            ), isActive: $navigateToBreathing) {
                EmptyView()
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear { startAutoAdvanceIfNeeded() }
    }

    private func advancePage() {
        guard currentPage < totalPages - 1 else {
            navigateToBreathing = true
            return
        }
        isTransitioning = true
        let next = currentPage + 1
        nextPage = next
        nextOpacity = 0.0
        withAnimation(.easeInOut(duration: 0.4)) { nextOpacity = 1.0 }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            currentPage = next
            nextPage = nil
            nextOpacity = 0.0
            isTransitioning = false
        }
    }

    private func startAutoAdvanceIfNeeded() {
        if currentPage == 0 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { advancePage() }
        }
    }
}

// MARK: - Text Style
private extension Text {
    func guideTextStyle() -> some View {
        self
            .font(.custom("Inter-VariableFont_opsz,wght.ttf", size: 22))
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .shadow(color: .black.opacity(0.4), radius: 4, x: 0, y: 2)
    }
}


#Preview {
    NavigationStack {
        GuideView()
    }
}
