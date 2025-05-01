//
//  ContentView.swift
//  Jornada Official App XCode
//
//  Created by Taijah Johnson on 4/23/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingSheet = false
    
    var body: some View {
      
        ZStack{
            
            Color("JornadaBlue").ignoresSafeArea(edges: .all)
                
            // 2️⃣ Top logo card
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.white)
                .frame(height: 80)
                .overlay(
                    Image("teamLogo")
                        .resizable()
                        .frame(width: 850, height: 700)
                        .offset(y: 80)
                )
                .padding(.horizontal, 24)
            VStack {
             Spacer() // Pushes the bottom bar to the bottom of the screen
                
                RoundedRectangle(cornerRadius: 20, style: .continuous) // Creates a rounded rectangle for the bottom bar
                    .fill(Color.yellow) // Sets the background color to yellow
                    .frame(height: 120)
                    
                    .offset(y: 50)// Specifies the height of the bottom bar
                 
                    .overlay(
                        Button(action: {
                            showingSheet.toggle()
                            
                        },label: {
                            
                            Text("Financial Tips💸")
                                .font(.custom("GROBOLD", size: 45))
                                .padding()
                                .foregroundColor(.jornadaGreen)
                                .offset(y:40)
                        })
                        .sheet(isPresented: $showingSheet) {
                                    FinancialTipsPage()
                                }
                        
                    )
                    .ignoresSafeArea(edges: .bottom) // Makes the bottom bar ignore safe areas (full width at the bottom)

                
                
        
    
       
                        }
            
        }
    }
}

#Preview {
    ContentView()
}
