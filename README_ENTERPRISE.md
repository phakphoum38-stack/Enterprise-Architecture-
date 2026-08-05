# Phakphum AI System Assistant
## Enterprise Architecture

โปรเจกต์นี้ใช้แนวทาง Enterprise Architecture เพื่อให้พัฒนา ดูแล และเปลี่ยนเทคโนโลยีได้ในระยะยาว

## เป้าหมาย
- แยก UI กับ Core อย่างชัดเจน
- เปลี่ยน UI ได้โดยไม่กระทบระบบหลัก
- รองรับ Windows, macOS, Linux, Android, iOS และ Web
- ให้ AI ช่วยสร้างโค้ด ทดสอบ Build และตรวจ Error
- แยก Release Package สำหรับผู้ใช้ ออกจาก Developer Package
- เก็บ Flutter Runtime ที่จำเป็นไว้ใน Release
- ไม่แจก Flutter SDK ให้ผู้ใช้ทั่วไป
- เปิดให้ผู้พัฒนานำ Source และ Core ไปพัฒนาต่อได้

## โครงสร้าง
```text
UI Layer
  ↓
Application Layer
  ↓
Core Layer
  ↓
Platform Adapter Layer
  ↓
Windows / macOS / Linux / Android / iOS / Web
```

## หลักการ
1. UI ไม่มี Business Logic สำคัญ
2. Core ไม่ขึ้นกับ Flutter
3. ทุก Platform เรียก Core ผ่าน Contract กลาง
4. Native Adapter ต้องรายงานผลจริง
5. งานสำคัญต้องผ่าน Permission Engine
6. Source และ Release ต้องแยกกัน
7. ทุก Release ต้อง Build ซ้ำได้จาก Source
