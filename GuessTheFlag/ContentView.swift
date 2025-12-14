//
//  ContentView.swift
//  Guess the Flag
//
//  Created by Eli J on 12/9/25.
//

import SwiftUI

struct ContentView: View {
    var countries: [String] = ["Estonia", "France", "Germany", "Ireland", "Italy",
                     "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    var correctAnswer: Int = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            Color(red: 0.3, green: 0.3, blue: 0.3)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .bold()
                        .foregroundStyle(.white)
                    Text(countries[correctAnswer])
                        .bold()
                        .foregroundStyle(.white)
                }
                
                ForEach(0..<3) { number in
                    Button {
                        // flag was tapped
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.white, lineWidth: 2))
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}


