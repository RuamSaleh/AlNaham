//
//  Home.swift
//  AlNaham
//
//  Created by Ghadeer Fallatah on 15/08/1447 AH.
//

import SwiftUI

struct StartJourney: View {
    var body: some View {
       ZStack {
           Color.background
           // BACKGROUND color behiend elements
        
           
           NavigationLink {
               Text("")
                   .font(.title)
           } label: {
               Text("لنبحر") //change font after team stand up
                   .font(.system(size: 18, weight: .medium))
                   .foregroundColor(.white)
                   .frame(width: 146, height: 47)
                   .background(
                       Capsule()
                           .fill(Color.onSurface)
                   )
           }
           
           
           ZStack{
               Image("sea")
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(height: 560)
                   .padding(.top, 403)
               
           }
           
           ZStack {
               Image("cloudL")
                   .resizable()
                   .aspectRatio(contentMode: .fill)
                   .frame(width: 352)
                   .padding(.top, 154)

           }
           
           ZStack{
                Image("cloudR")
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(width: 852, height: 865)
                   .padding(.top, 154)
               
               
           }
           
           Text("اختر سفينتك للرحلة") //change font after team stand up
               .font(Font.custom("Aref Ruqaa", size: 30))
               .fontWeight(.bold)
               .foregroundStyle(Color.primaryText)
               .padding(.top, -240)
           
           
           ZStack{
               VStack{
                   Image(systemName: "water.waves")
                       .offset(x:163, y:35)
                       .foregroundStyle(Color.secondText)
                   
                   Text("سَفينة النَّغم")//change font after team stand up
                       .font(.custom("waseem-light", size: 16))
                       .foregroundColor(.secondText)
                       .fontWeight(.bold)
                       .offset(x:163, y:40)
                      // .padding(.trailing, -305)
               }
                   
                   Image("ship") // First ship (Single element)
                       .resizable()
                       .aspectRatio(contentMode: .fit)
                       .frame(width: 615, height: 685)
                       .padding(.trailing, 345)
                       .padding(.top, 340)
           }
           
           
           ZStack{
               Image("path") // The Path (single element)
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(width: 370, height: 846)
                   .padding(.top, 46)
           }
            
           ZStack{
               VStack{
                   Image(systemName: "lungs")
                       .offset(x:-153, y:2)
                       .foregroundStyle(Color.secondText)
                   
                   Text("سَفينة السكينة")//change font after team stand up
                       .font(.custom("waseem-light", size: 16))
                       .fontWeight(.bold)
                       .foregroundColor(.secondText)
                       .offset(x:-153, y:2)
               }
               
               Image("ship") // Second ship (single element)
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(width: 281, height: 451)
                   .offset(x: 154, y: 161)
                   
                   //.padding(.top, 315) (leave for referance)
           }
        }
    
        
    }
    
}

struct BreathingPopup{
    var body: some View {
        Text("Hello, World!") // temporary placeholder
    }
}


struct SingingPopup{
    var body: some View {
        Text("Hello, World!") // temporary placeholder 
    }
}



#Preview {
    StartJourney()
}
