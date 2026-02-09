//
//  Home.swift
//  AlNaham
//
//  Created by Ghadeer Fallatah on 15/08/1447 AH.
//

import SwiftUI

struct StartJourney: View {
    @State private var ShowBreathingPopup = false
    @State private var ShowSingingPopup = false

    var body: some View {
       ZStack {
           Color.background
           // BACKGROUND color behiend elements
            Button(action: {}) {
               Text("لنبحر") 
                   .font(.system(size: 18, weight: .medium))
                   .foregroundColor(.white)
                   .frame(width: 146, height: 47)
                   .background(
                       Capsule()
                           .fill(Color.onSurface)
                   )
            }.padding(.top, -45)
           
           
           ZStack{
               Image("sea")
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(height: 560)
                   .padding(.top, 403)
                   .allowsHitTesting(false)
           }
           
           ZStack {
               Image("cloudL")
                   .resizable()
                   .aspectRatio(contentMode: .fill)
                   .frame(width: 352)
                   .padding(.top, 154)
                   .allowsHitTesting(false)
           }
           
           ZStack{
                Image("cloudR")
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(width: 852, height: 865)
                   .padding(.top, 154)
                   .allowsHitTesting(false)
           }
           
           Text("اختر سفينتك للرحلة")
               .font(Font.custom("Aref Ruqaa", size: 35))
               .fontWeight(.bold)
               .foregroundStyle(Color.primaryText)
               .padding(.top, -240)
           
           
           ZStack{
               VStack{
                   Image(systemName: "water.waves")
                       .offset(x:163, y:35)
                       .foregroundStyle(Color.secondText)
                   
                   Text("سَفينة النَّغم")
                       .font(.custom("Aref Ruqaa", size: 16))
                       .foregroundColor(.secondText)
                       .fontWeight(.bold)
                       .offset(x:163, y:40)
                       .padding(.trailing, 3)
               }
                   
                   Image("ship") // First ship (Single element)
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
           
           
           ZStack{
               Image("path") // The Path (single element)
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(width: 370, height: 846)
                   .padding(.top, 46)
                   .allowsHitTesting(false)
           }
            
           ZStack{
               VStack{
                   Image(systemName: "lungs")
                       .offset(x:-153, y:2)
                       .foregroundStyle(Color.secondText)
                   
                   Text("سَفينة السكينة")
                       .font(.custom("Aref Ruqaa", size: 16))
                       .fontWeight(.bold)
                       .foregroundColor(.secondText)
                       .offset(x:-153, y:2)
               }
               
               Image("ship") // Second ship (single element)
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(width: 281, height: 451)
                   .offset(x: 154, y: 161)
                   .onTapGesture {
                       ShowSingingPopup = true
                       ShowBreathingPopup = false
                   }
                   
                   //.padding(.top, 315) (leave for referance)
           }
           
           //overlay for dimming the backgriund
           
           if ShowBreathingPopup || ShowSingingPopup {
               Color.black.opacity(0.25)
                   .ignoresSafeArea()
                   .onTapGesture {
                       ShowBreathingPopup = false
                       ShowSingingPopup = false
                   }

               if ShowBreathingPopup {
                   BreathingPopup()
                       .transition(.scale)
                       .zIndex(1)
               }

               if ShowSingingPopup {
                   SingingPopup()
                       .transition(.scale)
                       .zIndex(1)
               }
           }
        }
    
    
    }
    
}

struct BreathingPopup: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 34, style: .continuous)
                .fill(Color.surface)
                .padding(.horizontal, 20)
            
                VStack{
                    Spacer().frame(height: 25)
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

                    
                    Text("سفينة السكينة")
                        .font(.custom("Aref Ruqaa", size: 24))
                        .fontWeight(.semibold)
                        .foregroundColor(.primaryText)
                    Spacer().frame(height: 12)

                    Text("خذ استراحة من ضجيج التغيير. هذه\nالرحلة صُممت لتكون مساحتك الخاصة،\nحيث تحول اضطراب المشاعر إلى أنفاس\nهادئة تصل بك إلى بر الأمان.")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundColor(.primaryText)
                        .multilineTextAlignment(.center)
                        //.lineSpacing(6)
                        .padding(.horizontal, 22)
                    Spacer().frame(height: 18)

                    HStack{
                        Image(systemName: "clock")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.secondText.opacity(0.6))

                        Text("رحلة مدتها ٦ دقائق")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundColor(.secondText.opacity(0.6))
                    }
                    .environment(\.layoutDirection, .rightToLeft)
                    .padding(.bottom, 10)


                    // button -> navigates to breathing excrcis
                    NavigationLink {
                        Text("breathing excercis")
                    } label: {
                        Text("لنبحر")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 275, height: 48)
                            .background(
                                Capsule().fill(Color.onSurface)
                            )
                    }
                     //.padding(.horizontal,6)
                     .padding(.bottom, 2)
                    
                }
              
                }.frame(width: 357, height: 354)
         
            }
        }


struct SingingPopup: View {
    var body: some View{
        ZStack{
            RoundedRectangle(cornerRadius: 34, style: .continuous)
                .fill(Color.surface)
                .padding(.horizontal, 20)
            
            VStack{
                Spacer().frame(height: 22)
                   
                ZStack {
                    Circle()
                        .fill(Color.background)
                        .frame(width: 44, height: 44)
                    
                    Image(systemName: "water.waves")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.secondText)
                        .frame(width: 31, height: 22)
                    
                }
                Spacer().frame(height: 13)
                
                
                Text("سفينة النّغم")
                    .font(.custom("Aref Ruqaa", size: 24))
                    .fontWeight(.semibold)
                    .foregroundColor(.primaryText)
                    
                Spacer().frame(height: 12)
                
                Text("أطلق صوتك لتهدأ روحك. هذه\nالرحلة صُممت لتكون صدى مشاعرك؛\nننسجُ من صوتك وصوت البحر لحناً\nيبدد شتات النفس، ويصل بك إلى مرسى الأمان.")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.primaryText)
                    .multilineTextAlignment(.center)
                //.lineSpacing(6)
                    .padding(.horizontal, 32)
                Spacer().frame(height: 18)
                

                
                // button -> navigates to singing excrcis
                NavigationLink {
                    Text("singing excercis")
                } label: {
                    Text("لنبحر")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 275, height: 48)
                        .background(
                            Capsule().fill(Color.onSurface)
                        )
                }
               .padding(.top, 24)
                
            }
            //.padding(.top, 51)
        }.frame(width: 357, height: 354)
        
    }
}


#Preview {
    StartJourney()
}

