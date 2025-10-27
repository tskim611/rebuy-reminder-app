# Wireframes & User Flows

**다 떨어지기 전에 (Before You Run Out)**

Visual specifications for all core screens and interactions.

---

## Screen 1: Home Screen (ContentView)

### Layout Structure

```
┌─────────────────────────────────────┐
│  ☰  다 떨어지기 전에        ⚙️  ➕   │  ← Navigation Bar
├─────────────────────────────────────┤
│                                     │
│  ┌───────────────────────────────┐  │
│  │ 🟢 Toothpaste               │  │
│  │    Personal Care             │  │
│  │    23 days remaining         │  │
│  │                   [Rebought] │  │  ← Item Card (Green)
│  └───────────────────────────────┘  │
│                                     │
│  ┌───────────────────────────────┐  │
│  │ 🟠 Coffee                    │  │
│  │    Pantry                    │  │
│  │    5 days remaining          │  │
│  │                   [Rebought] │  │  ← Item Card (Orange)
│  └───────────────────────────────┘  │
│                                     │
│  ┌───────────────────────────────┐  │
│  │ 🔴 Vitamins                  │  │
│  │    Health                    │  │
│  │    Time to rebuy!            │  │
│  │                   [Rebought] │  │  ← Item Card (Red)
│  └───────────────────────────────┘  │
│                                     │
│  ┌───────────────────────────────┐  │
│  │ 🟢 Shampoo                   │  │
│  │    Personal Care             │  │
│  │    15 days remaining         │  │
│  │                   [Rebought] │  │  ← Item Card (Green)
│  └───────────────────────────────┘  │
│                                     │
└─────────────────────────────────────┘
```

### Components Breakdown

**Navigation Bar:**
- Title: "다 떨어지기 전에" (Large Title, Bold, White)
- Left: None (or hamburger menu in future)
- Right:
  - Settings icon (⚙️) → Opens Settings sheet
  - Add button (➕, Blue) → Opens Add Item sheet

**Item Card:**
```
┌───────────────────────────────────┐
│ [Dot] [Item Name]     [Button]   │
│       [Category]                  │
│       [Status Text]               │
└───────────────────────────────────┘
```

Components:
- **Status Dot:** 12×12pt circle
  - 🟢 Green: 8+ days remaining
  - 🟠 Orange: 1-7 days remaining
  - 🔴 Red: Overdue (≤0 days)

- **Item Name:** Headline font, White

- **Category:** Caption font, Gray

- **Status Text:** Subheadline font, Status color
  - "X days remaining" or "Time to rebuy!"

- **Rebought Button:** Blue, Semibold
  - Tap: Haptic feedback + reset cycle
  - Updates lastPurchaseDate to today

**Card Styling:**
- Background: Gray 6 (30% opacity)
- Padding: 16pt
- Corner radius: 12pt
- Spacing: 12pt between cards

**Gestures:**
- **Swipe left** → Delete button appears
- **Tap card** → Future: Edit item (Phase 2)
- **Tap Rebought** → Reset cycle with animation

---

### Empty State

```
┌─────────────────────────────────────┐
│  ☰  다 떨어지기 전에        ⚙️  ➕   │
├─────────────────────────────────────┤
│                                     │
│                                     │
│              🛒                     │  ← Large cart icon
│                                     │
│         No items yet                │  ← Title (White)
│                                     │
│   Tap + to add your first item      │  ← Subtitle (Gray)
│         to track                    │
│                                     │
│                                     │
└─────────────────────────────────────┘
```

**Empty State Components:**
- Icon: `cart.badge.plus` (70pt, Gray)
- Title: "No items yet" (Title 2, White)
- Subtitle: "Tap + to add your first item to track" (Body, Gray)

---

## Screen 2: Add Item Screen (AddItemView)

### Layout Structure

