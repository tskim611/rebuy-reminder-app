import Foundation
import FirebaseAnalytics

/// Service for tracking analytics events with Firebase
class AnalyticsService {
    static let shared = AnalyticsService()

    private init() {}

    // MARK: - Item Events

    /// Track when a user adds a new item
    func trackItemAdded(category: String?, cycleDays: Int) {
        Analytics.logEvent("item_added", parameters: [
            "category": category ?? "none",
            "cycle_days": cycleDays
        ])
    }

    /// Track when a user edits an existing item
    func trackItemEdited(category: String?, cycleDays: Int) {
        Analytics.logEvent("item_edited", parameters: [
            "category": category ?? "none",
            "cycle_days": cycleDays
        ])
    }

    /// Track when a user marks an item as rebought
    func trackItemRebought(category: String?, cycleDays: Int) {
        Analytics.logEvent("item_rebought", parameters: [
            "category": category ?? "none",
            "cycle_days": cycleDays
        ])
    }

    /// Track when a user deletes an item
    func trackItemDeleted(category: String?) {
        Analytics.logEvent("item_deleted", parameters: [
            "category": category ?? "none"
        ])
    }

    /// Track when a user undoes a deletion
    func trackItemRestored(category: String?) {
        Analytics.logEvent("item_restored", parameters: [
            "category": category ?? "none"
        ])
    }

    // MARK: - Screen Views

    /// Track screen views
    func trackScreenView(screenName: String) {
        Analytics.logEvent(AnalyticsEventScreenView, parameters: [
            AnalyticsParameterScreenName: screenName,
            AnalyticsParameterScreenClass: screenName
        ])
    }

    // MARK: - Notification Events

    /// Track when user enables/disables notifications
    func trackNotificationToggle(enabled: Bool) {
        Analytics.logEvent("notification_toggled", parameters: [
            "enabled": enabled
        ])
    }

    // MARK: - User Properties

    /// Set user property for total items count
    func setTotalItemsCount(_ count: Int) {
        Analytics.setUserProperty("\(count)", forName: "total_items")
    }
}
