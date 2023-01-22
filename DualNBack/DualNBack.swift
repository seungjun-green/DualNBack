//
//  DualNBack.swift
//  DualNBack
//
//  Created by SeungJun Lee on 1/22/23.
//

import Foundation
import SwiftUI

struct DualNBack: View {
    @State private var currentLevel = UserDefaults.standard.integer(forKey: "currentLevel")
    @State private var manualLeveling = UserDefaults.standard.bool(forKey: "manual")
    var body: some View {
        VStack{
            NavigationStack{
                
                
                VStack{
                    Spacer()
                    
                    Toggle(isOn: $manualLeveling) {
                        Text("Manual Leving")
                    }.onChange(of: manualLeveling) { curr in
                        UserDefaults.standard.set(self.manualLeveling, forKey: "manual")
                        
                        if curr == false {
                            currentLevel = UserDefaults.standard.integer(forKey: "currentLevel")
                        }
                        
                    }.padding()
                    
                    if manualLeveling {
                        Stepper("N = \(currentLevel)", value: $currentLevel, in: 1...20).padding()
                    }
                    
                    Text("N = \(currentLevel)").font(.title)
                        .background(Color.myGray)
                    NavigationLink {
                        GameView().navigationBarBackButtonHidden(true)
                    } label: {
                        Image(systemName: "play.circle").resizable()
                            .frame(width: 60, height: 60)
                        
                    }
                    
                    Spacer()
                    
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.myGray).navigationTitle("Dual-N-Back")
                 
                
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.myGray)
                .onAppear{
                    if UserDefaults.standard.integer(forKey: "currentLevel") == 0 {
                        currentLevel = 1
                        UserDefaults.standard.set(self.currentLevel, forKey: "currentLevel")
                    } else {
                        currentLevel = UserDefaults.standard.integer(forKey: "currentLevel")
                    }
                }
            
        }
    }
}







struct GridView: View {
    let rows = ["R1", "R2", "R3"]
    let cols = ["C1", "C2", "C3"]
    
    var fillR: Int
    var fillC: Int
    
    
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<3) { row in
                HStack(spacing: 0) {
                    ForEach(0..<3) { column in
                        CellView(r: row, c: column, fillR: fillR, fillC: fillC, border: 3)
                    }
                }
            }
        }
    }
}

struct CellView: View {
    var r: Int
    var c: Int
    var fillR: Int
    var fillC: Int
    var border: CGFloat
    
    var curr: Bool {
        if r == fillR && c == fillC {
            return true
        } else {
            return false
        }
    }
    
    var offsetX: CGFloat {
        if c == 0{
            return 0
        } else if c == 1 {
            return -border
        } else {
            return -border*2
        }
    }
    
    var offsetY: CGFloat {
        if r == 0 {
            return 0
        } else if r == 1 {
            return -border
        } else {
            return -border*2
        }
    }
    
    var body: some View {
        Rectangle()
            .strokeBorder(Color.myGreen,lineWidth: 3)
            .frame(width: 100, height: 100)
            .background(Rectangle().foregroundColor(r == fillR && c == fillC ? Color.myWhite : Color.clear))
            .offset(x: offsetX, y: offsetY)
    }
}



struct CountDown: View {
    var second: Int
    var body: some View {
        ZStack(alignment: .center){
            Rectangle()
                .foregroundColor(Color.black.opacity(0.7))
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Text("Game Starts in").font(.title2)
                Text("\(second)").font(.title2)
                
            }
        }
    }
}



extension FileManager {
    static let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
}

