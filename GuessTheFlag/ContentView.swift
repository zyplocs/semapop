//
//  ContentView.swift
//  Guess the Flag
//
//  Created by Eli J on 12/9/25.
//

import SwiftUI

struct ContentView: View {
    @State private var countries: [String] = ["Estonia", "France", "Germany", "Ireland", "Italy",
                                              "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer: Int = Int.random(in: 0...2)
    
    @State private var correctCount: Int = 0
    @State private var questionCount: Int = 0
    
    @State private var tappedFlag: Int? = nil
    @State private var wasCorrect: Bool? = nil
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Color(red: 0.3, green: 0.3, blue: 0.3)
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                Spacer()
                
                VStack {
                    Text("Tap the flag of")
                        .bold()
                        .foregroundStyle(.white)
                        .font(.title2)
                    Text(countries[correctAnswer])
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                }
                
                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .renderingMode(.original)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                            .shadow(
                                color: glowColor(for: number),
                                radius: isAnimating && tappedFlag == number ? 15 : 0
                            )
                            .scaleEffect(isAnimating && tappedFlag == number ? 1.05 : 1.0)
                            .animation(.spring(response: 0.3, dampingFraction: 0.5), value: isAnimating)
                    }
                    .disabled(isAnimating)
                }
                
                Spacer()
                
                Text("Score: \(correctCount) / \(questionCount)")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .padding(.horizontal)
            }
            .padding(.top, 40)
        }
    }
    
    
    func borderColor(for number: Int) -> Color {
        guard isAnimating, tappedFlag == number else {
            return .white
        }
        return wasCorrect == true ? .green : .red
    }
    
    func glowColor(for number: Int) -> Color {
        guard isAnimating, tappedFlag == number else {
            return .clear
        }
        return wasCorrect == true ? .green : .red
    }
    
    func flagTapped(_ number: Int) {
        questionCount += 1
        tappedFlag = number
        wasCorrect = (number == correctAnswer)
        
        if wasCorrect == true {
            correctCount += 1
        }
        
        isAnimating = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            isAnimating = false
            tappedFlag = nil
            wasCorrect = nil
            askQuestion()
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}


