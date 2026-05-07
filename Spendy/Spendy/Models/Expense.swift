import SwiftData
import Foundation

@Model
final class Expense {
    @Attribute(.unique) var id: UUID
    var amount: Double
    var category: String
    var note: String
    var date: Date
    var isRecurring: Bool
    var recurringPeriod: String?

    init(amount: Double, category: String, note: String = "",
         date: Date = .now, isRecurring: Bool = false,
         recurringPeriod: String? = nil) {
        self.id = UUID()
        self.amount = amount
        self.category = category
        self.note = note
        self.date = date
        self.isRecurring = isRecurring
        self.recurringPeriod = recurringPeriod
    }
}
