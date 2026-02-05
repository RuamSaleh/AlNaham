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
           
           ZStack{
               Image("sea")
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(height: 560)
                   .padding(.top, 403)
               
           }
           
           
           ZStack{
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
                   Text("سَفينة السكينة")
                       .font(.custom("waseem-light", size: 30))
                       .foregroundColor(.black)
                       //.padding(.top, 100)
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

#Preview {
    StartJourney()
}
