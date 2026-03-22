# AbdouTV Flutter App

This repository contains the Flutter client for the AbdouTV streaming dashboard.

## Setup

1. Ensure Flutter is installed and added to your PATH.
2. From the project root (`AbdouTV`), run:

```bash
flutter pub get
```

3. Generate dependency injection / JSON code:

```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

4. Run the app:

```bash
flutter run
```

## Notes

- The API base URL is configured in `lib/src/core/network/api_routes.dart`.
- Place your launcher icon at `assets/icon/app_icon.png` before running `flutter pub run flutter_launcher_icons:main`.
