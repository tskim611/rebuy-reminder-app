import SwiftUI
import FirebaseCore
import FirebaseAnalytics

@main
struct RebuyReminderApp: App {
    let persistenceController = PersistenceController.shared

    init() {
        // Configure Firebase
        FirebaseApp.configure()

        // Set up notification categories on app launch
        NotificationService.shared.setupNotificationCategories()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
