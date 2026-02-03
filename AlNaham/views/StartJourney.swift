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
           Image("BackGround")
           // BACKGROUND IMAGE behiend elements
           
           ZStack{
               Image("sea")
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(height: 600)
                   .padding(.top, 426)
               
           }
           
           ZStack{
               Image("ShipPathL")
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(width: 493, height: 875)
           }
            
           
           ZStack{
               Image("ship")
                   .resizable()
                   .aspectRatio(contentMode: .fit)
                   .frame(width: 321, height: 510)
                   .padding(.trailing, -340)
                   .padding(.top, 290)
           }
        }
        
    }
}

#Preview {
    StartJourney()
}
