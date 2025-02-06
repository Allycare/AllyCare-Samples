# Project Setup Guide

This guide provides instructions to configure and run the project on both iOS and Android, including necessary camera permissions and orientation settings.

---

## 1. Running on iOS

### 1.1 iOS Camera Permission Setup

To enable camera functionality in this project, you need to add the necessary permissions in the `Info.plist` file. Follow these steps:

1. Open your Xcode project.
2. Navigate to the **Info.plist** file.
3. Add the following key-value pair to request camera access from users:

   ```xml
   <key>NSCameraUsageDescription</key>
   <string>This app requires access to the camera for capturing images and videos.</string>
   ```

Failing to include this permission will result in the app being unable to access the camera, leading to potential crashes or limited functionality.

---

### 1.2 Enabling Landscape Orientation

1. Open your Xcode project.
2. Navigate to the **Info.plist** file.
3. Add the following key-value pair to allow landscape orientation:

   ```xml
   <key>UISupportedInterfaceOrientations</key>
   <array>
      <string>UIInterfaceOrientationPortrait</string>
      <string>UIInterfaceOrientationLandscapeLeft</string>
      <string>UIInterfaceOrientationLandscapeRight</string>
   </array>
   ```

---

## 2. Running on Android

### 2.1 Android Camera Permission Setup

To enable camera functionality in this project, you need to add the necessary permissions in the `AndroidManifest.xml` file. Follow these steps:

1. Open your project in **Android Studio**.
2. Navigate to the `AndroidManifest.xml` file located in the `android/app/src/main/` directory.
3. Add the following permissions inside the `<manifest>` tag:

   ```xml
   <uses-permission android:name="android.permission.CAMERA"/>
   <uses-feature android:name="android.hardware.camera"/>
   <uses-feature android:name="android.hardware.camera.autofocus"/>
   ```

Failing to include these permissions will result in the app being unable to access the camera, leading to potential crashes or limited functionality.

---

### 2.2 Enabling Landscape Orientation in Android

To support landscape orientation in Android, modify your `AndroidManifest.xml` file:

1. Open `AndroidManifest.xml`.
2. Inside the `<activity>` tag of your main activity, add the following line:

   ```xml
   <activity
       android:name=".MainActivity"
       android:screenOrientation="unspecified">
   </activity>
   ```

This allows the app to automatically switch between landscape orientations.

---
