import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.lastPurchaseDate, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>

    @State private var showingAddItem = false
    @State private var showingSettings = false
    @State private var notificationPermissionGranted = false

    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)

                if items.isEmpty {
                    EmptyStateView()
                } else {
                    List {
                        ForEach(items) { item in
                            ItemRowView(item: item)
                                .listRowBackground(Color.clear)
                                .listRowSeparator(.hidden)
                        }
                        .onDelete(perform: deleteItems)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationTitle("다 떨어지기 전에")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingSettings = true }) {
                        Image(systemName: "gearshape")
                            .foregroundColor(.white)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddItem = true }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                }
            }
            .sheet(isPresented: $showingAddItem) {
                AddItemView()
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView()
            }
            .onAppear {
                requestNotificationPermissionIfNeeded()
                updateBadgeCount()
            }
            .onChange(of: items.count) { _ in
                updateBadgeCount()
            }
        }
        .preferredColorScheme(.dark)
    }

    private func requestNotificationPermissionIfNeeded() {
        NotificationService.shared.checkAuthorizationStatus { status in
            if status == .notDetermined {
                NotificationService.shared.requestAuthorization { granted, error in
                    notificationPermissionGranted = granted
                    if let error = error {
                        print("❌ Notification permission error: \(error.localizedDescription)")
                    }
                }
            } else {
                notificationPermissionGranted = (status == .authorized)
            }
        }
    }

    private func updateBadgeCount() {
        let itemsArray = Array(items)
        NotificationService.shared.updateBadgeCount(for: itemsArray)
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach { item in
                // Cancel notifications for this item
                NotificationService.shared.cancelNotification(for: item)

                // Delete from CoreData
                viewContext.delete(item)
            }

            do {
                try viewContext.save()
                updateBadgeCount()
            } catch {
                print("❌ Error deleting item: \(error.localizedDescription)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
