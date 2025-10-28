# Android Studio Setup & First Build - Let's Go! 🚀

## 🎯 Mission: Get Android Development Running (Next 1-2 Hours)

**Goal:** Install Android Studio, create project, run "Hello World" on your phone!

---

## 📋 STEP 1: Download Android Studio (5 min)

### 1.1 Go to Android Developer Site

**Open browser:**
```
https://developer.android.com/studio
```

### 1.2 Download

**Click:**
```
"Download Android Studio" button (big green button)

You'll see version info:
- Android Studio Hedgehog/Iguana/Jellyfish (2023.x or newer)
- For Windows (64-bit)
- ~1GB download
```

**Accept terms:**
```
Check "I have read and agree..."
Click "Download Android Studio for Windows"
```

### 1.3 Save File

**Save to:**
```
Downloads folder
File: android-studio-2023.x.x.x-windows.exe
Wait for download (~1GB, 5-10 minutes depending on internet)
```

---

## 📋 STEP 2: Install Android Studio (15-20 min)

### 2.1 Run Installer

**Find downloaded file:**
```
Downloads → android-studio-2023.x.x.x-windows.exe
Double-click to run
```

**User Account Control:**
```
Windows asks "Allow this app to make changes?"
Click "Yes"
```

### 2.2 Installation Wizard

**Welcome Screen:**
```
Click "Next"
```

**Choose Components:**
```
✅ Android Studio
✅ Android Virtual Device (for emulator)

Keep both checked!
Click "Next"
```

**Installation Location:**
```
Default is fine: C:\Program Files\Android\Android Studio
Click "Next"
```

**Start Menu Folder:**
```
Default: "Android Studio"
Click "Install"
```

**Wait for installation:**
```
Progress bar... 2-5 minutes
Installing Android Studio...
Installing components...
```

**Installation Complete:**
```
✅ "Completed"
Check "Start Android Studio"
Click "Finish"
```

---

## 📋 STEP 3: First Launch Setup (15-20 min)

### 3.1 Import Settings

**First screen:**
```
"Import Android Studio Settings From..."

Select: "Do not import settings"
Click "OK"
```

### 3.2 Welcome Screen

```
"Welcome to Android Studio"
Click "Next"
```

### 3.3 Install Type

```
Choose "Standard" (recommended)
Click "Next"
```

### 3.4 Select UI Theme

```
Light or Darcula (dark theme)
Choose what you prefer
Click "Next"
```

### 3.5 Verify Settings

```
Shows:
- Android SDK Location
- Android SDK Platform
- Performance (Intel HAXM or Windows Hypervisor)

Click "Next"
```

### 3.6 License Agreement

**IMPORTANT:**
```
You'll see multiple license agreements:

1. Android SDK License
   - Read (or scroll down)
   - Select "Accept"

2. Intel HAXM License (if applicable)
   - Select "Accept"

3. Repeat for all licenses shown

Click "Finish"
```

### 3.7 Downloading Components

**This is the longest part!**
```
Downloading:
- Android SDK Platform-Tools
- Android SDK Build-Tools
- Android Emulator
- Android SDK Platform 34
- Intel x86 Emulator Accelerator (HAXM)
- etc.

Total: ~3-4GB
Time: 10-20 minutes (depends on internet)

☕ GRAB COFFEE! This will take a while!
```

**Progress shows:**
```
"Downloading Components"
Progress bars for each component
Don't close this window!
```

**When complete:**
```
"All SDK components are installed and up-to-date"
Click "Finish"
```

---

## 📋 STEP 4: Create Your First Project! (5 min)

### 4.1 Welcome to Android Studio

**You should see:**
```
Welcome screen with options:
- New Project
- Open
- Get from VCS
etc.
```

**Click "New Project"**

### 4.2 Choose Template

**Select:**
```
Phone and Tablet tab (should be selected)

Template: "Empty Activity"
(Shows Jetpack Compose icon)

Description: "Creates a new empty Compose activity"

Click "Next"
```

### 4.3 Configure Your Project

**Fill in:**
```
Name: RebuyReminder

Package name: com.tskim.rebuyreminder
(or com.yourname.rebuyreminder)

Save location: C:\Projects\rebuy-reminder-app\android
(create "android" folder inside your existing project)

Language: Kotlin ✅

Minimum SDK: API 26 ("Nougat"; Android 8.0)
(Shows ~95% devices supported)

Build configuration language: Kotlin DSL (build.gradle.kts) ✅

Click "Finish"
```

### 4.4 Wait for Project Creation

**Android Studio will:**
```
1. Create project structure
2. Download Gradle wrapper
3. Sync Gradle (first time: 2-5 minutes)
4. Index files
5. Build project structure

Bottom panel shows:
"Build: Downloading..."
"Build: Syncing..."

Wait for: "BUILD SUCCESSFUL" or "Gradle sync finished"
```

**You'll see:**
```
Left: Project structure tree
Center: MainActivity.kt file open
Right: Preview pane (showing UI)
Bottom: Build output
```

---

## 📋 STEP 5: Test on Your Android Phone! (10-15 min)

### 5.1 Enable Developer Mode on Phone

**On your Android phone:**
```
1. Settings
2. About Phone (or System → About Phone)
3. Find "Build Number"
4. Tap "Build Number" 7 times rapidly
5. You'll see: "You are now a developer!" or countdown
6. Enter PIN/password if asked
```

### 5.2 Enable USB Debugging

**Still on phone:**
```
1. Settings → System (or Settings → Additional Settings)
2. Developer Options (newly appeared!)
3. Scroll down to "USB Debugging"
4. Toggle ON
5. Confirm "Allow USB debugging?"
```

