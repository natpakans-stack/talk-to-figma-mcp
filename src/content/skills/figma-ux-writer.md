---
name: figma-ux-writer
description: "เขียน UX Copy ระดับมืออาชีพทั้งภาษาไทยและอังกฤษ — ครอบคลุม microcopy, error messages, onboarding, CTA, empty states, notifications, tooltips, labels ทุกจุดสัมผัสกับผู้ใช้ ใช้ skill นี้เมื่อผู้ใช้ต้องการ: เขียน copy, UX writing, แก้ข้อความ, ปรับภาษา, microcopy, error message, button text, onboarding text, เขียนไทย-อังกฤษ, หรือเมื่อพิมพ์ 'UX writing', 'copy', 'เขียน copy', 'ข้อความ', 'microcopy', 'tone of voice', 'content design'"
---

# UX Writer Skill

เขียน UX Copy ที่ผู้ใช้อ่านแล้วเข้าใจทันที ไม่มีข้อสงสัย — ทั้งภาษาไทย (หลัก) และอังกฤษ ในระดับมืออาชีพ

## Overall Flow

```
1. Context → 2. Voice & Tone → 3. Write → 4. Review & Polish → 5. Apply (Optional)
```

1. **Context**: เข้าใจหน้าจอ, ผู้ใช้, สถานการณ์
2. **Voice & Tone**: กำหนด voice/tone ให้เหมาะกับ brand + สถานการณ์
3. **Write**: เขียน copy ทุกจุดสัมผัส — ทั้งไทยและอังกฤษ
4. **Review & Polish**: ตรวจตาม UX Writing Principles + ปรับให้สมบูรณ์
5. **Apply**: ใส่ text เข้า Figma ผ่าน MCP (optional)

---

## Step 1: รวบรวม Context

ถามข้อมูลเหล่านี้ (ถ้ายังไม่ได้ระบุ):

- **Screen/Feature**: เขียน copy สำหรับหน้าจอหรือ feature อะไร?
- **User**: ผู้ใช้เป็นใคร? ระดับ tech-savviness?
- **Language**: ไทย, อังกฤษ, หรือทั้งสองภาษา?
- **Situation**: ผู้ใช้กำลังทำอะไรอยู่ตอนเห็นข้อความนี้? อารมณ์ขณะนั้นเป็นอย่างไร?
- **Tone**: มี brand voice/tone ที่กำหนดไว้หรือยัง? (ถ้ายังไม่มี จะใช้ Standard Tone)
- **Existing Design**: มี Figma URL ที่ต้องเขียน copy ใส่ไหม?
- **Scope**: เขียนทั้งหน้า หรือเฉพาะบาง element?

ถ้ามี Figma URL:
```
get_screenshot(fileKey, nodeId)       → ดู visual context
scan_text_nodes(nodeId)               → อ่าน text ที่มีอยู่ทั้งหมด
read_my_design()                      → ดู design ที่เลือก
```

---

## Step 2: Voice & Tone

### 2.1 Standard Voice (ค่าเริ่มต้น)

ใช้เมื่อยังไม่มี brand voice กำหนด:

| Attribute | คำอธิบาย |
|-----------|----------|
| **ชัดเจน** | ตรงประเด็น ไม่อ้อมค้อม อ่านรู้เรื่องในครั้งเดียว |
| **เป็นมิตร** | เข้าถึงง่าย ไม่เป็นทางการเกินไป ไม่ใช่หุ่นยนต์ |
| **ช่วยเหลือ** | บอกสิ่งที่ต้องทำ ไม่ใช่แค่บอกปัญหา |
| **เคารพ** | ไม่โทษผู้ใช้ ไม่ใช้ศัพท์เทคนิคโดยไม่จำเป็น |
| **มั่นใจ** | สื่อสารอย่างแน่นอน ไม่คลุมเครือ |

### 2.2 Tone ตามสถานการณ์

Tone ปรับเปลี่ยนตามบริบท แม้ Voice จะเหมือนกัน:

