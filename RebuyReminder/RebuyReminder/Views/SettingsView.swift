import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("notificationsEnabled") private var notificationsEnabled = true
    @AppStorage("darkModeEnabled") private var darkModeEnabled = true

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Notifications")) {
                    Toggle("Enable Reminders", isOn: $notificationsEnabled)
                        .onChange(of: notificationsEnabled) { newValue in
                            if newValue {
                                requestNotificationPermission()
                            }
                        }

                    NavigationLink("Notification Settings") {
                        NotificationSettingsView()
                    }
                }

                Section(header: Text("Appearance")) {
                    Toggle("Dark Mode", isOn: $darkModeEnabled)
                }

                Section(header: Text("Premium")) {
                    Button("Unlock Premium - ₩4,900") {
                        // TODO: Implement StoreKit purchase
                    }
                    .foregroundColor(.blue)

                    Text("Unlimited items + Ad-free experience")
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Section(header: Text("About")) {
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.gray)
                    }

                    Button("Privacy Policy") {
                        // TODO: Show privacy policy
                    }

                    Button("Terms of Service") {
                        // TODO: Show TOS
                    }

                    Button("Contact Support") {
                        // TODO: Open email or support
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }

    private func requestNotificationPermission() {
        NotificationService.shared.requestAuthorization { granted, error in
            if let error = error {
                print("Error requesting notification permission: \(error)")
            }
            if !granted {
                // If permission denied, turn off the toggle
                DispatchQueue.main.async {
                    notificationsEnabled = false
                }
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
