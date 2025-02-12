//
//  HeaderCat.swift
//  pomodoroSimple
//
//  Created by Ingryd Cordeiro Duarte on 12/02/25.
//
import SwiftUI
import Foundation
var headerCat: String = "🐈"

struct HeaderCat: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack() {
            Image("coffeeCat")
                .resizable()
                .frame(width: 115, height: 120)
            
            Text("Olá. Preparado para começar?")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(colorScheme == .dark ? .white : .black)
        }
    }
}

struct RunningCat: View {
    var body: some View {
        Image("listenCat")
            .resizable()
            .frame(width: 220, height: 220)
    }
}

#Preview {
    HeaderCat()
}
