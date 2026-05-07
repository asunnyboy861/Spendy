import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var viewModel = ExpenseViewModel()
    @State private var showAddSheet = false
    @State private var newAmount = ""
    @State private var selectedCategory: ExpenseCategory = .food
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            NavigationStack {
                VStack(spacing: 0) {
                    Spacer().frame(height: 20)

                    DashboardView(
                        today: viewModel.todayTotal,
                        week: viewModel.weekTotal,
                        month: viewModel.monthTotal
                    )

                    if !viewModel.recentExpenses.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            HStack {
                                Text("Recent")
                                    .font(.headline)
                                Spacer()
                                NavigationLink("See All") {
                                    HistoryView()
                                }
                                .font(.subheadline)
                            }
                            .padding(.horizontal, 20)

                            ForEach(viewModel.recentExpenses) { expense in
                                ExpenseRowView(expense: expense)
                                    .padding(.horizontal, 20)
                            }
                        }
                        .padding(.top, 24)
                    }

                    Spacer()
                }
                .navigationTitle("")
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Spendy")
                            .font(.title2.bold())
                            .foregroundStyle(.primary)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            showAddSheet = true
                        } label: {
                            Image(systemName: "plus.circle.fill")
                                .font(.title2)
                        }
                    }
                }
                .sheet(isPresented: $showAddSheet) {
                    QuickAddExpenseView(
                        viewModel: viewModel,
                        newAmount: $newAmount,
                        selectedCategory: $selectedCategory
                    )
                    .presentationDetents([.medium])
                }
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }
            .tag(0)

            HistoryView()
                .tabItem {
                    Label("History", systemImage: "clock.arrow.circlepath")
                }
                .tag(1)

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape.fill")
                }
                .tag(2)
        }
        .onAppear {
            viewModel.configure(modelContext: modelContext)
        }
    }
}
