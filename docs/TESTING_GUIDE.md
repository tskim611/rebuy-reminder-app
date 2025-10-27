# Testing Guide

**다 떨어지기 전에 (Before You Run Out)**

Comprehensive guide for testing the app on Xcode Simulator and physical devices.

---

## Prerequisites

### Required
- macOS 12.0+ (Monterey or later)
- Xcode 14.0+ installed
- iOS Simulator or physical iOS device (iOS 15.0+)

### Optional
- Apple Developer Account (for device testing)
- Physical iPhone/iPad (for haptic feedback and real notifications)

---

## Setup & Build

### Step 1: Open Project in Xcode

```bash
cd /path/to/rebuy-reminder-app/RebuyReminder
open RebuyReminder.xcodeproj
```

**Or:**
- Launch Xcode
- File → Open
- Navigate to `RebuyReminder/RebuyReminder.xcodeproj`

### Step 2: Configure Project Settings

1. **Select project** in Project Navigator (⌘1)
2. **Select "RebuyReminder" target**
3. **Signing & Capabilities:**
   - Team: Select your Apple ID or "Add Account..."
   - Bundle Identifier: `com.yourcompany.rebuyreminder` (change if needed)
   - Signing: ✅ Automatically manage signing

### Step 3: Select Simulator

1. Click device selector in toolbar (top-left)
2. Recommended: **iPhone 14 Pro (iOS 16.0+)**
3. Or any iPhone running iOS 15.0+

### Step 4: Build & Run

- Press **⌘R** or click Play button
- Wait for build to complete (~30-60 seconds first time)
- Simulator will launch automatically

**Expected Result:**
- App launches with dark theme
- Navigation title: "다 떨어지기 전에"
- Empty state visible ("No items yet")

---

## Manual Testing Scenarios

### Test 1: First Launch & Permissions

**Steps:**
1. Launch app (first time)
2. Wait for notification permission alert

**Expected:**
- System alert appears: "다 떨어지기 전에 Would Like to Send You Notifications"
- Two buttons: "Don't Allow" and "Allow"

**Action:**
- Tap **"Allow"**

**Verify:**
- Alert dismisses
- No visible change in UI (permission granted in background)

**Reset Test:**
- Delete app from Simulator: Long-press icon → Remove App
- Simulator → Settings → Notifications → Reset permission

---

### Test 2: Add First Item

**Steps:**
1. Tap **+ (blue circle icon)** in top-right
2. Sheet slides up: "Add Item"

**Form Input:**
- **Item name:** "Toothpaste"
- **Category:** Select "Personal Care"
- **Last purchased:** Today's date (default)
- **Rebuy cycle:** 60 days (adjust stepper)
- **Notes:** (leave blank)

**Verify During Input:**
- "Next reminder" updates as you change cycle days
- "Save" button disabled when name is empty
- "Save" button enabled after typing name

**Action:**
- Tap **"Save"**

**Expected:**
- Sheet dismisses
- Item appears in list with:
  - 🟢 Green status dot
  - "Toothpaste" (Headline font)
  - "Personal Care" (Caption, gray)
  - "60 days remaining" (Green)
  - [Rebought] button (blue)

**Verify Notification:**
- Check console for: "✅ Notification scheduled for Toothpaste on [date]"

---

### Test 3: Add Multiple Items

**Add these items:**

| Name | Category | Cycle | Expected Status |
|------|----------|-------|----------------|
| Coffee | Pantry | 30 days | 🟢 Green (30 days) |
| Vitamins | Health | 90 days | 🟢 Green (90 days) |
| Shampoo | Personal Care | 45 days | 🟢 Green (45 days) |

**Expected:**
- All items appear in list
- Sorted by lastPurchaseDate (ascending)
- Each has correct category and cycle
- All have green dots (all > 7 days remaining)

---

### Test 4: Status Color Logic

To test orange and red states, we need to simulate items with shorter cycles:

**Add Test Item:**
- Name: "Test Item (Orange)"
- Cycle: 5 days
- Last purchased: Today

**Expected:**
- 🟠 Orange dot
- "5 days remaining" (orange text)

**Add Test Item:**
- Name: "Test Item (Red)"
- Cycle: 0 days (or edit later)
- Last purchased: Today

**Expected:**
- 🔴 Red dot
- "Time to rebuy!" (red text)

**Status Rules:**
- 🟢 Green: 8+ days remaining
- 🟠 Orange: 1-7 days remaining
- 🔴 Red: ≤0 days remaining (overdue)

---

### Test 5: Mark as Rebought

**Steps:**
1. Find any item in list
2. Tap **[Rebought]** button

**Expected Immediate:**
- ✅ Haptic feedback (if on device)
- Item updates instantly:
  - Status dot changes to green
  - Days remaining resets to full cycle
  - Example: "60 days remaining"

