# Changelog

All notable changes to 다 떨어지기 전에 (Before You Run Out) will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [Unreleased]

### Phase 1 - MVP Build (In Progress)
- Firebase Analytics integration
- StoreKit in-app purchase implementation
- App Store assets & screenshots

---

## [1.0] - Build 9 - 2025-11-03

### Beta Feedback Fixes

#### Fixed
- **Time Calculation** - Fixed date calculations to use KST (Korea Standard Time) instead of device timezone
  - Ensures consistent notification scheduling for Korean users
  - Fixes edge cases where timezone differences caused incorrect due date calculations

- **Card Tap Behavior** - Fixed item card tap interaction
  - Only the "재구매함" (Rebought) button triggers the rebuy action
  - Tapping the card itself no longer accidentally marks items as rebought
  - Improved user control and prevents accidental actions

#### Added
- **Motion Animations** - Enhanced user experience with smooth animations
  - Button scale animation on tap for better tactile feedback
  - Card entry animations when items are added
  - Smooth delete animations when removing items
  - All animations follow iOS design guidelines

---

## [0.1.0] - 2025-10-27

### Phase 0 - Setup & Identity

#### Added
- **Project Foundation**
  - iOS project structure with SwiftUI and CoreData
  - Git repository initialized and pushed to GitHub
  - Comprehensive .gitignore for iOS development

- **Core Data Model**
  - Item entity with attributes: id, name, category, lastPurchaseDate, cycleDays, notes, isCompleted, createdDate, notificationEnabled
  - PersistenceController with preview support for SwiftUI previews

- **User Interface**
  - ContentView (Home screen) with item list and empty state
  - ItemRowView with status indicators (Green/Orange/Red) and swipe-to-delete
  - AddItemView with form for creating items
  - EmptyStateView with cart icon and onboarding message
  - SettingsView with notifications, appearance, premium, and about sections
  - NotificationSettingsView for customizing reminder timing

- **Notification System**
  - NotificationService.swift with UNUserNotificationCenter integration
  - Schedule notifications 3 days before rebuy date (configurable)
  - Auto-reschedule when items marked as rebought
  - Cancel notifications when items deleted
  - Badge count management based on overdue items
  - Notification categories with actions: "Rebought" and "Remind Later"
  - Permission request on first launch

- **Localization**
  - English (en) and Korean (ko) support
  - Localizable.strings for all user-facing text
  - Korean app name: "다 떨어지기 전에"
  - Localized notification content

- **Documentation**
  - README.md with project overview and setup instructions
  - PRIVACY_POLICY_EN.md and PRIVACY_POLICY_KR.md (PIPA-compliant)
  - TERMS_OF_SERVICE_EN.md and TERMS_OF_SERVICE_KR.md
  - STYLE_GUIDE.md with brand voice, design system, and accessibility guidelines
  - FIREBASE_SETUP.md with step-by-step Firebase integration guide
  - WIREFRAMES.md with ASCII wireframes, user flows, and interaction patterns
  - PHASE_0_CHECKLIST.md for tracking Phase 0 completion

- **Design System**
  - Dark mode by default (preferredColorScheme: .dark)
  - Status color coding: Green (8+ days), Orange (1-7 days), Red (overdue)
  - SF Symbols icon set
  - Haptic feedback on "Rebought" action (medium impact)
  - 12pt corner radius cards with 16pt padding
  - System font (San Francisco) with dynamic type support

#### Technical Details
- **Minimum iOS Version:** 15.0+
- **Language:** Swift 5
- **Architecture:** MVVM with SwiftUI
- **Persistence:** CoreData (local-only in Phase 0)
- **Notifications:** UNUserNotificationCenter
- **Target Devices:** iPhone, iPad (portrait + landscape)

#### Known Limitations
- No cloud sync (Phase 3)
- No Firebase Analytics yet (Phase 1)
- No StoreKit premium unlock yet (Phase 1)
- No iCloud sync (Phase 3)
- Premium features not implemented (placeholder in Settings)
- Privacy Policy and TOS links not functional (placeholder buttons)

---

## Version History

### Version Numbering

- **Major.Minor.Patch** (e.g., 1.0.0)
- **Major:** Breaking changes, major features
- **Minor:** New features, non-breaking changes
- **Patch:** Bug fixes, minor improvements

