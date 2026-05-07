import SwiftUI

struct QuickAddExpenseView: View {
    let viewModel: ExpenseViewModel
    @Binding var newAmount: String
    @Binding var selectedCategory: ExpenseCategory
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isAmountFocused: Bool

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                HStack {
                    Text("$")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundStyle(.secondary)
                    TextField("0.00", text: $newAmount)
                        .font(.system(size: 48, weight: .bold))
                        .keyboardType(.decimalPad)
                        .focused($isAmountFocused)
                }
                .padding(.horizontal, 24)

                LazyVGrid(columns: Array(repeating: GridItem(.flexible()),
                                         count: 4), spacing: 12) {
                    ForEach(ExpenseCategory.allCases) { category in
                        CategoryButtonView(
                            category: category,
                            isSelected: selectedCategory == category
                        ) {
                            selectedCategory = category
                        }
                    }
                }
                .padding(.horizontal, 20)

                Button {
                    if let amount = Double(newAmount), amount > 0 {
                        viewModel.addExpense(
                            amount: amount,
                            category: selectedCategory
                        )
                        newAmount = ""
                        dismiss()
                    }
                } label: {
                    Text("Add")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.blue)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                }
                .padding(.horizontal, 20)
                .disabled(Double(newAmount) == nil || Double(newAmount) == 0)
            }
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear { isAmountFocused = true }
        }
    }
}
