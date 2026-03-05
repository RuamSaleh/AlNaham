//  Home.swift
//  AlNaham
//
//  Created by Ghadeer Fallatah on 15/08/1447 AH.
//
import SwiftUI

// MARK: - Duration Enum
enum Duration: String, CaseIterable, Identifiable {
    case three = "3"
    case six   = "6"
    case nine  = "9"

    var id: String { rawValue }

    var displayText: String {
        switch self {
        case .three: return "٣"
        case .six:   return "٦"
        case .nine:  return "٩"
        }
    }

    var seconds: Int {
        switch self {
        case .three: return 180
        case .six:   return 360
        case .nine:  return 540
        }
    }
}

// MARK: - StartJourney

struct StartJourney: View {

    @Environment(\.presentationMode) var presentationMode

    @State private var ShowBreathingPopup = false
    @State private var ShowSingingPopup = false

    var body: some View {

        GeometryReader { geo in

            let screenWidth = geo.size.width
            let screenHeight = geo.size.height

            ZStack {

                Color.background.ignoresSafeArea()

                // SEA
                Image("sea")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: screenWidth,
                           height: screenHeight * 0.5)
                    .offset(y: screenHeight * 0.20)
                    .allowsHitTesting(false)

                // CLOUD LEFT
                Image("cloudL")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: screenWidth * 1.1)
                    .offset(y: screenHeight * 0.05)
                    .allowsHitTesting(false)

                // CLOUD RIGHT
                Image("cloudR")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: screenWidth * 1.1)
                    .offset(y: screenHeight * 0.05)
                    .allowsHitTesting(false)

                // TITLE
                Text(LocalizedStringKey("اختر سفينتك للرحلة"))
                    .font(Font.custom("Aref Ruqaa", size: 34))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundStyle(Color.primaryText)
                    .frame(width: screenWidth * 0.90)
                    .offset(
                            x: -screenWidth * 0.05,
                            y: -screenHeight * 0.29
                    )
                    .minimumScaleFactor(0.7)

                // MARK: - Singing Ship

                ZStack {

                    VStack {

                        Image(systemName: "water.waves")
                            .foregroundStyle(Color.secondText)

                        Text(LocalizedStringKey("سَفينة النهمة"))
                            .font(.custom("Aref Ruqaa", size: 16))
                            .foregroundColor(.secondText)
                            .fontWeight(.bold)

                    }
                    .offset(x: screenWidth * 0.29,
                            y: screenHeight * -0.11)

                    Image("ship")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth * 0.9)
                        .offset(
                            x: -screenWidth * 0.48,
                            y: screenHeight * 0.13
                        )
                        .onTapGesture {

                            ShowSingingPopup = false
                            ShowBreathingPopup = true
                        }
                }

                // PATH

                Image("path")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: screenWidth * 0.79)
                    .offset(y: screenHeight * 0.0)
                    .allowsHitTesting(false)

                // MARK: - Breathing Ship

                ZStack {

                    VStack {

                        Image(systemName: "lungs")
                            .foregroundStyle(Color.secondText)

                        Text(LocalizedStringKey("سَفينة السكينة"))
                            .font(.custom("Aref Ruqaa", size: 16))
                            .fontWeight(.bold)
                            .foregroundColor(.secondText)

                    }
                    .offset(x: -screenWidth * 0.38,
                            y: screenHeight * -0.12)

                    Image("Ship3")
                        .resizable()
                        .scaledToFit()
                        .frame(width: screenWidth * 0.9)
                        .offset(
                            x: screenWidth * 0.52,
                            y: screenHeight * 0.12
                        )
                        .onTapGesture {

                            ShowBreathingPopup = false
                        }
                }

                // MARK: - Popup Background

                if ShowBreathingPopup || ShowSingingPopup {

                    Color.black.opacity(0.25)
                        .ignoresSafeArea()
                        .onTapGesture {

                            ShowBreathingPopup = false
                            ShowSingingPopup = false
                        }

                    if ShowBreathingPopup {

                        BreathingPopup(
                            isPresented: $ShowBreathingPopup,
                            dismissParent: {
                                presentationMode.wrappedValue.dismiss()
                            },
                            screenWidth: screenWidth,
                            screenHeight: screenHeight
                        )
                        .transition(.scale)
                        .zIndex(1)
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .environment(\.layoutDirection, .leftToRight)
    }
}

// MARK: - BreathingPopup

struct BreathingPopup: View {

    @Binding var isPresented: Bool

    var dismissParent: (() -> Void)? = nil

    var screenWidth: CGFloat
    var screenHeight: CGFloat

    @State private var selectedDuration: Duration = .six

    var body: some View {

        ZStack {

            RoundedRectangle(cornerRadius: 34, style: .continuous)
                .fill(Color.surface)
                .padding(.horizontal, screenWidth * 0.05)

            VStack {

                HStack {

                    Spacer()

                    Button {

                        isPresented = false

                    } label: {

                        Image(systemName: "xmark")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.primaryText)
                            .frame(width: 28, height: 28)
                    }
                }
                .padding(.horizontal, screenWidth * 0.09)
                .padding(.top, 12)

                Spacer().frame(height: 3)

                ZStack {

                    Circle()
                        .fill(Color.background)
                        .frame(width: 44, height: 44)

                    Image(systemName: "lungs")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(Color.secondText)
                        .frame(width: 31, height: 22)
                }

                Spacer().frame(height: 12)

                Text(LocalizedStringKey("سفينة السكينة"))
                    .font(.custom("Aref Ruqaa", size: 24))
                    .fontWeight(.semibold)
                    .foregroundColor(.primaryText)

                Spacer().frame(height: 12)

                Text(LocalizedStringKey("خذ استراحة من ضجيج التغيير. هذه\nالرحلة صُممت لتكون مساحتك الخاصة،\nحيث تحول اضطراب المشاعر إلى أنفاس\nهادئة تصل بك إلى بر الأمان."))
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.primaryText)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, screenWidth * 0.1)

                Spacer().frame(height: 18)

                // Duration selector

                HStack(spacing: 14) {

                    ForEach(Duration.allCases) { duration in

                        Button {

                            selectedDuration = duration

                        } label: {

                            Text(duration.displayText)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.primaryText)
                                .frame(width: 52, height: 40)
                                .background(
                                    Circle().fill(
                                        selectedDuration == duration
                                        ? Color.darkGreen.opacity(0.5)
                                        : Color.background
                                    )
                                )
                        }
                    }
                }
                .padding(.bottom, 10)

                NavigationLink {

                    GuideView(
                        sessionDuration: selectedDuration.seconds,
                        dismissToRoot: dismissParent
                    )

                } label: {

                    Text(LocalizedStringKey("لنبحر"))
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: screenWidth * 0.70,
                               height: 48)
                        .background(
                            Capsule().fill(Color.darkGreen)
                        )
                }
                .simultaneousGesture(
                    TapGesture().onEnded {
                        isPresented = false
                    }
                )
                .padding(.bottom, 22)
            }
        }
        .frame(
            width: screenWidth * 0.90,
            height: screenHeight * 0.42
        )
        .offset(x: -screenWidth * 0.05,
                y: -screenHeight * 0.07

        )
    }
}

#Preview {

    NavigationStack {

        StartJourney()
    }
}
