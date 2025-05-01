//
//  TabView.swift
//  Jornada
//
//  Created by Mohamed Kaid on 4/25/25.
//

import SwiftUI

struct TipsTabView: View {
    var body: some View {
        
        TabView {
            
            FinancialTipsPage()
                .tabItem {
                    Image(systemName: "lightbulb")
                    Text("$$$ Tips")
                }
            
            MatchingGame()
                .tabItem {
                    Image(systemName: "gamecontroller.circle.fill")
                    Text("More Games")
                }
            Calc()
                .tabItem {
                    Image(systemName: "dollarsign.circle")
                    Text("Budget Calculator")
                }

            
        }
    }
}

#Preview {
    TipsTabView()
}
