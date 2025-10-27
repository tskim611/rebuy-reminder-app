import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext

        // Create sample data for previews
        for i in 0..<5 {
            let newItem = Item(context: viewContext)
            newItem.id = UUID()
            newItem.name = ["Toothpaste", "Coffee", "Shampoo", "Vitamins", "Laundry Detergent"][i]
            newItem.category = ["Health", "Pantry", "Personal Care", "Health", "Household"][i]
            newItem.lastPurchaseDate = Date().addingTimeInterval(-Double(i * 86400 * 10))
            newItem.cycleDays = [60, 30, 45, 90, 30][i]
            newItem.createdDate = Date()
            newItem.notificationEnabled = true
            newItem.isCompleted = false
        }

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "RebuyReminder")

        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })

        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    func save() {
        let context = container.viewContext

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
