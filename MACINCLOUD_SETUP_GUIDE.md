# MacinCloud Setup Guide - iOS App Testing

## 🎯 Current Status

✅ **You have:** MacinCloud account (no subscription)
🎯 **You need:** Active subscription to build iOS app
⏱️ **Time needed:** 2-3 hours total testing

---

## 💰 MacinCloud Plan Recommendations

### Option 1: Pay As You Go (RECOMMENDED FOR TESTING)
**Best for:** One-time testing or occasional use

**Cost:**
- ~$1.00-1.50 USD/hour (~₩1,300-2,000/hour)
- **For 3 hours:** ~₩4,000-6,000 total
- No monthly commitment
- Stop anytime

**Perfect if:**
- ✅ You just want to test the app once
- ✅ You're not sure if you'll continue iOS development
- ✅ You want minimal cost (~₩5,000 total)

**How it works:**
1. Add credit to your account (minimum $10 USD = ~₩13,000)
2. Start Mac instance when needed
3. Pay only for hours used
4. Stop instance when done

---

### Option 2: Monthly Dedicated Server
**Best for:** Active development

**Cost:**
- **Basic Plan:** $30-40/month (~₩40,000-52,000)
- **Pro Plan:** $60-80/month (~₩78,000-104,000)
- Unlimited hours
- Your own Mac instance

**Perfect if:**
- ✅ You'll develop iOS app actively
- ✅ Need to build frequently (bug fixes, updates)
- ✅ Planning Phase 1 development (Firebase, StoreKit)

---

### Option 3: Managed Dedicated Server
**Best for:** Production apps

**Cost:**
- $79-200/month (~₩103,000-260,000)
- Premium support
- Better performance

**Perfect if:**
- ✅ You're serious about iOS app business
- ✅ Need reliable long-term solution
- ✅ Budget allows

---

## 🎯 My Recommendation for YOU

### **Start with "Pay As You Go" (~₩5,000)**

**Why:**
1. Your iOS code is READY (just needs testing)
2. You might find bugs that need fixing
3. Test first, commit later
4. Minimal financial risk

**Timeline:**
- **Hour 1:** Setup, clone repo, build in Xcode
- **Hour 2:** Test app, identify bugs
- **Hour 3:** Fix critical bugs, rebuild

**After testing:**
- ✅ App works → Decide on monthly plan for Phase 1
- ❌ Major issues → Fix on Windows, test again later

---

## 📋 Step-by-Step Activation Guide

### Step 1: Log into MacinCloud
1. Go to: https://www.macincloud.com/login
2. Enter your email and password
3. You should see dashboard

### Step 2: Choose Plan
**For Pay As You Go:**
1. Click "Plans" or "Subscribe"
2. Look for "Pay As You Go" or "On-Demand"
3. Select "macOS Server" (not iOS device)
4. Choose specs:
   - **macOS Version:** Monterey 12.0+ or Ventura 13.0+
   - **RAM:** 8GB minimum (16GB better)
   - **Storage:** 50GB is enough

### Step 3: Add Payment
1. Add credit card
2. Add credits: $10-20 USD (~₩13,000-26,000)
   - $10 = ~7-10 hours
   - $20 = ~15-20 hours
3. Confirm payment

### Step 4: Start Your Mac Instance
1. Click "Start Server" or "Launch"
2. Wait 2-5 minutes for Mac to boot
3. You'll get connection details:
   - IP address
   - Username
   - Password

---

## 💻 Connecting to Your Cloud Mac

### Windows Connection (Remote Desktop)

**Step 1: Install Microsoft Remote Desktop**
```
1. Open Microsoft Store
2. Search "Microsoft Remote Desktop"
3. Install (free)
```

**Step 2: Connect to Mac**
1. Open Microsoft Remote Desktop
2. Click "+ Add" → "PC"
3. Enter:
   - **PC Name:** [IP from MacinCloud]
   - **User Account:** [Username from MacinCloud]
   - **Password:** [Password from MacinCloud]
4. Click "Connect"

**Step 3: You're on a Mac!**
- You'll see macOS desktop
- Full remote control
- Install Xcode if needed

---

## 🛠️ Setup Development Environment

### Once Connected to Cloud Mac:

**Step 1: Install/Verify Xcode**
```bash
# Open Terminal on Mac
# Check if Xcode installed
xcode-select -p

# If not installed:
# Go to App Store → Search "Xcode" → Install (8GB, ~30 min)
```

**Step 2: Install Xcode Command Line Tools**
```bash
xcode-select --install
# Click "Install" in popup
# Wait 5-10 minutes
```

**Step 3: Configure Git**
```bash
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

**Step 4: Clone Your Repository**
```bash
# Navigate to Desktop or Documents
cd ~/Desktop

# Clone your repo
git clone https://github.com/tskim611/rebuy-reminder-app.git

