import SwiftUI

struct OnboardingView: View {
    @AppStorage("hasCompletedOnboarding") private var hasCompletedOnboarding = false
    @State private var currentPage = 0

    private let pages = [
        OnboardingPage(
            title: "Track in Seconds",
            subtitle: "Log any expense in under 3 seconds. Just enter the amount, pick a category, and you're done.",
            icon: "bolt.fill"
        ),
        OnboardingPage(
            title: "Three Numbers, That's It",
            subtitle: "See exactly what you spent today, this week, and this month. No clutter, no overwhelm.",
            icon: "numbers.rectangle"
        ),
        OnboardingPage(
            title: "100% Private",
            subtitle: "All your data stays on your device. No accounts, no cloud, no tracking. Ever.",
            icon: "lock.shield.fill"
        )
    ]

    var body: some View {
        TabView(selection: $currentPage) {
            ForEach(0..<pages.count, id: \.self) { index in
                VStack(spacing: 24) {
                    Spacer()

                    Image(systemName: pages[index].icon)
                        .font(.system(size: 60))
                        .foregroundStyle(.blue)
                        .padding(.bottom, 8)

                    Text(pages[index].title)
                        .font(.title.bold())
                        .multilineTextAlignment(.center)

                    Text(pages[index].subtitle)
                        .font(.body)
                        .foregroundStyle(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)

                    Spacer()
                }
                .tag(index)
            }
        }
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .overlay(alignment: .bottom) {
            Button {
                if currentPage < pages.count - 1 {
                    withAnimation { currentPage += 1 }
                } else {
                    hasCompletedOnboarding = true
                }
            } label: {
                Text(currentPage < pages.count - 1 ? "Next" : "Get Started")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
    }
}

private struct OnboardingPage {
    let title: String
    let subtitle: String
    let icon: String
}
