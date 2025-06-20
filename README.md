@@ -1 +1,60 @@
# project_smart_attendance
# 📱 Smart Attendance System Using BLE Beacons & Flutter App

A mobile attendance system that uses **Bluetooth Low Energy (BLE) beacons** and a **Flutter** app to automate and track student attendance in real-time. The app integrates with **Firebase** for authentication and data storage.

---

## 🎯 Objective

Build a secure and efficient system for tracking classroom attendance using BLE beacons and a Flutter mobile app that interacts with Firebase.

---

## 🚀 Features

### ✅ Authentication
- Email/password login via Firebase Authentication
- (Optional) OAuth providers (Google, Facebook)

### ✅ BLE Beacon Scanning
- Scan for nearby BLE devices using `flutter_blue_plus`
- Detect beacons, connect, and display:
  - Beacon UUID
  - Signal strength (RSSI)
  - Estimated distance

### ✅ Attendance Logic
- Record attendance when:
  - Beacon distance ≤ 2 meters
  - Beacon detected ≥ 2 minutes
  - Student is logged in and session is active
- Status:
  - **Attended**: Beacon nearby for 2+ minutes
  - **Absent**: No valid beacon detection during session

### ✅ Firebase Integration
- Store in Firestore or Realtime Database:
  - Student profiles (UID, name, email)
  - Beacon info (UUID, class/course, schedule)
  - Attendance records (timestamp, status)

### ✅ Screens
- **Login Screen** – Sign up/login via email or OAuth
- **Home Screen** – Navigation to Take Attendance or View Records
- **Take Attendance** – Scans for beacons and evaluates presence
- **Attendance Records** – View attendance history by course

---

## 📦 Technologies Used

- **Flutter** (Dart)
- **Firebase**: Authentication & Firestore
- **flutter_blue_plus**: BLE scanning
- **Android Studio**: IDE
- **BLE Beacons** (e.g., Estimote, Radius Networks)

---
