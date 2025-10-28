# Let's Build Your iOS App! 🚀

## ✅ Decision Made: Pay As You Go

**Smart choice!** You'll spend ~₩5,000-10,000 to test, validate, then decide.

---

## 🎯 Your Mission: Next 3 Hours

1. ✅ Subscribe to Pay As You Go
2. ✅ Connect to cloud Mac
3. ✅ Build your iOS app
4. ✅ Test it thoroughly
5. ✅ Document bugs
6. ✅ **Stop server!** (Important!)

**Let's go step by step!**

---

## 📋 STEP 1: Subscribe to MacinCloud Pay As You Go

### 1.1 Go to MacinCloud
```
Open browser: https://www.macincloud.com/login
Enter your email and password
Click "Login"
```

### 1.2 Find Pay As You Go Plan
```
Look for:
- "Plans" (top menu)
- "Pay As You Go" option
- "On-Demand Server"
- "Managed Dedicated Server" (hourly billing)

It might be called different names, but look for:
- Hourly billing
- Pay per hour
- On-demand
```

### 1.3 Select Server Configuration

**Choose:**
```
macOS Version: Ventura 13.x or Sonoma 14.x (latest available)
RAM: 8GB minimum (16GB if option available)
Storage: 50GB (default is fine)
Billing: Hourly / Pay As You Go
```

### 1.4 Add Credits

**How much:**
```
Option 1: $10 USD (~₩13,000)
- Gets you ~7-10 hours
- Enough for testing + small buffer

Option 2: $20 USD (~₩26,000)
- Gets you ~15-20 hours
- More buffer for bugs/fixes
- Recommended if you want peace of mind
```

**My recommendation:** Start with $10. You can add more anytime.

**Payment:**
```
Enter credit card
Confirm payment
Wait for confirmation
```

### 1.5 Start Your Server

**After payment:**
```
1. Dashboard → "My Servers" or "Start Server"
2. Click "Start" or "Launch"
3. Wait 2-5 minutes for server to boot
4. Status will change: "Starting..." → "Running"
```

**You'll receive connection details:**
```
IP Address: 208.xxx.xxx.xxx (write this down!)
Username: macuser (or similar - write this down!)
Password: random string (COPY THIS!)
VNC Port: 5900 (usually)
```

**⚠️ SAVE THESE DETAILS!** You need them to connect!

---

## 📋 STEP 2: Install Remote Desktop (While Waiting)

### 2.1 Download Microsoft Remote Desktop
```
On your Windows PC:
1. Open Microsoft Store
2. Search "Microsoft Remote Desktop"
3. Click "Get" (free download)
4. Wait for installation (~2 minutes)
```

### 2.2 Launch Remote Desktop
```
1. Click "Open" in Microsoft Store
   OR
2. Start Menu → Search "Remote Desktop" → Open

You'll see an empty window with "+" button
```

---

## 📋 STEP 3: Connect to Your Cloud Mac

### 3.1 Add Connection

**In Microsoft Remote Desktop:**
```
1. Click "+" button OR "Add" → "PCs"
2. Fill in the form:

   PC name: [IP address from MacinCloud]
   Example: 208.113.174.xxx

   User account: Click "Add User Account"
   - Username: [from MacinCloud, usually "macuser"]
   - Password: [from MacinCloud - paste it!]
   - Friendly name: "MacinCloud iOS Dev" (optional)

3. Click "Add" or "Save"
```

### 3.2 Connect!

```
1. Double-click the PC connection you just created
2. If security warning appears:
   - "The identity of the remote PC can't be verified..."
   - Click "Continue" or "Connect Anyway"

3. Wait 10-30 seconds...
4. 🎉 You should see macOS desktop!
```

**Troubleshooting:**
- Connection refused? Server might still be starting (wait 2 more min)
- Wrong password? Copy-paste from MacinCloud dashboard
- Can't connect? Double-check IP address is correct

