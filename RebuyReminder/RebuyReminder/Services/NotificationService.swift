import Foundation
import UserNotifications

class NotificationService {
    static let shared = NotificationService()

    private let notificationCenter = UNUserNotificationCenter.current()

    private init() {}

    // MARK: - Permission Management

    /// Request notification permission from the user
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            DispatchQueue.main.async {
                completion(granted, error)
            }
        }
    }

    /// Check current notification authorization status
    func checkAuthorizationStatus(completion: @escaping (UNAuthorizationStatus) -> Void) {
        notificationCenter.getNotificationSettings { settings in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus)
            }
        }
    }

    // MARK: - Notification Scheduling

    /// Schedule a notification for an item's rebuy date
    /// - Parameters:
    ///   - item: The item to schedule notification for
    ///   - daysBefore: How many days before rebuy date to notify (default: 3)
    func scheduleNotification(for item: Item, daysBefore: Int = 3) {
        guard let itemId = item.id?.uuidString,
              let itemName = item.name else {
            print("❌ Cannot schedule notification: missing item ID or name")
            return
        }

        // Calculate notification date
        guard let rebuyDate = Calendar.current.date(
            byAdding: .day,
            value: Int(item.cycleDays),
            to: item.lastPurchaseDate ?? Date()
        ) else {
            print("❌ Cannot calculate rebuy date")
            return
        }

        guard let notificationDate = Calendar.current.date(
            byAdding: .day,
            value: -daysBefore,
            to: rebuyDate
        ) else {
            print("❌ Cannot calculate notification date")
            return
        }

        // Don't schedule if notification date is in the past
        if notificationDate <= Date() {
            print("⚠️ Notification date is in the past, skipping: \(itemName)")
            return
        }

        // Create notification content
        let content = UNMutableNotificationContent()
        content.title = itemName

        // Calculate days since last purchase for context
        let daysSincePurchase = Calendar.current.dateComponents(
            [.day],
            from: item.lastPurchaseDate ?? Date(),
            to: Date()
        ).day ?? 0

        // Korean localization
        if Locale.current.languageCode == "ko" {
            content.body = "재구매 시간입니다 – \(Int(item.cycleDays))일 전에 구매함"
        } else {
            content.body = "Time to rebuy – last purchased \(Int(item.cycleDays)) days ago"
        }

        content.sound = .default
        content.badge = 1
        content.categoryIdentifier = "ITEM_REMINDER"
        content.userInfo = [
            "itemId": itemId,
            "itemName": itemName,
            "category": item.category ?? "Other"
        ]

        // Create trigger
        let triggerDate = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: notificationDate
        )

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: triggerDate,
            repeats: false
        )

        // Create request
        let request = UNNotificationRequest(
            identifier: itemId,
            content: content,
            trigger: trigger
        )

        // Schedule notification
        notificationCenter.add(request) { error in
            if let error = error {
                print("❌ Error scheduling notification for \(itemName): \(error.localizedDescription)")
            } else {
                print("✅ Notification scheduled for \(itemName) on \(notificationDate)")
            }
        }
    }

    /// Schedule notification with custom time
    func scheduleNotification(
        for item: Item,
        daysBefore: Int,
        at time: Date
    ) {
        guard let itemId = item.id?.uuidString,
              let itemName = item.name else {
            return
        }

        // Calculate notification date
        guard let rebuyDate = Calendar.current.date(
            byAdding: .day,
            value: Int(item.cycleDays),
            to: item.lastPurchaseDate ?? Date()
        ) else {
            return
        }

        guard var notificationDate = Calendar.current.date(
            byAdding: .day,
            value: -daysBefore,
            to: rebuyDate
        ) else {
            return
        }

        // Set the custom time
        let timeComponents = Calendar.current.dateComponents([.hour, .minute], from: time)
        notificationDate = Calendar.current.date(
            bySettingHour: timeComponents.hour ?? 9,
            minute: timeComponents.minute ?? 0,
            second: 0,
            of: notificationDate
        ) ?? notificationDate

        // Don't schedule if in the past
        if notificationDate <= Date() {
            print("⚠️ Notification date is in the past, skipping: \(itemName)")
            return
        }

        // Create content
        let content = UNMutableNotificationContent()
        content.title = itemName

        if Locale.current.languageCode == "ko" {
            content.body = "재구매 시간입니다 – \(Int(item.cycleDays))일 전에 구매함"
        } else {
            content.body = "Time to rebuy – last purchased \(Int(item.cycleDays)) days ago"
        }

        content.sound = .default
        content.badge = 1
        content.categoryIdentifier = "ITEM_REMINDER"
        content.userInfo = [
            "itemId": itemId,
            "itemName": itemName,
            "category": item.category ?? "Other"
        ]

        // Create trigger with custom time
        let triggerDate = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute],
            from: notificationDate
        )

        let trigger = UNCalendarNotificationTrigger(
            dateMatching: triggerDate,
            repeats: false
        )

        let request = UNNotificationRequest(
            identifier: itemId,
            content: content,
            trigger: trigger
        )

        notificationCenter.add(request) { error in
            if let error = error {
                print("❌ Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("✅ Notification scheduled for \(itemName) at \(notificationDate)")
            }
        }
    }

    // MARK: - Notification Management

    /// Cancel notification for a specific item
    func cancelNotification(for item: Item) {
        guard let itemId = item.id?.uuidString else { return }

        notificationCenter.removePendingNotificationRequests(withIdentifiers: [itemId])
        print("🗑 Notification cancelled for item: \(item.name ?? "Unknown")")
    }

    /// Cancel all pending notifications
    func cancelAllNotifications() {
        notificationCenter.removeAllPendingNotificationRequests()
        print("🗑 All notifications cancelled")
    }

    /// Reschedule all notifications for all items
    func rescheduleAllNotifications(
        for items: [Item],
        daysBefore: Int,
        at time: Date? = nil
    ) {
        // Cancel existing notifications
        cancelAllNotifications()

        // Schedule new notifications
        for item in items where item.notificationEnabled {
            if let time = time {
                scheduleNotification(for: item, daysBefore: daysBefore, at: time)
            } else {
                scheduleNotification(for: item, daysBefore: daysBefore)
            }
        }

        print("🔄 Rescheduled notifications for \(items.count) items")
    }

    /// Get all pending notification requests
    func getPendingNotifications(completion: @escaping ([UNNotificationRequest]) -> Void) {
        notificationCenter.getPendingNotificationRequests { requests in
            DispatchQueue.main.async {
                completion(requests)
            }
        }
    }

    /// Get count of pending notifications
    func getPendingNotificationCount(completion: @escaping (Int) -> Void) {
        getPendingNotifications { requests in
            completion(requests.count)
        }
    }

    // MARK: - Notification Actions

    /// Set up notification categories and actions
    func setupNotificationCategories() {
        // "Mark as Rebought" action
        let reboughtAction = UNNotificationAction(
            identifier: "REBOUGHT_ACTION",
            title: Locale.current.languageCode == "ko" ? "재구매함" : "Rebought",
            options: [.foreground]
        )

        // "Remind Me Later" action
        let remindLaterAction = UNNotificationAction(
            identifier: "REMIND_LATER_ACTION",
            title: Locale.current.languageCode == "ko" ? "나중에 알림" : "Remind Me Later",
            options: []
        )

        // Create category
        let category = UNNotificationCategory(
            identifier: "ITEM_REMINDER",
            actions: [reboughtAction, remindLaterAction],
            intentIdentifiers: [],
            options: []
        )

        notificationCenter.setNotificationCategories([category])
        print("✅ Notification categories set up")
    }

    // MARK: - Badge Management

    /// Update app badge count to match overdue items
    func updateBadgeCount(for items: [Item]) {
        let overdueCount = items.filter { item in
            guard let nextPurchaseDate = Calendar.current.date(
                byAdding: .day,
                value: Int(item.cycleDays),
                to: item.lastPurchaseDate ?? Date()
            ) else {
                return false
            }
            return nextPurchaseDate <= Date()
        }.count

        UNUserNotificationCenter.current().setBadgeCount(overdueCount) { error in
            if let error = error {
                print("❌ Error setting badge count: \(error.localizedDescription)")
            } else {
                print("🔔 Badge count updated: \(overdueCount)")
            }
        }
    }

    /// Clear app badge
    func clearBadge() {
        UNUserNotificationCenter.current().setBadgeCount(0)
    }
}
