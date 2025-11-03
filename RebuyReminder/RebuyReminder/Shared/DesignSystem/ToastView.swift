import SwiftUI

struct ToastView: View {
    let title: String
    let actionTitle: String
    let action: () -> Void

    var body: some View {
        HStack {
            Text(title)
                .font(TypoKR.sub)
                .foregroundColor(.primary)

            Spacer()

            Button(action: action) {
                Text(actionTitle)
                    .font(TypoKR.sub.weight(.semibold))
                    .foregroundColor(Theme.accent)
            }
        }
        .padding()
        .background(.ultraThinMaterial, in: Capsule())
        .shadow(color: Theme.shadow, radius: 6, y: 3)
        .padding(.horizontal, Spacing.inset)
        .transition(.move(edge: .bottom).combined(with: .opacity))
    }
}

struct ToastModifier<ToastContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let content: () -> ToastContent

    func body(content base: Content) -> some View {
        ZStack {
            base

            if isPresented {
                VStack {
                    Spacer()
                    self.content()
                        .padding(.bottom, 20)
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        withAnimation {
                            isPresented = false
                        }
                    }
                }
            }
        }
    }
}

extension View {
    func toast<Content: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) -> some View {
        modifier(ToastModifier(isPresented: isPresented, content: content))
    }
}
