import SwiftUI

struct SpendCardView: View {
    let title: String
    let amount: Double
    let color: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            Text(amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .font(.title.bold())
                .foregroundStyle(color)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 16))
    }
}
