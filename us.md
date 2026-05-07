# Spendy - iOS Development Guide

## Executive Summary

Spendy is a minimalist expense tracking app designed for the US market that answers one question: "How much did I spend?" Unlike complex budgeting tools like YNAB ($109/year) or Monarch Money ($14.99/month), Spendy shows only three numbers on the home screen: today's spending, this week's spending, and this month's spending. With a 3-second input flow (amount, category, done), Spendy eliminates the friction that causes 80% of users to abandon expense tracking within 14 days. The app stores all data locally, requires no account creation, and collects zero personal information, making it the most private and fastest expense tracker on the App Store.

**Target Audience**: US adults aged 18-45 who want to track spending without the complexity, cost, or privacy concerns of existing finance apps.

**Key Differentiators**:
- 3-second expense input (5-10x faster than competitors)
- Only 3 numbers on screen (zero learning curve)
- Completely free with no subscriptions
- 100% local storage, zero data collection
- No account required, no bank linking

## Competitive Analysis

| App | Strengths | Weaknesses | Our Advantage |
|-----|-----------|------------|---------------|
| YNAB | Comprehensive budgeting, zero-based method, strong community | $109/year, steep learning curve, information overload | Free, zero learning curve, 3 numbers only |
| Rocket Money | Bill negotiation, subscription cancellation, bank sync | Premium $6-12/month, requires bank linking, privacy concerns | No bank linking needed, 100% local, free |
| EveryDollar | Dave Ramsey method, good for budgeting beginners | Premium $17.99/month, limited free version, complex UI | Completely free, 3-second input, minimal UI |
| Expenses: Spending Tracker | Simple, iCloud sync, Apple-featured | Has IAP, more features than needed, 44.8MB size | Lighter, faster input, no IAP, truly free |
| Spending Tracker | Manual tracking, no bank links, simple | Outdated UI, limited analytics, no widgets | Modern SwiftUI, widgets, 3-number dashboard |

## Apple Design Guidelines Compliance

- **HIG - Data Entry**: Quick input flow with decimal pad keyboard, category grid, and single-tap submission follows Apple's guidance on minimizing keyboard interaction
- **HIG - Navigation**: Single-screen dashboard with sheet-based input eliminates navigation complexity
- **HIG - Visual Design**: Uses system fonts (.title.bold(), .subheadline), standard colors, and .ultraThinMaterial for cards following Apple's material design language
- **HIG - Privacy**: All data stored locally with UserDefaults and SwiftData, no network requests, no analytics, no third-party SDKs
- **HIG - Widgets**: WidgetKit implementation for home screen quick-view following Apple's widget design guidelines
- **HIG - Accessibility**: Dynamic Type support, VoiceOver labels on all interactive elements, sufficient color contrast
- **App Store Review Guidelines 5.1.1**: No personal data collection, no tracking, privacy-first approach ensures compliance
- **App Store Review Guidelines 3.1.1**: No IAP, no subscriptions, completely free, no payment-related review issues
- **iOS 26 Liquid Glass**: Use .glassEffect() modifier for card backgrounds to align with the new design system where available, with .ultraThinMaterial fallback

## Technical Architecture

- **Language**: Swift 5.9+
- **Framework**: SwiftUI (primary), WidgetKit, ActivityKit, SwiftData
- **Data**: SwiftData (iOS 17+ primary), UserDefaults for widget data sharing via App Groups
- **Architecture**: MVVM (Model-View-ViewModel)
- **Security**: LocalAuthentication (FaceID/TouchID) for app lock
- **Notifications**: UserNotifications for daily reminders
- **Shortcuts**: App Intents for Siri voice input

## Module Structure

```
Spendy/
├── SpendyApp.swift
├── Views/
│   ├── Dashboard/
│   │   ├── DashboardView.swift
│   │   └── SpendCardView.swift
│   ├── AddExpense/
│   │   ├── QuickAddExpenseView.swift
│   │   └── CategoryButtonView.swift
│   ├── History/
│   │   ├── HistoryView.swift
│   │   └── ExpenseRowView.swift
│   ├── Settings/
│   │   ├── SettingsView.swift
│   │   └── ContactSupportView.swift
│   └── Onboarding/
│       └── OnboardingView.swift
├── ViewModels/
│   └── ExpenseViewModel.swift
├── Models/
│   ├── Expense.swift
│   └── ExpenseCategory.swift
├── Services/
│   ├── NotificationService.swift
│   └── WidgetDataService.swift
├── Widgets/
│   ├── SpendyWidget.swift
│   └── SpendyWidgetBundle.swift
└── Extensions/
    └── Color+Extensions.swift
```

## Implementation Flow

1. Create data models (Expense, ExpenseCategory) with SwiftData @Model
2. Build ExpenseViewModel with CRUD operations and period calculations
3. Implement DashboardView with ThreeNumberDashboard (today/week/month)
4. Build QuickAddExpenseView with 3-second input flow
5. Create HistoryView with chronological expense list
6. Add SettingsView with app lock, daily reminder, and policy links
7. Implement WidgetKit widget for home screen
8. Add OnboardingView for first-launch experience
9. Configure App Groups for widget data sharing
10. Add LocalAuthentication for FaceID/TouchID lock
11. Add UserNotifications for daily expense reminders
12. Test on iPhone XS Max and iPad Pro 13-inch (M4)

## UI/UX Design Specifications

- **Color Scheme**: System blue (#007AFF) for primary, system purple (#AF52DE) for week, system green (#34C759) for month, system background for cards
- **Typography**: SF Pro, .title.bold() for amounts, .subheadline for labels, .caption for secondary text
- **Layout**: Single-column dashboard, 2-column category grid (4 per row), full-width action button
- **Cards**: .ultraThinMaterial background, 16pt corner radius, 16pt padding
- **Animations**: .spring() for category selection, .transition(.move(edge: .bottom)) for add sheet
- **Input**: Decimal pad keyboard with auto-focus, category tap-to-select, single "Add" button
- **iPad**: Max content width 720pt, centered layout, no sidebar restrictions
- **Dark Mode**: Full support using semantic colors (.primary, .secondary, .ultraThinMaterial)

## Code Generation Rules

- Use SwiftData @Model for all data models
- Use @Observable for ViewModels (not ObservableObject)
- Use @Environment(\.modelContext) for data access
- Use .sheet for add expense flow
- Use .presentationDetents([.medium]) for add sheet
- All SwiftUI views must support Dynamic Type
- No third-party dependencies
- No comments in code unless asked
- All attributes in SwiftData models must be optional or have default values
- Use .frame(maxWidth: 720).frame(maxWidth: .infinity) for iPad content

## Build & Deployment Checklist

- [ ] Verify Bundle ID: com.zzoutuo.Spendy
- [ ] Verify Deployment Target: iOS 17.0
- [ ] Verify Swift Language Version: 5.0+
- [ ] App Icon configured in Asset Catalog
- [ ] Capabilities configured (if any)
- [ ] Build succeeds on iPhone simulator
- [ ] Build succeeds on iPad simulator
- [ ] Widget target added and configured
- [ ] App Group configured for widget data sharing
- [ ] Privacy Policy page deployed
- [ ] Support page deployed
- [ ] App Store metadata prepared (keytext.md)
- [ ] Push to GitHub repository
