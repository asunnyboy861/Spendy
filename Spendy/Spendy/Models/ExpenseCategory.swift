import Foundation

enum ExpenseCategory: String, CaseIterable, Identifiable {
    case food = "Food"
    case transport = "Transport"
    case shopping = "Shopping"
    case bills = "Bills"
    case entertainment = "Fun"
    case health = "Health"
    case education = "Education"
    case other = "Other"

    var id: String { rawValue }

    var emoji: String {
        switch self {
        case .food: return "🍔"
        case .transport: return "🚗"
        case .shopping: return "🛍️"
        case .bills: return "📄"
        case .entertainment: return "🎮"
        case .health: return "💊"
        case .education: return "📚"
        case .other: return "📌"
        }
    }

    var colorHex: String {
        switch self {
        case .food: return "FF6B6B"
        case .transport: return "4ECDC4"
        case .shopping: return "45B7D1"
        case .bills: return "96CEB4"
        case .entertainment: return "FFEAA7"
        case .health: return "DDA0DD"
        case .education: return "98D8C8"
        case .other: return "C9CCD5"
        }
    }
}
