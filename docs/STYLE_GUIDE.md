# 다 떨어지기 전에 – Style Guide

**Brand Identity & Design System**

---

## Brand Voice

### Core Characteristics
- **Calm:** Non-intrusive, gentle reminders without urgency
- **Precise:** Clear, direct communication without ambiguity
- **Empathetic:** Understanding user needs and respecting their time

### Tone Guidelines

**Do:**
- Use conversational, friendly language
- Be specific and actionable ("3 days remaining" not "soon")
- Acknowledge user effort ("Great! Updated your cycle")
- Keep copy concise and scannable

**Don't:**
- Use aggressive urgency ("ACT NOW!", "URGENT!")
- Over-explain or patronize
- Use jargon or technical terms
- Include unnecessary emoji or exclamation marks

### Voice Examples

| Context | Poor | Better |
|---------|------|--------|
| Empty state | "Oops! No items found!" | "No items yet" |
| Notification | "ATTENTION! Rebuy toothpaste NOW!" | "Time to rebuy toothpaste" |
| Success | "Successfully added!!!" | "Item added" |
| Error | "Error occurred!" | "Unable to save. Please try again." |

---

## Visual Design

### Color Palette

#### Primary Colors
```
Background (Dark Mode):
- Primary: #000000 (Pure Black)
- Secondary: #1C1C1E (System Gray 6)
- Tertiary: #2C2C2E (System Gray 5)

Text:
- Primary: #FFFFFF (White)
- Secondary: #8E8E93 (Gray)
- Tertiary: #636366 (Dark Gray)

Accent:
- Blue: #007AFF (iOS System Blue)
- Success: #34C759 (Green)
- Warning: #FF9500 (Orange)
- Critical: #FF3B30 (Red)
```

#### Semantic Colors
```
Status Indicators:
- Green (#34C759): 8+ days remaining
- Orange (#FF9500): 1-7 days remaining
- Red (#FF3B30): Overdue (0 or negative days)

Interactive:
- Primary Button: #007AFF
- Destructive: #FF3B30
- Disabled: #3A3A3C (40% opacity)
```

### Typography

#### Font System
```swift
// iOS System Font (San Francisco)

// Headers
Title Large: .largeTitle (34pt, Bold)
Title: .title (28pt, Bold)
Title 2: .title2 (22pt, Bold)
Title 3: .title3 (20pt, Semibold)

// Body
Headline: .headline (17pt, Semibold)
Body: .body (17pt, Regular)
Callout: .callout (16pt, Regular)
Subheadline: .subheadline (15pt, Regular)
Footnote: .footnote (13pt, Regular)
Caption: .caption (12pt, Regular)
Caption 2: .caption2 (11pt, Regular)
```

#### Typography Usage
- **Navigation titles:** Large Title (다 떨어지기 전에)
- **Item names:** Headline
- **Categories:** Caption (Gray)
- **Days remaining:** Subheadline (Status color)
- **Button text:** Callout (Semibold)
- **Settings labels:** Body

### Spacing & Layout

#### Grid System
```
Screen margins: 16pt
Section spacing: 24pt
Card padding: 16pt
Element spacing: 12pt (large), 8pt (medium), 4pt (small)

Minimum tap target: 44x44pt (iOS HIG)
```

#### Corner Radius
```
Cards: 12pt
Buttons: 8pt
Pills/Tags: 16pt (fully rounded)
Status indicators: Circular
```

### Components

#### Item Row Card
```
Height: Dynamic (min 80pt)
Background: Gray 6 (30% opacity)
Padding: 16pt
Corner radius: 12pt
Shadow: None (dark mode)

Layout:
[Status Dot] [Name + Category + Days] [Button]
   12pt          Flexible spacing         -
```

#### Buttons

**Primary (Action)**
```
Background: System Blue (#007AFF)
Text: White, Semibold
Padding: 12pt horizontal, 8pt vertical
Corner radius: 8pt
```

**Secondary (Rebought)**
```
Background: Transparent
Border: 1pt Blue
Text: Blue, Semibold
```

**Destructive**
```
Background: System Red (#FF3B30)
Text: White, Semibold
```

#### Status Dot
```
Size: 12x12pt
Shape: Circle
Colors: Green, Orange, Red (based on status)
```

---

## Localization

### Language Support
- Primary: Korean (한국어)
- Secondary: English

