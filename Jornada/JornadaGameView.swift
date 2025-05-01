import SwiftUI

// MARK: - Data Models

// Represents a user's choice with an item and price
struct UserChoice: Identifiable, CustomStringConvertible {
    let id = UUID()
    var item: String
    var price: Int

    var description: String {
        return "\(item): $\(price)"
    }
}

// Represents a question with its text, options, and an associated image
struct Question: Identifiable {
    let id = UUID()
    let text: String
    let options: [UserChoice]
    let imageName: String
}

// MARK: - Main Game View

struct JornadaGameView: View {
    // Tracks selected choices
    @State private var selectedChoices: [UserChoice] = []
    
    // Index of the current question
    @State private var currentQuestionIndex = 0
    
    // Whether the financial tips sheet is showing
    @State private var showingSheet = false
    
    // The total buget that will be left over
    @State private var budget: Double = 0
    
    // The total budget the player has (can adjust this)
    let totalBudget: Double = 45

    // Game questions
    let questions: [Question] = [
        Question(
            text: "Jag needs food. What should he buy?",
            options: [
                UserChoice(item: "Candy", price: 15),
                UserChoice(item: "Fruit", price: 10)
            ],
            
            imageName: "Candy_Fruit"
        ),
        Question(
            text: "Jag‘s pencil broken in class, but he loves video games. What should he buy?",
            options: [
                UserChoice(item: "School Supplies", price: 20),
                UserChoice(item: "Video Games", price: 35)
            ],
            imageName: "school-video"
        ),
        Question(
            text: "Jag loves to play in the sun and loves toys, but has no protection. Which should he buy?",
            options: [
                UserChoice(item: "Sun Screen", price: 5),
                UserChoice(item: "Toys", price: 15)
            ],
            imageName: "sunscreen_toy"
        )
    ]
    
    // Computed property to sum up the money spent so far
    var moneySpent: Double {
        selectedChoices.map { Double($0.price) }.reduce(0, +)
    }

    var body: some View {
        NavigationStack {
            if currentQuestionIndex < questions.count {
                // MARK: - Game Question Screen
                VStack(spacing: 20) {
                    
                    // Question Text
                    Text(questions[currentQuestionIndex].text)
                        .font(.custom("GROBOLD", size: 23))
                        .foregroundColor(.white)
                        .padding()
                        .fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.center)
                        
                    
                    
                    // MARK: - Progress Bar (Money Tracker)
                    VStack() {
                        ProgressView(value: moneySpent, total: totalBudget)
                            .progressViewStyle(LinearProgressViewStyle(tint: .green))
                            .frame(height: 0)
                            .padding(.horizontal)
                        
                        Text("Money Spent: $\(Int(moneySpent)) / $\(Int(totalBudget))")
                            .font(.caption)
                            .foregroundColor(.white)
                            .bold()
                    }
                    
                    // MARK: - Answer Buttons
                    HStack(spacing: 60) {
                        ForEach(questions[currentQuestionIndex].options) { choice in
                            Button(action: {
                                // Append selected choice and advance to next question
                                selectedChoices.append(choice)
                                currentQuestionIndex += 1
                                
                                if currentQuestionIndex == questions.count {
                                    budget = Double(moneySpent)
                                }
                                
                            }) {
                                VStack {
                                    Text(choice.item)
                                    Text("$\(choice.price)")
                                }
                                .font(.custom("GROBOLD", size: 26))
                                .foregroundColor(.jornadaGreen)
                                .frame(width: 140, height: 100)
                                .background(Color.white)
                                .cornerRadius(40)
                            }
                        }
                    }
                    
                    // MARK: - Question Image (Fixed Size)
                    Image(questions[currentQuestionIndex].imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 400, height: 300)
                        .offset(y: 65)

                    Spacer()

                    

                    // MARK: - Bottom Financial Tips Bar
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.yellow)
                        .frame(width: 399, height: 120)
                        .offset(y: 50)
                        .overlay(
                            Button(action: {
                                showingSheet.toggle()
                            }, label: {
                                Text("Tips & Games💸")
                                    .font(.custom("GROBOLD", size: 37))
                                    .padding()
                                    .foregroundColor(.jornadaGreen)
                                    .offset(y: 36)
                            })
                            
                            .sheet(isPresented: $showingSheet) {
                                TipsTabView()
                            }
                        )
                        .ignoresSafeArea(edges: .bottom)
                }
                .padding()
                .background(Color.blue.ignoresSafeArea())

            } else {
                // MARK: - Summary Screen
                VStack(spacing: 20) {
                    // Title
                    Text("Your Choices:")
                        .font(.custom("GROBOLD", size: 32))
                        .multilineTextAlignment(.center)

                    // List of selected choices
                    ForEach(selectedChoices) { choice in
                        Text("\(choice.item): $\(choice.price)")
                            .font(.custom("GROBOLD", size: 22))
                            .padding(.vertical, 4)
                    }

                    // Total Money Spent
                    Text("Total Spent: $\(Int(moneySpent))")
                        .font(.custom("GROBOLD", size: 26))
                        .padding(.top, 16)

                    // Budget Summary
                    Group {
                        if totalBudget - budget > 0 {
                            Text("You started with a budget of $\(Int(totalBudget)).\nYou are currently $\(Int(totalBudget - budget)) under budget 🤩")
                                .font(.custom("GROBOLD", size: 22))
                                .multilineTextAlignment(.center)
                                .background(Color.green.opacity(0.4))
                        } else if totalBudget - budget == 0 {
                            Text("You started with a budget of $\(Int(totalBudget)).\nYou're right on the money!! 😎")
                                .font(.custom("GROBOLD", size: 22))
                                .multilineTextAlignment(.center)
                                .background(Color.black.opacity(0.4))
                        } else {
                            Text("You started with a budget of $\(Int(totalBudget)).\nYou are currently $\(Int(totalBudget - budget)) over budget 😱")
                                .font(.custom("GROBOLD", size: 22))
                                .multilineTextAlignment(.center)
                                .background(Color.red.opacity(0.4))
                        }
                    }
                    .padding()
                    .cornerRadius(12)
                    .padding(.horizontal)

                    Spacer()
                }
                .padding()
                .frame(maxWidth: 600) // Keeps it clean on iPhone and iPad
                .background(Color.jornadaYellow.ignoresSafeArea())


              
            }
        }
    }
}

#Preview {
    JornadaGameView()
}
