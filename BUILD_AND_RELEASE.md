# BUILD_AND_RELEASE.md

## Source Package
สำหรับผู้พัฒนา:
```text
source/
native_core/
docs/
scripts/
tests/
pubspec.yaml
```

## Release Package
สำหรับผู้ใช้ทั่วไป:

### Windows
```text
PhakphumAI.exe
flutter_windows.dll
data/
plugins/
native_core.dll
```

### Android
```text
PhakphumAI.apk
PhakphumAI.aab
```

### macOS
```text
PhakphumAI.app
PhakphumAI.dmg
```

### Linux
```text
PhakphumAI.AppImage
PhakphumAI.deb
```

### Web
```text
build/web/
```

## Flutter Runtime Policy
- เก็บ Flutter Runtime ที่จำเป็นไว้ใน Release
- ห้ามลบ Runtime ที่แอปต้องใช้
- ไม่แจก Flutter SDK ให้ผู้ใช้ทั่วไป
- ไม่รวม Source Code ใน Release
- เก็บ Source ใน Developer Package และ Repository

## Build Pipeline
```text
Checkout
  ↓
Dependency Restore
  ↓
Format Check
  ↓
Static Analysis
  ↓
Tests
  ↓
Platform Build
  ↓
Package Validation
  ↓
Signing
  ↓
Release Artifact
```

## Release Validation
- แอปเปิดได้
- UI เชื่อม Core ได้
- Permission ทำงาน
- Emergency Stop ใช้ได้
- ไม่มี Source หลุดใน Release
- ไม่มี API Key หรือ Secret
- มี Third-party License Notices
