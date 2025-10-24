# 🚀 Quick Start - Get Your APK in 3 Steps

## Step 1: Create GitHub Repository

1. Go to https://github.com/new
2. Repository name: `heart-rate-monitor` (or whatever you like)
3. Choose Public or Private
4. **DON'T** check "Add README" (we have files already)
5. Click **"Create repository"**

## Step 2: Push Your Code

### Option A: Use the Helper Script (Easiest)

In the Replit Shell, run:
```bash
./push-to-github.sh
```

Then set up your GitHub remote:
```bash
git remote add origin https://github.com/YOUR_USERNAME/heart-rate-monitor.git
git push -u origin main
```

### Option B: Manual Commands

```bash
git init
git add .
git commit -m "Heart Rate Monitor app"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/heart-rate-monitor.git
git push -u origin main
```

**Replace `YOUR_USERNAME` with your actual GitHub username!**

## Step 3: Download Your APK

1. Go to your GitHub repository page
2. Click **"Actions"** tab (at the top)
3. Click on the latest workflow run
4. Wait 5-10 minutes for it to finish (you'll see a green checkmark ✓)
5. Scroll down to **"Artifacts"**
6. Click **"heart-rate-monitor-apk"** to download
7. Unzip the downloaded file
8. You'll get `app-release.apk` - this is your app!

## Step 4: Install on Your Android Phone

1. Transfer the APK to your phone (email, USB, Google Drive, etc.)
2. Tap the APK file on your phone
3. Allow "Install from Unknown Sources" if asked
4. Tap "Install"
5. Done! The app is now on your phone 📱

## Using the App

1. Open the app
2. Tap the Bluetooth icon (top right)
3. Turn on your BLE heart rate sensor (chest strap, watch, etc.)
4. Wait for it to appear in the list
5. Tap "Connect"
6. You'll see your live heart rate! 💓
7. Tap "Start Recording" to save your data
8. Tap "View History" to see graphs

## Supported Heart Rate Sensors

Any Bluetooth Low Energy heart rate monitor:
- ✅ Polar H10, H9, H7
- ✅ Garmin HRM straps
- ✅ Wahoo TICKR
- ✅ Most fitness tracker chest straps
- ✅ Some smartwatches

## Need Help?

See `BUILD_INSTRUCTIONS.md` for detailed troubleshooting and options.

---

**That's it! You now have a fully functional heart rate monitoring app! 🎉**
