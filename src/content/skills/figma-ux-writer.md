---
name: figma-ux-writer
description: "เขียน UX Copy ระดับมืออาชีพทั้งภาษาไทยและอังกฤษ — ครอบคลุม microcopy, error messages, onboarding, CTA, empty states, notifications, tooltips, labels ทุกจุดสัมผัสกับผู้ใช้ พร้อมตรวจคำผิด/ไวยากรณ์ทั้งไทย-อังกฤษ และสร้าง Correction Log ใช้ skill นี้เมื่อผู้ใช้ต้องการ: เขียน copy, UX writing, แก้ข้อความ, ปรับภาษา, microcopy, error message, button text, onboarding text, เขียนไทย-อังกฤษ, ตรวจคำผิด, เช็คสะกด, spell check, grammar check, ตรวจสะกด, ตรวจไวยากรณ์, proofread, หรือเมื่อพิมพ์ 'UX writing', 'copy', 'เขียน copy', 'ข้อความ', 'microcopy', 'tone of voice', 'content design', 'ตรวจคำผิด', 'spell check', 'เช็คคำผิด', 'proofread'"
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
4. **Review & Polish**: ตรวจตาม UX Writing Principles + ตรวจคำผิด/ไวยากรณ์ + สร้าง Correction Log
5. **Apply**: ใส่ text เข้า HTML preview หรือ Figma (optional)

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

| Attribute | คำอธิบาย |
|-----------|----------|
| **ชัดเจน** | ตรงประเด็น ไม่อ้อมค้อม อ่านรู้เรื่องในครั้งเดียว |
| **เป็นมิตร** | เข้าถึงง่าย ไม่เป็นทางการเกินไป ไม่ใช่หุ่นยนต์ |
| **ช่วยเหลือ** | บอกสิ่งที่ต้องทำ ไม่ใช่แค่บอกปัญหา |
| **เคารพ** | ไม่โทษผู้ใช้ ไม่ใช้ศัพท์เทคนิคโดยไม่จำเป็น |
| **มั่นใจ** | สื่อสารอย่างแน่นอน ไม่คลุมเครือ |

### 2.2 Tone ตามสถานการณ์

| สถานการณ์ | Tone | ตัวอย่าง (ไทย) | ตัวอย่าง (EN) |
|-----------|------|----------------|---------------|
| สำเร็จ / ยินดี | อบอุ่น, ยินดีด้วย | "สมัครสมาชิกเรียบร้อยแล้ว" | "You're all set!" |
| ข้อผิดพลาด | สงบ, ช่วยเหลือ | "กรอกอีเมลไม่ถูกรูปแบบ ลองตรวจอีกครั้ง" | "That email doesn't look right." |
| คำเตือน | จริงจัง, ชัดเจน | "ลบแล้วจะกู้คืนไม่ได้" | "This can't be undone." |
| รอ / โหลด | ผ่อนคลาย | "กำลังเตรียมข้อมูลให้..." | "Getting things ready..." |
| ว่างเปล่า | ให้กำลังใจ | "ยังไม่มีรายการ เริ่มเพิ่มตัวแรกกันเลย" | "Nothing here yet." |
| Onboarding | ตื่นเต้น | "มาเริ่มกันเลย!" | "Let's get you started!" |
| ขออนุญาต | เปิดเผย | "เราต้องใช้ตำแหน่งเพื่อแสดงร้านค้าใกล้เคียง" | "We need your location." |

### 2.3 Custom Tone
ถ้าผู้ใช้กำหนด brand voice/tone → จดไว้และใช้ตลอด session ปรับตาม tone matrix แต่คง brand voice

---

## Step 3: Write — เขียน Copy ทุกจุดสัมผัส

### 3.1 Copy Types & Guidelines

#### Headlines & Titles
- สั้นกระชับ: ไม่เกิน 5-8 คำ (ไทย) / 3-6 คำ (EN)
- บอก value ไม่ใช่ feature
- ใช้ active voice