```
┌─────────────────────────────────────┐
│  Cancel      Add Item         Save  │  ← Navigation Bar
├─────────────────────────────────────┤
│                                     │
│  ┌─── Item Details ──────────────┐  │
│  │                               │  │
│  │  Item name                    │  │
│  │  ┌─────────────────────────┐  │  │
│  │  │ [Text input field]      │  │  │
│  │  └─────────────────────────┘  │  │
│  │                               │  │
│  │  Category                     │  │
│  │  ┌─────────────────────────┐  │  │
│  │  │ Select category      ▼  │  │  │  ← Picker
│  │  └─────────────────────────┘  │  │
│  │                               │  │
│  │  Last purchased               │  │
│  │  ┌─────────────────────────┐  │  │
│  │  │ Oct 27, 2025         📅 │  │  │  ← Date Picker
│  │  └─────────────────────────┘  │  │
│  │                               │  │
│  └───────────────────────────────┘  │
│                                     │
│  ┌─── Reminder Settings ─────────┐  │
│  │                               │  │
│  │  Rebuy cycle: 30 days         │  │
│  │  ┌─────────────────────────┐  │  │
│  │  │  [- ]   30   [ + ]      │  │  │  ← Stepper
│  │  └─────────────────────────┘  │  │
│  │                               │  │
│  │  Next reminder: Nov 26, 2025  │  │  ← Calculated
│  │                               │  │
│  └───────────────────────────────┘  │
│                                     │
│  ┌─── Notes (Optional) ──────────┐  │
│  │                               │  │
│  │  ┌─────────────────────────┐  │  │
│  │  │ [Multi-line text input] │  │  │
│  │  │                         │  │  │  ← Text Editor
│  │  │                         │  │  │
│  │  └─────────────────────────┘  │  │
│  │                               │  │
│  └───────────────────────────────┘  │
│                                     │
└─────────────────────────────────────┘
```

### Form Sections

**Section 1: Item Details**
- **Item name:** TextField (required)
  - Placeholder: "Item name"
  - Auto-capitalization: Words
  - Clear button when typing

- **Category:** Picker (optional)
  - Options: Select category, Health, Pantry, Personal Care, Household, Pet Care, Other
  - Default: "Select category"

- **Last purchased:** DatePicker
  - Display: Date only (no time)
  - Default: Today
  - Format: "Oct 27, 2025"

**Section 2: Reminder Settings**
- **Rebuy cycle:** Stepper
  - Label: "Rebuy cycle: X days"
  - Range: 1-365 days
  - Default: 30 days
  - Step: 1 day

- **Next reminder:** Read-only text
  - Calculated: Last purchased + Cycle days
  - Format: "Nov 26, 2025"
  - Font: Caption, Gray

**Section 3: Notes (Optional)**
- **Notes:** TextEditor
  - Placeholder: None (section header says optional)
  - Height: 80pt
  - Multi-line

**Navigation Actions:**
- **Cancel:** Dismiss sheet without saving
- **Save:** Create item + dismiss
  - Disabled if item name is empty
  - Haptic feedback on save

---

## Screen 3: Settings Screen (SettingsView)

### Layout Structure

```
┌─────────────────────────────────────┐
│                Settings        Done │  ← Navigation Bar
├─────────────────────────────────────┤
│                                     │
│  ┌─── Notifications ─────────────┐  │
│  │                               │  │
│  │  Enable Reminders       [ON]  │  │  ← Toggle
│  │                               │  │
│  │  Notification Settings    >   │  │  ← Navigation Link
│  │                               │  │
│  └───────────────────────────────┘  │
│                                     │
│  ┌─── Appearance ────────────────┐  │
│  │                               │  │
│  │  Dark Mode              [ON]  │  │  ← Toggle
│  │                               │  │
│  └───────────────────────────────┘  │
│                                     │
│  ┌─── Premium ───────────────────┐  │
│  │                               │  │
│  │  Unlock Premium - ₩4,900      │  │  ← Button (Blue)
│  │                               │  │
│  │  Unlimited items + Ad-free    │  │  ← Caption (Gray)
│  │  experience                   │  │
│  │                               │  │
│  └───────────────────────────────┘  │
│                                     │
│  ┌─── About ─────────────────────┐  │
│  │                               │  │
│  │  Version              1.0.0   │  │  ← Read-only
│  │                               │  │
│  │  Privacy Policy           >   │  │  ← Navigation Link
│  │                               │  │
│  │  Terms of Service         >   │  │  ← Navigation Link
│  │                               │  │
│  │  Contact Support          >   │  │  ← Navigation Link
│  │                               │  │
│  └───────────────────────────────┘  │
│                                     │
└─────────────────────────────────────┘
```

### Settings Sections

