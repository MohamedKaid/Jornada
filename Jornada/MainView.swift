import SwiftUI

struct MainView: View {
    @State private var isNavigating = false
    @State private var showingSheet = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // 1️⃣ Background color
                Color.blue.ignoresSafeArea()
                
                VStack(spacing: 40) {
                    Spacer().frame(height: 60)
                    
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
                    
                    // 3️⃣ START button
                    Button(action: {
                        isNavigating = true
                    }) {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .fill(Color.white)
                            .frame(height: 67)
                            .overlay(
                                Text("START")
                                    .font(.custom("GROBOLD", size: 41))
                                    .foregroundColor(.jornadaGreen)
                            )
                            .padding(.horizontal, 24)
                    }
                    
                    // 4️⃣ Character image
                    Image("Jig")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: 600, maxHeight: 600)
                        .offset(y: 35)

                    
                    // 🟡 Bottom Bar with Financial Tips
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color.yellow)
                        .frame(height: 100)
                        .offset(y: 50)
                        .overlay(
                            Button(action: {
                                showingSheet.toggle()
                            }, label: {
                                Text("Tips & Games 💸")
                                    .font(.custom("GROBOLD", size: 37))
                                    .padding()
                                    .foregroundColor(.jornadaGreen) // Replace .jornadaGreen if custom color not defined - DONE by TJ
                                    .offset(y: 45)
                            })
                            .sheet(isPresented: $showingSheet) {
                                TipsTabView()
                            }
                        )
                        .ignoresSafeArea(edges: .bottom)
                }
            }
            
            // ✅ Navigation destination
            .navigationDestination(isPresented: $isNavigating) {
                JornadaGameView()
            }
        }
    }
}


#Preview {
    MainView()
}
