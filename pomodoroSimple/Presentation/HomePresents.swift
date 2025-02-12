//
//  HomePresents.swift
//  pomodoroSimple
//
//  Created by Ingryd Cordeiro Duarte on 12/02/25.
//

import Foundation
import UserNotifications
import AVKit

@Observable
final class HomePresents {
    var isTimerRunning: Bool = false
    var isTimerPaused: Bool = false
    var timer: Timer? = nil
    var timeRemaining: Int = 1500

    init(){
        requestNotificationPermission()
    }
    
    func playSoundToEnd() {
        AudioServicesPlaySystemSound(1009)
    }
    
    func startTimer() {
        if !isTimerRunning {
            isTimerRunning = true
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                if self.timeRemaining > 0 {
                    self.timeRemaining -= 1
                } else {
                    self.timer?.invalidate()
                    self.isTimerRunning = false
                    self.sendNotification()
                    self.playSoundToEnd()
                }
            }
        }
    }
    
    func stopTimer(){
        timer?.invalidate()
        isTimerRunning = false
        isTimerPaused = true
    }
    
    func resetTimer() {
        timer?.invalidate()
        isTimerRunning = false
        isTimerPaused = false
        timeRemaining = 1500
        
    }
    
    func timeString(from seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func requestNotificationPermission() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("Permissão concedida")
            } else if let error = error {
                print("Erro ao solicitar permissão: \(error.localizedDescription)")
            }
        }
    }
    
    func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Tempo Acabou!"
        content.body = "Seu tempo de Pomodoro terminou. Faça uma pausa!"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Erro ao adicionar notificação: \(error.localizedDescription)")
            } else {
                print("Notificação agendada com sucesso!")
            }
        }
    }
}
