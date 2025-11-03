import Foundation
import CoreData

struct ItemModel: Identifiable, Equatable, Hashable {
    let id: UUID
    var icon: String
    var name: String
    var lastBought: Date
    var cycleDays: Int
    var category: String?
    var notes: String?
    var notificationEnabled: Bool

    // Reference to CoreData object for updates
    var coreDataItem: Item?

    // 0.0 ~ 1.0 progress toward next rebuy
    var progress: Double {
        let elapsed = Date().timeIntervalSince(lastBought) / 86400.0
        return min(1.0, max(0.0, elapsed / Double(cycleDays)))
    }

    var daysLeft: Int {
        max(0, cycleDays - Int(Date().timeIntervalSince(lastBought) / 86400.0))
    }

    var isOverdue: Bool {
        daysLeft <= 0
    }

    // Initialize from CoreData Item
    init(from item: Item) {
        self.id = item.id ?? UUID()

        // Debug: Print category value from CoreData
        print("🔍 ItemModel.init - Creating item '\(item.name ?? "")' with category: '\(item.category ?? "nil")'")

        self.icon = ItemModel.iconForCategory(item.category)
        print("🎯 ItemModel.init - Assigned icon: '\(self.icon)' for category: '\(item.category ?? "nil")'")

        self.name = item.name ?? ""
        self.lastBought = item.lastPurchaseDate ?? Date()
        self.cycleDays = Int(item.cycleDays)
        self.category = item.category
        self.notes = item.notes
        self.notificationEnabled = item.notificationEnabled
        self.coreDataItem = item
    }

    // Initialize for new items
    init(id: UUID = UUID(), icon: String, name: String, lastBought: Date, cycleDays: Int, category: String? = nil, notes: String? = nil, notificationEnabled: Bool = true) {
        self.id = id
        self.icon = icon
        self.name = name
        self.lastBought = lastBought
        self.cycleDays = cycleDays
        self.category = category
        self.notes = notes
        self.notificationEnabled = notificationEnabled
        self.coreDataItem = nil
    }

    // Map category to emoji icon
    static func iconForCategory(_ category: String?) -> String {
        print("🎨 Getting icon for category: '\(category ?? "nil")'")
        switch category {
        case "health": return "💊"
        case "pantry": return "🥛"
        case "personal_care": return "🧴"
        case "household": return "🧻"
        case "pet_care": return "🐾"
        case "other": return "📦"
        default:
            print("⚠️ No match found, using default box icon")
            return "📦"
        }
    }

    // Equatable conformance
    static func == (lhs: ItemModel, rhs: ItemModel) -> Bool {
        lhs.id == rhs.id
    }

    // Hashable conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