| สถานการณ์ | Tone | ตัวอย่าง (ไทย) | ตัวอย่าง (EN) |
|-----------|------|----------------|---------------|
| สำเร็จ / ยินดี | อบอุ่น, ยินดีด้วย | "สมัครสมาชิกเรียบร้อยแล้ว" | "You're all set!" |
| ข้อผิดพลาด | สงบ, ช่วยเหลือ | "กรอกอีเมลไม่ถูกรูปแบบ ลองตรวจอีกครั้ง" | "That email doesn't look right. Please check and try again." |
| คำเตือน | จริงจัง, ชัดเจน | "ลบแล้วจะกู้คืนไม่ได้" | "This can't be undone." |
| รอ / โหลด | ผ่อนคลาย | "กำลังเตรียมข้อมูลให้..." | "Getting things ready..." |
| ว่างเปล่า | ให้กำลังใจ, แนะนำ | "ยังไม่มีรายการ เริ่มเพิ่มตัวแรกกันเลย" | "Nothing here yet. Add your first item to get started." |
| Onboarding | ตื่นเต้น, ให้กำลังใจ | "มาเริ่มกันเลย!" | "Let's get you started!" |
| ขออนุญาต | เปิดเผย, ให้เหตุผล | "เราต้องใช้ตำแหน่งของคุณเพื่อแสดงร้านค้าใกล้เคียง" | "We need your location to show nearby stores." |

### 2.3 Custom Tone (ถ้ามี)

ถ้าผู้ใช้กำหนด brand voice/tone:
- จดไว้และใช้ตลอดทั้ง session
- ปรับตาม tone matrix ข้างบน แต่ยังคง brand voice
- ถ้าไม่แน่ใจ → ถามผู้ใช้

---

## Step 3: Write — เขียน Copy ทุกจุดสัมผัส

### 3.1 Copy Types & Guidelines

#### Headlines & Titles

| หลักการ | คำอธิบาย |
|---------|----------|
| สั้นกระชับ | ไม่เกิน 5-8 คำ (ไทย) / 3-6 คำ (EN) |
| บอก value | บอกว่าผู้ใช้ได้อะไร ไม่ใช่บอกว่า feature คืออะไร |
| ใช้ active voice | "จัดการคำสั่งซื้อ" ดีกว่า "คำสั่งซื้อของคุณ" |

```
❌ "ระบบจัดการรายการสินค้าในตะกร้า"
✅ "ตะกร้าของคุณ"

❌ "Feature: Notifications Management"
✅ "Notifications"
```

#### Buttons & CTAs

| หลักการ | คำอธิบาย |
|---------|----------|
| เริ่มด้วยกริยา | บอกว่ากดแล้วจะ "ทำ" อะไร |
| เจาะจง | "บันทึกที่อยู่" ดีกว่า "บันทึก" |
| 2-4 คำ | ไม่ยาวเกินจน button ใหญ่ |
| Primary ≠ Secondary | Primary ชัด, Secondary รอง |

```
❌ "ตกลง" / "OK"
✅ "ยืนยันการสั่งซื้อ" / "Place Order"

❌ "Submit" / "ส่ง"
✅ "สมัครสมาชิก" / "Create Account"

Destructive:
❌ "ตกลง"
✅ "ลบบัญชี" / "Delete Account"

Cancel pair:
✅ "ยกเลิก" + "ลบถาวร"
✅ "Keep" + "Delete Forever"
```

#### Form Labels & Placeholders

| Element | หลักการ |
|---------|---------|
| Label | ชัดเจน, สั้น, ไม่ลงท้ายด้วย : (colon) |
| Placeholder | ตัวอย่างจริง ไม่ใช่คำอธิบาย |
| Helper text | อธิบายเพิ่มเมื่อ label ไม่พอ |
| Required | ใช้ "(ไม่บังคับ)" ต่อท้าย optional ดีกว่าใช้ * ต่อท้าย required |

```
Label:     "อีเมล" / "Email"
Placeholder: "name@example.com"
Helper:    "เราจะส่งรหัสยืนยันไปที่อีเมลนี้"

Label:     "เบอร์โทรศัพท์" / "Phone Number"
Placeholder: "081-234-5678"

Label:     "ชื่อเล่น (ไม่บังคับ)" / "Nickname (optional)"
```

#### Error Messages

**สูตร: [สิ่งที่เกิดขึ้น] + [วิธีแก้]**

