# Phase 0 – Setup & Identity Checklist

**Goal:** Lock the concept, tooling, and tone before any line of code.

**Timeline:** Weeks 1-3

---

## 1. Project Environment ✅

- [x] Set up Claude Code workspace
- [x] Create iOS project structure (SwiftUI + CoreData)
- [x] Configure `.gitignore` for iOS
- [x] Create README with project overview
- [ ] Initialize Git repository
- [ ] Push to GitHub (private repo)
- [ ] Set up Xcode project with proper bundle ID
- [ ] Test build on iOS Simulator
- [ ] Register Apple Developer Account (₩129,000/year)

**Status:** 70% Complete

---

## 2. Brand & Tone ✅

- [x] App name finalized: **"다 떨어지기 전에"**
- [x] Tagline: "Before you run out"
- [x] Brand voice defined: Calm, precise, empathetic
- [x] Style guide created (`STYLE_GUIDE.md`)
- [x] Localization glossary (KR/EN)
- [ ] App icon design (placeholder for now)
- [ ] Launch screen design

**Status:** 80% Complete

---

## 3. UX Mock-ups

- [ ] Wireframe: Home screen (item list)
- [ ] Wireframe: Add/Edit item screen
- [ ] Wireframe: Settings screen
- [ ] Define navigation flow
- [ ] Document gestures (swipe-to-delete, pull-to-refresh)
- [ ] Create empty state illustrations
- [ ] Design notification templates

**Tool Suggestion:** Figma or hand-drawn sketches → photos

**Status:** 0% Complete (Next priority)

---

## 4. Compliance Prep ✅

- [x] Draft Privacy Policy (KR) – `PRIVACY_POLICY_KR.md`
- [x] Draft Privacy Policy (EN) – `PRIVACY_POLICY_EN.md`
- [x] Draft Terms of Service (KR) – `TERMS_OF_SERVICE_KR.md`
- [x] Draft Terms of Service (EN) – `TERMS_OF_SERVICE_EN.md`
- [ ] Legal review (consult lawyer for PIPA compliance)
- [ ] Register business entity (optional for individual developer)
- [ ] Obtain business registration number (사업자등록번호)
- [ ] Register for telecom sales business (통신판매업 신고) if required

**Status:** 60% Complete (Drafts ready, need legal review)

---

## 5. Technical Foundation ✅

- [x] SwiftUI app entry point
- [x] CoreData model (Item entity)
- [x] Persistence controller with preview
- [x] Basic views (Home, Add, Settings, Empty State)
- [x] Localization files (KR/EN)
- [x] Info.plist configuration
- [ ] Firebase project setup
- [ ] Analytics service integration
- [ ] Notification permission handling (UNUserNotificationCenter)

**Status:** 75% Complete

---

## 6. Documentation ✅

- [x] README.md
- [x] STYLE_GUIDE.md
- [x] PRIVACY_POLICY_KR.md
- [x] PRIVACY_POLICY_EN.md
- [x] TERMS_OF_SERVICE_KR.md
- [x] TERMS_OF_SERVICE_EN.md
- [x] FIREBASE_SETUP.md
- [ ] CONTRIBUTING.md (if open-sourcing later)
- [ ] CHANGELOG.md (version tracking)

**Status:** 90% Complete

---

## 7. Development Environment

- [ ] Install Xcode 14+ on macOS
- [ ] Configure iOS Simulator (iPhone 14 Pro recommended)
- [ ] Set up physical test device (optional)
- [ ] Create Firebase development project
- [ ] Add `GoogleService-Info.plist` to project
- [ ] Test build on device
- [ ] Configure code signing (automatic for now)

**Status:** 0% Complete (Environment-dependent)

---

## Phase 0 Completion Criteria

### Must-Have (Blocking Phase 1)
- [ ] Xcode project builds successfully
- [ ] Git repository initialized and pushed
- [ ] Apple Developer Account active
- [ ] Firebase dev project created
- [ ] Privacy Policy & TOS finalized (post legal review)
- [ ] Basic wireframes complete

### Nice-to-Have (Can defer)
- [ ] App icon designed
- [ ] Business registration (can do later)
- [ ] Physical device testing (Simulator OK for now)

---

## Next Steps → Phase 1

Once Phase 0 is complete, move to:

**Phase 1 – MVP Build (Weeks 4-10)**
- Implement UNUserNotificationCenter scheduling
- Build reminder service with notification triggers
- Integrate Firebase Analytics
- Implement StoreKit in-app purchase (₩4,900 unlock)
- Create App Store assets (screenshots, descriptions)
- Deploy to TestFlight for beta testing

---

## Time Estimate

| Task Category | Estimated Time | Status |
|---------------|----------------|--------|
| Project Setup | 4 hours | ✅ 90% |
| Brand & Style | 3 hours | ✅ 80% |
| Legal Docs | 2 hours | ✅ 60% |
| Wireframes | 4 hours | ⏳ 0% |
| Dev Environment | 2 hours | ⏳ 0% |
| Testing & QA | 2 hours | ⏳ 0% |
| **Total** | **17 hours** | **~50%** |

**Remaining:** ~8 hours

---

## Resources Needed

- [ ] Apple Developer Account (₩129,000/year)
- [ ] Figma account (free tier OK)
- [ ] Legal consultation (₩200,000-500,000 one-time)
- [ ] Domain name (optional, ₩15,000/year)
- [ ] Email hosting (optional, ₩5,000/month)

**Total Initial Cost:** ₩130,000-650,000

---

## Blockers & Risks

### Current Blockers
1. **Apple Developer Account:** Need to register before device testing
2. **Legal Review:** Privacy Policy & TOS need lawyer approval (PIPA)
3. **Wireframes:** No visual mockups yet (can proceed with code, but risky)

### Mitigation
- Register Apple account ASAP (1-2 days approval)
- Consult with Korean IP lawyer specializing in app privacy
- Create quick Figma wireframes or hand-drawn sketches

---

## Definition of Done (Phase 0)

✅ Phase 0 is complete when:
1. Xcode project builds and runs on iOS Simulator
2. Git repository is initialized with all files committed
3. Apple Developer Account is active
4. Firebase dev project is configured
5. Privacy Policy & TOS are legally reviewed and finalized
6. At least low-fidelity wireframes exist for 3 core screens
7. All team members (just you!) understand the brand voice and design system

**Target Completion:** End of Week 3

---

**Last Updated:** 2025-10-27
**Progress:** ~50% Complete
