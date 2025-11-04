import SwiftUI
import CoreData

struct EditItemView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    let item: ItemModel

    @State private var itemName: String
    @State private var category: String
    @State private var cycleDays: Int
    @State private var notes: String
    @State private var lastPurchaseDate: Date
    @State private var notificationEnabled: Bool

    let predefinedCategories = ["health", "pantry", "personal_care", "household", "pet_care", "other"]

    init(item: ItemModel) {
        self.item = item
        _itemName = State(initialValue: item.name)
        _category = State(initialValue: item.category ?? "")
        _cycleDays = State(initialValue: item.cycleDays)
        _notes = State(initialValue: item.notes ?? "")
        _lastPurchaseDate = State(initialValue: item.lastBought)
        _notificationEnabled = State(initialValue: item.notificationEnabled)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("edit.title")) {
                    TextField(NSLocalizedString("add.item_name", comment: ""), text: $itemName)
                        .autocapitalization(.words)

                    Picker(NSLocalizedString("add.category", comment: ""), selection: $category) {
                        Text(NSLocalizedString("add.select_category", comment: "")).tag("")
                        ForEach(predefinedCategories, id: \.self) { cat in
                            Text(NSLocalizedString("category.\(cat)", comment: "")).tag(cat)
                        }
                    }

                    DatePicker(NSLocalizedString("add.last_purchased", comment: ""), selection: $lastPurchaseDate, displayedComponents: .date)
                }

                Section {
                    HStack {
                        Text(NSLocalizedString("add.rebuy_cycle_label", comment: ""))
                        Spacer()
                        TextField("", value: $cycleDays, format: .number)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                            .frame(width: 60)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Text(NSLocalizedString("add.days_unit", comment: ""))
                    }

                    Stepper("", value: $cycleDays, in: 1...365)
                        .labelsHidden()

                    HStack {
                        Text(NSLocalizedString("add.next_reminder", comment: ""))
                        Spacer()
                        Text(nextReminderDate, style: .date)
                    }
                    .font(.caption)
                    .foregroundColor(.gray)
                }

                Section(header: Text(NSLocalizedString("add.notes", comment: ""))) {
                    TextEditor(text: $notes)
                        .frame(height: 80)
                }

                Section {
                    Toggle(NSLocalizedString("settings.notifications_enabled", comment: ""), isOn: $notificationEnabled)
                }
            }
            .navigationTitle(NSLocalizedString("edit.title", comment: ""))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(NSLocalizedString("add.cancel", comment: "")) {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(NSLocalizedString("add.save", comment: "")) {
                        saveChanges()
                    }
                    .disabled(itemName.isEmpty)
                }
            }
        }
    }

    private var nextReminderDate: Date {
        Calendar.current.date(byAdding: .day, value: cycleDays, to: lastPurchaseDate) ?? Date()
    }

    private func saveChanges() {
        guard let coreDataItem = item.coreDataItem else {
            print("❌ CoreData item not found")
            dismiss()
            return
        }

        withAnimation {
            // Update CoreData item
            coreDataItem.name = itemName
            coreDataItem.category = category.isEmpty ? nil : category
            coreDataItem.lastPurchaseDate = lastPurchaseDate
            coreDataItem.cycleDays = Int32(cycleDays)
            coreDataItem.notes = notes.isEmpty ? nil : notes
            coreDataItem.notificationEnabled = notificationEnabled

            do {
                try viewContext.save()

                // Update notification
                if notificationEnabled {
                    NotificationService.shared.scheduleNotification(for: coreDataItem)
                } else {
                    NotificationService.shared.cancelNotification(for: coreDataItem)
                }

                dismiss()
            } catch {
                let nsError = error as NSError
                print("❌ Error saving changes: \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct EditItemView_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.preview.container.viewContext
        let sampleItem = Item(context: context)
        sampleItem.id = UUID()
        sampleItem.name = "Sample Item"
        sampleItem.category = "health"
        sampleItem.lastPurchaseDate = Date()
        sampleItem.cycleDays = 30
        sampleItem.notes = "Test notes"
        sampleItem.notificationEnabled = true

        return EditItemView(item: ItemModel(from: sampleItem))
            .environment(\.managedObjectContext, context)
    }
}
