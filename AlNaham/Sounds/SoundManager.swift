//
//  SoundManager.swift
//  AlNaham
//
//  Created by ruam on 16/08/1447 AH.
//
//
import AVFoundation

final class SoundManager {
    static let shared = SoundManager()

    private var loadingPlayer: AVAudioPlayer?

    private var currentPlayer: AVAudioPlayer?
    private var nextPlayer: AVAudioPlayer?
    private var fadeTimer: Timer?

    private var isLoadingMuted = false

    private init() {}

    func playLoadingSound() {
        guard let url = Bundle.main.url(forResource: "LoadingScreenSound", withExtension: "mp3") else {
            print("Missing sound: LoadingScreenSound")
            return
        }

        do {
            loadingPlayer = try AVAudioPlayer(contentsOf: url)
            loadingPlayer?.numberOfLoops = -1
            loadingPlayer?.volume = isLoadingMuted ? 0 : 1
            loadingPlayer?.play()
        } catch {
            print("Audio error:", error.localizedDescription)
        }
    }

    func muteLoadingSound() {
        isLoadingMuted = true
        loadingPlayer?.volume = 0
    }

    func unmuteLoadingSound() {
        isLoadingMuted = false
        loadingPlayer?.volume = 1
    }

    func playLoop(named name: String, volume: Float = 1.0) {
        guard let url = Bundle.main.url(forResource: name, withExtension: "mp3") else {
            print("Missing sound:", name)
            return
        }

        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.numberOfLoops = -1
            player.volume = volume
            player.play()
            currentPlayer = player
        } catch {
            print("Audio error:", error.localizedDescription)
        }
    }

    func crossfade(to nextSound: String, duration: TimeInterval = 1.2) {
        guard let url = Bundle.main.url(forResource: nextSound, withExtension: "mp3") else {
            print("Missing sound:", nextSound)
            return
        }

        do {
            let next = try AVAudioPlayer(contentsOf: url)
            next.volume = 0
            next.numberOfLoops = -1
            next.play()

            nextPlayer = next
            fadeTimer?.invalidate()

            let steps = 30
            let interval = duration / Double(steps)
            var step = 0

            fadeTimer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
                step += 1
                let progress = Float(step) / Float(steps)

                self.currentPlayer?.volume = 1 - progress
                self.nextPlayer?.volume = progress

                if step >= steps {
                    timer.invalidate()
                    self.currentPlayer?.stop()
                    self.currentPlayer = self.nextPlayer
                    self.nextPlayer = nil
                }
            }

        } catch {
            print("Audio error:", error.localizedDescription)
        }
    }
}
