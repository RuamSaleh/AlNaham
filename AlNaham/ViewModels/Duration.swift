//
//  Duration.swift
//  AlNaham
//
//  Created by Ghadeer Fallatah on 14/09/1447 AH.
//
// import time_h
import Foundation
import  Combine

enum Duration: Int, CaseIterable, Identifiable {
    case three = 3
    case  six = 6
    case  nine = 9

    var id: Int { rawValue }
        
        var minutes: Int {
            rawValue
        }
        
      
        var totalSeconds: Int {
            rawValue * 60
        }
        
    
        var displayText: String {
            switch self {
            case .three: return "٣ د"
            case .six:   return "٦ د"
            case .nine:  return "٩ د" // change to english
                
            }
        }
    }

