# MyFit — วางแผนการออกกำลังกาย

เว็บ MyFit ใช้ภาษาไทยสำหรับจัดตาราง ออกกำลังกาย และติดตามความคืบหน้า รองรับบัญชีผู้ใช้และซิงก์ข้อมูลข้ามอุปกรณ์ผ่าน Supabase

## เริ่มใช้บนเครื่อง

1. ติดตั้ง Node.js 20 ขึ้นไป
2. เปิด PowerShell ในโฟลเดอร์โปรเจกต์ แล้วรัน `npm install`
3. สร้างไฟล์ `.env.local` จาก `.env.example`
4. ใส่ Supabase Project URL และ Publishable key ลงใน `.env.local`
5. รัน `npm run dev` แล้วเปิด URL ที่แสดงในหน้าต่างคำสั่ง

หากยังไม่ตั้งค่า Supabase สามารถเลือกใช้โหมดในอุปกรณ์นี้ได้ ข้อมูลโหมดนี้ไม่ซิงก์ข้ามเครื่อง

## ตั้งค่าบัญชีและฐานข้อมูล

1. สร้างโปรเจกต์ใน Supabase
2. เปิด SQL Editor แล้วรันเนื้อหาใน `supabase/schema.sql` เพื่อสร้างตารางและนโยบาย Row Level Security
3. ใน Supabase Authentication ตั้ง Site URL และ Redirect URL ให้ตรงกับ URL ของเว็บ GitHub Pages
4. ใส่ค่า Project URL และ Publishable key ใน `.env.local` เพื่อใช้งานในเครื่อง
5. เปิด GitHub repository → Settings → Secrets and variables → Actions แล้วเพิ่ม Secrets ชื่อ `VITE_SUPABASE_URL` และ `VITE_SUPABASE_PUBLISHABLE_KEY`
6. ตั้ง GitHub Pages ให้ Deploy from GitHub Actions แล้ว push ไป branch `main`

Workflow ใน `.github/workflows/deploy.yml` จะ build และเผยแพร่เว็บให้อัตโนมัติ ใช้เฉพาะ Publishable key ฝั่งเว็บ ฐานข้อมูลจำกัดการอ่าน/เขียนด้วย RLS ให้เข้าถึงได้เฉพาะบัญชีเจ้าของข้อมูล อย่านำ Secret/service-role key ไปใส่ในเว็บหรือ GitHub Actions build variables

## ความสามารถหลัก

- สมัครสมาชิกด้วยอีเมลและรหัสผ่าน พร้อมยืนยันอีเมลตามการตั้งค่า Supabase
- เข้าสู่ระบบ ออกจากระบบ และโหลดข้อมูลส่วนตัวจากฐานข้อมูลบัญชี
- ซิงก์แผนฝึก ประวัติ น้ำหนัก โปรไฟล์ และการตั้งค่าระหว่างอุปกรณ์
- ย้ายข้อมูลเดิมในเบราว์เซอร์นี้เข้าบัญชีโดยอัตโนมัติครั้งแรกที่สร้างบัญชีและเข้าสู่ระบบ
- ใช้ Local Storage ต่อได้ในเครื่อง เมื่อยังไม่ได้ตั้งค่าการเชื่อมต่อออนไลน์
- ข้อมูลของแต่ละบัญชีแยกจากกันด้วย Row Level Security

ข้อมูลในบัญชีเก็บเป็น JSON ต่อผู้ใช้ในตาราง `myfit_user_data` ส่วนไฟล์สื่อเดิมใน IndexedDB ยังอยู่เฉพาะเบราว์เซอร์นั้น และไม่ได้ซิงก์ขึ้นคลาวด์
