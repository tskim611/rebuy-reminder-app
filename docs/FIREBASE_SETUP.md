# Firebase Setup Guide

**For 다 떨어지기 전에 (Before You Run Out)**

This guide walks through setting up Firebase for analytics and future cloud features.

---

## Prerequisites

- Google account
- Xcode project (already created)
- CocoaPods or Swift Package Manager

---

## Phase 1: Create Firebase Project

### Step 1: Firebase Console

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project"
3. **Project name:** `rebuy-reminder-app`
4. **Google Analytics:** Enable (recommended)
   - Choose "Default Account for Firebase"
5. Click "Create project"

### Step 2: Add iOS App

1. In Firebase Console, click "Add app" → iOS
2. **iOS bundle ID:** `com.yourcompany.rebuyreminder`
   - ⚠️ Must match Xcode bundle identifier exactly
3. **App nickname:** "다 떨어지기 전에 (iOS)"
4. **App Store ID:** Leave blank for now (add after App Store submission)
5. Click "Register app"

### Step 3: Download Configuration

1. Download `GoogleService-Info.plist`
2. **Important:** Save this file securely
3. Add to Xcode:
   - Drag into `RebuyReminder/RebuyReminder/` folder
   - ✅ Check "Copy items if needed"
   - ✅ Select `RebuyReminder` target
4. Verify it's in the project navigator

---

## Phase 2: Install Firebase SDK

### Option A: Swift Package Manager (Recommended)

1. In Xcode: File → Add Packages...
2. Enter repository URL:
   ```
   https://github.com/firebase/firebase-ios-sdk
   ```
3. Version: Select "Up to Next Major Version" (10.0.0+)
4. Select packages:
   - ✅ FirebaseAnalytics
   - ✅ FirebaseCrashlytics (optional, for crash reporting)
   - ✅ FirebaseFirestore (for Phase 3 - cloud sync)
5. Click "Add Package"

### Option B: CocoaPods

1. Create `Podfile` in project root:
   ```ruby
   platform :ios, '15.0'
   use_frameworks!

   target 'RebuyReminder' do
     pod 'Firebase/Analytics'
     pod 'Firebase/Crashlytics'
     pod 'Firebase/Firestore'
   end
   ```

2. Install:
   ```bash
   pod install
   ```

3. Open `RebuyReminder.xcworkspace` (not `.xcodeproj`)

---

## Phase 3: Configure Firebase in Code

### Update `RebuyReminderApp.swift`

```swift
import SwiftUI
import Firebase

@main
struct RebuyReminderApp: App {
    let persistenceController = PersistenceController.shared

    init() {
        // Configure Firebase
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
```

---

## Phase 4: Analytics Events

### Create Analytics Service

Create `RebuyReminder/RebuyReminder/Services/AnalyticsService.swift`:

```swift
import Foundation
import FirebaseAnalytics

struct AnalyticsService {
    static let shared = AnalyticsService()

    private init() {}

    // Track item added
    func logItemAdded(category: String, cycleDays: Int) {
        Analytics.logEvent("item_added", parameters: [
            "category": category,
            "cycle_days": cycleDays
        ])
    }

    // Track rebuy action
    func logItemRebought(category: String, daysOverdue: Int) {
        Analytics.logEvent("item_rebought", parameters: [
            "category": category,
            "days_overdue": daysOverdue
        ])
    }

    // Track premium unlock
    func logPremiumPurchase() {
        Analytics.logEvent("premium_purchase", parameters: [:])
    }

    // Track notification interaction
    func logNotificationOpened(itemName: String) {
        Analytics.logEvent("notification_opened", parameters: [
            "item_name": itemName
        ])
    }

    // Screen views
    func logScreenView(_ screenName: String) {
        Analytics.logEvent(AnalyticsEventScreenView, parameters: [
            AnalyticsParameterScreenName: screenName
        ])
    }
}
```

### Integrate in Views

**In `AddItemView.swift`** (after saving):
```swift
private func saveItem() {
    withAnimation {
        // ... existing save code ...

        // Analytics
        AnalyticsService.shared.logItemAdded(
            category: category.isEmpty ? "Other" : category,
            cycleDays: cycleDays
        )

        dismiss()
    }
}
```

**In `ItemRowView.swift`** (in `markAsRebought`):
```swift
private func markAsRebought() {
    withAnimation {
        let daysOverdue = max(0, -daysUntilRebuy)

        item.lastPurchaseDate = Date()

        // Analytics
        AnalyticsService.shared.logItemRebought(
            category: item.category ?? "Other",
            daysOverdue: daysOverdue
        )

        // ... rest of existing code ...
    }
}
```

**In `ContentView.swift`** (in body):
```swift
.onAppear {
    AnalyticsService.shared.logScreenView("Home")
}
```

---

## Phase 5: Privacy & Compliance

### Update Privacy Policy

