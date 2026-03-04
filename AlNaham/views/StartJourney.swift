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
        ZStack {
            Color.black.ignoresSafeArea()

            ZStack {
                Image("sea")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 560)
                    .padding(.top, 403)
                    .allowsHitTesting(false)
                    .background(Color.background)
                    .clipped()
            }

            ZStack {
                Image("cloudL")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 352)
                    .padding(.top, 154)
                    .allowsHitTesting(false)
            }

            ZStack {
                Image("cloudR")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 852, height: 865)
                    .padding(.top, 154)
                    .allowsHitTesting(false)
            }

            Text(LocalizedStringKey("اختر سفينتك للرحلة"))
                .font(Font.custom("Aref Ruqaa", size: 35))
                .fontWeight(.bold)
                .foregroundStyle(Color.primaryText)
                .padding(.top, -240)

            ZStack {
                VStack {
                    Image(systemName: "water.waves")
                        .offset(x: 163, y: 35)
                        .foregroundStyle(Color.secondText)

                    Text(LocalizedStringKey("سَفينة النهمة"))
                        .font(.custom("Aref Ruqaa", size: 16))
                        .foregroundColor(.secondText)
                        .fontWeight(.bold)
                        .offset(x: 163, y: 40)
                        .padding(.trailing, 3)
                }

                Image("ship")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 615, height: 685)
                    .padding(.trailing, 345)
                    .padding(.top, 340)
                    .onTapGesture {
                        ShowSingingPopup = false
                        ShowBreathingPopup = true
                    }
            }

            ZStack {
                Image("path")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 370, height: 846)
                    .padding(.top, 46)
                    .allowsHitTesting(false)
            }

            ZStack {
                VStack {
                    Image(systemName: "lungs")
                        .offset(x: -153, y: 2)
                        .foregroundStyle(Color.secondText)

                    Text(LocalizedStringKey("سَفينة السكينة"))
                        .font(.custom("Aref Ruqaa", size: 16))
                        .fontWeight(.bold)
                        .foregroundColor(.secondText)
                        .offset(x: -153, y: 2)
                }

                Image("ship")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 281, height: 451)
                    .offset(x: 154, y: 161)
                    .onTapGesture {
                        ShowBreathingPopup = false
                    }
            }

            if ShowBreathingPopup || ShowSingingPopup {
                Color.black.opacity(0.25)
                    .ignoresSafeArea()
                    .onTapGesture {
                        ShowBreathingPopup = false
                        ShowSingingPopup = false
                    }

                if ShowBreathingPopup {
                    BreathingPopup(isPresented: $ShowBreathingPopup, dismissParent: {
                        presentationMode.wrappedValue.dismiss()
                    })
                        .transition(.scale)
                        .zIndex(1)
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - BreathingPopup

struct BreathingPopup: View {
    @Binding var isPresented: Bool
    var dismissParent: (() -> Void)? = nil
    @State private var selectedDuration: Duration = .six

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
                    .padding(.horizontal, 22)
                Spacer().frame(height: 18)

                // Duration selector: ٣ / ٦ / ٩
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
                    GuideView(sessionDuration: selectedDuration.seconds, dismissToRoot: dismissParent)
                } label: {
                    Text(LocalizedStringKey("لنبحر"))
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 275, height: 48)
                        .background(Capsule().fill(Color.darkGreen))
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
    NavigationStack {
        StartJourney()
    }
}
