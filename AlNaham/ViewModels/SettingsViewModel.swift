//
//  SettingsViewModel.swift
//  AlNaham
//
//  Created by ruam on 23/08/1447 AH.
//
//import Foundation
//internal import Combine
//
//final class SettingsViewModel: ObservableObject {
//
//    @Published var settings: UserSettings
//    private let store: SettingsStore
//
//    init(store: SettingsStore) {
//        self.store = store
//        self.settings = store.settings
//    }
//
//    func save() {
//        store.save()
//    }
//
//    func handleSoundChange(_ isOn: Bool) {
//        SoundManager.shared.setMuted(!isOn)
//    }
//}
