# SECURITY.md

## Permission Levels

### Safe
- เปิดแอป
- เปิดหน้าตั้งค่า
- อ่านสถานะระบบ
- ค้นหาไฟล์

### Confirmation Required
- เริ่มบันทึกหน้าจอ
- ปิดหรือรีสตาร์ตแอป
- เปลี่ยนค่าระบบ
- ย้ายไฟล์จำนวนมาก
- ติดตั้งหรือถอนโปรแกรม
- ปิดหรือรีสตาร์ตเครื่อง

### Restricted
- บันทึกหน้าจอหรือไมค์แบบลับ
- ข้าม Permission
- ปิดระบบความปลอดภัย
- รัน Shell แบบไม่จำกัด
- ลบถาวรโดยไม่ยืนยัน
- ส่งข้อมูลส่วนตัวโดยไม่อนุญาต

## Audit Log
ทุก Action ต้องบันทึก:
- Command ID
- เวลา
- Platform
- Action
- Permission Result
- Confirmation Result
- Execution Result
- Error Code
- Duration

## Emergency Stop
ต้อง:
- หยุด Action ปัจจุบัน
- ยกเลิก Queue
- หยุด Recording
- หยุด Automation
- แจ้งผู้ใช้
- บันทึก Audit Log