---

## 📋 STEP 4: Check Xcode (On the Mac)

### 4.1 Open Terminal

**On the Mac desktop you're connected to:**
```
1. Bottom dock → Find "Terminal" (black icon)
   OR
2. Spotlight (⌘ + Space) → type "Terminal" → Enter
   OR
3. Applications → Utilities → Terminal
```

### 4.2 Check if Xcode is Installed

**In Terminal, type:**
```
xcode-select -p
```

**Press Enter**

**Result A - Xcode IS installed:** ✅
```
/Applications/Xcode.app/Contents/Developer

→ Great! Skip to Step 5
```

**Result B - Xcode NOT installed:** ❌
```
error: unable to get active developer directory
OR
command not found

→ Need to install Xcode (continue below)
```

### 4.3 Install Xcode (If Needed)

**Method 1 - App Store (Easier):**
```
1. Dock → "App Store" icon
2. Search bar → type "Xcode"
3. Click "Get" or download icon (cloud with arrow)
4. Wait 20-40 minutes (it's ~8-10GB)
   - Grab coffee ☕
   - Take a break 🚶
   - This is the longest wait!
5. After download:
   - Click "Open"
   - Accept license agreement
   - Wait for "Installing components..." (2-5 min)
   - First launch takes longer
```

**Method 2 - Command Line (Faster for tools only):**
```
Terminal:
xcode-select --install

Click "Install" in popup
Wait 10-15 minutes
This installs command-line tools only (might not be enough for full Xcode)

Recommendation: Use Method 1 (App Store) for full Xcode
```

### 4.4 Verify Installation

**In Terminal:**
```
xcode-select -p

Should show:
/Applications/Xcode.app/Contents/Developer
```

**Launch Xcode once:**
```
Spotlight (⌘ + Space) → "Xcode" → Enter
Wait for it to open
Accept any agreements
Let it finish "Installing components"
Then close it
```

---

## 📋 STEP 5: Clone Your GitHub Repository

### 5.1 Configure Git

**In Terminal:**
```
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

### 5.2 Navigate to Desktop

**In Terminal:**
```
cd ~/Desktop
```

### 5.3 Clone Your Repo

**In Terminal:**
```
git clone https://github.com/tskim611/rebuy-reminder-app.git
```

**Wait 10-30 seconds for download**

**Verify:**
```
cd rebuy-reminder-app/RebuyReminder
ls
```

**You should see:**
```
RebuyReminder.xcodeproj
RebuyReminder/
Info.plist
(and other files)
```

---

## 📋 STEP 6: Open Project in Xcode

### 6.1 Open Xcode Project

**In Terminal (still in ~/Desktop/rebuy-reminder-app/RebuyReminder):**
```
open RebuyReminder.xcodeproj
```

**OR:**
```
1. Finder → Desktop → rebuy-reminder-app → RebuyReminder
2. Double-click "RebuyReminder.xcodeproj"
```

**Xcode will launch!**

### 6.2 Wait for Indexing

```
Top bar shows: "Indexing..."
Wait for this to complete (1-3 minutes)
Don't do anything until indexing is done
```

---

## 📋 STEP 7: Configure Signing

### 7.1 Add Your Apple ID

```
1. Xcode → Preferences (or Settings on newer macOS)
2. Click "Accounts" tab
3. Click "+" button (bottom left)
4. Select "Apple ID"
5. Sign in with your Apple ID
   (The one you use for iPhone/App Store)
6. Password
7. Wait for verification
8. Click "Done"
```

### 7.2 Select Team for Project

```
1. Left sidebar → Click "RebuyReminder" (blue icon at top)
2. Middle pane → Select "RebuyReminder" under TARGETS
3. Top tabs → Click "Signing & Capabilities"
4. Check ✅ "Automatically manage signing"
5. Team dropdown → Select your Apple ID / Personal Team
```

### 7.3 Fix Bundle Identifier (If Error)

**If you see error "Bundle identifier already in use":**
```
Same screen (Signing & Capabilities):
1. Find "Bundle Identifier" field
2. Currently shows: com.tskim.rebuyreminder
3. Change to: com.YOURNAME.rebuyreminder
   (Replace YOURNAME with your actual name, no spaces)

