//
//  HomeView.swift
//  pomodoroSimple
//
//  Created by Ingryd Cordeiro Duarte on 18/09/24.
//

import SwiftUI
import UserNotifications
import AVFoundation

struct HomeView: View {
    @State private var timeRemaining: Int = 1500 // 25 minutos
    @State private var isTimerRunning: Bool = false
    @State private var timer: Timer? = nil
    
    init() {
        requestNotificationPermission()
    }
    
    var body: some View {
        ZStack{
            Color.primaryBG
                .ignoresSafeArea()
            
            VStack {
                if isTimerRunning == false{
                    HStack{
                        Image("coffeeCat")
                            .resizable()
                            .frame(width: 115, height: 120)
                        
                        Text("Olá. Preparado para começar?")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.white)
                        
                    }.padding(4)
                } else {
                    Image("listenCat")
                        .frame(width: 320, height: 320)
                }
                
                
                
                Text("\(timeString(from: timeRemaining))")
                    .font(.largeTitle)
                    .foregroundStyle(Color.white)
                    .fontWeight(.bold)
                    .padding()
                
                HStack {
                    Button(action: {
                        startTimer()
                    }) {
                        Text("Iniciar")
                            .fontWeight(.bold)
                            .padding()
                            .background(Color.cleanGreen)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        resetTimer()
                    }) {
                        Text("Reiniciar")
                            .fontWeight(.bold)
                            .padding()
                            .background(Color.cleanBlue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
            
            .onDisappear {
                resetTimer()
            }
        }
    }
    
    
    
    func startTimer() {
        if !isTimerRunning {
            isTimerRunning = true
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    timer?.invalidate()
                    isTimerRunning = false
                    sendNotification()
                    playSound()
                }
            }
        }
    }
    
    func stopTimer(){
        
    }
    
    func resetTimer() {
        timer?.invalidate()
        isTimerRunning = false
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
    
    func playSound() {
        AudioServicesPlaySystemSound(1009)
        /* 1000: Sonar
         1001: Toque
         1002: Clique
         1003: Abertura
         1004: Fechar
         1005: Disparar
         1006: Erro
         1007: Notificação
         1008: Nova mensagem
         1009: Alerta
         1010: Mensagem recebida */
    }
    
}

#Preview {
    HomeView()
}
