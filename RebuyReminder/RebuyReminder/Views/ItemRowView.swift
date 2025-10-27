import SwiftUI
import CoreData

struct ItemRowView: View {
    @ObservedObject var item: Item
    @Environment(\.managedObjectContext) private var viewContext

    var daysUntilRebuy: Int {
        let nextPurchaseDate = Calendar.current.date(byAdding: .day, value: Int(item.cycleDays), to: item.lastPurchaseDate) ?? Date()
        return Calendar.current.dateComponents([.day], from: Date(), to: nextPurchaseDate).day ?? 0
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
                    Text(category)
                        .font(.caption)
                        .foregroundColor(.gray)
                }

                Text(daysUntilRebuy <= 0 ? "Time to rebuy!" : "\(daysUntilRebuy) days remaining")
                    .font(.subheadline)
                    .foregroundColor(statusColor)
            }

            Spacer()

            // Rebuy button
            Button(action: {
                markAsRebought()
            }) {
                Text("Rebought")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color(.systemGray6).opacity(0.3))
        .cornerRadius(12)
        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
            Button(role: .destructive) {
                deleteItem()
            } label: {
                Label("Delete", systemImage: "trash")
            }
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
            } catch {
                let nsError = error as NSError
                print("Error saving context: \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItem() {
        withAnimation {
            viewContext.delete(item)

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                print("Error deleting item: \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
