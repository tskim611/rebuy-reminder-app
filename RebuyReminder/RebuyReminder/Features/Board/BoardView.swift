import SwiftUI

struct BoardView: View {
    @StateObject private var vm: BoardViewModel
    @State private var showingAddItem = false
    @State private var showingSettings = false
    @State private var showUndo: (Bool, ItemModel?) = (false, nil)
    @State private var notificationPermissionGranted = false
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    @State private var showingOnboarding = false

    init(context: NSManagedObjectContext = PersistenceController.shared.container.viewContext) {
        _vm = StateObject(wrappedValue: BoardViewModel(context: context))
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Theme.bg.edgesIgnoringSafeArea(.all)

                Group {
                    if vm.items.isEmpty {
                        // Empty state
                        VStack(spacing: 16) {
                            Text(NSLocalizedString("empty.allStocked", comment: ""))
                                .font(TypoKR.title)
                                .padding()
                                .background(Theme.cardBG, in: RoundedRectangle(cornerRadius: Spacing.cardR))
                                .shadow(color: Theme.shadow, radius: 4, y: 2)

                            Text(NSLocalizedString("hint.swipeDelete", comment: ""))
                                .font(TypoKR.sub)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.horizontal, Spacing.inset)
                    } else {
                        // Card list
                        List {
                            ForEach(Array(vm.items.enumerated()), id: \.element.id) { index, item in
                                ItemCard(item: item) {
                                    withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                                        vm.markRebought(item)
                                    }
                                    Haptics.light()
                                }
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
                                    value: vm.items.count
                                )
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button(role: .destructive) {
                                        let deleted = item
                                        withAnimation(.easeInOut(duration: 0.22)) {
                                            vm.delete(item)
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
            .onChange(of: vm.items.count) { _ in
                updateBadgeCount()
            }
            .toast(isPresented: $showUndo.0) {
                ToastView(
                    title: NSLocalizedString("label.deleted", comment: ""),
                    actionTitle: NSLocalizedString("label.undo", comment: ""),
                    action: {
                        if let item = showUndo.1 {
                            withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                                vm.restore(item)
                            }
                            showUndo = (false, nil)
                        }
                    }
                )
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
        // Get CoreData items for badge count
        let coreDataItems = vm.items.compactMap { $0.coreDataItem }
        NotificationService.shared.updateBadgeCount(for: coreDataItems)
    }
}