### 5.3 Connect Phone to PC

**Physical connection:**
```
1. USB cable: Phone ↔ Windows PC
2. Phone shows: "USB charging this device"
3. Tap notification → Change to "File Transfer" or "MTP"
```

**On phone:**
```
Popup: "Allow USB debugging?"
Computer name: [your PC name]

Check "Always allow from this computer"
Tap "OK" or "Allow"
```

### 5.4 Select Device in Android Studio

**Top toolbar:**
```
Look for device dropdown (next to green ▶ play button)
Currently shows: "No devices"

After connecting phone:
Shows: [Your Phone Model] (your-phone-id)
Example: "Samsung Galaxy S21" or "Pixel 7"

Click to select your phone
```

**If phone doesn't show:**
```
- Check USB cable is connected
- Check phone shows "USB debugging" notification
- Try different USB port
- Install phone USB drivers (Windows should auto-install)
```

### 5.5 Run the App!

**In Android Studio:**
```
Click ▶ (green play button) at top
OR
Press Shift+F10

You'll see:
"Running 'app'"
"Installing APK..."
"Launching app..."
```

**On your phone:**
```
Screen unlocks (if locked)
App installs automatically
App launches!

You should see:
- White/dark screen
- Text: "Hello Android!" or similar
- Default Compose template UI
```

**🎉 SUCCESS! Your first Android app is running on your phone! 🎉**

---

## 📋 STEP 6: Verify Everything Works

### 6.1 Check Android Studio

**Bottom panel:**
```
Run tab shows:
"$ adb shell am start ..."
"BUILD SUCCESSFUL in Xs"
```

**Logcat tab:**
```
Shows app logs
No red errors (red = bad)
Some blue/green info messages (normal)
```

### 6.2 Check Your Phone

**App is running:**
```
✅ App opened automatically
✅ Shows Compose template content
✅ No crashes
✅ Responds to touches
```

### 6.3 Make a Test Change

**In Android Studio:**
```
1. Find MainActivity.kt (should be open)
2. Look for text "Hello Android!" or similar
3. Change it to "Hello RebuyReminder!"
4. Click ▶ again
5. App reinstalls and relaunches
6. Phone now shows "Hello RebuyReminder!"
```

**If this works → You're ready to develop! ✅**

---

## 📋 STEP 7: Project Structure Overview

### What you have now:

```
android/
├── app/
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/tskim/rebuyreminder/
│   │   │   │   └── MainActivity.kt ← Your code here!
│   │   │   ├── res/
│   │   │   │   ├── values/
│   │   │   │   │   └── strings.xml ← Text resources
│   │   │   │   ├── drawable/ ← Images
│   │   │   │   └── mipmap/ ← App icons
│   │   │   └── AndroidManifest.xml ← App config
│   │   └── test/ ← Tests (later)
│   └── build.gradle.kts ← Dependencies
├── gradle/ ← Build system
└── build.gradle.kts ← Project config
```

---

## 🚀 Next Steps (After This Works)

### You're ready to build the real app!

**Next development phases:**

1. ✅ **Setup complete!** (You are here)
2. ⏳ Create data model (Item.kt)
3. ⏳ Setup Room database
4. ⏳ Build UI screens (HomeScreen, AddItemScreen)
5. ⏳ Implement notifications
6. ⏳ Add localization (Korean/English)
7. ⏳ Test and polish
8. ⏳ Prepare for Google Play

---

## 🆘 Troubleshooting

### Issue 1: Gradle Sync Failed

**Fix:**
```
1. Check internet connection
2. File → Invalidate Caches → Restart
3. Try again
4. If still fails, tell me the error!
```

### Issue 2: Phone Not Detected

**Fix:**
```
1. Check USB cable (try different cable)
2. Phone: Re-toggle USB debugging OFF then ON
3. Windows: Install phone USB drivers
4. Try different USB port
5. Restart Android Studio
```

### Issue 3: "SDK Platform Not Found"

**Fix:**
```
Tools → SDK Manager
SDK Platforms tab
Check: Android 14.0 (API 34) or latest
Click "Apply" → Download
```

### Issue 4: Build Error

**Copy the full error and tell me!**
```
I'll help you fix it
```

---

## ✅ Success Checklist

**Before proceeding, verify:**

- [x] Android Studio installed
- [x] First project created (RebuyReminder)
- [x] Phone connected and detected
- [x] App runs on phone
- [x] Can make changes and see them
- [x] No major errors

**If all checked → You're ready! 🎉**

---

## 💡 Quick Tips

### Save Time:

1. **Use physical phone** (faster than emulator)
2. **Keep phone unlocked** while developing
3. **Enable "Stay awake"** in Developer Options
4. **Use good USB cable** (data cable, not just charging)

### Learn as you go:

1. Jetpack Compose = Modern Android UI (like SwiftUI)
2. Kotlin = Modern language (like Swift)
3. Room = Database (like CoreData)
4. Everything has good documentation!

---

## 📞 Tell Me Your Status!

**Where are you at?**

1. **"Installing Android Studio now..."** → Great! Let me know when done
2. **"Android Studio installed!"** → Perfect! Create the project
3. **"Project created!"** → Awesome! Test on your phone
4. **"App running on my phone!"** → 🎉 YOU'RE READY TO CODE!
5. **"I'm stuck at..."** → Tell me where and I'll help!

**Update me on your progress!** 🚀

---

**Next:** Once you confirm the app runs on your phone, I'll guide you through building the actual RebuyReminder features!

Let's do this! 💪
