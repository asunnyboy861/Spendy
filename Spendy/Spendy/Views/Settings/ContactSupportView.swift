import SwiftUI

struct ContactSupportView: View {
    @State private var email = ""
    @State private var message = ""
    @State private var name = ""
    @State private var topic = "General"
    @State private var isSubmitting = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Environment(\.dismiss) private var dismiss

    private let topics = ["General", "Bug Report", "Feature Request", "Question"]

    var body: some View {
        Form {
            Section("Topic") {
                Picker("Topic", selection: $topic) {
                    ForEach(topics, id: \.self) { t in
                        Text(t).tag(t)
                    }
                }
            }

            Section("Your Info") {
                TextField("Name (optional)", text: $name)
                TextField("Email", text: $email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
            }

            Section("Message") {
                TextEditor(text: $message)
                    .frame(minHeight: 100)
            }

            Section {
                Button {
                    submitFeedback()
                } label: {
                    if isSubmitting {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    } else {
                        Text("Submit")
                            .frame(maxWidth: .infinity)
                    }
                }
                .disabled(email.isEmpty || message.isEmpty || isSubmitting)
            }
        }
        .navigationTitle("Contact Support")
        .alert("Feedback", isPresented: $showAlert) {
            Button("OK") {
                if alertMessage.contains("success") {
                    dismiss()
                }
            }
        } message: {
            Text(alertMessage)
        }
    }

    private func submitFeedback() {
        isSubmitting = true
        let body: [String: Any] = [
            "topic": topic,
            "name": name,
            "email": email,
            "message": message,
            "app": "Spendy"
        ]

        guard let url = URL(string: "https://feedback-board.iocompile67692.workers.dev") else {
            alertMessage = "Invalid server URL"
            showAlert = true
            isSubmitting = false
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)

        URLSession.shared.dataTask(with: request) { _, response, error in
            DispatchQueue.main.async {
                isSubmitting = false
                if let error = error {
                    alertMessage = "Failed: \(error.localizedDescription)"
                } else if let httpResponse = response as? HTTPURLResponse,
                          (200...299).contains(httpResponse.statusCode) {
                    alertMessage = "Message sent successfully!"
                    email = ""
                    message = ""
                    name = ""
                } else {
                    alertMessage = "Failed to send. Please try again."
                }
                showAlert = true
            }
        }.resume()
    }
}
