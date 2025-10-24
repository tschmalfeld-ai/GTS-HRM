# Building Your Heart Rate Monitor APK

This guide shows you how to automatically build Android APKs using GitHub Actions (100% free).

## Quick Start - Get Your APK in 5 Minutes

### Step 1: Push to GitHub

1. Create a new repository on GitHub (https://github.com/new)
2. Name it something like `heart-rate-monitor`
3. Make it public or private (your choice)
4. **Don't** initialize with README (we already have files)

### Step 2: Push Your Code

In Replit, open the Shell and run these commands:

```bash
# Initialize git (if not already done)
git init

# Add all files
git add .

# Commit
git commit -m "Initial commit - Heart Rate Monitor app"

# Connect to GitHub (replace with your repo URL)
git remote add origin https://github.com/YOUR_USERNAME/heart-rate-monitor.git

# Push to GitHub
git push -u origin main
```

**Note:** If the branch is called `master` instead of `main`, use:
```bash
git branch -M main
git push -u origin main
```

### Step 3: GitHub Automatically Builds Your APK! 🎉

Once you push to GitHub:

1. Go to your GitHub repository
2. Click on **"Actions"** tab at the top
3. You'll see a workflow running called "Build Flutter APK"
4. Wait about 5-10 minutes for it to complete
5. When done, scroll down to **"Artifacts"** section
6. Download **"heart-rate-monitor-apk"**
7. Unzip it and you'll have `app-release.apk`!

## Installing the APK on Your Android Device

### Method 1: Direct Transfer
1. Transfer the APK to your Android phone via USB, email, or cloud storage
2. On your phone, tap the APK file
3. Allow installation from unknown sources if prompted
4. Install and enjoy!

### Method 2: Using ADB (for developers)
```bash
adb install app-release.apk
```

## Building Locally (Alternative Method)

If you prefer to build on your own computer:

### Prerequisites
- Install Flutter: https://docs.flutter.dev/get-started/install
- Install Android Studio: https://developer.android.com/studio

### Build Commands

**Standard APK:**
```bash
flutter build apk --release
```

**Split APKs (smaller size):**
```bash
flutter build apk --split-per-abi --release
```

**App Bundle (for Google Play):**
```bash
flutter build appbundle --release
```

## What Gets Built

The GitHub Action builds **two** versions:

1. **APK** (`app-release.apk`) 
   - Install directly on any Android device
   - Good for sharing with testers
   - Larger file size

2. **App Bundle** (`app-release.aab`)
   - Required for Google Play Store
   - Smaller download size for users
   - Google Play optimizes for each device

## Troubleshooting

### GitHub Actions fails?
- Check that your repository is public or you have GitHub Actions enabled for private repos
- Look at the error logs in the Actions tab

### APK won't install?
- Enable "Install from Unknown Sources" in Android settings
- Make sure you're using Android 5.0 or higher

### App crashes on start?
- This shouldn't happen! The app is tested and working
- If it does, check that your Android version is 5.0+

## Publishing to Google Play Store

If you want to publish to the Play Store:

1. Create a Google Play Developer account ($25 one-time fee)
2. Use the `app-release.aab` file from GitHub Actions
3. Follow Google's submission guidelines
4. Add app description, screenshots, etc.

**Note:** You'll need to:
- Sign the app with a keystore (security requirement)
- Add privacy policy
- Complete Play Store listing

Need help with Play Store publishing? Let me know!

## Updating Your App

Every time you push new code to GitHub:
1. GitHub Actions automatically builds a new APK
2. Download the new version from the Actions artifacts
3. Install it on your device (it will update the existing app)

## Support

If you run into issues:
- Check the GitHub Actions logs for build errors
- Make sure all dependencies in `pubspec.yaml` are up to date
- Verify your Flutter version matches the workflow (3.24.0)

Happy monitoring! 💓
