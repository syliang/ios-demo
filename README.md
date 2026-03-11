# LoginDemo — Bestill

A SwiftUI login demo app ("A still mind begins here") showcasing a custom login flow with state management.

## Prerequisites

- **macOS** with [Xcode](https://developer.apple.com/xcode/) installed
- **Xcode 14+** (download from the Mac App Store or Apple Developer site)
- No external dependencies — pure SwiftUI, no CocoaPods/SPM packages needed

## Setup

### 1. Install Xcode

1. Open the **Mac App Store** and search for **Xcode**, or download it from [developer.apple.com/xcode](https://developer.apple.com/xcode/)
2. Install and launch Xcode
3. On first launch, Xcode will prompt you to install additional components — accept and wait for completion

### 2. Install iOS Simulator

Xcode includes simulators, but you may need to download a specific iOS runtime:

1. Open Xcode → **Settings** (⌘,) → **Platforms** tab
2. Find **iOS** and click the **+** button to download the latest iOS Simulator runtime
3. Wait for the download and installation to complete

### 3. Open the Project

```bash
git clone https://github.com/syliang/ios-demo.git
cd ios-demo/LoginDemo
open LoginDemo.xcodeproj
```

## Running the App

### In the iOS Simulator

1. In Xcode, select a simulator from the device picker in the toolbar (e.g. **iPhone 16**)
2. Press **⌘R** or click the **Run** (▶) button
3. The Simulator will launch and the app will appear automatically

### Login Credentials

The app uses hardcoded demo credentials:

| Field    | Value              |
|----------|--------------------|
| Email    | `user@example.com` |
| Password | `password`         |

Enter these on the login screen to access the home view.

## Project Structure

```
LoginDemo/
├── LoginDemoApp.swift   # App entry point
├── ContentView.swift    # Root view — routes between Login and Home
├── LoginView.swift      # Login screen with custom Lune illustration
└── HomeView.swift       # Home screen shown after successful login
```

## Troubleshooting

**Simulator not showing up in device picker**
Go to Xcode → **Settings** → **Platforms** and ensure an iOS runtime is installed.

**Build errors on first open**
Make sure your Xcode Command Line Tools are set: Xcode → **Settings** → **Locations** → set **Command Line Tools** to your Xcode version.

**"Trust this developer" prompt on device**
If running on a physical device, go to iOS **Settings** → **General** → **VPN & Device Management** → trust your developer certificate.
