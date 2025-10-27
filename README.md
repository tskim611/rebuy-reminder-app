# 다 떨어지기 전에 (Before You Run Out)

A thoughtful iOS app that helps you remember to rebuy consumable items before you run out.

## Project Status

**Phase 0 – Setup & Identity** (Weeks 1-3) ✅ **95% COMPLETE**

**Current Version:** 0.1.0 | [View Changelog](CHANGELOG.md) | [Testing Guide](docs/TESTING_GUIDE.md)

## Features

### Core Functionality
- Track consumable items (toothpaste, coffee, vitamins, etc.)
- Set custom rebuy cycles for each item
- Local push notifications to remind you when it's time to rebuy
- Simple "Rebought" button to reset the cycle
- CoreData persistence with future iCloud sync support

### User Experience
- Dark mode by default
- Haptic feedback on interactions
- Swipe-to-delete gestures
- Korean + English localization
- Clean, minimal interface

## Tech Stack

- **Platform:** iOS 15+
- **Framework:** SwiftUI
- **Persistence:** CoreData (with iCloud sync planned)
- **Notifications:** UNUserNotificationCenter
- **Analytics:** Firebase (planned)
- **Monetization:** StoreKit (one-time unlock)

## Project Structure

```
RebuyReminder/
├── RebuyReminder/
│   ├── RebuyReminderApp.swift           # App entry point
│   ├── Models/
│   │   └── RebuyReminder.xcdatamodeld   # CoreData model
│   ├── Views/
│   │   ├── ContentView.swift            # Main home screen
│   │   ├── ItemRowView.swift            # Individual item row
│   │   ├── EmptyStateView.swift         # Empty state placeholder
│   │   ├── AddItemView.swift            # Add/edit item form
│   │   └── SettingsView.swift           # Settings & preferences
│   ├── Services/
│   │   ├── PersistenceController.swift  # CoreData stack
│   │   └── NotificationService.swift    # UNUserNotificationCenter
│   ├── Localization/
│   │   ├── en.lproj/
│   │   └── ko.lproj/
│   ├── Resources/
│   └── Info.plist
├── RebuyReminder.xcodeproj/
└── docs/
    ├── PRIVACY_POLICY_EN.md
    ├── PRIVACY_POLICY_KR.md
    ├── TERMS_OF_SERVICE_EN.md
    ├── TERMS_OF_SERVICE_KR.md
    ├── STYLE_GUIDE.md
    ├── FIREBASE_SETUP.md
    ├── WIREFRAMES.md
    ├── PHASE_0_CHECKLIST.md
    └── TESTING_GUIDE.md
```

## CoreData Model

**Item Entity:**
- `id` (UUID) – Unique identifier
- `name` (String) – Item name
- `category` (String, optional) – Category (Health, Pantry, etc.)
- `lastPurchaseDate` (Date) – Last purchase date
- `cycleDays` (Int32) – Days until next rebuy
- `notes` (String, optional) – User notes
- `isCompleted` (Bool) – Completion status
- `createdDate` (Date) – Creation timestamp
- `notificationEnabled` (Bool) – Notification preference

## Getting Started

