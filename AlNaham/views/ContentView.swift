//
//  ContentView.swift
//  AlNaham
//
//  Created by ruam on 10/08/1447 AH.
//
import SwiftUI

// MARK: - Main View

struct ContentView: View {

    // MARK: App Storage

    @AppStorage("isLoadingSoundOn") private var isLoadingSoundOn = true
    @AppStorage("isGuideOn") private var isGuideOn = true
    @AppStorage("isHapticOn") private var isHapticOn = true
    @AppStorage("isNotificationOn") private var isNotificationOn = true
    @AppStorage("userRating") private var userRating = 4


    var body: some View {

        GeometryReader { geo in

            ZStack {

                // Background
                AppColors.background
                    .ignoresSafeArea()

                ScrollView {

                    VStack(spacing: geo.size.height * 0.03) {

                        // MARK: Title
                        Text("الإعدادات")
                            .font(AppFonts.title)
                            .padding(.top, geo.size.height * 0.05)


                        // MARK: Music Card
                        SettingsCard {

                            ToggleRow(
                                title: "🎵 الموسيقى",
                                isOn: $isLoadingSoundOn
                            )
                            .onChange(of: isLoadingSoundOn) { isOn in
                                handleSound(isOn)
                            }
                        }


                        // MARK: Usage Card
                        SettingsCard {

                            VStack(spacing: 16) {

                                SectionTitle("تسهيلات الاستخدام")

                                ToggleRow(
                                    title: "الصوت الإرشادي",
                                    isOn: $isGuideOn
                                )

                                Divider()

                                ToggleRow(
                                    title: "الاستجابة اللمسية",
                                    isOn: $isHapticOn
                                )
                            }
                        }


                        // MARK: Sleep Card
                        SettingsCard {

                            VStack(spacing: 16) {

                                SectionTitle("منارة النّهام")

                                RatingView(rating: $userRating)

                                Divider()

                                ToggleRow(
                                    title: "التنبيهات",
                                    isOn: $isNotificationOn
                                )
                            }
                        }


                        // MARK: Info Card
                        SettingsCard {

                            InfoSection()
                        }


                        Spacer(minLength: 30)
                    }
                    .padding(.horizontal, geo.size.width * 0.05)
                }
            }
        }
        // RTL Support
        .environment(\.layoutDirection, .rightToLeft)

        // Sounds
        .onAppear {
            SoundManager.shared.playLoadingSound()
            SoundManager.shared.playLoop(
                named: "ES_Calm Waves Lapping Against Rocks, Sea, Seagulls In Background, Foam Details - Epidemic Sound"
            )
        }
    }


    // MARK: Helpers

    private func handleSound(_ isOn: Bool) {

        if isOn {
            SoundManager.shared.unmuteLoadingSound()
        } else {
            SoundManager.shared.muteLoadingSound()
        }
    }
}



// MARK: - Colors

enum AppColors {

    static let background = Color(red: 0.95, green: 0.94, blue: 0.92)
    static let card = Color(red: 0.90, green: 0.88, blue: 0.85)
}



// MARK: - Fonts

enum AppFonts {

    static let title = Font.custom("Aref Ruqaa", size: 34).bold()
    static let section = Font.custom("Aref Ruqaa", size: 20).bold()
}



// MARK: - Settings Card

struct SettingsCard<Content: View>: View {

    @ViewBuilder let content: Content


    var body: some View {

        VStack(alignment: .trailing, spacing: 16) {
            content
        }
        .padding(20)
        .background(AppColors.card)
        .cornerRadius(18)
        .shadow(color: .black.opacity(0.05), radius: 4, y: 2)
    }
}



// MARK: - Toggle Row

struct ToggleRow: View {

    let title: String
    @Binding var isOn: Bool


    var body: some View {

        HStack {

            Text(title)
                .font(.system(size: 16))

            Spacer()

            Toggle("", isOn: $isOn)
                .labelsHidden()
        }
    }
}



// MARK: - Section Title

struct SectionTitle: View {

    let text: String


    init(_ text: String) {
        self.text = text
    }


    var body: some View {

        HStack {

            Text(text)
                .font(AppFonts.section)

            Spacer()
        }
    }
}



// MARK: - Rating View

struct RatingView: View {

    @Binding var rating: Int

    private let maxRating = 5


    var body: some View {

        HStack {

            Text("تقييم الرحلة")

            Spacer()

            HStack(spacing: 6) {

                ForEach(1...maxRating, id: \.self) { index in

                    Image(systemName: index <= rating ? "star.fill" : "star")
                        .foregroundColor(.yellow)
                        .font(.system(size: 18))
                        .onTapGesture {
                            rating = index
                        }
                }
            }
        }
    }
}



// MARK: - Info Section

struct InfoSection: View {

    var body: some View {

        VStack(alignment: .trailing, spacing: 20) {

            // Intellectual Property
            HStack {

                Image(systemName: "lightbulb")

                Text("حقوق الملكية الفكرية")
                    .bold()

                Spacer()
            }

            Text("""
نعتز بالتعاون مع الفنانة أحلام التي جسدت أصالة التراث برسم يدوي عصري.
خصيصاً لهذا المشروع يمكنكم دعم مسيرتها عبر:
ahlamalonazi21@gmail.com
""")
            .font(.system(size: 14))
            .multilineTextAlignment(.trailing)


            Divider()


            // About App
            HStack {

                Image(systemName: "info.circle")

                Text("عن تطبيق النغام")
                    .bold()

                Spacer()
            }

            Text("""
تطبيق ينسج بين موروث المنطقة الشرقية والصحة النفسية، مستلهماً إيقاع البحر وصوت النهمة.
يقدم مساحات تفاعلية تمنح المستخدم شعوراً بالسكينة والانتماء.
""")
            .font(.system(size: 14))
            .multilineTextAlignment(.trailing)
        }
    }
}



// MARK: - Preview

#Preview {
    ContentView()
}
