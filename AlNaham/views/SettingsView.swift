//
//  SettingsView.swift
//  AlNaham
//
//  Created by ruam on 10/08/1447 AH.
//
import SwiftUI

struct SettingsView: View {
    
    // App Storage
    @StateObject private var vm =
    SettingsViewModel(store: SettingsStore())
    
    
    var body: some View {
        
        GeometryReader { geo in
            
            ZStack {
                
                AppColors.background
                    .ignoresSafeArea()
                
                ScrollView {
                    
                    VStack(spacing: geo.size.height * 0.03) {
                        
                        // MARK: Title
                        Text("الإعدادات")
                            .font(AppFonts.title)
                            .padding(.top, geo.size.height * 0.05)
                        
                        
                        // MARK: Music
                        SettingsCard {
                            
                            IconToggleRow(
                                icon: "music.note",
                                title: "الموسيقى",
                                isOn: $vm.settings.isLoadingSoundOn
                            )
                            .onChange(of: vm.settings.isLoadingSoundOn) { newValue in
                                
                                vm.handleSoundChange(newValue)
                                vm.save()
                            }
                            
                        }
                        
                        
                        // Usage
                        SettingsCard {
                            
                            VStack(spacing: 16) {
                                
                                SectionTitle("تسهيلات الاستخدام")
                                
                                IconToggleRow(
                                    icon: "speaker.wave.2",
                                    title: "الصوت الإرشادي",
                                    isOn: $vm.settings.isGuideOn
                                )
                                .onChange(of: vm.settings.isGuideOn) {
                                    vm.save()
                                }
                                
                                Divider()
                                
                                IconToggleRow(
                                    icon: "hand.tap",
                                    title: "الاستجابة اللمسية",
                                    isOn: $vm.settings.isHapticOn
                                )
                                .onChange(of: vm.settings.isHapticOn) {
                                    vm.save()
                                }
                            }
                        }
                        
                        
                        // MARK: Sleep
                        SettingsCard {
                            
                            VStack(spacing: 16) {
                                
                                SectionTitle("منارة النّهام")
                                RatingView(rating: $vm.settings.userRating)
                                    .onChange(of: vm.settings.userRating) {
                                        vm.save()
                                    }
                                
                                Divider()
                                
                                IconToggleRow(
                                    icon: "bell",
                                    title: "التنبيهات",
                                    isOn: $vm.settings.isNotificationOn
                                )
                                .onChange(of: vm.settings.isNotificationOn) {
                                    vm.save()
                                }
                                Divider()
                                InfoSection()
                                
                            }
                        }
                        
                        
                        Spacer(minLength: 30)
                    }
                    .padding(.horizontal, geo.size.width * 0.05)
                }
            }
        }
        .environment(\.layoutDirection, .rightToLeft)
        .onAppear {
            vm.handleSoundChange(vm.settings.isLoadingSoundOn)
            
            SoundManager.shared.playLoadingSound()
        }
        
    }
}

//Colors

enum AppColors {
    
    static let background = Color("Background")
    static let card = Color("Surface")
}



//Fonts

enum AppFonts {
    
    static let title = Font.custom("Aref Ruqaa", size: 34).bold()
    static let section = Font.custom("Aref Ruqaa", size: 20).bold()
}



//  Settings Card

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



// Icon Toggle Row

struct IconToggleRow: View {
    
    let icon: String
    let title: String
    
    @Binding var isOn: Bool
    
    
    var body: some View {
        
        HStack(spacing: 12) {
            
            Image(systemName: icon)
                .foregroundColor(.black)
                .frame(width: 22)
            
            
            Text(title)
                .font(.system(size: 16))
            
            
            Spacer()
            
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(.black) // ON color
                .opacity(isOn ? 1 : 0.5) // OFF dim
        }
    }
}



// Section Title

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



// Rating View

struct RatingView: View {
    
    @Binding var rating: Int
    
    private let maxRating = 5
    
    
    var body: some View {
        
        HStack {
            
            Image(systemName: "star")
                .foregroundColor(.black)
            
            Text("تقييم الرحلة")
            
            
            Spacer()
            
            
            HStack(spacing: 6) {
                
                ForEach(1...maxRating, id: \.self) { index in
                    
                    Image(systemName: index <= rating ? "star.fill" : "star")
                        .foregroundColor(
                            index <= rating ? .black : .gray
                        )
                        .font(.system(size: 18))
                        .onTapGesture {
                            rating = index
                        }
                }
            }
        }
    }
}



//Info Section

struct InfoSection: View {
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Image(systemName: "lightbulb")
                    .foregroundColor(.black)
                
                Text("حقوق الملكية الفكرية")
                    .bold()
                
                Spacer()
            }
            
            Text("""
يتضمن التطبيق بعض الأعمال الفنية المنفذة بالتعاون مع الفنانة أحلام.
نقدّر مساهمتها الإبداعية في دعم الهوية البصرية للمشروع.
جميع الحقوق محفوظة ومستخدمة بموجب اتفاق.
""")
            .font(.system(size: 14))
            
            
            Divider()
            
            
            // About
            HStack {
                
                Image(systemName: "info.circle")
                    .foregroundColor(.black)
                
                Text("عن تطبيق النهام")
                    .bold()
                
                Spacer()
            }
            
            Text("""
تطبيق ينسج بين موروث المنطقة الشرقية والصحة النفسية، مستلهماً إيقاع البحر وصوت النهمة.
يقدم مساحات تفاعلية تمنح المستخدم شعوراً بالسكينة والانتماء.
""")
            .font(.system(size: 14))
        }
    }
}



// Preview

#Preview {
    SettingsView()
}
