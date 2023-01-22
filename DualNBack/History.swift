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
                    
                    
                    Text("Only game that scored more than 90% and played in automatic leveling are shown").multilineTextAlignment(.center)
                    
                       

                }.padding()
                    .onAppear{
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

