//
//  HomeView.swift
//  pomodoroSimple
//
//  Created by Ingryd Cordeiro Duarte on 18/09/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack{
            HStack{
                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 115, height: 120)
                    
                
                VStack(alignment: .leading){
                    Text("Olá!")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("Preparado para começar?")
                        .font(.headline)
                }
            }
            Spacer()
            
        }
    }
}

#Preview {
    HomeView()
}
