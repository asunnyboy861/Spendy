import SwiftUI
import SwiftData

struct ExpenseRowView: View {
    let expense: Expense

    private var categoryEnum: ExpenseCategory {
        ExpenseCategory(rawValue: expense.category) ?? .other
    }

    var body: some View {
        HStack(spacing: 12) {
            Text(categoryEnum.emoji)
                .font(.title2)
                .frame(width: 36, height: 36)
                .background(Color.gray.opacity(0.1))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 2) {
                Text(expense.category)
                    .font(.subheadline.weight(.medium))
                if !expense.note.isEmpty {
                    Text(expense.note)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                }
            }

            Spacer()

            Text(expense.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .font(.subheadline.bold())
                .foregroundStyle(.red)
        }
        .padding(.vertical, 8)
    }
}