**Section 1: Notifications**
- **Enable Reminders:** Toggle
  - Default: ON
  - If toggled ON: Request notification permission
  - If toggled OFF: Disable all notifications

- **Notification Settings:** Navigation Link
  - Opens sub-screen (see below)

**Section 2: Appearance**
- **Dark Mode:** Toggle
  - Default: ON
  - Instantly updates color scheme

**Section 3: Premium**
- **Unlock Premium Button:**
  - Text: "Unlock Premium - ₩4,900"
  - Color: Blue
  - Action: Trigger StoreKit purchase

- **Description:**
  - "Unlimited items + Ad-free experience"
  - Font: Caption, Gray

**Section 4: About**
- **Version:** Read-only label
  - Shows current app version (1.0.0)

- **Privacy Policy:** Navigation Link
  - Opens in-app WebView or Safari

- **Terms of Service:** Navigation Link
  - Opens in-app WebView or Safari

- **Contact Support:** Navigation Link
  - Opens email composer or support form

---

### Notification Settings Sub-Screen

```
┌─────────────────────────────────────┐
│  <  Notification Settings           │
├─────────────────────────────────────┤
│                                     │
│  ┌─── Reminder Timing ───────────┐  │
│  │                               │  │
│  │  Reminder Time                │  │
│  │  ┌─────────────────────────┐  │  │
│  │  │  9:00 AM             🕐 │  │  │  ← Time Picker
│  │  └─────────────────────────┘  │  │
│  │                               │  │
│  │  Remind 3 days before         │  │
│  │  ┌─────────────────────────┐  │  │
│  │  │  [- ]   3   [ + ]       │  │  │  ← Stepper
│  │  └─────────────────────────┘  │  │
│  │                               │  │
│  └───────────────────────────────┘  │
│                                     │
│  ┌───────────────────────────────┐  │
│  │  You will receive             │  │
│  │  notifications at the         │  │
│  │  selected time, X days        │  │  ← Footer text (Gray)
│  │  before each item needs to    │  │
│  │  be repurchased.              │  │
│  └───────────────────────────────┘  │
│                                     │
└─────────────────────────────────────┘
```

---

## User Flows

### Flow 1: Add First Item

```
Home (Empty)
    ↓ [Tap + button]
Add Item Sheet
    ↓ [Enter "Toothpaste"]
    ↓ [Select "Personal Care"]
    ↓ [Set cycle: 60 days]
    ↓ [Tap Save]
Home (1 item)
    ↓ [Automatic]
Notification Scheduled (60 days from now)
```

**Expected Time:** 30 seconds

---

### Flow 2: Mark Item as Rebought

```
Home (Item showing "Time to rebuy!")
    ↓ [Tap "Rebought" button]
    ↓ [Haptic feedback]
Item Updated (lastPurchaseDate = today)
    ↓ [Status changes to "60 days remaining"]
Notification Rescheduled (60 days from now)
```

**Expected Time:** 2 seconds

---

### Flow 3: Delete Item

```
Home (Item visible)
    ↓ [Swipe left on item]
Delete Button Appears
    ↓ [Tap Delete]
    ↓ [Confirmation haptic]
Item Removed
Notification Cancelled
```

**Expected Time:** 3 seconds

---

### Flow 4: Change Notification Settings

```
Home
    ↓ [Tap ⚙️ Settings]
Settings Sheet
    ↓ [Tap "Notification Settings"]
Notification Settings
    ↓ [Change time to 8:00 AM]
    ↓ [Change days before to 5]
    ↓ [Back]
Settings
    ↓ [Tap Done]
Home
    ↓ [Automatic]
All Notifications Rescheduled (new time)
```

**Expected Time:** 20 seconds

---

### Flow 5: Purchase Premium

```
Settings
    ↓ [Tap "Unlock Premium - ₩4,900"]
StoreKit Payment Sheet
    ↓ [Authenticate with Face ID / Password]
    ↓ [Confirm purchase]
Purchase Successful
    ↓ [Dismiss sheet]
Settings (Premium button hidden)
Home (Ads removed, no item limit)
```

**Expected Time:** 15 seconds

---

## Navigation Map

