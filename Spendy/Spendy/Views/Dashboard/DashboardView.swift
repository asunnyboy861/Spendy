import SwiftUI

struct DashboardView: View {
    let today: Double
    let week: Double
    let month: Double

    var body: some View {
        VStack(spacing: 16) {
            HStack(spacing: 12) {
                SpendCardView(title: "Today", amount: today, color: .blue)
                SpendCardView(title: "This Week", amount: week, color: .purple)
            }
            SpendCardView(title: "This Month", amount: month, color: .green)
                .frame(maxWidth: .infinity)
        }
        .padding(.horizontal, 20)
    }
}
