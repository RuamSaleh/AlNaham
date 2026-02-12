//
//  SettingsStore.swift
//  AlNaham
//
//  Created by ruam on 23/08/1447 AH.
//
import SwiftUI
internal import Combine

final class SettingsStore: ObservableObject {

    @AppStorage("isLoadingSoundOn")
    private var soundOn = true

    @AppStorage("isGuideOn")
    private var guideOn = true

    @AppStorage("isHapticOn")
    private var hapticOn = true

    @AppStorage("isNotificationOn")
    private var notificationOn = true

    @AppStorage("userRating")
    private var rating = 4


    @Published var settings = UserSettings()


    init() {
        load()
        
        // Sync SoundManager immediately on app launch
        SoundManager.shared.setMuted(!settings.isLoadingSoundOn)
    }


    func load() {
        settings.isLoadingSoundOn = soundOn
        settings.isGuideOn = guideOn
        settings.isHapticOn = hapticOn
        settings.isNotificationOn = notificationOn
        settings.userRating = rating
    }


    func save() {
        soundOn = settings.isLoadingSoundOn
        guideOn = settings.isGuideOn
        hapticOn = settings.isHapticOn
        notificationOn = settings.isNotificationOn
        rating = settings.userRating
    }
}