**Verify in Console:**
- "✅ Notification scheduled for [item] at [new date]"

**Verify Persistence:**
1. Force-quit app (swipe up in App Switcher)
2. Relaunch app
3. Item still shows updated date

---

### Test 6: Swipe to Delete

**Steps:**
1. Swipe **left** on any item
2. Red "Delete" button appears

**Expected:**
- Button slides in from right
- Trash icon visible
- Red background

**Action:**
- Tap **Delete**

**Expected:**
- Item removes with animation
- Other items shift up
- If last item: Empty state appears

**Verify in Console:**
- "🗑 Notification cancelled for item: [name]"

**Verify Persistence:**
- Force-quit and relaunch
- Deleted item stays deleted

---

### Test 7: Empty State After Deletion

**Steps:**
1. Delete all items (swipe left → Delete)

**Expected:**
- Empty state appears:
  - 🛒 Cart icon (gray, large)
  - "No items yet"
  - "Tap + to add your first item to track"

**Verify:**
- No items in list
- + button still functional
- Settings button still accessible

---

### Test 8: Settings Screen

**Steps:**
1. Tap **⚙️ (gear icon)** in top-right
2. Settings sheet slides up

**Verify Sections:**

**Notifications:**
- ✅ "Enable Reminders" toggle (ON by default)
- → "Notification Settings" link

**Appearance:**
- ✅ "Dark Mode" toggle (ON by default)

**Premium:**
- "Unlock Premium - ₩4,900" button (blue)
- "Unlimited items + Ad-free experience" (gray caption)

**About:**
- "Version" → "1.0.0"
- "Privacy Policy" button
- "Terms of Service" button
- "Contact Support" button

**Action:**
- Tap **Done**

**Expected:**
- Sheet dismisses
- Returns to Home

---

### Test 9: Notification Settings

**Steps:**
1. Settings → Notification Settings
2. Push navigation (back button appears)

**Verify:**
- "Reminder Time" DatePicker (default: 9:00 AM)
- "Remind X days before" Stepper (default: 3)
- Footer text: "You will receive notifications at the selected time..."

**Test Changes:**
- Change time to 8:00 AM
- Change days before to 5

**Expected:**
- Changes save immediately (AppStorage)

**Action:**
- Tap **< Back**
- Tap **Done**

**Verify:**
- Settings persist after relaunch

---

### Test 10: Dark Mode Toggle

**Steps:**
1. Settings → Dark Mode toggle
2. Toggle **OFF**

**Expected:**
- Instant color scheme change
- Background: White
- Text: Black
- Cards: Light gray

**Toggle Back ON:**
- Background: Black
- Text: White
- Cards: Dark gray

**Note:** Simulator might override with system appearance. Test on device for accurate results.

---

### Test 11: Badge Count

**Setup:**
1. Add item: "Badge Test" with 0-day cycle (overdue)

**Expected:**
- App icon badge shows "1"

**Add Another Overdue:**
- Add item: "Badge Test 2" with 0-day cycle

**Expected:**
- Badge shows "2"

**Mark One as Rebought:**
- Tap [Rebought] on one item

**Expected:**
- Badge reduces to "1"

**Verify in Console:**
- "🔔 Badge count updated: X"

**Clear All:**
- Mark both as rebought or delete

**Expected:**
- Badge clears (no number)

---

### Test 12: Notification Delivery (Simulator Limitations)

**⚠️ Important:** Simulator has limited notification support. For full testing, use a physical device.

**Simulator Test (Scheduled Notifications):**
1. Add item with very short cycle (e.g., 1 minute from now)
2. Background the app (⌘⇧H)
3. Wait for notification time

**Expected (Device Only):**
- Notification banner appears
- Title: "[Item name]"
- Body: "Time to rebuy – last purchased X days ago"

**Simulator Workaround:**
- Use `xcrun simctl push` to send test notification
- See "Advanced Testing" section below

---

### Test 13: Localization (Korean)

**Steps:**
1. Simulator → Settings → General → Language & Region
2. iPhone Language → 한국어
3. Relaunch app

**Expected:**
- Navigation title: "다 떨어지기 전에"
- Empty state: "아직 항목이 없습니다"
- Add button: "항목 추가"
- Categories in Korean
- Notification content in Korean

**Test Both:**
- English (default)
- Korean (한국어)

**Reset:**
- Change back to English for remaining tests

---

### Test 14: Rotation & iPad Support

**iPhone:**
1. Rotate simulator (⌘← or ⌘→)

**Expected:**
- Portrait: Optimized layout
- Landscape: Content adjusts (may be cramped on small screens)