### Prerequisites
- macOS with Xcode 14+
- iOS Simulator or physical device running iOS 15+
- Apple Developer Account (for device testing & App Store submission)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/tskim611/rebuy-reminder-app.git
   cd rebuy-reminder-app/RebuyReminder
   ```

2. Open the project in Xcode:
   ```bash
   open RebuyReminder.xcodeproj
   ```

3. Configure signing:
   - Select project in Navigator
   - Signing & Capabilities → Select your Apple ID
   - Change bundle identifier if needed

4. Select target (iPhone 14 Pro or newer)

5. Build and run (⌘R)

### Testing

Follow the comprehensive [Testing Guide](docs/TESTING_GUIDE.md) for:
- 20 manual test scenarios
- Notification testing
- Localization validation (KR/EN)
- Accessibility testing (VoiceOver, Dynamic Type)
- Performance profiling with Instruments

### Phase 0 Completion Status

**✅ Completed (95%):**
- [x] iOS project structure (SwiftUI + CoreData)
- [x] All core views (Home, Add Item, Settings, Empty State, Notification Settings)
- [x] NotificationService with UNUserNotificationCenter
- [x] Localization support (KR/EN)
- [x] Wireframes & user flows
- [x] Privacy Policy (PIPA-compliant, KR/EN)
- [x] Terms of Service (KR/EN)
- [x] Style Guide (brand voice, design system)
- [x] Firebase setup instructions
- [x] Comprehensive testing guide
- [x] Git repository + GitHub

**⏳ Remaining (5%):**
- [ ] Test build in Xcode Simulator
- [ ] Register Apple Developer Account (₩129k/year)
- [ ] Legal review of Privacy Policy & TOS
- [ ] Firebase dev project setup (optional for Phase 0)

### Phase 1 – MVP Build (Weeks 4-10)

**Ready to Start:**
- [ ] Firebase Analytics integration → [Setup Guide](docs/FIREBASE_SETUP.md)
- [ ] StoreKit in-app purchase (₩4,900 unlock)
- [ ] App Store assets (6 screenshots, descriptions)
- [ ] TestFlight beta deployment (300 users)
- [ ] Beta feedback & iteration

**Target KPIs:**
- ≥30% D7 retention
- No crash reports
- >4.3★ average rating
- 5,000 downloads / 1,500 MAU

## Documentation

Comprehensive documentation available in [`/docs`](docs/):

| Document | Description |
|----------|-------------|
| [CHANGELOG.md](CHANGELOG.md) | Version history and release notes |
| [TESTING_GUIDE.md](docs/TESTING_GUIDE.md) | 20 test scenarios + troubleshooting |
| [WIREFRAMES.md](docs/WIREFRAMES.md) | ASCII wireframes + user flows |
| [STYLE_GUIDE.md](docs/STYLE_GUIDE.md) | Brand voice + design system |
| [FIREBASE_SETUP.md](docs/FIREBASE_SETUP.md) | Backend integration guide |
| [PRIVACY_POLICY_EN.md](docs/PRIVACY_POLICY_EN.md) | English privacy policy (PIPA) |
| [PRIVACY_POLICY_KR.md](docs/PRIVACY_POLICY_KR.md) | Korean 개인정보 처리방침 |
| [TERMS_OF_SERVICE_EN.md](docs/TERMS_OF_SERVICE_EN.md) | English terms of service |
| [TERMS_OF_SERVICE_KR.md](docs/TERMS_OF_SERVICE_KR.md) | Korean 이용약관 |
| [PHASE_0_CHECKLIST.md](docs/PHASE_0_CHECKLIST.md) | Phase 0 progress tracker |

**Total: 11 documents, 4,500+ lines**

## Roadmap

**Key Milestones:**
- **v0.1.0** (Current) – Phase 0 complete (95%)
- **v1.0.0** (Week 10) – Public iOS release (App Store KR)
- **v1.1.0** (Month 5) – Refinements + A/B testing
- **v2.0.0** (Month 8) – Android port + Cloud sync
- **v2.1.0** (Month 11) – ChatGPT App integration
- **v3.0.0** (Year 2) – Predictive AI + Ecosystem

See [CHANGELOG.md](CHANGELOG.md) for detailed roadmap.

## Localization

The app supports Korean and English:
- Korean: `ko.lproj/Localizable.strings`
- English: `en.lproj/Localizable.strings`

## Design Philosophy

**Brand Voice:** Calm, precise, empathetic
**UX Principles:**
- Simple gestures (swipe → done)
- Minimal cognitive load
- Proactive but not annoying
- Respectful of user time

## Monetization

- Free tier: Up to 5 items with ads
- Premium unlock: ₩4,900 one-time
  - Unlimited items
  - Ad-free experience
  - Cloud backup (future)
  - Family sharing (future)

## Contributing

This is a private project for now. Contributions will be opened after v1.0.0 public release.

## License

Proprietary – All rights reserved

## Acknowledgments

- **Built with:** Claude Code by Anthropic
- **Design System:** iOS Human Interface Guidelines
- **Localization:** Korean (PIPA-compliant) + English

---

## Quick Links

- **GitHub:** https://github.com/tskim611/rebuy-reminder-app
- **Issues:** https://github.com/tskim611/rebuy-reminder-app/issues
- **Changelog:** [CHANGELOG.md](CHANGELOG.md)
- **Testing:** [TESTING_GUIDE.md](docs/TESTING_GUIDE.md)
- **Roadmap:** See Phase 0-5 in [CHANGELOG.md](CHANGELOG.md)

---

**Built with Claude Code** 🤖 | **Current Version:** 0.1.0 (Phase 0 - 95% Complete)