| หลักการ | คำอธิบาย |
|---------|----------|
| ไม่โทษผู้ใช้ | "รหัสผ่านไม่ถูกต้อง" ❌ "คุณใส่รหัสผ่านผิด" |
| บอกวิธีแก้ | ไม่ใช่แค่บอกว่าผิด |
| เจาะจง | "กรอกอีเมลให้ถูกรูปแบบ เช่น name@example.com" ดีกว่า "อีเมลไม่ถูกต้อง" |
| วางใกล้จุดที่ผิด | inline ดีกว่า toast |

```
Inline validation:
❌ "ข้อมูลไม่ถูกต้อง" / "Invalid input"
✅ "กรอกอีเมลไม่ถูกรูปแบบ ลองตรวจอีกครั้ง" / "That doesn't look like an email. Try name@example.com"

❌ "Error 500"
✅ "เกิดข้อผิดพลาด กรุณาลองใหม่อีกครั้ง" / "Something went wrong. Please try again."

❌ "ไม่สามารถทำรายการได้"
✅ "ชำระเงินไม่สำเร็จ กรุณาตรวจสอบข้อมูลบัตรแล้วลองอีกครั้ง" / "Payment failed. Please check your card details and try again."

Password:
❌ "รหัสผ่านไม่ผ่านเกณฑ์"
✅ "รหัสผ่านต้องมีอย่างน้อย 8 ตัวอักษร รวมตัวเลข 1 ตัว" / "Use at least 8 characters with 1 number"
```

#### Empty States

**สูตร: [สิ่งที่จะอยู่ตรงนี้] + [ทำอย่างไรให้มี]**

```
❌ "ไม่มีข้อมูล" / "No data"
✅ "ยังไม่มีคำสั่งซื้อ เริ่มช้อปปิ้งกันเลย" / "No orders yet. Start shopping to see them here."

❌ "ไม่พบผลลัพธ์"
✅ "ไม่พบสินค้าที่ค้นหา ลองเปลี่ยนคำค้นหาหรือเลือกดูหมวดหมู่" / "No results for that search. Try different keywords or browse categories."

❌ "ว่าง"
✅ "ยังไม่มีรายการโปรด กดหัวใจบนสินค้าที่ชอบเพื่อเก็บไว้ที่นี่" / "No favorites yet. Tap the heart on items you love to save them here."
```

#### Success & Confirmation

```
✅ "สั่งซื้อเรียบร้อยแล้ว! หมายเลขคำสั่งซื้อ #12345" / "Order placed! Your order number is #12345."
✅ "บันทึกเรียบร้อยแล้ว" / "Saved successfully."
✅ "ส่งอีเมลยืนยันไปที่ name@email.com แล้ว" / "We've sent a confirmation email to name@email.com."
```

#### Confirmation Dialogs (Destructive)

**สูตร: [ผลที่จะเกิดขึ้น] + [ย้อนกลับได้ไหม]**

```
Title:   "ลบบัญชีถาวร?" / "Delete your account?"
Body:    "ข้อมูลทั้งหมดจะถูกลบและไม่สามารถกู้คืนได้ รวมถึงประวัติการสั่งซื้อ รายการโปรด และข้อมูลส่วนตัว"
         / "All your data will be permanently deleted, including order history, favorites, and personal info. This can't be undone."
Buttons: [ยกเลิก] [ลบบัญชีถาวร]
         / [Cancel] [Delete Account Permanently]
```

#### Notifications & Alerts

```
Push:  "คำสั่งซื้อ #12345 จัดส่งแล้ว! ติดตามพัสดุได้ที่นี่"
       / "Order #12345 has shipped! Track your package."

In-app: "อัปเดตเวอร์ชันใหม่พร้อมแล้ว" / "A new version is available."

Permission:
❌ "แอปต้องการเข้าถึงกล้องของคุณ"
✅ "อนุญาตให้ใช้กล้องเพื่อถ่ายรูปสินค้าที่ต้องการค้นหา"
   / "Allow camera access to scan products and search by photo."
```

#### Tooltips & Help Text

```
❌ "คลิกที่นี่เพื่อดูข้อมูลเพิ่มเติม"
✅ "ราคาก่อนหักส่วนลด" / "Price before discount"

❌ "CVV is the security code"
✅ "เลข 3 หลักด้านหลังบัตร" / "3-digit code on the back of your card"
```

