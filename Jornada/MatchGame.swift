import SwiftUI

struct MatchingGame: View {
    // MARK: - Private State Variables
    @State private var currentIndex: Int = 0
    @State private var selectedAnswer: String? = nil
    @State private var isAnswered: Bool = false

    // MARK: - Static Variables
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

    // MARK: - Computed Property
    var currentWord: String {
        words[currentIndex]
    }

    // MARK: - Main Body
    var body: some View {
        ZStack {
            Color.jornadaYellow.ignoresSafeArea(edges: .top) // Yellow background

            ScrollView { // Make screen scrollable
                VStack(spacing: 20) {
                    // Header Title
                    Text("$ Match the Word to the Meaning $")
                        .multilineTextAlignment(.center)
                        .font(.custom("GROBOLD", size: 26))
                        .foregroundColor(.jornadaGreen)
                        .frame(height: 120)
                        .padding(.top, 20)

                    // Highlighted Word
                    Text(currentWord)
                        .font(.custom("GROBOLD", size: 30))
                        .foregroundColor(.jornadaBlue)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(25)
                        .shadow(radius: 5)

                    // Answer Choices
                    VStack(spacing: 20) {
                        ForEach(definitions, id: \.self) { definition in
                            Button(action: {
                                if !isAnswered {
                                    selectedAnswer = definition
                                    isAnswered = true
                                }
                            }) {
                                Text(definition)
                                    .font(.custom("GROBOLD", size: 18))
                                    .foregroundColor(changeFontColor(for: definition))
                                    .padding()
                                    .frame(width: 260)
                                    .background(buttonColor(for: definition))
                                    .cornerRadius(20)
                                    .multilineTextAlignment(.center)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .disabled(isAnswered) // Disable after selecting
                        }
                    }

                    // Next Word Button
                    if isAnswered {
                        Button("Next Word") {
                            moveToNextWord()
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.jornadaGreen)
                        .cornerRadius(12)
                        .padding(.top, 30)
                    }

                    Spacer()
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width) // Force full width layout
            }
        }
    }

    // MARK: - Helper Functions

    // Change Button Background Color After Answering
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

    // Change Button Text Color After Answering
    func changeFontColor(for definition: String) -> Color {
        guard isAnswered else { return .black }
        if definition == correctMatches[currentWord] {
            return .white
        } else if definition == selectedAnswer {
            return .white
        } else {
            return .black
        }
    }

    // Move to the Next Word
    func moveToNextWord() {
        currentIndex = (currentIndex + 1) % words.count
        selectedAnswer = nil
        isAnswered = false
    }
}

// MARK: - Preview
#Preview {
    MatchingGame()
}