```
                    ┌───────────┐
                    │   Home    │ ← Root
                    └─────┬─────┘
                          │
           ┌──────────────┼──────────────┐
           ↓              ↓              ↓
      ┌─────────┐   ┌──────────┐   ┌──────────┐
      │ Add Item│   │ Settings │   │ Item     │
      │ (Sheet) │   │ (Sheet)  │   │ Detail*  │
      └─────────┘   └────┬─────┘   └──────────┘
                         │
                         ↓
                  ┌──────────────┐
                  │ Notification │
                  │  Settings    │
                  └──────────────┘

* Phase 2 feature
```

**Navigation Types:**
- **Sheet:** Modal presentation (swipe down to dismiss)
- **Push:** Stack navigation (back button in nav bar)

---

## Interaction Patterns

### Gestures

| Gesture | Screen | Action |
|---------|--------|--------|
| Tap + button | Home | Open Add Item sheet |
| Tap ⚙️ button | Home | Open Settings sheet |
| Tap "Rebought" | Home | Reset item cycle + haptic |
| Swipe left | Home (Item) | Reveal Delete button |
| Tap Delete | Home (Item) | Remove item + haptic |
| Pull down | Any sheet | Dismiss sheet |
| Tap outside | Picker/Date | Collapse picker |

### Haptic Feedback

| Action | Haptic Type | Style |
|--------|-------------|-------|
| Mark Rebought | Impact | Medium |
| Delete Item | Notification | Success |
| Error (save failed) | Notification | Error |
| Sheet dismiss | None | - |

---

## Accessibility

### VoiceOver Labels

| Element | Label | Hint |
|---------|-------|------|
| + button | "Add item" | "Opens form to add new item" |
| ⚙️ button | "Settings" | "Opens app settings" |
| Rebought button | "Mark as rebought" | "Resets purchase cycle to today" |
| Delete (swipe) | "Delete [item name]" | "Removes item from list" |
| Item card | "[Item name], [category], [X days remaining]" | "Double tap to edit" |

### Dynamic Type Support

All text scales with iOS accessibility text size settings.

**Test Sizes:**
- Small (default)
- Large (accessibility)
- Extra Large (accessibility)

---

## States & Edge Cases

### Home Screen States

1. **Empty State:** No items added
2. **Single Item:** First item added
3. **Many Items:** 3+ items (scrollable)
4. **All Green:** All items have 8+ days
5. **All Red:** All items overdue
6. **Mixed:** Various status colors

### Add Item Validation

| Field | Required | Validation |
|-------|----------|------------|
| Item name | ✅ Yes | Min 1 char, max 100 chars |
| Category | ❌ No | Default: nil |
| Last purchased | ✅ Yes | Can't be future date |
| Cycle days | ✅ Yes | 1-365 range |
| Notes | ❌ No | Max 500 chars |

**Save Button:**
- **Enabled:** Item name not empty
- **Disabled:** Item name empty (grayed out)

---

## Design Tokens

### Spacing Scale
- 4pt (xs)
- 8pt (sm)
- 12pt (md)
- 16pt (lg)
- 24pt (xl)
- 32pt (xxl)

### Typography Scale
- Caption: 12pt
- Footnote: 13pt
- Subheadline: 15pt
- Callout: 16pt
- Body: 17pt
- Headline: 17pt (Semibold)
- Title 3: 20pt (Semibold)
- Title 2: 22pt (Bold)
- Title: 28pt (Bold)
- Large Title: 34pt (Bold)

---

## Animation Timings

| Action | Duration | Curve |
|--------|----------|-------|
| Sheet present | 0.3s | Spring |
| Sheet dismiss | 0.3s | Spring |
| Item add | 0.2s | Ease-in-out |
| Item delete | 0.3s | Fade |
| Rebought tap | 0.2s | Spring |
| Toggle switch | 0.2s | Ease |

---

## Future Enhancements (Phase 2+)

- **Item Detail Screen:** Tap card → Edit mode
- **Search/Filter:** Search bar in Home
- **Sort Options:** By name, date, status
- **Categories View:** Group items by category
- **Statistics:** Usage analytics, rebuy history
- **Widgets:** iOS Home Screen widget
- **Siri Shortcuts:** "Add toothpaste to rebuy list"

---

**Created:** 2025-10-27
**Version:** 1.0
**Status:** Phase 0 - Wireframes Complete
