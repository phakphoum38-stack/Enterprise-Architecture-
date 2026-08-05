# DEVELOPMENT.md

## Developer Package
```text
developer_package/
├── source/
│   ├── flutter_ui/
│   ├── application/
│   ├── core/
│   └── platform_interfaces/
├── native_core/
│   ├── windows/
│   ├── macos/
│   ├── linux/
│   ├── android/
│   ├── ios/
│   └── web/
├── scripts/
├── docs/
├── tests/
├── licenses/
└── VERSION
```

## Flutter Usage
Flutter ใช้สำหรับ:
- UI
- UI Test
- Build
- เชื่อม Core ผ่าน Interface

ผู้ใช้ทั่วไปไม่ต้องติดตั้ง Flutter SDK  
ผู้พัฒนาที่แก้ Flutter UI ต้องติดตั้ง Flutter SDK ที่ตรงกับเวอร์ชันโปรเจกต์

## AI Responsibilities
AI ช่วย:
- สร้างและแก้ไฟล์
- สร้าง Test
- รัน Analyze
- Build
- อ่าน Log
- แก้ Error
- จัดทำ Release Notes

ต้องขอยืนยันก่อน:
- ลบไฟล์จำนวนมาก
- เปลี่ยน Architecture หลัก
- Push Repository
- Publish Release
- ใช้ Signing Certificate
- เข้าถึงบัญชี Store

## Coding Rules
- Core ห้าม import Flutter
- UI ห้ามเรียก Native API โดยตรง
- ทุก Action ต้องผ่าน Application Layer
- ทุก Error ต้องมี Error Code
- ทุกงานสำคัญต้องรองรับ Cancellation
- ห้ามเก็บ Secret ใน Source
