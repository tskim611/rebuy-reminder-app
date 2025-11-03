import Foundation
import SwiftUI
import CoreData

@MainActor
final class BoardViewModel: ObservableObject {
    @Published var items: [ItemModel] = []

    private let viewContext: NSManagedObjectContext
    private let notificationService: NotificationService

    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        self.viewContext = context
        self.notificationService = NotificationService.shared
        loadItems()
    }

    // Load items from CoreData
    func loadItems() {
        print("📥 Loading items from CoreData...")
        let request = Item.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Item.lastPurchaseDate, ascending: true)
        ]

        do {
            let fetchedItems = try viewContext.fetch(request)
            print("📦 Fetched \(fetchedItems.count) items from CoreData")
            items = fetchedItems.map { ItemModel(from: $0) }
            print("✅ Items array updated. Count: \(items.count)")
        } catch {
            print("❌ Failed to fetch items: \(error)")
        }
    }

    // Delete item
    func delete(_ item: ItemModel) {
        guard let coreDataItem = item.coreDataItem else { return }

        // Cancel notifications
        if item.notificationEnabled {
            notificationService.cancelNotification(for: coreDataItem)
        }

        // Delete from CoreData
        viewContext.delete(coreDataItem)

        do {
            try viewContext.save()
            // Remove from local array
            items.removeAll { $0.id == item.id }
        } catch {
            print("❌ Failed to delete item: \(error)")
        }
    }

    // Mark as rebought
    func markRebought(_ item: ItemModel) {
        guard let coreDataItem = item.coreDataItem else { return }

        // Update last purchase date
        coreDataItem.lastPurchaseDate = Date()

        // Reschedule notification
        if item.notificationEnabled {
            notificationService.scheduleNotification(for: coreDataItem)
        }

        do {
            try viewContext.save()
            // Reload items to reflect changes
            loadItems()
        } catch {
            print("❌ Failed to mark rebought: \(error)")
        }
    }

    // Restore deleted item (for undo)
    func restore(_ item: ItemModel) {
        // Create new CoreData item
        let newItem = Item(context: viewContext)
        newItem.id = item.id
        newItem.name = item.name
        newItem.category = item.category
        newItem.lastPurchaseDate = item.lastBought
        newItem.cycleDays = Int32(item.cycleDays)
        newItem.notes = item.notes
        newItem.notificationEnabled = item.notificationEnabled
        newItem.isCompleted = false
        newItem.createdDate = Date()

        // Schedule notification
        if item.notificationEnabled {
            notificationService.scheduleNotification(for: newItem)
        }

        do {
            try viewContext.save()
            loadItems()
        } catch {
            print("❌ Failed to restore item: \(error)")
        }
    }
}
