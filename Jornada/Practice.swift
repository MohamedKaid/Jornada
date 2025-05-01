import SwiftUI

struct WordMatchGame: View {
    // MARK: - State
    @State private var currentIndex: Int = 0
    @State private var selectedAnswer: String? = nil
    @State private var isAnswered: Bool = false
    
    // MARK: - Data
    let words = ["Money", "Savings", "Budget", "Goal", "Needs"]
    
    let definitions = [
        "A plan for how to use your money",
        "Something you want to achieve",
        "Things like food, clothes, or a home",
        "Coins or bills you use to buy things",
        "Putting aside money for later"
    ]
    
    let correctMatches: [String: String] = [
        "Money": "Coins or bills you use to buy things",
        "Savings": "Putting aside money for later",
        "Budget": "A plan for how to use your money",
        "Goal": "Something you want to achieve",
        "Needs": "Things like food, clothes, or a home"
    ]
    
    var currentWord: String {
        words[currentIndex]
    }
    
    // MARK: - View
    var body: some View {
        ZStack {
            Color.blue.ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.white)
                    .overlay(
                        VStack {
                            HStack {
                                Text("$")
                                Spacer()
                                Text("$")
                            }
                            .padding(.horizontal)
                            
                            Text("Match the Word to the Meaning")
                                .multilineTextAlignment(.center)
                                .font(.custom("MarkerFelt-Wide", size: 26))
                                .foregroundColor(.green)
                        }
                        .padding()
                    )
                    .frame(height: 120)
                    .padding(.top, 20)
                
                // Highlighted word
                Text(currentWord)
                    .font(.custom("MarkerFelt-Wide", size: 35))
                    .foregroundColor(.yellow)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(25)
                    .shadow(radius: 5)
                
                // Answer buttons
                VStack(spacing: 20) {
                    ForEach(definitions, id: \.self) { definition in
                        Button(action: {
                            if !isAnswered {
                                selectedAnswer = definition
                                isAnswered = true
                            }
                        }) {
                            Text(definition)
                                .font(.system(size: 16))
                                .foregroundColor(.black)
                                .padding()
                                .frame(width: 260)
                                .background(buttonColor(for: definition))
                                .cornerRadius(20)
                                .multilineTextAlignment(.center)
                        }
                        .disabled(isAnswered) // prevent tapping multiple answers
                    }
                }
                
                // Next button
                if isAnswered {
                    Button("Next Word") {
                        moveToNextWord()
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(12)
                    .padding(.top, 30)
                }
                
                Spacer()
            }
            .padding()
        }
    }
    
    // MARK: - Helper Functions
    func buttonColor(for definition: String) -> Color {
        guard isAnswered else { return Color.white }
        if definition == correctMatches[currentWord] {
            return .green
        } else if definition == selectedAnswer {
            return .red
        } else {
            return .white
        }
    }
    
    func moveToNextWord() {
        currentIndex = (currentIndex + 1) % words.count
        selectedAnswer = nil
        isAnswered = false
    }
}

// MARK: - Preview
struct WordMatchGame_Previews: PreviewProvider {
    static var previews: some View {
        WordMatchGame()
    }
}
