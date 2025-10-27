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

    let predefinedCategories = ["Health", "Pantry", "Personal Care", "Household", "Pet Care", "Other"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Item Details")) {
                    TextField("Item name", text: $itemName)
                        .autocapitalization(.words)

                    Picker("Category", selection: $category) {
                        Text("Select category").tag("")
                        ForEach(predefinedCategories, id: \.self) { cat in
                            Text(cat).tag(cat)
                        }
                    }

                    DatePicker("Last purchased", selection: $lastPurchaseDate, displayedComponents: .date)
                }

                Section(header: Text("Reminder Settings")) {
                    Stepper("Rebuy cycle: \(cycleDays) days", value: $cycleDays, in: 1...365)

                    Text("Next reminder: \(nextReminderDate, style: .date)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Section(header: Text("Notes (Optional)")) {
                    TextEditor(text: $notes)
                        .frame(height: 80)
                }
            }
            .navigationTitle("Add Item")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
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
                dismiss()
            } catch {
                let nsError = error as NSError
                print("Error saving item: \(nsError), \(nsError.userInfo)")
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
