import SwiftUI
import SwiftData

struct HistoryView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Expense.date, order: .reverse) private var expenses: [Expense]
    @State private var selectedFilter: ExpenseCategory?

    private var filteredExpenses: [Expense] {
        if let filter = selectedFilter {
            return expenses.filter { $0.category == filter.rawValue }
        }
        return expenses
    }

    private var groupedExpenses: [(String, [Expense])] {
        let calendar = Calendar.current
        let grouped = Dictionary(grouping: filteredExpenses) { expense in
            if calendar.isDateInToday(expense.date) {
                return "Today"
            } else if calendar.isDateInYesterday(expense.date) {
                return "Yesterday"
            } else {
                return expense.date.formatted(.dateTime.month().day())
            }
        }
        return grouped.sorted { pair1, pair2 in
            let order = ["Today": 0, "Yesterday": 1]
            let o1 = order[pair1.key] ?? Int.max
            let o2 = order[pair2.key] ?? Int.max
            return o1 < o2
        }
    }

    var body: some View {
        NavigationStack {
            List {
                Picker("Filter", selection: $selectedFilter) {
                    Text("All").tag(nil as ExpenseCategory?)
                    ForEach(ExpenseCategory.allCases) { category in
                        Text("\(category.emoji) \(category.rawValue)").tag(category as ExpenseCategory?)
                    }
                }
                .pickerStyle(.menu)

                ForEach(groupedExpenses, id: \.0) { section in
                    Section(section.0) {
                        ForEach(section.1) { expense in
                            ExpenseRowView(expense: expense)
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        modelContext.delete(expense)
                                        try? modelContext.save()
                                    } label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                }
                        }
                    }
                }
            }
            .navigationTitle("History")
        }
    }
}
