import SwiftUI
import CoreData

struct AddItemView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State private var itemName = ""
    @State private var category = ""
    @State private var cycleDays = 30
    @State private var notes = ""
    @State private var lastPurchaseDate = Date()

    let predefinedCategories = ["health", "pantry", "personal_care", "household", "pet_care", "other"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("add.title")) {
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
            }
            .navigationTitle(NSLocalizedString("add.title", comment: ""))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(NSLocalizedString("add.cancel", comment: "")) {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(NSLocalizedString("add.save", comment: "")) {
                        saveItem()
                    }
                    .disabled(itemName.isEmpty)
                }
            }
        }
    }

    private var nextReminderDate: Date {
        Calendar.current.date(byAdding: .day, value: cycleDays, to: lastPurchaseDate) ?? Date()
    }

    private func saveItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.id = UUID()
            newItem.name = itemName
            newItem.category = category.isEmpty ? nil : category
            newItem.lastPurchaseDate = lastPurchaseDate
            newItem.cycleDays = Int32(cycleDays)
            newItem.notes = notes.isEmpty ? nil : notes
            newItem.createdDate = Date()
            newItem.notificationEnabled = true
            newItem.isCompleted = false

            do {
                try viewContext.save()

                print("✅ Item saved to CoreData: \(newItem.name ?? "")")

                // Schedule notification for the new item
                NotificationService.shared.scheduleNotification(for: newItem)

                // Post notification to reload board
                NotificationCenter.default.post(name: NSNotification.Name("ItemAdded"), object: nil)
                print("📢 Posted ItemAdded notification")

                dismiss()
            } catch {
                let nsError = error as NSError
                print("❌ Error saving item: \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
