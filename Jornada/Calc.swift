import SwiftUI

// MARK: - Data Model
struct FinancialEntry: Identifiable, Hashable {
    let id = UUID()
    var amount: Double
    var description: String
}

// MARK: - Main View
struct Calc: View {
    // MARK: - State Variables
    @State private var entries: [FinancialEntry] = []       // List of financial entries
    @State private var amount: Double = 0.0                 // New entry amount
    @State private var tempAmount: String = ""            // used as a placeholder for amount in calc screen
    @State private var description: String = ""             // New entry description
    @State private var showConfirmation = false             // Control the success alert after saving screenshot

    // MARK: - Computed Property
    var total: Double {
        // Calculate total amount from all entries
        entries.reduce(0) { $0 + $1.amount }
    }

    // MARK: - Body
    var body: some View {
        ScrollView { // Makes the screen scrollable when content is larger than screen
            VStack(spacing: 16) { // Main vertical stack with tighter spacing
                VStackContent() // The main app content (input fields, list, total)
                    .background(Color.yellow)
                    .cornerRadius(10)
                    .padding()

                Button(action: takeScreenshot) {
                    Text("Take Screenshot")
                        .font(.custom("GROBOLD", size: 20))
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
            }
            .frame(width: UIScreen.main.bounds.width) // Make sure it stretches horizontally
        }
        .background(Color.yellow.ignoresSafeArea()) // Extend yellow background to full screen
        .alert("Screenshot Saved!", isPresented: $showConfirmation) {
            Button("OK", role: .cancel) { }
        }
    }

    // MARK: - Main Content View
    @ViewBuilder
    private func VStackContent() -> some View {
        VStack(spacing: 12) { // Slightly tighter vertical spacing
            // Input Section
            HStack(spacing: 8) { // Horizontal stack for amount and description
                Text("R$")
                    .font(.custom("GROBOLD", size: 24))
                    .frame(width: 50, height: 50)
                    .background(Color.white)
                    .cornerRadius(5)
                
                TextField("Amount", value: $tempAmount, formatter: NumberFormatter.currencyFormatter)
                    .font(.custom("GROBOLD", size: 15))
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onChange(of: tempAmount){
                        if let validAmount = Double(tempAmount) {
                                    amount = validAmount
                                } else {
                                    amount = 0.0 // Or whatever default you prefer
                                }
                    }

                TextField("Description", text: $description)
                    .font(.custom("GROBOLD", size: 15))
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: addEntry) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title)
                        .foregroundColor(.blue)
                }
            }
            .padding(.horizontal, 8) // Padding only horizontally to tighten layout

            Divider() // A thin line between input and list for better separation

            // List Section
            VStack(spacing: 8) {
                ForEach(entries) { entry in
                    HStack {
                        Text(String(format: "$%.2f", entry.amount))
                            .font(.custom("GROBOLD", size: 18))
                        Spacer()
                        Text(entry.description)
                            .font(.custom("GROBOLD", size: 18))
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 1)
                }
            }
            .padding(.horizontal, 8)

            Divider() // Another separator before total

            // Total Section
            Text("Total: \(String(format: "$%.2f", total))")
                .font(.custom("GROBOLD", size: 24))
                .padding(.top, 10)
        }
        .padding(10) // Overall padding for the content inside yellow card
    }

    // MARK: - Action: Add Entry
    private func addEntry() {
        guard !description.isEmpty else { return }
        entries.append(FinancialEntry(amount: amount, description: description))
        amount = 0
        description = ""
    }

    // MARK: - Action: Take Screenshot
    private func takeScreenshot() {
        // Create a snapshot image from the main VStackContent
        let fullScreenView = VStackContent()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)

        let image = fullScreenView.snapshot()
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        showConfirmation = true // Trigger success alert
    }
}

// MARK: - Extensions

// Extension to snapshot any SwiftUI View into a UIImage
extension View {
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
}

// Currency Formatter for consistent decimal style
extension NumberFormatter {
    static var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
}

// MARK: - Preview
#Preview {
    Calc()
}