#### Loading & Progress

```
❌ "กำลังโหลด..." / "Loading..."
✅ "กำลังเตรียมข้อมูล..." / "Getting things ready..."
✅ "กำลังค้นหาร้านใกล้คุณ..." / "Finding stores near you..."
✅ "อีกสักครู่..." / "Almost there..."

Progress:
✅ "กำลังอัปโหลด (3 จาก 10 รูป)" / "Uploading 3 of 10 photos..."
```

#### Onboarding

```
Step 1: "ค้นหาร้านค้าใกล้บ้าน" / "Find stores near you"
        Subtitle: "เราจะแนะนำร้านค้าที่ดีที่สุดในละแวกของคุณ"
        / "We'll recommend the best stores in your area."

Step 2: "เลือกสินค้าที่ชอบ" / "Pick what you love"
        Subtitle: "เพิ่มสินค้าลงตะกร้า แล้วเราจัดส่งให้ถึงบ้าน"
        / "Add items to your cart and we'll deliver right to your door."

CTA: "เริ่มใช้งาน" / "Get Started"
Skip: "ข้ามไปก่อน" / "Skip for now"
```

### 3.2 ภาษาไทย — หลักการเฉพาะ

| หลักการ | คำอธิบาย | ตัวอย่าง |
|---------|----------|----------|
| ไม่ใช้ราชาศัพท์ | ใช้ภาษาปกติ | "กรุณา" ไม่ใช่ "โปรดกรุณา" |
| ไม่ห้วนเกินไป | ใส่คำนุ่มนวลเล็กน้อย | "ลองอีกครั้ง" ดีกว่า "ทำใหม่" |
| ครับ/ค่ะ ใช้เฉพาะเมื่อเหมาะสม | ใน chatbot ใส่ได้ แต่ใน UI ปกติไม่จำเป็น | UI: "บันทึกแล้ว" / Chat: "บันทึกเรียบร้อยแล้วครับ" |
| หลีกเลี่ยงทับศัพท์ที่มีคำไทย | ถ้ามีคำไทยที่คนเข้าใจ ใช้คำไทย | "เข้าสู่ระบบ" ดีกว่า "ล็อกอิน" |
| ทับศัพท์ได้ถ้าคุ้นเคยกว่า | บางคำทับศัพท์เข้าใจง่ายกว่า | "อีเมล" ดีกว่า "ไปรษณีย์อิเล็กทรอนิกส์" |
| สะกดทับศัพท์ตามราชบัณฑิต | อ้างอิงการสะกดที่เป็นมาตรฐาน | "อีเมล" (ไม่ใช่ อีเมล์), "เว็บไซต์" (ไม่ใช่ เว็ปไซต์) |
| ไม่ใช้ "ของคุณ" ทุกที่ | ใช้เมื่อจำเป็นเท่านั้น | "ตะกร้า" ดีกว่า "ตะกร้าของคุณ" |
| ไม่ขึ้นต้นด้วย "กรุณา" ทุกครั้ง | ใช้เมื่อเป็นการขอร้องจริงๆ | "กรอกอีเมล" ดีกว่า "กรุณากรอกอีเมล" |

### 3.3 ภาษาอังกฤษ — หลักการเฉพาะ

| หลักการ | คำอธิบาย | ตัวอย่าง |
|---------|----------|----------|
| Use sentence case | Capitalize first word only | "Create new account" ไม่ใช่ "Create New Account" |
| Use contractions | ให้เป็นธรรมชาติ | "You're all set" ไม่ใช่ "You are all set" |
| Avoid "please" everywhere | ใช้เมื่อขอร้องจริงๆ | "Enter your email" ไม่ใช่ "Please enter your email" |
| Use "you/your" sparingly | ตัดได้ถ้าไม่จำเป็น | "Cart" ไม่ใช่ "Your cart" |
| Active voice | ชัดเจนกว่า passive | "We sent a code" ไม่ใช่ "A code was sent" |
| Front-load keywords | คำสำคัญอยู่ต้นประโยค | "Password must be 8+ characters" |
| No jargon | ใช้คำง่าย | "Something went wrong" ไม่ใช่ "An unexpected error occurred" |
| Oxford comma | ใช้เมื่อเป็น list | "name, email, and password" |

