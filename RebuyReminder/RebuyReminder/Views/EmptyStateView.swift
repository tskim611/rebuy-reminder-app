import SwiftUI

struct EmptyStateView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "cart.badge.plus")
                .font(.system(size: 70))
                .foregroundColor(.gray)

            Text(NSLocalizedString("home.empty.title", comment: ""))
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.white)

            Text(NSLocalizedString("home.empty.subtitle", comment: ""))
                .font(.body)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
    }
}

struct EmptyStateView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyStateView()
            .preferredColorScheme(.dark)
    }
}