### Release Cadence

- **Phase 0 (Weeks 1-3):** v0.1.0 - Foundation
- **Phase 1 (Weeks 4-10):** v1.0.0 - MVP Public Release
- **Phase 2 (Months 3-5):** v1.1.0 - Refinements
- **Phase 3 (Months 6-8):** v2.0.0 - Android + Cloud Sync
- **Phase 4 (Months 9-11):** v2.1.0 - ChatGPT App Integration
- **Phase 5 (Year 2):** v3.0.0 - AI & Ecosystem

---

## Roadmap

### v1.0.0 - MVP (Phase 1) - ETA: Week 10
- [ ] Firebase Analytics integration
- [ ] UNUserNotificationCenter implementation (✅ Complete)
- [ ] StoreKit in-app purchase (₩4,900 one-time)
- [ ] App Store Connect listing
- [ ] TestFlight beta (300 users)
- [ ] 6 localized screenshots (KR/EN)

**Success Criteria:**
- ≥30% D7 retention
- No crash reports
- >4.3★ average rating

### v1.1.0 - Refinements (Phase 2) - ETA: Month 5
- [ ] Auto-interval suggestion (ML-based)
- [ ] A/B testing for pricing (₩2,900 vs ₩4,900)
- [ ] Enhanced onboarding flow
- [ ] Widget support (iOS Home Screen)
- [ ] Siri Shortcuts integration

**KPI Targets:**
- 5,000 downloads
- 1,500 MAU
- ≥5% paid conversion

### v2.0.0 - Cross-Platform (Phase 3) - ETA: Month 8
- [ ] Firebase Firestore backend
- [ ] Android app (Flutter)
- [ ] Cross-device sync (iCloud + Firestore)
- [ ] Family sharing mode
- [ ] Cloud backup

### v2.1.0 - ChatGPT App (Phase 4) - ETA: Month 11
- [ ] ChatGPT App Store integration
- [ ] REST API for ChatGPT bridge
- [ ] Conversational item management
- [ ] Email/chat secondary reminders

### v3.0.0 - AI & Ecosystem (Phase 5) - ETA: Year 2
- [ ] Predictive cycle AI (Claude API)
- [ ] Retailer affiliate links (Coupang, Kurly)
- [ ] Voice assistant (Alexa, Google Home)
- [ ] Subscription tier (₩1,900/month)

---

## Migration Notes

### v0.1.0 → v1.0.0
- No data migration needed (first public release)
- CoreData schema unchanged
- Notifications automatically scheduled on upgrade

### Future Migrations
- v1.x → v2.0.0: Local CoreData → Firestore sync (optional)
- v2.x → v3.0.0: Add AI prediction fields to schema

---

## Deprecation Notices

None at this time.

---

## Contributors

- **Development:** Built with Claude Code
- **Design:** Phase 0 style guide
- **Legal:** Privacy Policy & TOS (requires review)

---

## Links

- **GitHub:** https://github.com/tskim611/rebuy-reminder-app
- **Issues:** https://github.com/tskim611/rebuy-reminder-app/issues
- **Roadmap:** See `docs/PHASE_0_CHECKLIST.md`
- **Docs:** See `docs/` folder

---

## Notes

### Release Process
1. Update version in `Info.plist` (CFBundleShortVersionString)
2. Update build number (CFBundleVersion)
3. Update CHANGELOG.md with release notes
4. Tag release in Git: `git tag -a v1.0.0 -m "Release 1.0.0"`
5. Push tag: `git push origin v1.0.0`
6. Build archive in Xcode
7. Upload to App Store Connect
8. Submit for review

### Testing Checklist (Pre-Release)
- [ ] All SwiftUI previews render correctly
- [ ] CoreData CRUD operations work
- [ ] Notifications schedule and fire correctly
- [ ] Localization displays properly (KR/EN)
- [ ] Dark mode renders correctly
- [ ] Haptic feedback works on device
- [ ] Settings persist across app restarts
- [ ] No memory leaks or crashes
- [ ] VoiceOver accessibility works
- [ ] Dynamic Type scales correctly

---

**Last Updated:** 2025-10-27
**Current Version:** 0.1.0 (Phase 0 Complete)
**Next Release:** 1.0.0 (Phase 1 - MVP)
