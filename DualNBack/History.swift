//
//  History.swift
//  DualNBack
//
//  Created by SeungJun Lee on 1/22/23.
//

import Charts
import SwiftUI


struct Game: Identifiable, Codable {
    var id = UUID()
    var level: Int
    var score: Double
    var playedDate: Date
}


struct History: View {
    
    @State private var games = [Game]()

    
    @State private var playedLevel = 5
    @State private var firstData = [Game]()
    @State private var secondData = [Game]()
    @State private var firstText = ""
    
    @State private var selectedOption = "All time"
    var options = ["All time", "30", "10"]
    
    var body: some View {
        NavigationView {
            VStack {
                
                
                VStack{
                    HStack{
                        Text("Played N-Level").fontWeight(.bold)
                        Spacer()
                    }
                    
                    Picker("", selection: $selectedOption) {
                                    ForEach(options, id: \.self) {
                                        Text($0)
                                    }
                                }
                                .pickerStyle(.segmented)
                                .onChange(of: selectedOption) { _ in
                                    let totalCount = games.count
                                    
                                    if selectedOption == "10" {
                                        if totalCount >= 10 {
                                            firstData = games.suffix(10)
                                        } else {
                                            firstData = games
                                        }
                                    }
                                    
                                    if selectedOption == "30" {
                                        if totalCount >= 30 {
                                            firstData = games.suffix(10)
                                        } else {
                                            firstData = games
                                        }
                                    }
                                    
                                    if selectedOption == "All time" {
                                        firstData = games
                                    }
                                }
                    
                    // average N levels played by user on certina date
                    
                    VStack{
                        if firstData.isEmpty {
                            Text("There is no data to show at this moment")
                        } else {
                            Chart(firstData) { game in
                                if selectedOption == "All time" {
                                    LineMark(x: .value("Date",game.playedDate), y: .value("Level", game.level))
                                } else {
                                    BarMark(x: .value("Date",game.playedDate), y: .value("Level", game.level))
                                }
                                
                            }.chartXAxis {
                                AxisMarks { value in
                                    AxisGridLine()
                                    AxisTick()
                                    // only show first and last xAxis value label
                                    if value.index == 0 || value.index == value.count-1 {
                                        AxisValueLabel()
                                    }
                                }
                            }
                        }
                    }.frame(height: 400)
                    
                    
                    Text("Only game that scored more than 70% and played in automatic leveling mode are shown").multilineTextAlignment(.center)
                    
                       

                }.padding()
                    .onAppear{
                        // load data
//                        do {
//                            let destinationURL = FileManager.documentDirectory.appendingPathComponent("games.json")
//                            let loadedCheckBooks = try JSONDecoder().decode([Game].self, from: .init(contentsOf: destinationURL))
//                            let loadedData = loadedCheckBooks
//
//                            games = loadedData
//                            print("games successfuly loaded")
//                        } catch {
//                            print("failed to load games")
//                        }
                        
                        games = myData.myCustomData
                        
                        firstData = games
                    }
                
                                
              
                

            }.navigationTitle("History")
                
        }.background(Color.myGray)
    }
}



// TODOLIST
// actually saving data and loading it when user launch the app, and update it whenever user finish playing the game
// automatic level playing? or let user set the levels by themsevles?
// detetct if the text is cut, and if it is don't show any x labels



class myData {
    static let myCustomData: [Game] = [
        Game(level: 1, score: 80, playedDate: Date.init(timeIntervalSinceNow: 1)),
        Game(level: 2, score: 81, playedDate: Date.init(timeIntervalSinceNow: 2)),
        Game(level: 2, score: 82, playedDate: Date.init(timeIntervalSinceNow: 3)),
        Game(level: 3, score: 83, playedDate: Date.init(timeIntervalSinceNow: 4)),
        Game(level: 3, score: 84, playedDate: Date.init(timeIntervalSinceNow: 5)),
        Game(level: 4, score: 85, playedDate: Date.init(timeIntervalSinceNow: 6)),
        Game(level: 4, score: 86, playedDate: Date.init(timeIntervalSinceNow: 7)),
        Game(level: 4, score: 87, playedDate: Date.init(timeIntervalSinceNow: 8)),
        Game(level: 5, score: 88, playedDate: Date.init(timeIntervalSinceNow: 9)),
        Game(level: 5, score: 90, playedDate: Date.init(timeIntervalSinceNow: 10)),
        Game(level: 4, score: 91, playedDate: Date.init(timeIntervalSinceNow: 11)),
        Game(level: 4, score: 92, playedDate: Date.init(timeIntervalSinceNow: 12)),
        Game(level: 5, score: 93, playedDate: Date.init(timeIntervalSinceNow: 13)),
        Game(level: 5, score: 94, playedDate: Date.init(timeIntervalSinceNow: 14)),
        Game(level: 5, score: 95, playedDate: Date.init(timeIntervalSinceNow: 15)),
        Game(level: 5, score: 96, playedDate: Date.init(timeIntervalSinceNow: 16)),
        Game(level: 6, score: 97, playedDate: Date.init(timeIntervalSinceNow: 17)),
        Game(level: 6, score: 98, playedDate: Date.init(timeIntervalSinceNow: 18)),
        Game(level: 6, score: 99, playedDate: Date.init(timeIntervalSinceNow: 19)),
        Game(level: 7, score: 100, playedDate: Date.init(timeIntervalSinceNow: 20))
    ]
}