Example: com.john.rebuyreminder

4. Error should disappear!
```

---

## 📋 STEP 8: Select Simulator

### 8.1 Choose Device

**Top bar in Xcode (next to Play/Stop buttons):**
```
Click device dropdown (might show "Any iOS Device")

Select: iPhone 14 Pro
OR any "iPhone 1X Pro" simulator
```

**If no simulators show:**
```
1. Xcode → Preferences → Components
2. Look for "iOS 16.x Simulator" or "iOS 17.x Simulator"
3. Click download icon
4. Wait 5-10 minutes (~2-3GB download)
5. Try selecting simulator again
```

---

## 📋 STEP 9: BUILD THE APP! 🎉

### 9.1 Press Build

**In Xcode:**
```
Press ⌘R (Command + R)
OR
Click ▶ (Play button) top left

Watch the progress bar (top middle)
First build takes 30-90 seconds
```

### 9.2 Expected Results

**✅ SUCCESS:**
```
- Build progress bar completes
- iOS Simulator window opens (new window)
- Your app icon appears on simulated iPhone
- App launches automatically
- You see: "빈 목록" or empty state screen
- UI shows: "+" button, dark theme

🎉🎉🎉 YOUR APP IS RUNNING! 🎉🎉🎉
```

**⚠️ WARNINGS (Yellow triangles):**
```
These are OK! App still builds.
Common warnings:
- "Prefer 'let' over 'var'"
- "Function too long"
- "Unused variable"

Ignore for now. As long as app runs, warnings are fine!
```

**❌ BUILD FAILED (Errors):**
```
Build stops with red error messages

Common errors & fixes:

Error 1: "No signing identity found"
→ Fix: Go back to Step 7, add Apple ID

Error 2: "Bundle identifier already in use"
→ Fix: Step 7.3, change bundle identifier

Error 3: "Development team not selected"
→ Fix: Step 7.2, select team

Error 4: Missing file errors
→ Fix: Make sure git clone worked (Step 5)

COPY THE ERROR MESSAGE and tell me!
I'll help you fix it!
```

---

## 📋 STEP 10: TEST YOUR APP! 🧪

**Follow the testing checklist in the simulator:**

### Test 1: Empty State ✅
```
- App shows "빈 목록" (Empty List)
- "+" button visible (top right)
- Dark theme (black/gray background)
- Korean text renders correctly
```

### Test 2: Add Item ✅
```
1. Tap "+" button
2. Screen shows "항목 추가" (Add Item)
3. Type in 이름 field: 우유
4. Select 사용 기간: 7일
5. Tap "추가하기" button
6. Return to list
7. Item "우유" appears with 7 days indicator
```

### Test 3: Notification Permission ✅
```
After adding first item:
- Alert should appear: "Allow notifications?"
- Tap "Allow"

If no alert: That's a bug! Note it.
```

### Test 4: Multiple Items ✅
```
Add 3 more items:
- 계란, 3일
- 빵, 5일
- 치즈, 10일

All items show in list
Check sorting/ordering
```

### Test 5: Mark as Rebought ✅
```
Tap an item (or checkmark icon)
Item should show "rebought" status
Visual indicator changes
```

### Test 6: Delete Item ✅
```
Swipe LEFT on an item
"Delete" button appears
Tap "Delete"
Item disappears
```

### Test 7: Settings ✅
```
Find Settings (gear icon or menu)
Open Settings screen
Toggle notifications ON/OFF
Check language options if available
```

---

## 📋 STEP 11: Document Bugs 📝

**For EVERY issue you find, write down:**

```
Bug #X: [Short description]