#### Buttons & CTAs
- เริ่มด้วยกริยา: บอกว่ากดแล้วจะ "ทำ" อะไร
- เจาะจง: "ยืนยันการสั่งซื้อ" ดีกว่า "ตกลง"
- 2-4 คำ
- Destructive: ใช้คำชัดเจน "ลบบัญชี" + Cancel pair "ยกเลิก"

#### Form Labels & Placeholders
- Label: ชัดเจน สั้น ไม่ลงท้ายด้วย :
- Placeholder: ตัวอย่างจริง ("name@example.com")
- Helper text: อธิบายเพิ่มเมื่อ label ไม่พอ
- Optional: ใช้ "(ไม่บังคับ)" ต่อท้ายดีกว่า * ต่อท้าย required

#### Error Messages
**สูตร: [สิ่งที่เกิดขึ้น] + [วิธีแก้]**
- ไม่โทษผู้ใช้ บอกวิธีแก้ เจาะจง วางใกล้จุดที่ผิด

#### Empty States
**สูตร: [สิ่งที่จะอยู่ตรงนี้] + [ทำอย่างไรให้มี]**

#### Success & Confirmation
- ยืนยันว่าทำสำเร็จ + ข้อมูลสำคัญ (order number, email sent)

#### Confirmation Dialogs (Destructive)
**สูตร: [ผลที่จะเกิดขึ้น] + [ย้อนกลับได้ไหม]**

#### Notifications & Alerts
- Push: สั้น + actionable
- Permission: บอกเหตุผลว่าทำไมต้องขออนุญาต

#### Tooltips & Help Text
- สั้น ตรง ไม่ใช่ "คลิกที่นี่เพื่อ..."

#### Loading & Progress
- บอกว่ากำลังทำอะไร ไม่ใช่แค่ "กำลังโหลด..."

#### Onboarding
- Step title + subtitle อธิบาย value
- CTA + Skip option

### 3.2 ภาษาไทย — หลักการเฉพาะ

- ไม่ใช้ราชาศัพท์ ใช้ภาษาปกติ
- ไม่ห้วนเกินไป ใส่คำนุ่มนวลเล็กน้อย
- ครับ/ค่ะ ใช้ใน chatbot ได้ แต่ UI ปกติไม่จำเป็น
- ใช้คำไทยถ้ามี แต่ทับศัพท์ได้ถ้าคุ้นเคยกว่า
- สะกดทับศัพท์ตามราชบัณฑิต
- ไม่ใช้ "ของคุณ" ทุกที่ ไม่ขึ้นต้นด้วย "กรุณา" ทุกครั้ง

### 3.3 ภาษาอังกฤษ — หลักการเฉพาะ

- Sentence case, Use contractions, Avoid "please"
- Use "you/your" sparingly, Active voice
- Front-load keywords, No jargon, Oxford comma

---

## Step 4: Review & Polish

### 4.1 UX Writing Checklist

| # | Check | คำถาม |
|---|-------|-------|
| 1 | **ชัดเจน** | อ่านครั้งเดียวเข้าใจไหม? |
| 2 | **กระชับ** | ตัดคำไหนออกได้? |
| 3 | **มีประโยชน์** | บอกสิ่งที่ต้องทำต่อไหม? |
| 4 | **เหมาะกับ Tone** | Tone ตรงกับสถานการณ์? |
| 5 | **ไม่โทษผู้ใช้** | ภาษาเชิงบวก/กลางๆ? |
| 6 | **เข้าถึงได้** | หลีกเลี่ยงศัพท์เทคนิค? |
| 7 | **สม่ำเสมอ** | ใช้คำเดียวกันเรียกสิ่งเดียวกัน? |
| 8 | **ครบทุก state** | มี copy สำหรับ success, error, empty, loading? |
| 9 | **ไม่ยาวเกินกรอบ** | text ไม่ล้น container? |
| 10 | **สะกดถูก** | ตรวจ typo, ทับศัพท์? (ดู Section 4.2) |

### 4.2 Spell & Grammar Check

ตรวจคำผิดทุกข้อความ — ทั้งสะกดผิด, ไวยากรณ์ผิด, ทับศัพท์ผิด, เว้นวรรคผิด

