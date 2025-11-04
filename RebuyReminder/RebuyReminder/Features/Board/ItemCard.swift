import SwiftUI

struct ItemCard: View {
    let item: ItemModel
    let onRebought: () -> Void
    let onTap: () -> Void

    var body: some View {
        HStack(spacing: Spacing.gap) {
            // Emoji icon
            Text(item.icon)
                .font(.system(size: 32))
                .frame(width: 44, height: 44)

            // Item info
            VStack(alignment: .leading, spacing: 6) {
                Text(item.name)
                    .font(TypoKR.title)
                    .foregroundColor(.primary)

                if item.daysLeft > 0 {
                    Text(String(format: NSLocalizedString("label.daysLeft", comment: ""), item.daysLeft))
                        .font(TypoKR.sub)
                        .foregroundStyle(.secondary)
                } else {
                    Text(NSLocalizedString("label.overdue", comment: "Overdue"))
                        .font(TypoKR.sub)
                        .foregroundColor(.red)
                }
            }

            Spacer()

            // Progress ring
            CircularProgressView(progress: item.progress)
                .frame(width: 36, height: 36)
        }
        .padding()
        .background(Theme.cardBG, in: RoundedRectangle(cornerRadius: Spacing.cardR, style: .continuous))
        .shadow(color: Theme.shadow, radius: 8, x: 0, y: 4)
        .contentShape(RoundedRectangle(cornerRadius: Spacing.cardR, style: .continuous))
        .onTapGesture {
            onTap()
        }
        .contextMenu {
            Button {
                onRebought()
            } label: {
                Label(NSLocalizedString("label.restocked", comment: ""), systemImage: "checkmark.circle")
            }
        }
    }
}

// Custom circular progress view
struct CircularProgressView: View {
    let progress: Double

    var body: some View {
        ZStack {
            // Background circle
            Circle()
                .stroke(Color.gray.opacity(0.2), lineWidth: 3)

            // Progress circle
            Circle()
                .trim(from: 0, to: CGFloat(progress))
                .stroke(
                    progressColor,
                    style: StrokeStyle(lineWidth: 3, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.3), value: progress)
        }
    }

    private var progressColor: Color {
        if progress < 0.5 {
            return .green
        } else if progress < 0.8 {
            return .orange
        } else {
            return .red
        }
    }
}
