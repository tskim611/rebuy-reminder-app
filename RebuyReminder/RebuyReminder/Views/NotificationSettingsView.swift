//
//  NotificationSettingsView.swift
//  RebuyReminder
//
//  Created by RebuyReminder Team
//

import SwiftUI
import UserNotifications

struct NotificationSettingsView: View {
    @AppStorage("notificationTime") private var notificationTime = Date()
    @AppStorage("daysBeforeReminder") private var daysBeforeReminder = 3
    @State private var notificationsEnabled = false

    var body: some View {
        List {
            Section {
                DatePicker("notification.reminder_time", selection: $notificationTime, displayedComponents: .hourAndMinute)

                Picker("notification.remind_days_before", selection: $daysBeforeReminder) {
                    ForEach([1, 2, 3, 5, 7], id: \.self) { days in
                        Text(String(format: NSLocalizedString("notification.remind_days_before", comment: ""), days))
                            .tag(days)
                    }
                }
            }

            Section {
                Text("notification.description")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            if !notificationsEnabled {
                Section {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("notification.permission")
                            .font(.body)

                        Button(action: requestNotificationPermission) {
                            Text("settings.enable_reminders")
                                .frame(maxWidth: .infinity)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                    .padding(.vertical, 8)
                }
            }
        }
        .navigationTitle("settings.notification_settings")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            checkNotificationStatus()
        }
    }

    private func checkNotificationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            DispatchQueue.main.async {
                notificationsEnabled = settings.authorizationStatus == .authorized
            }
        }
    }

    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            DispatchQueue.main.async {
                if granted {
                    notificationsEnabled = true
                }
            }
        }
    }
}

#Preview {
    NavigationView {
        NotificationSettingsView()
    }
}