**วิธีใช้**: สแกนข้อความ → ตรวจทีละประโยค → แก้ไข → สร้าง Correction Log

**ตารางคำผิด + ไวยากรณ์ + Correction Log format**: ดู `references/ux-writing-spellcheck.md`

#### เมื่อตรวจจาก Figma

```
1. scan_text_nodes(nodeId)                → ดึง text ทั้งหมด
2. ตรวจทุก text node ด้วยหลักการจาก references/ux-writing-spellcheck.md
3. สร้าง Correction Log
4. (Optional) แก้ text: set_multiple_text_contents(parentId, [...])
5. (Optional) ใส่ annotation: set_multiple_annotations({...})
```

### 4.3 Terminology Consistency Table

สร้างตาราง terminology เพื่อให้ทั้ง app ใช้คำเดียวกัน:

```markdown
| Concept | ไทย | English | ห้ามใช้ |
|---------|-----|---------|---------|
| Sign in | เข้าสู่ระบบ | Sign in | ล็อกอิน, Login |
| Sign up | สมัครสมาชิก | Create account | ลงทะเบียน, Register |
| Sign out | ออกจากระบบ | Sign out | ล็อกเอาท์, Logout |
| Password | รหัสผ่าน | Password | พาสเวิร์ด |
| Delete | ลบ | Delete | เอาออก, Remove |
| Save | บันทึก | Save | เซฟ |
| Cancel | ยกเลิก | Cancel | — |
| Settings | การตั้งค่า | Settings | — |
| Search | ค้นหา | Search | เสิร์ช, หา |
```

### 4.4 Character Count

ดูตาราง max character count ต่อ element ที่ `references/ux-writing-spellcheck.md` > Character Count Guidelines

---

## Step 5: Apply — ใส่ Text เข้า Design (Optional)

### Option A: Apply ลง HTML Preview File
- ใช้ Read tool อ่านไฟล์ `.html`
- ใช้ Edit tool แก้ text content โดยตรง
- User refresh browser เห็นผลทันที

### Option B: Apply ลง Figma
```
scan_text_nodes(nodeId)                        → ดู text ทั้งหมด
set_multiple_text_contents(parentId, [...])    → แก้หลาย nodes พร้อมกัน
set_multiple_annotations({...})                → ใส่ annotation อธิบาย copy decisions
```

---

## Output Formats

### Copy Deck Table (Output หลัก)

```markdown
## Copy Deck: [Screen Name]

### Voice & Tone
- Voice: [Standard / Custom]
- Tone: [ตาม situation]

### Copy
| # | Element | Location | ไทย | English | Tone | Max Length | Notes |
|---|---------|----------|-----|---------|------|-----------|-------|

### Terminology
| Concept | ไทย | English |
|---------|-----|---------|
```

### Content Audit Table (เมื่อ review copy ที่มีอยู่)

```markdown
## Content Audit: [Screen Name]
| # | Element | Current Copy | Issue | Recommended | Principle |
|---|---------|-------------|-------|-------------|-----------|
```

---

## หลักการสำคัญ

1. **ชัดเจนเหนือสิ่งอื่นใด**: ถ้าต้องเลือกระหว่างสวยกับชัด เลือกชัด
2. **อ่านครั้งเดียวเข้าใจ**: ผู้ใช้ไม่ควรต้องอ่านซ้ำ
3. **ทุกข้อความมีหน้าที่**: ถ้าตัดออกแล้วไม่เสียอะไร ให้ตัด
4. **ภาษาของผู้ใช้ ไม่ใช่ภาษาของระบบ**: "บันทึกแล้ว" ไม่ใช่ "Data saved successfully"
5. **Bilingual Consistency**: ไทยและอังกฤษสื่อความหมายเดียวกัน ไม่ต้องแปลตรงตัว
6. **ครบทุก State**: default, success, error, empty, loading
7. **Terminology เดียวกันทั้ง App**: ใช้ terminology table ตลอด
8. **Test ด้วยการอ่านออกเสียง**: ถ้าพูดแล้วเข้าใจ เขียนก็เข้าใจ