Ensure `PRIVACY_POLICY_KR.md` and `PRIVACY_POLICY_EN.md` mention:
- Firebase Analytics data collection
- Google Privacy Policy link
- Option to disable analytics (Settings)

### App Tracking Transparency (iOS 14.5+)

1. Add to `Info.plist`:
   ```xml
   <key>NSUserTrackingUsageDescription</key>
   <string>We use analytics to improve the app experience. No personal data is shared.</string>
   ```

2. Request permission (optional for Firebase Analytics):
   ```swift
   import AppTrackingTransparency

   // In ContentView or Settings
   ATTrackingManager.requestTrackingAuthorization { status in
       // Handle response
   }
   ```

### Analytics Opt-Out

Add toggle in `SettingsView.swift`:

```swift
@AppStorage("analyticsEnabled") private var analyticsEnabled = true

// In Settings Form
Section(header: Text("Privacy")) {
    Toggle("Usage Analytics", isOn: $analyticsEnabled)
        .onChange(of: analyticsEnabled) { newValue in
            Analytics.setAnalyticsCollectionEnabled(newValue)
        }
}
```

---

## Phase 6: Testing & Verification

### Debug Mode

Enable debug mode to see real-time events:

1. In Xcode, edit scheme: Product → Scheme → Edit Scheme
2. Run → Arguments → Arguments Passed On Launch
3. Add: `-FIRDebugEnabled`

### DebugView in Console

1. Go to Firebase Console → Analytics → DebugView
2. Run app on simulator/device
3. Verify events appear in real-time

### Test Events

1. Add an item → Check `item_added` event
2. Mark as rebought → Check `item_rebought` event
3. Navigate screens → Check `screen_view` events

---

## Phase 7: Firestore Setup (Future - Phase 3)

### Enable Firestore

1. Firebase Console → Build → Firestore Database
2. Click "Create database"
3. **Mode:** Start in test mode (change to production later)
4. **Location:** `asia-northeast3` (Seoul)
5. Click "Enable"

### Security Rules (Initial)

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Only authenticated users can read/write their own data
    match /users/{userId}/{document=**} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

### Data Structure (Planned)

```
users/
  {userId}/
    items/
      {itemId}/
        - id: string
        - name: string
        - category: string
        - lastPurchaseDate: timestamp
        - cycleDays: number
        - notes: string
        - createdDate: timestamp
```

---

## Cost Estimation

### Free Tier Limits (Sufficient for MVP)

**Analytics:**
- Unlimited events
- 500 distinct events

**Firestore:**
- 1 GB storage
- 50,000 reads/day
- 20,000 writes/day
- 20,000 deletes/day

**Crashlytics:**
- Unlimited crash reports

### Paid Tier (Blaze - Pay as you go)

Upgrade when:
- Users exceed 10,000 MAU
- Firestore operations exceed free tier

**Estimated cost for 10K MAU:**
- ≈ $20-50/month (mostly Firestore operations)

---

## Environment Setup

### Development vs. Production

Create two Firebase projects:

1. **Development:** `rebuy-reminder-dev`
   - Use for testing
   - Separate analytics data

2. **Production:** `rebuy-reminder-prod`
   - Live app
   - Real user data

**Switch between environments:**
- Use different `GoogleService-Info.plist` files
- Configure via Xcode build schemes

---

## Troubleshooting

### Common Issues

**Error: "FirebaseApp.configure() not called"**
- Ensure `FirebaseApp.configure()` is in app init
- Verify `GoogleService-Info.plist` is in target

**Events not appearing in DebugView:**
- Check debug mode is enabled (`-FIRDebugEnabled`)
- Wait 1-2 minutes for propagation
- Verify network connection

**Build errors after adding Firebase:**
- Clean build folder (⇧⌘K)
- Delete DerivedData
- Restart Xcode

---

## Next Steps

1. ✅ Create Firebase project
2. ✅ Add `GoogleService-Info.plist` to Xcode
3. ✅ Install Firebase SDK
4. ✅ Configure in `RebuyReminderApp.swift`
5. ✅ Create `AnalyticsService.swift`
6. ✅ Integrate analytics in key views
7. ✅ Test in DebugView
8. ⏳ (Phase 3) Enable Firestore for cloud sync
9. ⏳ (Phase 3) Implement authentication

---

## Security Checklist

- [ ] `GoogleService-Info.plist` added to `.gitignore`
- [ ] Firestore security rules configured (when enabled)
- [ ] Analytics opt-out toggle in Settings
- [ ] Privacy Policy updated with Firebase mention
- [ ] App Tracking Transparency (if needed)

---

## Resources

- [Firebase iOS Setup](https://firebase.google.com/docs/ios/setup)
- [Firebase Analytics](https://firebase.google.com/docs/analytics/ios/start)
- [Firestore Docs](https://firebase.google.com/docs/firestore)
- [Firebase Console](https://console.firebase.google.com/)

---

**Questions?** Check Firebase documentation or contact the dev team.