---

## Step 4: Review & Polish

### 4.1 UX Writing Checklist

ตรวจทุกข้อความด้วย checklist นี้:

| # | Check | คำถาม |
|---|-------|-------|
| 1 | **ชัดเจน** | อ่านครั้งเดียวเข้าใจไหม? ไม่มีข้อสงสัย? |
| 2 | **กระชับ** | ตัดคำไหนออกได้โดยความหมายไม่เปลี่ยน? |
| 3 | **มีประโยชน์** | บอกสิ่งที่ต้องทำต่อไหม? |
| 4 | **เหมาะกับ Tone** | Tone ตรงกับสถานการณ์ไหม? |
| 5 | **ไม่โทษผู้ใช้** | ใช้ภาษาเชิงบวก/กลางๆ ไหม? |
| 6 | **เข้าถึงได้** | หลีกเลี่ยงศัพท์เทคนิค, คำย่อ, idiom? |
| 7 | **สม่ำเสมอ** | ใช้คำเดียวกันเรียกสิ่งเดียวกันทั้ง app? |
| 8 | **ครบทุก state** | มี copy สำหรับ success, error, empty, loading? |
| 9 | **ไม่ยาวเกินกรอบ** | text ไม่ล้น container? พอดีกับ layout? |
| 10 | **สะกดถูก** | ตรวจ typo, การสะกดทับศัพท์? |

### 4.2 Terminology Consistency Table

สร้างตาราง terminology เพื่อให้ทั้ง app ใช้คำเดียวกัน:

```markdown
| Concept | ไทย | English | ห้ามใช้ |
|---------|-----|---------|---------|
| Sign in | เข้าสู่ระบบ | Sign in | ล็อกอิน, Login, Log in |
| Sign up | สมัครสมาชิก | Create account | ลงทะเบียน, Register, Sign up |
| Sign out | ออกจากระบบ | Sign out | ล็อกเอาท์, Logout |
| Password | รหัสผ่าน | Password | พาสเวิร์ด |
| Delete | ลบ | Delete | เอาออก, Remove (ยกเว้น remove from list) |
| Save | บันทึก | Save | เซฟ |
| Cancel | ยกเลิก | Cancel | ยกเลิกการทำรายการ |
| Settings | การตั้งค่า | Settings | ตั้งค่า (ใช้ได้ถ้าสั้นกว่า) |
| Search | ค้นหา | Search | เสิร์ช, หา |
```

ผู้ใช้สามารถเพิ่ม/แก้ terminology table ตามต้องการ

### 4.3 Character Count Guidelines

ตรวจว่า copy ไม่ยาวเกินกรอบ:

| Element | Max (ไทย) | Max (EN) | หมายเหตุ |
|---------|-----------|----------|----------|
| Button | 12 ตัวอักษร | 20 characters | ยิ่งสั้นยิ่งดี |
| Tab label | 8 ตัวอักษร | 12 characters | ไม่ควรตัด |
| Nav item | 8 ตัวอักษร | 12 characters | ไม่ควร 2 บรรทัด |
| Toast/Snackbar | 40 ตัวอักษร | 60 characters | อ่านเร็ว |
| Title | 20 ตัวอักษร | 30 characters | 1 บรรทัด |
| Body text | ตามกรอบ | ตามกรอบ | Line length 45-75 chars |
| Tooltip | 30 ตัวอักษร | 50 characters | สั้นและชัด |
| Error (inline) | 40 ตัวอักษร | 60 characters | พอดี 2 บรรทัด |

---

## Step 5: Apply — ใส่ Text เข้า Figma (Optional)

ถ้ามี Figma design ที่ต้องใส่ copy:

### 5.1 อ่าน Text ที่มีอยู่

```
scan_text_nodes(nodeId)               → ดู text ทั้งหมดในหน้าจอ
read_my_design()                      → ดู design ที่เลือก
```

### 5.2 แก้ Text

```
set_text_content(nodeId, "ข้อความใหม่")              → แก้ทีละ node
set_multiple_text_contents(parentId, [               → แก้หลาย nodes พร้อมกัน
  { nodeId: "title-id", text: "ตะกร้าของคุณ" },
  { nodeId: "subtitle-id", text: "3 รายการ" },
  { nodeId: "button-id", text: "สั่งซื้อ" }
])
```

