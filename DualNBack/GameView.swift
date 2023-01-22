//
//  GameView.swift
//  DualNBack
//
//  Created by SeungJun Lee on 1/22/23.
//

import AVFoundation
import SwiftUI

struct GameView: View {
    @State private var currentLevel = UserDefaults.standard.integer(forKey: "currentLevel")
    @State private var alphabets = [Character]()
    @State private var positions = [[Int]]()
    @State var fillR = -1
    @State var fillC = -1
    @State var synthesizer = AVSpeechSynthesizer()
    @State private var sessions = 4
    @State private var correctAnswer = [String]()
    @State private var usersAnswer = [String]()
    
    @State private var gameEnded = false
    @State private var record = ""
    @State private var score: Double = 0.0
    
    @Environment(\.presentationMode) var presentation
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var timeRemaining = 3
    @State private var manualLeveling = UserDefaults.standard.bool(forKey: "manual")
    @State private var games = [Game]()
    
    var body: some View {
        VStack{
            if gameEnded == false {
                ZStack{
                    Color.myGray.ignoresSafeArea()
                    VStack{
                        
                        Spacer()
                        
                        Text("N = \(currentLevel)").font(.title)
                        
                        
                        
                        
                        Spacer()
                        
                        GridView(fillR: fillR, fillC: fillC)
                        
                        Spacer()
                        
                        
                        HStack{
                            Button {
                                //ddd
                                record.append("S")
                            } label: {
                                Text("Sound")
                            }
                            
                            Spacer()
                            
                            Button {
                                record.append("P")
                            } label: {
                                Text("Position")
                            }
                        }.padding(.horizontal)
                        
                        Spacer()
                    }.toolbar(.hidden, for: .tabBar)
                    
                    if timeRemaining > -1 {
                        CountDown(second: timeRemaining) .onReceive(timer) { _ in
                            if timeRemaining > -1 {
                                timeRemaining -= 1
                                
                                if timeRemaining == 0 {
                                    startGame()
                                }
                            }
                        }
                    }
                }.onAppear{
                    alphabets = alphabetArray()
                    positions = positionArray()
                    correctAnswer = createAnswer()
                    usersAnswer = []
                }
            } else {
                VStack{
                    Text("Game Ended")
                    
                    Text("\(String(format: "%.2f", score))%")
                    
                    VStack{
                
                        if score >= 90 {
                            Text("Congrats, Level up to N = \(currentLevel)").onAppear{
                                print("C: \(currentLevel)")
                                if currentLevel < 20 {
                                    currentLevel += 1
                                    UserDefaults.standard.set(self.currentLevel, forKey: "currentLevel")
                                }
                                print("C: \(currentLevel)")
                            }
                        }
                        
                        if score >= 70 && score < 90 {
                            Text("Keep up the good work")
                        }
                        
                        if score < 70 {
                            Text("Your level was decreased to N = \(currentLevel)").onAppear{
                                if currentLevel > 1 {
                                    currentLevel -= 1
                                    UserDefaults.standard.set(self.currentLevel, forKey: "currentLevel")
                                }
                            }
                        }
                    }.onAppear{
                        if manualLeveling == false {
                            print("Save current work flow")
                            
                            let new = Game(level: currentLevel, score: score, playedDate: Date())
                            games.append(new)
                            
                            // saving
                            do {
                                let destinationURL = FileManager.documentDirectory.appendingPathComponent("games.json")
                                try JSONEncoder().encode(games).write(to: destinationURL)
                                print("games saved")
                            } catch {
                                print("failed saving games")
                            }
                            
                        }
                    }
                    
                    HStack{
                        Button {
                            //
                            self.presentation.wrappedValue.dismiss()
                        } label: {
                            Text("Home")
                        }
                        
                        Spacer()
                        
                        Button {
                            gameEnded = false
                            timeRemaining = 3
                        } label: {
                            Text("Play Again")
                        }
                        
                    }.padding(.horizontal)
                }.toolbar(.hidden, for: .tabBar)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.myGray).onAppear{
                        score = calculateScore()
                    }
            }
        }.onAppear{
            // load data
            do {
                let destinationURL = FileManager.documentDirectory.appendingPathComponent("games.json")
                let loadedCheckBooks = try JSONDecoder().decode([Game].self, from: .init(contentsOf: destinationURL))
                let loadedData = loadedCheckBooks
                
                games = loadedData
                print("games successfuly loaded")
            } catch {
                print("failed to load games")
            }
        }
        
    }
    
    func startGame() {
        var runCount = 0
        
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { timer in
            
            if runCount < sessions*currentLevel {
                
                // record previous users answer
                if runCount == 0 {
                    // do nothing
                } else {
                    record = removeDuplicates(string: record)
                    if record == "" {
                        usersAnswer.append("X")
                    } else if record == "S" {
                        usersAnswer.append("S")
                    } else if record == "P" {
                        usersAnswer.append("P")
                    } else {
                        usersAnswer.append("SP")
                    }
                    
                    record = ""
                }
                
                //fill color
                let curr: [Int] = positions[runCount]
                fillR = curr[0]
                fillC = curr[1]
                
                
                // speak character
                let utterance = AVSpeechUtterance(string: "\(alphabets[runCount])")
                utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
                synthesizer.speak(utterance)
                
                runCount += 1
            } else {
                record = removeDuplicates(string: record)
                if record == "" {
                    usersAnswer.append("X")
                } else if record == "S" {
                    usersAnswer.append("S")
                } else if record == "P" {
                    usersAnswer.append("P")
                } else {
                    usersAnswer.append("SP")
                }
                
                record = ""
                
                
                fillR = -1
                fillC = -1
                timer.invalidate()
                gameEnded = true
                print(usersAnswer)
                
            }
        }
    }
    
    
    func alphabetArray() -> [Character] {
        let arraySize = sessions*currentLevel
        let characters = "abcdefghijklmnopqrstuvwxyz"
        let randomCharacters = (0..<arraySize).map { _ in characters.randomElement()! }
        return randomCharacters
    }
    
    func positionArray() -> [[Int]] {
        let arraySize = sessions*currentLevel
        let positions = (0..<arraySize).map { _ in [Int.random(in: 0..<3), Int.random(in: 0..<3)] }
        return positions
    }
    
    
    func createAnswer() -> [String] {
        var answer = Array(repeating: "X", count: currentLevel)
        
        for i in currentLevel..<alphabets.count {
            if alphabets[i] == alphabets[i-currentLevel] && positions[i] == positions[i-currentLevel] {
                answer.append("SP")
            } else if alphabets[i] == alphabets[i-currentLevel] && positions[i] != positions[i-currentLevel] {
                answer.append("S")
            } else if alphabets[i] != alphabets[i-currentLevel] && positions[i] == positions[i-currentLevel] {
                answer.append("P")
            } else {
                answer.append("X")
            }
        }
        
        return answer
    }
    
    func calculateScore() -> Double {
        var correct = 0
        var wrong = 0
        for i in 0..<correctAnswer.count {
            if correctAnswer[i] == usersAnswer[i] {
                correct += 1
            } else {
                wrong+=1
            }
        }
        
        let score = Double(correct)/Double(correctAnswer.count)*100
        return score
    }
    
    func removeDuplicates(string: String) -> String {
        var seenCharacters = Set<Character>()
        return String(string.filter { seenCharacters.insert($0).inserted })
    }
}

