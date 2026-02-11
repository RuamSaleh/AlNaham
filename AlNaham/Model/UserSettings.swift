//
//  UserSettings.swift
//  AlNaham
//
//  Created by ruam on 10/08/1447 AH.
//
import Foundation
import SwiftData

@Model
final class UserSettings {

    var isLoadingSoundOn: Bool
    var isGuideOn: Bool
    var isHapticOn: Bool
    var isNotificationOn: Bool
    var userRating: Int

    init() {
        self.isLoadingSoundOn = true
        self.isGuideOn = true
        self.isHapticOn = true
        self.isNotificationOn = true
        self.userRating = 4
    }
}
