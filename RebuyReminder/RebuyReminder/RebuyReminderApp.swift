import SwiftUI

@main
struct RebuyReminderApp: App {
    let persistenceController = PersistenceController.shared

    init() {
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
