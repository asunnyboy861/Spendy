import SwiftUI

struct SettingsView: View {
    @AppStorage("isAppLockEnabled") private var isAppLockEnabled = false
    @AppStorage("isDailyReminderEnabled") private var isDailyReminderEnabled = false
    @State private var reminderTime = Date()

    private let supportURL = "https://asunnyboy861.github.io/Spendy/support.html"
    private let privacyURL = "https://asunnyboy861.github.io/Spendy/privacy.html"

    var body: some View {
        NavigationStack {
            Form {
                Section("Security") {
                    Toggle("App Lock (Face ID / Touch ID)", isOn: $isAppLockEnabled)
                }

                Section("Reminders") {
                    Toggle("Daily Reminder", isOn: $isDailyReminderEnabled)
                    if isDailyReminderEnabled {
                        DatePicker("Reminder Time", selection: $reminderTime,
                                   displayedComponents: .hourAndMinute)
                    }
                }

                Section("Links") {
                    Link("Support Page", destination: URL(string: supportURL)!)
                    Link("Privacy Policy", destination: URL(string: privacyURL)!)
                    NavigationLink("Contact Support") {
                        ContactSupportView()
                    }
                }

                Section("About") {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundStyle(.secondary)
                    }
                    HStack {
                        Text("Data Storage")
                        Spacer()
                        Text("Local Only")
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}
