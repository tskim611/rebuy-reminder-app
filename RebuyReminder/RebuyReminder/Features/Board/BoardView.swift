import SwiftUI
import CoreData

struct BoardView: View {
    @Environment(\.managedObjectContext) private var viewContext

    // Use @FetchRequest to automatically observe CoreData changes
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.lastPurchaseDate, ascending: true)],
        animation: .default
    )
    private var coreDataItems: FetchedResults<Item>

    // Convert CoreData items to ItemModel for UI
    // Force recomputation by using coreDataItems.count as a dependency
    private var items: [ItemModel] {
        print("🔄 BoardView.items computed - coreDataItems.count: \(coreDataItems.count)")
        let result = coreDataItems.map { item in
            print("🔄 Converting CoreData item: \(item.name ?? "") with category: \(item.category ?? "nil")")
            return ItemModel(from: item)
        }
        print("🔄 Finished converting \(result.count) items")
        return result
    }

    @State private var showingAddItem = false
    @State private var showingSettings = false
    @State private var showingEditItem = false
    @State private var itemToEdit: ItemModel?
    @State private var showUndo: (Bool, ItemModel?) = (false, nil)
    @State private var notificationPermissionGranted = false
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @State private var showingOnboarding = false

    private let notificationService = NotificationService.shared

    var body: some View {
        NavigationStack {
            ZStack {
                // Background with gradient
                ZStack {
                    Theme.bg.edgesIgnoringSafeArea(.all)

                    // Green sprout gradient at top
                    LinearGradient(
                        gradient: Gradient(colors: [
                            Color(red: 0.7, green: 0.9, blue: 0.7).opacity(0.3),  // Light sprout green
                            Color(red: 0.85, green: 0.95, blue: 0.85).opacity(0.2), // Very light green
                            Color.clear
                        ]),
                        startPoint: .top,
                        endPoint: .center
                    )
                    .edgesIgnoringSafeArea(.all)
                }

                Group {
                    if items.isEmpty {
                        // Empty state
                        VStack(spacing: 16) {
                            Text(NSLocalizedString("empty.allStocked", comment: ""))
                                .font(TypoKR.title)
                                .padding()
                                .background(Theme.cardBG, in: RoundedRectangle(cornerRadius: Spacing.cardR))
                                .shadow(color: Theme.shadow, radius: 8, x: 0, y: 4)

                            Text(NSLocalizedString("hint.swipeDelete", comment: ""))
                                .font(TypoKR.sub)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.horizontal, Spacing.inset)
                    } else {
                        // Card list
                        List {
                            ForEach(Array(items.enumerated()), id: \.element.id) { index, item in
                                ItemCard(item: item, onRebought: {
                                    withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                                        markRebought(item)
                                    }
                                    Haptics.light()
                                }, onTap: {
                                    itemToEdit = item
                                    showingEditItem = true
                                    Haptics.light()
                                })
                                .listRowSeparator(.hidden)
                                .listRowBackground(Color.clear)
                                .listRowInsets(EdgeInsets(top: 6, leading: Spacing.inset, bottom: 6, trailing: Spacing.inset))
                                .transition(.asymmetric(
                                    insertion: .move(edge: .trailing).combined(with: .opacity),
                                    removal: .scale.combined(with: .opacity)
                                ))
                                .animation(
                                    .spring(response: 0.4, dampingFraction: 0.8)
                                        .delay(Double(index) * 0.02),
                                    value: items.count
                                )
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        let deleted = item
                                        withAnimation(.easeInOut(duration: 0.22)) {
                                            delete(item)
                                        }
                                        Haptics.medium()
                                        showUndo = (true, deleted)
                                    } label: {
                                        Label("삭제", systemImage: "trash")
                                    }
                                    .tint(.red)
                                }
                            }
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                    }
                }
            }
            .navigationTitle(Text(NSLocalizedString("app.title", comment: "")))
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingSettings = true
                    } label: {
                        Image(systemName: "gearshape")
                            .imageScale(.large)
                    }
                }

                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showingAddItem = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                            .foregroundStyle(Theme.accent)
                    }
                    .accessibilityLabel(NSLocalizedString("button.addItem", comment: ""))
                }
            }
            .sheet(isPresented: $showingAddItem) {
                AddItemView()
                    .environment(\.managedObjectContext, viewContext)
            }
            .sheet(isPresented: $showingEditItem) {
                if let item = itemToEdit {
                    EditItemView(item: item)
                        .environment(\.managedObjectContext, viewContext)
                }
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView()
            }
            .fullScreenCover(isPresented: $showingOnboarding) {
                OnboardingView(isPresented: $showingOnboarding)
                    .onDisappear {
                        hasSeenOnboarding = true
                    }
            }
            .onAppear {
                if !hasSeenOnboarding {
                    showingOnboarding = true
                }
                requestNotificationPermissionIfNeeded()
                updateBadgeCount()
            }
            .onChange(of: coreDataItems.count) { _ in
                updateBadgeCount()
            }
            .toast(isPresented: $showUndo.0) {
                ToastView(
                    title: NSLocalizedString("label.deleted", comment: ""),
                    actionTitle: NSLocalizedString("label.undo", comment: ""),
                    action: {
                        if let item = showUndo.1 {
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                                restore(item)
                            }
                            showUndo = (false, nil)
                        }
                    }
                )
            }
        }
        .preferredColorScheme(.light)
    }

    // MARK: - Actions

    private func delete(_ item: ItemModel) {
        guard let coreDataItem = item.coreDataItem else { return }

        // Cancel notifications
        if item.notificationEnabled {
            notificationService.cancelNotification(for: coreDataItem)
        }

        // Delete from CoreData
        viewContext.delete(coreDataItem)

        do {
            try viewContext.save()
        } catch {
            print("❌ Failed to delete item: \(error)")
        }
    }

    private func markRebought(_ item: ItemModel) {
        guard let coreDataItem = item.coreDataItem else { return }

        // Update last purchase date
        coreDataItem.lastPurchaseDate = Date()

        // Reschedule notification
        if item.notificationEnabled {
            notificationService.scheduleNotification(for: coreDataItem)
        }

        do {
            try viewContext.save()
        } catch {
            print("❌ Failed to mark rebought: \(error)")
        }
    }

    private func restore(_ item: ItemModel) {
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
        } catch {
            print("❌ Failed to restore item: \(error)")
        }
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
        // Get CoreData items for badge count
        NotificationService.shared.updateBadgeCount(for: Array(coreDataItems))
    }
}
