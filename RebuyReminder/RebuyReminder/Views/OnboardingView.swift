import SwiftUI

struct OnboardingView: View {
    @Binding var isPresented: Bool
    @State private var currentPage = 0

    let pages = [
        OnboardingPage(
            icon: "cart.fill",
            title: "onboarding.page1.title",
            description: "onboarding.page1.description"
        ),
        OnboardingPage(
            icon: "clock.badge.checkmark.fill",
            title: "onboarding.page2.title",
            description: "onboarding.page2.description"
        ),
        OnboardingPage(
            icon: "bell.badge.fill",
            title: "onboarding.page3.title",
            description: "onboarding.page3.description"
        )
    ]

    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)

            VStack(spacing: 40) {
                // Skip button
                HStack {
                    Spacer()
                    Button(action: {
                        isPresented = false
                    }) {
                        Text(NSLocalizedString("onboarding.skip", comment: ""))
                            .foregroundColor(.gray)
                            .padding()
                    }
                }

                Spacer()

                // Page content
                TabView(selection: $currentPage) {
                    ForEach(0..<pages.count, id: \.self) { index in
                        VStack(spacing: 30) {
                            Image(systemName: pages[index].icon)
                                .font(.system(size: 100))
                                .foregroundColor(.blue)

                            Text(NSLocalizedString(pages[index].title, comment: ""))
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)

                            Text(NSLocalizedString(pages[index].description, comment: ""))
                                .font(.body)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                        }
                        .tag(index)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .frame(height: 400)

                Spacer()

                // Page indicator and action button
                VStack(spacing: 20) {
                    // Custom page indicator
                    HStack(spacing: 8) {
                        ForEach(0..<pages.count, id: \.self) { index in
                            Circle()
                                .fill(currentPage == index ? Color.blue : Color.gray)
                                .frame(width: 8, height: 8)
                        }
                    }
                    .padding(.bottom, 10)

                    // Action button
                    Button(action: {
                        if currentPage < pages.count - 1 {
                            withAnimation {
                                currentPage += 1
                            }
                        } else {
                            isPresented = false
                        }
                    }) {
                        Text(currentPage == pages.count - 1
                             ? NSLocalizedString("onboarding.get_started", comment: "")
                             : NSLocalizedString("onboarding.next", comment: ""))
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(12)
                            .padding(.horizontal, 40)
                    }
                }
                .padding(.bottom, 40)
            }
        }
    }
}

struct OnboardingPage {
    let icon: String
    let title: String
    let description: String
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView(isPresented: .constant(true))
    }
}
