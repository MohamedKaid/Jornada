//
//  FinancialTipsPage.swift
//  Jornada Official App XCode
//
//  Created by Taijah Johnson on 4/23/25.
//

import SwiftUI

struct FinancialTipsPage: View {
    @State var isPortuguese = false
    var body: some View {
        
        ZStack{
            
            
            
            Color("JornadaYellow").ignoresSafeArea(edges: .all)
            
            VStack{
                
                Text(isPortuguese ? "Dicas Financeiras":"Financial Tips")
                    .font(.custom("GROBOLD", size: 30))
                    .padding()
                    .foregroundColor(.jornadaGreen)
                
                
                Text(isPortuguese ? "💰 1. Dinheiro Tip: O dinheiro é o que usamos para comprar coisas. Aprender a economizar um pouco de cada mesada ajuda a realizar sonhos maiores no futuro.":"💰 1. Money Tip: Money is what we use to buy things. Learning to save a little bit of your allowance helps you reach bigger dreams in the future.")
                    .padding(25)
                
            
                Text(isPortuguese ? "🏦 2. Poupança Tip: Guardar parte do dinheiro em um cofrinho ou na conta poupança faz o dinheiro crescer com o tempo. Poupar é como plantar uma sementinha!":"🏦 2. Savings Tip: Saving part of your money in a piggy bank or savings account helps it grow over time. Saving is like planting a tiny seed!")
                    .padding(25)
                
                Text(isPortuguese ? "📊 3. Orçamento Tip: Um orçamento é como um plano para o seu dinheiro. Ensine a dividir: uma parte para gastar, outra para poupar e uma parte para doar.":"📊 3. Budgeting Tip: A budget is like a plan for your money. Teach kids to divide it: one part to spend, one to save, and one to share or donate.")
                    .padding(25)
                
                Text(isPortuguese ? " 🛍️ 4. Desejo x Necessidade Tip: Antes de comprar algo, pergunte: “Eu preciso mesmo disso?” Isso ajuda a tomar decisões mais inteligentes com o dinheiro.":" 🛍️ 4. Wants vs. Needs Tip: Before buying something, ask: “Do I really need this?” That helps you make smarter money choices.")
                    .padding(25)
                
                Text(isPortuguese ? "🎯 5. Meta Tip: Ter um objetivo — como comprar um brinquedo ou fazer uma viagem — ajuda a manter o foco e motiva a guardar dinheiro.":"🎯 5. Goal Setting Tip: Having a goal — like buying a toy or going on a trip — helps you stay focused and motivated to save money.")
                   
                    .padding(25)
            
//                Text("Financial Tips: This is a page of financial advice for Jag").bold()
                
                Toggle("Toggle Here for Portugese", isOn: $isPortuguese)
                    .tint(.white)
                    .bold()
                    .padding()
                    .italic()
                
                
            }
            .toggleStyle(SwitchToggleStyle(tint: .green))
            .padding(.top,10)
            .bold()
           
        }
    }
}
#Preview {
    FinancialTipsPage()
}
