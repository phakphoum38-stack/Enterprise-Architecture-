# ARCHITECTURE.md

## แนวทาง
ใช้ Clean Architecture, Hexagonal Architecture และ Platform Adapter Pattern

```text
Flutter UI
    ↓
Application Services
    ↓
Core / Domain
    ↓
Ports
    ↓
Native Platform Adapters
```

## UI Layer
หน้าที่:
- แสดงผล
- รับคำสั่ง
- แสดงแผน
- ขอคำยืนยัน
- แสดงสถานะและผลลัพธ์

ข้อห้าม:
- ห้ามเรียก Native API โดยตรง
- ห้ามรัน Shell หรือ PowerShell โดยตรง
- ห้ามตัดสินความเสี่ยงเอง

## Core Layer
ประกอบด้วย:
- AI Command Engine
- Command Planner
- Risk Classifier
- Permission Engine
- Recorder Engine
- File Engine
- App Management Engine
- Settings Engine
- Diagnostics Engine
- Ad & Tracker Blocking Engine
- Audit Log
- Emergency Stop

## Platform Adapter
ทุกระบบต้องมี Adapter ที่:
- ใช้ Native API ของระบบ
- เคารพ Permission
- รองรับ Cancellation
- ส่งผลจริงกลับมา
- ไม่อ้างว่าสำเร็จเมื่อยังไม่ได้ทำ

## Replaceable UI
Flutter เป็น UI รุ่นแรก แต่สามารถเปลี่ยนเป็น:
- WinUI
- SwiftUI
- Jetpack Compose
- Qt
- Web UI

โดยใช้ Core Contract เดิม
