//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Ankit Kumar Ojha on 10/11/25.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"]
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var score = 0
    @State private var currentQuestion = 1
    
    private let maxQuestions = 10
    
    var isGameOver: Bool {
        currentQuestion >= maxQuestions
    }
    
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom).ignoresSafeArea(edges: .all)
            
                VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                        .foregroundStyle(.white)
                        .font(.subheadline.weight(.heavy))
                    
                    Text(countries[correctAnswer])
                        .foregroundStyle(.white)
                        .font(.largeTitle.weight(.semibold))
                }
                
                ForEach(0 ..< 3) { number in
                    Button {
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .clipShape(.capsule)
                            .shadow(radius: 5)
                    }
                }
                
            }
        }.alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(scoreMessage)
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            score += 1;
            scoreTitle = isGameOver ? "Finished" : "Correct"
            scoreMessage = "Your score is \(score). "
        } else {
            scoreTitle = isGameOver ? "Finished" : "Wrong"
            scoreMessage = "Wrong! That’s the flag of \(countries[number]). "
        }

        scoreMessage += isGameOver ? "Play again?" : "Keep going!"
        showingScore = true
    }
    
    func askQuestion() {
        if(isGameOver) {
            score = 0
            currentQuestion = 1
        } else {
            currentQuestion += 1;
        }
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
