# Capabilities Configuration

## Analysis
Based on operation guide analysis:
- Local data storage only (SwiftData) → No iCloud capability needed
- No bank linking or network requests → No network capability needed
- FaceID/TouchID app lock → LocalAuthentication
- Daily expense reminders → UserNotifications (Push Notifications)
- Home screen widget → WidgetKit (App Groups for data sharing)
- Siri voice input → SiriKit / App Intents
- No In-App Purchase → No StoreKit capability
- No camera/photo access → No media capability
- No location access → No location capability
- No health data → No HealthKit

## Auto-Configured Capabilities
| Capability | Status | Method |
|------------|--------|--------|
| Push Notifications | ✅ Configured | Xcode project |
| App Groups | ✅ Configured | Xcode project (for widget data sharing) |

## Manual Configuration Required
| Capability | Status | Steps |
|------------|--------|-------|
| LocalAuthentication | ⏳ Pending | No Xcode capability toggle needed - framework import only |
| WidgetKit | ⏳ Pending | Add Widget Extension target in Xcode |
| App Intents (Siri) | ⏳ Pending | No Xcode capability toggle needed - framework import only |

## No Configuration Needed
- iCloud / CloudKit → Local-only storage, no sync
- In-App Purchase → Completely free app
- Camera / Photo Library → No photo features
- Location Services → No location features
- HealthKit → No health data
- Sign in with Apple → No account system
- Background Modes → No background processing needed
- Apple Watch → No Watch companion
- Maps → No map features

## Verification
- Build succeeded after configuration: ✅
- All entitlements correct: ✅
- Bundle ID: com.zzoutuo.Spendy ✅
- Deployment Target: iOS 17.0 ✅
