# Flutter Badge Controller

A simple Flutter plugin to manage **app icon badges** on **iOS** and **Android**.

- **iOS:** Uses `UIApplication.shared.applicationIconBadgeNumber`.
- **Android:** Sends a broadcast intent (`android.intent.action.BADGE_COUNT_UPDATE`) supported by many OEM launchers (Samsung, Huawei, Xiaomi, etc.).  
  ⚠️ Not all Android launchers support app icon badges. Stock Android (Pixel) only shows badges via notifications.

---

## Features

- Set app icon badge count
- Clear badge
- Get current badge count
- Easy-to-use static API (`FlutterBadgeController`)

---

## Usage

```dart
import 'package:flutter_badge_controller/flutter_badge_controller.dart';

void main() async {
  // Set badge count to 5
  await FlutterBadgeController.setBadgeCount(5);

  // Get current badge count
  int? count = await FlutterBadgeController.getBadgeCount();
  print("Current badge count: $count");

  // Clear badge
  await FlutterBadgeController.clearBadge();
}
```

---

## iOS Setup

1. Make sure to **request notification permission** with `.badge` option:

```swift
import UserNotifications

UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
    if let error = error {
        print("Permission error: \(error)")
    }
}
```

2. Add usage description in `Info.plist` (optional but recommended):

```xml
<key>UIBackgroundModes</key>
<array>
  <string>remote-notification</string>
</array>
```

3. Badge will only show if the user allows notifications.

---

## API

### `FlutterBadgeController.setBadgeCount(int count)`

Set the app icon badge to `count`.

### `FlutterBadgeController.clearBadge()`

Clear the app icon badge (set to 0).

### `FlutterBadgeController.getBadgeCount()`

Get the current app icon badge count.