# Navigate to project
cd rebuy-reminder-app/RebuyReminder
```

**Step 5: Open in Xcode**
```bash
open RebuyReminder.xcodeproj
```

---

## 🚀 Building Your App

### In Xcode:

**Step 1: Configure Signing**
1. Click project name (top left)
2. Select "RebuyReminder" target
3. Go to "Signing & Capabilities" tab
4. **Team:** Select your Apple ID
   - If no team: Click "Add Account" → Sign in with your Apple ID
   - Free account is OK for simulator testing!
5. **Bundle Identifier:**
   - Change to unique ID: `com.yourname.rebuyreminder`
   - Or keep existing if it works

**Step 2: Select Simulator**
1. Top bar: Click device dropdown
2. Select: "iPhone 14 Pro" or any simulator
3. If no simulators: Xcode → Preferences → Components → Download

**Step 3: Build & Run**
```
Press ⌘R (or click ▶ Play button)
Wait 30-60 seconds for first build
```

**Expected Results:**
- ✅ **Success:** Simulator launches, app shows empty state
- ⚠️ **Warnings:** Normal (yellow triangles)
- ❌ **Errors:** We'll fix together

---

## 🧪 Testing Checklist

Follow these tests in order:

### Test 1: App Launches
- [ ] Simulator opens
- [ ] App shows "빈 목록" (empty state)
- [ ] No crashes

### Test 2: Add Item
- [ ] Tap "+" button
- [ ] Enter: 우유 (milk)
- [ ] Select: 7 days
- [ ] Tap "추가하기"
- [ ] Item appears in list

### Test 3: Notifications
- [ ] Simulator prompts for permission
- [ ] Allow notifications
- [ ] Check Settings → RebuyReminder (notification toggle works)

### Test 4: Basic Functions
- [ ] Swipe to delete item
- [ ] Mark item as rebought (checkmark)
- [ ] Add multiple items
- [ ] Language switches (Settings → Language)

**Document any bugs you find!**

---

## 🐛 Common Issues & Fixes

### Issue 1: "No signing identity found"
**Fix:**
```
1. Xcode → Preferences → Accounts
2. Click "+" → Add Apple ID
3. Sign in with your Apple ID (free is OK)
4. Close preferences
5. Try building again
```

### Issue 2: "Bundle identifier already in use"
**Fix:**
```
1. Project Settings → General
2. Bundle Identifier: Change to unique ID
   Example: com.yourname.rebuyreminder
3. Try building again
```

### Issue 3: Simulator not available
**Fix:**
```
1. Xcode → Preferences → Components
2. Download iOS 16.0+ Simulator
3. Wait for download (~2GB)
4. Try again
```

### Issue 4: Build too slow
**Fix:**
- MacinCloud server might be slow
- Upgrade to better server specs
- Or be patient (first build is always slow)

---

## 💰 Cost Tracking

### Your Estimated Costs:

**Initial Testing (This Week):**
- Pay As You Go: ₩5,000-10,000 (3-5 hours)
- Goal: Validate app works, find bugs

**Phase 1 Development (Weeks 2-8):**
- Monthly Plan: ₩40,000-52,000/month
- OR Pay As You Go: ₩30,000-50,000 total
- Goal: Fix bugs, add Firebase, StoreKit

**Long-Term (Month 3+):**
- If successful: Buy used Mac Mini (₩500,000)
- If testing: Continue monthly MacinCloud
- If pivoting: Consider Android

---

## ⏱️ Time Management

### Optimize Your Cloud Mac Time:

**Before Connecting:**
✅ Read all documentation (on Windows)
✅ Plan what to test
✅ Have GitHub credentials ready
✅ Know what you'll build

**During Connection:**
✅ Clone repo immediately
✅ Build app (30 min)
✅ Test systematically (30 min)
✅ Document bugs (15 min)
✅ Fix critical issues only (1 hour)

**After Disconnecting:**
✅ Fix non-critical bugs on Windows
✅ Update documentation
✅ Plan next session
✅ Connect again only when ready to test

**Minimize Costs:** Do coding on Windows, use Mac only for building/testing!

---

## 🎯 Action Plan for Next 24 Hours

### Today (2 hours):
1. ⏰ **0-15 min:** Subscribe to Pay As You Go
2. ⏰ **15-30 min:** Add $10-20 credit
3. ⏰ **30-40 min:** Start Mac instance
4. ⏰ **40-50 min:** Connect via Remote Desktop
5. ⏰ **50-60 min:** Verify/install Xcode

### Tomorrow (2-3 hours):
6. ⏰ **Hour 1:** Clone repo, open in Xcode
7. ⏰ **Hour 2:** Build app, fix signing issues
8. ⏰ **Hour 3:** Test app in simulator
9. ⏰ **Hour 4:** Document bugs, stop instance

### Week 1:
- Fix bugs on Windows (update Swift code)
- Reconnect to Mac (1-2 hours)
- Rebuild and retest
- Complete Phase 0 testing

---

## 📊 Decision Matrix

### Subscribe to MacinCloud Pay As You Go IF:
✅ You want to test iOS app NOW
✅ You have ₩5,000-10,000 budget
✅ You're committed to iOS-first strategy
✅ Korean market is your target (64% iOS)

### DON'T Subscribe Yet IF:
❌ Still considering Android pivot
❌ Budget is ₩0 (find friend's Mac instead)
❌ Prefer to wait and save for Mac Mini
❌ Not ready to test this week

---

## 🎯 Next Steps

**Tell me:**
1. ✅ Ready to subscribe to Pay As You Go (~₩5,000)?
2. ✅ Want monthly plan instead (~₩40,000/month)?
3. ❌ Want to explore Android pivot instead?
4. ❌ Want to wait and find free Mac access?

**If you're ready:**
- Go to MacinCloud → Subscribe → Pay As You Go
- Tell me when you've started the Mac instance
- I'll guide you through the build process step-by-step!

---

## 🚀 Let's Build This!

Your iOS app is **95% complete**. We're SO CLOSE!

Just need:
- ₩5,000-10,000 for testing
- 2-3 hours of your time
- MacinCloud Pay As You Go

**Then you'll have a working app on your iPhone! 📱**

---

**Created:** 2025-10-27
**Purpose:** Guide you through MacinCloud setup for iOS testing
**Next:** Your decision - subscribe or pivot?
