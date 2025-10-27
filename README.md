# 다 떨어지기 전에 (Before You Run Out)

A thoughtful iOS app that helps you remember to rebuy consumable items before you run out.

## Project Status

**Phase 0 – Setup & Identity** (Weeks 1-3) ✅ In Progress

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
│   ├── RebuyReminderApp.swift      # App entry point
│   ├── Models/
│   │   └── RebuyReminder.xcdatamodeld  # CoreData model
│   ├── Views/
│   │   ├── ContentView.swift        # Main home screen
│   │   ├── ItemRowView.swift        # Individual item row
│   │   ├── EmptyStateView.swift     # Empty state placeholder
│   │   ├── AddItemView.swift        # Add/edit item form
│   │   └── SettingsView.swift       # Settings & preferences
│   ├── Services/
│   │   └── PersistenceController.swift  # CoreData stack
│   ├── Localization/
│   │   ├── en.lproj/
│   │   └── ko.lproj/
│   ├── Resources/
│   └── Info.plist
└── RebuyReminder.xcodeproj/
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

1. Open the project in Xcode:
   ```bash
   cd RebuyReminder
   open RebuyReminder.xcodeproj
   ```

2. Select your target device/simulator

3. Build and run (⌘R)

### Next Steps

**Phase 0 Remaining Tasks:**
- [ ] Create Figma wireframes for core screens
- [ ] Draft Privacy Policy (PIPA-compliant, KR/EN)
- [ ] Draft Terms of Service
- [ ] Register Apple Developer Account
- [ ] Set up Firebase project (dev environment)

**Phase 1 – MVP Build (Weeks 4-10):**
- [ ] Implement UNUserNotificationCenter scheduling
- [ ] Build reminder service with notification triggers
- [ ] Add Firebase Analytics integration
- [ ] Implement StoreKit in-app purchase (₩4,900 unlock)
- [ ] Create App Store assets (screenshots, descriptions)
- [ ] TestFlight beta deployment

## Roadmap

See the [full roadmap](ROADMAP.md) for detailed planning through Year 2.

**Key Milestones:**
- **Month 3:** Public iOS release (App Store KR)
- **Month 6:** Android port via Flutter
- **Month 9:** ChatGPT App integration
- **Year 2:** Predictive AI, affiliate links, voice assistant

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

## License

Proprietary – All rights reserved

## Contact

For questions or feedback, please contact [your email/support channel]

---

**Built with Claude Code** 🤖
