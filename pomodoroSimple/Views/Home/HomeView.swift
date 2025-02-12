//
//  HomeView.swift
//  pomodoroSimple
//
//  Created by Ingryd Cordeiro Duarte on 18/09/24.
//

import SwiftUI

struct HomeView: View {
    var viewModel = HomePresents()
    @Environment(\.colorScheme) var colorScheme
    
    
    var body: some View {
        ZStack{
            Color.primaryBG
                .ignoresSafeArea()
            
            VStack {
                if (viewModel.isTimerRunning != true && viewModel.isTimerPaused == true){
                    Image(systemName: "pause.circle.fill")
                        .resizable()
                        .foregroundStyle(Color.stopRed)
                        .frame(width: 100, height: 100)
                } else    if (viewModel.isTimerRunning != true) {
                    HStack{
                        HeaderCat()
                    }.padding(4)
                }else {
                    RunningCat()
                }
                
                Text("\(viewModel.timeString(from: viewModel.timeRemaining))")
                    .font(.largeTitle)
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                    .fontWeight(.bold)
                    .padding()
                
                HStack {
                    if (viewModel.isTimerRunning != true){
                        Button(action: {
                            viewModel.startTimer()
                        }) {
                            Text("Iniciar")
                                .fontWeight(.bold)
                                .padding()
                                .background(Color.cleanGreen)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    } else {
                        Button(action: {
                            viewModel.stopTimer()
                        }) {
                            Text("Pausar")
                                .fontWeight(.bold)
                                .padding()
                                .background(Color.stopRed)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                
                Button(action: {
                    viewModel.resetTimer()
                }) {
                    Text("Reiniciar")
                        .fontWeight(.bold)
                        .padding()
                        .background(Color.cleanBlue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    
                }
                .padding()
            }
            
            .onDisappear {
                viewModel.resetTimer()
            }
        }
    }
}

#Preview {
    HomeView()
}
