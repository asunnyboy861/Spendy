import SwiftData
import Foundation

@Observable
final class ExpenseViewModel {
    var todayTotal: Double = 0
    var weekTotal: Double = 0
    var monthTotal: Double = 0
    var recentExpenses: [Expense] = []
    var allExpenses: [Expense] = []

    private var modelContext: ModelContext?

    func configure(modelContext: ModelContext) {
        self.modelContext = modelContext
        fetchTotals()
    }

    func addExpense(amount: Double, category: ExpenseCategory,
                    note: String = "") {
        guard let context = modelContext else { return }
        let expense = Expense(
            amount: amount,
            category: category.rawValue,
            note: note
        )
        context.insert(expense)
        try? context.save()
        fetchTotals()
    }

    func deleteExpense(_ expense: Expense) {
        guard let context = modelContext else { return }
        context.delete(expense)
        try? context.save()
        fetchTotals()
    }

    func fetchTotals() {
        guard let context = modelContext else { return }
        let now = Date()
        let calendar = Calendar.current

        let todayStart = calendar.startOfDay(for: now)
        let weekStart = calendar.date(from: calendar.dateComponents(
            [.yearForWeekOfYear, .weekOfYear], from: now))!
        let monthStart = calendar.date(from: calendar.dateComponents(
            [.year, .month], from: now))!

        let descriptor = FetchDescriptor<Expense>(
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
        let expenses = (try? context.fetch(descriptor)) ?? []

        todayTotal = expenses
            .filter { $0.date >= todayStart }
            .reduce(0) { $0 + $1.amount }

        weekTotal = expenses
            .filter { $0.date >= weekStart }
            .reduce(0) { $0 + $1.amount }

        monthTotal = expenses
            .filter { $0.date >= monthStart }
            .reduce(0) { $0 + $1.amount }

        recentExpenses = Array(expenses.prefix(5))
        allExpenses = expenses
    }

    func expensesForCategory(_ category: ExpenseCategory) -> [Expense] {
        allExpenses.filter { $0.category == category.rawValue }
    }

    func totalForCategory(_ category: ExpenseCategory) -> Double {
        expensesForCategory(category).reduce(0) { $0 + $1.amount }
    }
}