Steps to reproduce:
1. Do this
2. Do that
3. See problem

Expected: [What should happen]
Actual: [What actually happened]

Severity: Critical / Major / Minor
```

**Example:**
```
Bug #1: Notification permission alert never appears

Steps:
1. Fresh launch
2. Add item "우유", 7 days
3. Tap "추가하기"

Expected: Alert asking "Allow notifications?"
Actual: No alert, item just added silently

Severity: Critical (notifications won't work!)
```

**Create a text file on your Windows PC with all bugs!**

---

## 📋 STEP 12: STOP THE SERVER! ⚠️

**CRITICAL: When you're done testing!**

### 12.1 On the Mac:
```
Save any work
Close Xcode
Log out (optional)
```

### 12.2 On Your Windows PC:
```
Go to: https://www.macincloud.com/dashboard

Find your running server
Status shows: "Running"

Click "Stop" or "Shutdown" button
Wait for status: "Stopped"
```

**⚠️ IF YOU FORGET TO STOP:**
- Server keeps running
- You keep getting charged (₩1,500/hour)
- Even overnight!
- Could waste ₩20,000-30,000!

**ALWAYS STOP THE SERVER!**

---

## 📊 After Testing - What's Next?

### If App Works Great ✅
```
1. Document all bugs found (minor issues OK)
2. Fix bugs on Windows (edit Swift code)
3. Push fixes to GitHub
4. Restart server (1-2 hours)
5. Rebuild and retest
6. If still good → Continue iOS development!
7. Consider upgrading to Monthly plan (₩40,000)
```

### If App Has Major Issues ⚠️
```
1. Document all critical bugs
2. Fix on Windows
3. Test again with Pay As You Go (2-3 more hours)
4. Reassess viability
5. Might need deeper debugging session
```

### If Pivoting to Android ❌
```
1. Only spent ₩5,000-10,000 (minimal loss!)
2. Cancel MacinCloud
3. I'll create Android migration plan
4. Build Android version instead
```

---

## 💰 Cost Tracking

**Your spending today:**
```
MacinCloud credit purchase: ₩13,000 ($10)
Actual usage (3-4 hours): ₩5,000-6,000
Remaining credit: ₩7,000-8,000 (save for bug fixes)
```

**Remember to stop server!**

---

## 🆘 Troubleshooting Quick Reference

### Can't Connect to Mac
```
- Check IP address is correct
- Wait 2-5 more minutes (server might be starting)
- Check MacinCloud dashboard - is server "Running"?
```

### Xcode Won't Build
```
- Check signing (Step 7)
- Check simulator selected (Step 8)
- Check scheme says "RebuyReminder"
```

### Simulator Won't Launch
```
- First launch can take 1-2 minutes
- Check Activity Monitor - is simulator starting?
- Try selecting different simulator
```

### App Crashes
```
- Check Xcode console for error messages (bottom panel)
- Note the crash message
- Tell me what it says!
```

---

## 📞 I'm Here to Help!

**Tell me at each step:**

1. ✅ "Subscribed to Pay As You Go, server starting..."
2. ✅ "Server running! I have IP/username/password"
3. ✅ "Connected to Mac via Remote Desktop!"
4. ✅ "Xcode is installed and ready"
5. ✅ "Repo cloned, project open"
6. ✅ "Building now..."
7. ✅ "IT'S RUNNING!" or "Error: [copy error message]"
8. ✅ "Found X bugs, here's the list..."
9. ✅ "Server stopped!"

**At ANY step, if you're stuck, just tell me and I'll help!**

---

## 🎯 Your Next Action

**RIGHT NOW:**

1. Open browser
2. Go to: https://www.macincloud.com/login
3. Subscribe to Pay As You Go
4. Add $10 credit
5. Start server
6. Come back and tell me: **"Server is starting!"**

**Let's build this app! 🚀**

I'll be waiting for your update!