### Korean Copy Guidelines

**Formal vs. Casual:**
- Use informal polite form (해요체) for most UI
- Use formal when addressing legal/policy content (합니다체)

**Examples:**
```
Informal: "항목을 추가하세요" (Add an item)
Formal: "본 약관에 동의합니다" (You agree to these terms)
```

**Number Formatting:**
- Days: "3일 남음" (3 days remaining)
- Price: "₩4,900" (Korean won symbol)
- Dates: "2025년 10월 27일" (YYYY년 MM월 DD일)

### String Keys

All user-facing text uses localized string keys:
```swift
// Usage
Text(NSLocalizedString("item.days_remaining", comment: ""))

// Localizable.strings format
"item.days_remaining" = "%d days remaining";  // EN
"item.days_remaining" = "%d일 남음";          // KR
```

---

## Iconography

### Icon Style
- Use SF Symbols (iOS system icons)
- Weight: Regular or Medium
- Size: 20-24pt for toolbar, 16-18pt inline

### Common Icons
```
Add: plus.circle.fill
Settings: gearshape
Delete: trash
Cart: cart.badge.plus
Calendar: calendar
Bell: bell.fill
Checkmark: checkmark.circle.fill
```

---

## Animation & Motion

### Principles
- Subtle and purposeful
- Respect accessibility (reduce motion setting)
- Duration: 0.2-0.4s for most transitions

### Haptic Feedback
```swift
// On "Rebought" button tap
UIImpactFeedbackGenerator(style: .medium).impactOccurred()

// On delete
UINotificationFeedbackGenerator().notificationOccurred(.success)

// On error
UINotificationFeedbackGenerator().notificationOccurred(.error)
```

### Transitions
```
List updates: .default (spring animation)
Modal presentation: .sheet (iOS standard)
Deletion: .fade with slide
```

---

## Accessibility

### Requirements
- VoiceOver labels for all interactive elements
- Minimum contrast ratio: 4.5:1 (WCAG AA)
- Dynamic Type support (all text scales)
- Reduce Motion support (disable animations)

### VoiceOver Labels
```swift
// Example
Button("Rebought") {
    markAsRebought()
}
.accessibilityLabel("Mark as rebought")
.accessibilityHint("Resets the purchase cycle to today")
```

---

## Photography & Graphics

### Illustration Style
- Minimalist, line-based illustrations
- Monochromatic (use accent colors sparingly)
- Clean, geometric shapes

### Empty States
- Simple icon (cart.badge.plus)
- Short, clear message
- Actionable suggestion

### App Icon (Future)
- Simple, recognizable at small sizes
- Circular or rounded square
- Limited color palette (2-3 colors max)
- No text in icon

---

## Notification Copy

### Push Notification Format
```
Title: [Item name]
Body: "Time to rebuy – last purchased [X] days ago"

Example (KR):
Title: "치약"
Body: "재구매 시간입니다 – 60일 전에 구매함"

Example (EN):
Title: "Toothpaste"
Body: "Time to rebuy – last purchased 60 days ago"
```

### Notification Tone
- Non-urgent, informative
- Include context (last purchase date)
- Actionable (tap to mark as rebought)

---

## Error Messages

### Structure
```
[What happened] [Why it might have occurred] [What to do]
```

### Examples
```
Good: "Unable to save item. Check your connection and try again."
Poor: "Error 500. Server failure."

Good: "Notification permission denied. Enable in Settings to receive reminders."
Poor: "Notifications off."
```

---

## Compliance & Legal

### Required Disclosures

**App Store Description:**
- Clear feature list
- Premium pricing prominently displayed
- Privacy summary (data collection)

**In-App:**
- Privacy Policy link (Settings)
- Terms of Service link (Settings)
- Contact support option

### Age Rating
- 4+ (No objectionable content)
- No gambling, violence, or mature themes

---

## File Naming Conventions

### Assets
```
icon_[name]_[size].png
illustration_[context].svg
screenshot_[screen]_[locale].png
```

### Code
```
SwiftUI Views: PascalCase (ContentView.swift)
Services: PascalCase (PersistenceController.swift)
Localization: snake_case (Localizable.strings)
```

---

## Version History

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2025-10-27 | Initial style guide |

---

**Questions?** Contact the design team or update this guide as the brand evolves.
