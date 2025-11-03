# UI Redesign - Xcode Setup Instructions

## ⚠️ IMPORTANT: Add New Files to Xcode Project

The UI redesign has been implemented with new files that need to be added to the Xcode project.

### New Files Created:

#### Design System (`Shared/DesignSystem/`)
1. `Typography.swift` - Korean-first typography system
2. `Spacing.swift` - Consistent spacing values
3. `Theme.swift` - Color scheme and theming
4. `Haptics.swift` - Tactile feedback system
5. `ToastView.swift` - Undo toast component

#### Models (`Models/`)
1. `ItemModel.swift` - Bridge between CoreData Item and UI layer

#### Board Feature (`Features/Board/`)
1. `BoardViewModel.swift` - ViewModel with CoreData integration
2. `BoardView.swift` - New card-based main screen
3. `ItemCard.swift` - Card component with progress ring

### Steps to Add Files in Xcode:

**On MacinCloud:**

1. **Pull the latest changes:**
   ```bash
   git fetch origin
   git checkout feature/ui-redesign-cards
   ```

2. **Open Xcode project:**
   ```bash
   cd RebuyReminder
   open RebuyReminder.xcodeproj
   ```

3. **Add Design System files:**
   - Right-click on `RebuyReminder` folder in Project Navigator
   - Select "Add Files to RebuyReminder..."
   - Navigate to `Shared/DesignSystem/`
   - Select ALL 5 files (Typography, Spacing, Theme, Haptics, ToastView)
   - **IMPORTANT:**
     - ☐ UNCHECK "Copy items if needed"
     - ☑ CHECK "Add to targets: RebuyReminder"
   - Click "Add"

4. **Add Models:**
   - Right-click on `RebuyReminder` folder
   - Add Files → `Models/ItemModel.swift`
   - Same settings as above

5. **Add Board Feature:**
   - Right-click on `RebuyReminder` folder
   - Add Files → Select all 3 files in `Features/Board/`
     - BoardViewModel.swift
     - BoardView.swift
     - ItemCard.swift
   - Same settings as above

6. **Verify in Project Navigator:**
   You should see:
   ```
   RebuyReminder/
   ├── Shared/
   │   └── DesignSystem/
   │       ├── Typography.swift
   │       ├── Spacing.swift
   │       ├── Theme.swift
   │       ├── Haptics.swift
   │       └── ToastView.swift
   ├── Models/
   │   └── ItemModel.swift
   ├── Features/
   │   └── Board/
   │       ├── BoardViewModel.swift
   │       ├── BoardView.swift
   │       └── ItemCard.swift
   ```

7. **Build & Test:**
   - Product → Clean Build Folder (Shift+Cmd+K)
   - Product → Build (Cmd+B)
   - Fix any errors if they appear
   - Product → Run (Cmd+R) on simulator

## What Changed:

### Visual Changes:
- ✅ **Card Layout** - Items now appear as rounded cards with shadows
- ✅ **Progress Ring** - Visual indicator showing time until rebuy
- ✅ **Swipe to Delete** - Professional swipe-left-to-delete with undo toast
- ✅ **Haptic Feedback** - Phone vibrates on actions
- ✅ **Smooth Animations** - Cards slide in/out, progress animates
- ✅ **Better Spacing** - More breathing room, cleaner layout

### Technical Changes:
- New MVVM architecture with `BoardViewModel`
- `ItemModel` wraps CoreData `Item` for UI layer
- Design system for consistency
- Toast notification for undo
- All CoreData and NotificationService integration preserved

## Testing Checklist:

After building, test these scenarios:

- [ ] App launches without errors
- [ ] Existing items load and display in cards
- [ ] Progress ring shows correct state (green/orange/red)
- [ ] Swipe left on item → Delete button appears
- [ ] Delete item → Toast appears with "Undo"
- [ ] Tap "Undo" → Item restored
- [ ] Long-press item → Context menu → "재구매함"
- [ ] Mark as rebought → Progress resets
- [ ] Add new item → Appears as card
- [ ] Notifications still work
- [ ] Korean/English localization works

## If Build Fails:

Common issues:

1. **"Cannot find BoardView in scope"**
   - Make sure BoardView.swift is added to targets

2. **"Cannot find TypoKR/Spacing/Theme"**
   - Design system files not added to project

3. **"Cannot find ItemModel"**
   - Models/ItemModel.swift not added

**Solution:** Re-add the missing files using steps 3-5 above.

## Next Steps:

Once builds successfully:
1. Test thoroughly
2. Fix any bugs
3. Merge to main
4. Bump to Build 10
5. Upload to TestFlight

---

**Built:** 2025-11-03
**Branch:** `feature/ui-redesign-cards`
**Build Target:** Build 10