### 5.3 Annotate

ใส่ annotation อธิบาย copy decisions:
```
set_multiple_annotations({
  nodeId: "screen-id",
  annotations: [
    { nodeId: "error-text-id", labelMarkdown: "**Error copy**\nสูตร: [สิ่งที่เกิด] + [วิธีแก้]\nTone: สงบ, ช่วยเหลือ" },
    { nodeId: "cta-id", labelMarkdown: "**CTA**\nเริ่มด้วยกริยา\nMax 12 ตัวอักษร (TH)" }
  ]
})
```

---

## Output Formats

### Copy Deck Table (Output หลัก)

สำหรับทุกหน้าจอ สร้าง copy deck:

```markdown
## Copy Deck: [Screen Name]

### Voice & Tone
- Voice: [Standard / Custom]
- Tone: [ตาม situation]

### Copy

| # | Element | Location | ไทย | English | Tone | Max Length | Notes |
|---|---------|----------|-----|---------|------|-----------|-------|
| 1 | Page title | Top | ตะกร้า | Cart | neutral | 20 | — |
| 2 | Empty state title | Center | ตะกร้าว่างอยู่ | Your cart is empty | encouraging | 30 | แสดงเมื่อไม่มีสินค้า |
| 3 | Empty state body | Center | เลือกสินค้าที่ชอบแล้วเพิ่มลงตะกร้าได้เลย | Browse products and add items you love | encouraging | 60 | มี CTA ด้านล่าง |
| 4 | Empty state CTA | Center | เลือกสินค้า | Browse Products | encouraging | 12 | ไปหน้า catalog |
| 5 | Error: payment | Bottom | ชำระเงินไม่สำเร็จ ตรวจสอบข้อมูลบัตรแล้วลองอีกครั้ง | Payment failed. Check your card details and try again. | calm, helpful | 60 | inline error |

### Terminology
| Concept | ไทย | English |
|---------|-----|---------|
| Cart | ตะกร้า | Cart |
| Checkout | ชำระเงิน | Checkout |
```

### Content Audit Table (เมื่อ review copy ที่มีอยู่)

```markdown
## Content Audit: [Screen Name]

| # | Element | Current Copy | Issue | Recommended | Principle |
|---|---------|-------------|-------|-------------|-----------|
| 1 | Button | "ตกลง" | ไม่เจาะจง | "ยืนยันคำสั่งซื้อ" | เริ่มด้วยกริยา + เจาะจง |
| 2 | Error | "Error" | ไม่ช่วยเหลือ | "เกิดข้อผิดพลาด ลองใหม่อีกครั้ง" | [สิ่งที่เกิด] + [วิธีแก้] |
| 3 | Empty | "No data" | ไม่แนะนำ action | "ยังไม่มีรายการ เริ่มเพิ่มตัวแรกเลย" | [สิ่งที่จะอยู่] + [ทำอย่างไร] |
```

---

## หลักการสำคัญ

1. **ชัดเจนเหนือสิ่งอื่นใด**: ถ้าต้องเลือกระหว่างสวยกับชัด เลือกชัด
2. **อ่านครั้งเดียวเข้าใจ**: ผู้ใช้ไม่ควรต้องอ่านซ้ำ
3. **ทุกข้อความมีหน้าที่**: ถ้าตัดออกแล้วไม่เสียอะไร ให้ตัด
4. **ภาษาของผู้ใช้ ไม่ใช่ภาษาของระบบ**: "บันทึกแล้ว" ไม่ใช่ "Data saved successfully to database"
5. **Bilingual Consistency**: ไทยและอังกฤษต้องสื่อความหมายเดียวกัน ไม่จำเป็นต้องแปลตรงตัว
6. **ครบทุก State**: ทุกหน้าจอต้องมี copy สำหรับ default, success, error, empty, loading
7. **Terminology เดียวกันทั้ง App**: สร้าง terminology table และใช้ตลอด
8. **Test ด้วยการอ่านออกเสียง**: ถ้าพูดแล้วเข้าใจ เขียนก็เข้าใจ
