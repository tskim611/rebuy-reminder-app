import SwiftUI
import CoreData

struct ItemRowView: View {
    @ObservedObject var item: Item
    @Environment(\.managedObjectContext) private var viewContext

    var daysUntilRebuy: Int {
        // Use KST (Korea Standard Time) for date calculations
        var calendar = Calendar.current
        calendar.timeZone = TimeZone(identifier: "Asia/Seoul") ?? TimeZone.current

        // Get today's date at midnight KST
        let today = calendar.startOfDay(for: Date())

        // Get last purchase date at midnight KST
        let lastPurchase = calendar.startOfDay(for: item.lastPurchaseDate ?? Date())

        // Calculate next purchase date
        let nextPurchaseDate = calendar.date(byAdding: .day, value: Int(item.cycleDays), to: lastPurchase) ?? today

        // Calculate days difference
        return calendar.dateComponents([.day], from: today, to: nextPurchaseDate).day ?? 0
    }

    var statusColor: Color {
        if daysUntilRebuy <= 0 {
            return .red
        } else if daysUntilRebuy <= 7 {
            return .orange
        } else {
            return .green
        }
    }

    var body: some View {
        HStack(spacing: 16) {
            // Status indicator
            Circle()
                .fill(statusColor)
                .frame(width: 12, height: 12)

            VStack(alignment: .leading, spacing: 4) {
                Text(item.name ?? "Unknown Item")
                    .font(.headline)
                    .foregroundColor(.white)

                if let category = item.category, !category.isEmpty {
                    let categoryKey = category.hasPrefix("category.") ? category : "category.\(category)"
                    Text(NSLocalizedString(categoryKey, comment: ""))
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Text(daysUntilRebuy <= 0 ? NSLocalizedString("item.rebuy_now", comment: "") : String(format: NSLocalizedString("item.days_remaining", comment: ""), daysUntilRebuy))
                    .font(.subheadline)
                    .foregroundColor(statusColor)
            }

            Spacer()

            // Rebuy button
            Button(action: {
                markAsRebought()
            }) {
                Text(NSLocalizedString("item.rebought", comment: ""))
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .buttonStyle(.plain)
        }
        .padding()
        .background(Color(.systemGray6).opacity(0.3))
        .cornerRadius(12)
        .contentShape(Rectangle())
        .onTapGesture {
            // Do nothing - prevents the entire card from being tappable
            // Only the button should trigger the rebuy action
        }
    }

    private func markAsRebought() {
        withAnimation {
            item.lastPurchaseDate = Date()

            // Haptic feedback
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()

            do {
                try viewContext.save()

                // Reschedule notification with new date
                NotificationService.shared.scheduleNotification(for: item)
            } catch {
                let nsError = error as NSError
                print("Error saving context: \(nsError), \(nsError.userInfo)")
            }
        }
    }

}
