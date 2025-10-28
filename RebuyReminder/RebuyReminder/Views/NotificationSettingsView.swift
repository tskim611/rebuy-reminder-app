//
//  NotificationSettingsView.swift
//  RebuyReminder
//
//  Created by RebuyReminder Team
//

import SwiftUI
import UserNotifications

struct NotificationSettingsView: View {
    @AppStorage("notificationHour") private var notificationHour = 9
    @AppStorage("notificationMinute") private var notificationMinute = 0
    @AppStorage("daysBeforeReminder") private var daysBeforeReminder = 3
    @State private var notificationsEnabled = false
    @State private var notificationTime = Date()

    var body: some View {
        List {
            Section {
                DatePicker("notification.reminder_time", selection: $notificationTime, displayedComponents: .hourAndMinute)
                    .onChange(of: notificationTime) { newValue in
                        let components = Calendar.current.dateComponents([.hour, .minute], from: newValue)
                        notificationHour = components.hour ?? 9
                        notificationMinute = components.minute ?? 0
                    }

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
            // Load saved time into Date picker
            var components = DateComponents()
            components.hour = notificationHour
            components.minute = notificationMinute
            if let date = Calendar.current.date(from: components) {
                notificationTime = date
            }
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