**iPad:**
1. Select iPad simulator (iPad Pro 12.9")
2. Run app

**Expected:**
- Wider layout
- Navigation bar scales appropriately
- Content remains readable

---

### Test 15: VoiceOver Accessibility

**Steps:**
1. Simulator → Settings → Accessibility → VoiceOver → ON
2. Or: Accessibility Inspector (Xcode → Developer Tools)

**Test Elements:**
- + button: "Add item, Opens form to add new item"
- ⚙️ button: "Settings, Opens app settings"
- Item card: "[Item name], [category], [X days remaining]"
- Rebought button: "Mark as rebought, Resets purchase cycle to today"

**Navigate:**
- Two-finger swipe: Scroll
- Single tap: Select
- Double-tap: Activate

**Verify:**
- All interactive elements have labels
- Status is read aloud
- Navigation is logical (top to bottom)

---

### Test 16: Dynamic Type (Text Scaling)

**Steps:**
1. Simulator → Settings → Accessibility → Display & Text Size
2. Larger Text → Move slider to max

**Expected:**
- All text scales up
- Layout adjusts (may overflow on small text)
- Buttons remain tappable (44pt minimum)

**Test Sizes:**
- Default (body 17pt)
- Large (accessibility)
- Extra Large (accessibility)

**Verify:**
- No text cutoffs
- No overlapping elements

---

### Test 17: Memory & Performance

**Xcode Instruments:**
1. Product → Profile (⌘I)
2. Select "Leaks" or "Allocations"
3. Record while using app

**Test Actions:**
- Add 20+ items
- Scroll list rapidly
- Open/close sheets repeatedly
- Toggle settings

**Expected:**
- No memory leaks
- Smooth 60fps scrolling
- Sheet animations are fluid

**Debug View Hierarchy:**
- Debug → View Debugging → Capture View Hierarchy
- Check for overdraw or layout issues

---

### Test 18: CoreData Persistence

**Steps:**
1. Add 5 items with various data
2. Force-quit app (⌘⇧H twice, swipe up)
3. Relaunch app

**Expected:**
- All items persist
- Same order
- Same dates and cycles

**Test Data Loss:**
1. Delete app from Simulator
2. Reinstall (run again from Xcode)

**Expected:**
- Fresh install: Empty state
- All data cleared (expected behavior)

---

### Test 19: Edge Cases

**Empty Item Name:**
- Try to save with blank name
- **Expected:** Save button disabled

**Very Long Item Name:**
- Enter 200+ characters
- **Expected:** Text wraps or truncates

**Future Date (Last Purchased):**
- Set date picker to tomorrow
- **Expected:** Allows (no validation currently)
- **Note:** Consider adding validation in Phase 1

**Max Cycle Days:**
- Set cycle to 365 days (max)
- **Expected:** Accepts and calculates correctly

**Min Cycle Days:**
- Set cycle to 1 day (min)
- **Expected:** Accepts and schedules notification

**Negative Days Remaining:**
- Item purchased 60 days ago, 30-day cycle
- **Expected:** Shows "Time to rebuy!" (red)

---

### Test 20: Notification Permission Denied

**Steps:**
1. Fresh install (delete app)
2. Launch app
3. Tap **"Don't Allow"** on permission alert

**Expected:**
- App continues to work
- Items save correctly
- **But:** No notifications scheduled

**Verify in Console:**
- "⚠️ Notification date is in the past, skipping: [item]"
- Or permission denied error

**Re-enable:**
- Settings → Notifications Settings toggle
- Triggers permission request again
- Or: System Settings → Notifications → 다 떨어지기 전에 → Allow

---

## Advanced Testing

### Push Notification Simulation (Simulator)

**Step 1: Get Device Token**
```swift
// Add to NotificationService.swift (temporarily)
UNUserNotificationCenter.current().getNotificationSettings { settings in
    print("📱 Notification settings: \(settings)")
}
```

**Step 2: Create Test Payload**
Create `test_notification.json`:
```json
{
  "Simulator Target Bundle": "com.yourcompany.rebuyreminder",
  "aps": {
    "alert": {
      "title": "Toothpaste",
      "body": "Time to rebuy – last purchased 60 days ago"
    },
    "badge": 1,
    "sound": "default"
  }
}
```

**Step 3: Send Notification**
```bash
xcrun simctl push booted com.yourcompany.rebuyreminder test_notification.json
```

**Expected:**
- Notification banner appears in Simulator
- Badge updates
- Console logs appear

---

### Testing Notification Actions

**On Device Only:**
1. Receive notification
2. Long-press or swipe notification
3. See actions: "Rebought" and "Remind Me Later"

**Expected (Phase 1 - Not Implemented Yet):**
- Tap "Rebought" → Item updates
- Tap "Remind Later" → Notification reschedules

---

### Stress Testing

**Add 100 Items:**
```swift
// Run in Xcode playground or temporary button
for i in 1...100 {
    let item = Item(context: viewContext)
    item.id = UUID()
    item.name = "Test Item \(i)"
    item.category = "Test"
    item.lastPurchaseDate = Date()
    item.cycleDays = Int32.random(in: 1...365)
    item.notificationEnabled = true
}
try? viewContext.save()
```

**Expected:**
- List remains scrollable
- No lag
- Memory stable

**100 Notifications:**
- Verify UNUserNotificationCenter handles 64+ (system limit)
- Older notifications drop off (expected iOS behavior)

---

## Troubleshooting

### Build Errors

**Error: "No such module 'SwiftUI'"**
- **Fix:** Xcode → Preferences → Components → Install iOS Simulator

**Error: "Code signing failed"**
- **Fix:** Select your Apple ID in Signing & Capabilities
- Or: Change bundle identifier to unique value

**Error: "Sandbox access denied"**
- **Fix:** Clean build folder (⇧⌘K)
- Derived Data → Delete (Xcode → Preferences → Locations)

---

### Runtime Issues

**App Crashes on Launch:**
- **Check:** Console for error messages
- **Common:** CoreData model mismatch
- **Fix:** Delete app, clean build, reinstall

**Notifications Not Scheduling:**
- **Check:** Permission granted (Settings → Notifications)
- **Check:** Console for "⚠️ Notification date is in the past"
- **Fix:** Ensure notification date is in future

**Items Not Persisting:**
- **Check:** viewContext.save() called
- **Check:** CoreData stack initialized
- **Fix:** Verify PersistenceController.shared in App

**Dark Mode Not Working:**
- **Check:** Simulator appearance setting
- **Fix:** Simulator → Features → Toggle Appearance

---

### Simulator Issues

**Simulator Won't Launch:**
- **Fix:** Xcode → Window → Devices and Simulators
- Delete and re-add simulator

**Simulator Slow:**
- **Fix:** Reduce simulator count
- Allocate more RAM (Xcode → Preferences → Components)
- Restart Mac

**Keyboard Not Showing:**
- **Fix:** Hardware → Keyboard → Toggle Software Keyboard (⌘K)

---

## Testing Checklist (Pre-Release)

Copy this checklist for each build:

### Functionality
- [ ] App launches without crashes
- [ ] Add item creates and saves correctly
- [ ] Edit item updates correctly (Phase 2)
- [ ] Delete item removes and cancels notification
- [ ] Mark rebought resets cycle
- [ ] Notifications schedule correctly
- [ ] Badge count updates accurately
- [ ] Empty state displays when no items

### UI/UX
- [ ] Dark mode displays correctly
- [ ] Light mode displays correctly (toggle off)
- [ ] Navigation flows are intuitive
- [ ] Buttons have correct labels
- [ ] Status colors match spec (Green/Orange/Red)
- [ ] Haptic feedback works (device only)
- [ ] Animations are smooth

### Localization
- [ ] English displays correctly
- [ ] Korean displays correctly
- [ ] Notifications localized properly
- [ ] Date formats correct for locale

### Accessibility
- [ ] VoiceOver labels present
- [ ] Dynamic Type scales correctly
- [ ] Minimum tap targets (44pt)
- [ ] Sufficient color contrast (4.5:1)

### Data & Persistence
- [ ] CoreData saves persist after app restart
- [ ] Notifications persist after app restart
- [ ] Settings persist after app restart
- [ ] No data loss on force-quit

### Performance
- [ ] No memory leaks (Instruments)
- [ ] Scrolling is smooth (60fps)
- [ ] No UI jank or lag
- [ ] App launches in <3 seconds

### Edge Cases
- [ ] Empty item name blocked
- [ ] Very long names handled
- [ ] Max cycle days (365) works
- [ ] Min cycle days (1) works
- [ ] Overdue items show correct status

---

## Next Steps After Testing

### If Tests Pass:
1. Update `Info.plist` version to 1.0.0
2. Tag release: `git tag -a v1.0.0 -m "Release 1.0.0"`
3. Archive for App Store (Product → Archive)
4. Upload to App Store Connect

### If Tests Fail:
1. Document bugs in GitHub Issues
2. Fix critical blockers
3. Re-test
4. Update CHANGELOG.md with fixes

---

## Resources

- [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- [Testing on Simulators](https://developer.apple.com/documentation/xcode/running-your-app-in-simulator-or-on-a-device)
- [Push Notifications](https://developer.apple.com/documentation/usernotifications)
- [Accessibility Testing](https://developer.apple.com/accessibility/)

---

**Last Updated:** 2025-10-27
**Version:** 1.0
**Status:** Ready for Phase 0 Testing
