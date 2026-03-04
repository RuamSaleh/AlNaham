//
//  JourenyPrograss.swift
//  AlNaham
//
//  Created by Ghadeer Fallatah on 15/09/1447 AH.
//

import Foundation
import SwiftUI
import Combine

class JourenyPrograss: ObservableObject {
    
    let duration: Duration
    
    @Published var elapsedSeconds: Int = 0
    @Published var isRunning: Bool = false
    
    private var timer: Timer?
    
    init(duration: Duration) {
        self.duration = duration
    }
    
    var totalSeconds: Int {
        duration.totalSeconds
    }
    
    var progress: Double {
        guard totalSeconds > 0 else { return 0 }
        return Double(elapsedSeconds) / Double(totalSeconds)
    }
    
    func start() {
        guard !isRunning else { return }
        isRunning = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            if self.elapsedSeconds < self.totalSeconds {
                self.elapsedSeconds += 1
            } else {
                self.stop()
            }
        }
    }
    
    func stop() {
        timer?.invalidate()
        timer = nil
        isRunning = false
    }
    
    func reset() {
        stop()
        elapsedSeconds = 0
    }
}
