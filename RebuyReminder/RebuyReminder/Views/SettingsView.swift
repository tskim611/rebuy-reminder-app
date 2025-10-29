import SwiftUI

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @AppStorage("notificationsEnabled") private var notificationsEnabled = true
    @AppStorage("darkModeEnabled") private var darkModeEnabled = true

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("settings.notifications")) {
                    Toggle("settings.enable_reminders", isOn: $notificationsEnabled)
                        .onChange(of: notificationsEnabled) { newValue in
                            if newValue {
                                requestNotificationPermission()
                            }
                        }

                    NavigationLink("settings.notification_settings") {
                        NotificationSettingsView()
                    }
                }

                Section(header: Text("settings.appearance")) {
                    Toggle("settings.dark_mode", isOn: $darkModeEnabled)
                }

                Section(header: Text("settings.premium")) {
                    Button("settings.unlock_premium") {
                        // TODO: Implement StoreKit purchase
                    }
                    .foregroundColor(.blue)

                    Text("settings.premium_description")
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Section(header: Text("settings.about")) {
                    HStack {
                        Text("settings.version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.gray)
                    }

                    Button("settings.privacy_policy") {
                        // TODO: Show privacy policy
                    }

                    Button("settings.terms_of_service") {
                        // TODO: Show TOS
                    }

                    Button("settings.contact_support") {
                        // TODO: Open email or support
                    }
                }
            }
            .navigationTitle("settings.title")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("settings.done") {
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
