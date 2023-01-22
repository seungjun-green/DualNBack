//
//  ContentView.swift
//  DualNBack
//
//  Created by SeungJun Lee on 1/22/23.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = "One"
    
    

    var body: some View {
        VStack{
            TabView(selection: $selectedTab) {
                DualNBack()
                    .tabItem {
                        Image(systemName: "house")
                    }
                    .tag("One")

                History().background(Color.myGray)
                    .tabItem {
                        Image(systemName: "chart.xyaxis.line")
                    }
                    .tag("Two")
                
            }
        } .environment(\.colorScheme, .dark)
     
    }
}
