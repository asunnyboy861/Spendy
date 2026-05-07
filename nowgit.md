# Git Repositories

## Main App (iOS Application)

| Item | Value |
|------|-------|
| **Repository Name** | Spendy |
| **Git URL** | git@github.com:asunnyboy861/Spendy.git |
| **Repo URL** | https://github.com/asunnyboy861/Spendy |
| **Visibility** | Public |
| **Primary Language** | Swift |
| **GitHub Pages** | ✅ **ENABLED** (from `/docs` folder) |

## Policy Pages (Deployed from Main Repository /docs)

| Page | URL | Status |
|------|-----|--------|
| Landing Page | https://asunnyboy861.github.io/Spendy/ | ✅ Active |
| Support | https://asunnyboy861.github.io/Spendy/support.html | ✅ Active |
| Privacy Policy | https://asunnyboy861.github.io/Spendy/privacy.html | ✅ Active |

Note: Terms of Use not required for Free apps.

## Repository Structure

```
Spendy/
├── Spendy/                           # iOS App Source Code
│   ├── Spendy.xcodeproj/             # Xcode Project
│   ├── Spendy/                       # Swift Source Files
│   │   ├── Views/
│   │   │   ├── Dashboard/
│   │   │   ├── AddExpense/
│   │   │   ├── History/
│   │   │   ├── Settings/
│   │   │   └── Onboarding/
│   │   ├── Models/
│   │   ├── ViewModels/
│   │   └── Assets.xcassets/
│   └── ...
├── docs/                             # Policy Pages (GitHub Pages source)
│   ├── index.html                    # Landing Page
│   ├── support.html                  # Support Page
│   └── privacy.html                  # Privacy Policy
├── .github/workflows/
│   └── deploy.yml                    # GitHub Pages deployment
├── us.md                             # English Development Guide
├── keytext.md                        # App Store Metadata
├── capabilities.md                   # Capabilities Configuration
├── icon.md                           # App Icon Details
├── price.md                          # Pricing Configuration
└── nowgit.md                         # This File
```
