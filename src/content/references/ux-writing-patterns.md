# UX Writing Patterns Reference

รวม patterns จากหนังสือ UX Writing ชั้นนำ: Strategic Writing for UX (Torrey Podmajersky), Nicely Said (Nicole Fenton & Kate Kifer Lee), Because Internet (Gretchen McCulloch)

---

## Voice Chart System (6 Dimensions)

ใช้กำหนด Brand Voice อย่างเป็นระบบ — ทุก dimension ต้องมีทั้ง "ใช่" และ "ไม่ใช่":

| Dimension | คำอธิบาย | ตัวอย่าง "ใช่" | ตัวอย่าง "ไม่ใช่" |
|-----------|----------|----------------|-------------------|
| **Concepts** | แนวคิด/metaphor ที่ brand ใช้ | ใช้คำเปรียบเทียบจากธรรมชาติ | ไม่ใช้ศัพท์เทคนิค/jargon |
| **Vocabulary** | ระดับคำศัพท์ | ใช้คำง่ายที่คนทั่วไปเข้าใจ | ไม่ใช้คำทางการเกินไป |
| **Verbosity** | ความยาว/รายละเอียด | กระชับ ตรงประเด็น | ไม่ยืดเยื้อ ไม่ซ้ำซ้อน |
| **Grammar** | โครงสร้างประโยค | ใช้ active voice, ประโยคสั้น | ไม่ใช้ passive voice ยกเว้นจำเป็น |
| **Punctuation** | เครื่องหมายวรรคตอน | ใช้ ... สำหรับ loading states | ไม่ใช้ ! มากเกินไป (>1 ต่อหน้า) |
| **Capitalization** | ตัวพิมพ์ใหญ่-เล็ก (EN) | Sentence case ทุกที่ | ไม่ใช้ ALL CAPS ยกเว้น acronym |

### Voice Chart Template

```markdown
## Voice Chart: [Brand Name]

### Concepts
- ✅ ใช้: [metaphor/แนวคิดที่ตรงกับ brand]
- ❌ ไม่ใช้: [metaphor ที่ขัดกับ brand]

### Vocabulary
- ✅ ใช้: [ระดับคำศัพท์ที่เหมาะสม]
- ❌ ไม่ใช้: [คำที่หลีกเลี่ยง]

### Verbosity
- ✅ ใช้: [ระดับความยาว/รายละเอียด]
- ❌ ไม่ใช้: [ระดับที่ไม่เหมาะ]

### Grammar
- ✅ ใช้: [โครงสร้างที่ใช้]
- ❌ ไม่ใช้: [โครงสร้างที่หลีกเลี่ยง]

### Punctuation
- ✅ ใช้: [เครื่องหมายที่ใช้ + เมื่อไหร่]
- ❌ ไม่ใช้: [เครื่องหมายที่หลีกเลี่ยง]

### Capitalization (EN)
- ✅ ใช้: [รูปแบบที่ใช้]
- ❌ ไม่ใช้: [รูปแบบที่หลีกเลี่ยง]
```

---

## 11 UX Text Patterns

### Pattern 1: Titles (หัวข้อ)
- **หน้าที่**: บอก user ว่าอยู่ที่ไหน / กำลังทำอะไร
- **ความยาว**: 1-5 คำ (ยิ่งสั้นยิ่งดี)
- **กฎ**: ใช้ noun phrase หรือ verb phrase สั้นๆ
- **ไทย**: "ตั้งค่า", "ประวัติการสั่งซื้อ", "บัญชีของฉัน"
- **EN**: "Settings", "Order history", "My account"

### Pattern 2: Buttons / Links / Commands (1-2 คำ ดีที่สุด)
- **หน้าที่**: บอก user ว่ากดแล้วจะเกิดอะไร
- **ความยาว**: 1-2 คำ perform ดีที่สุด, สูงสุด 4 คำ
- **กฎ**:
  - เริ่มด้วย verb เสมอ: "บันทึก", "ส่ง", "ยกเลิก"
  - Match button text กับ title: ถ้า title คือ "ลบบัญชี" → button = "ลบบัญชี" ไม่ใช่ "ตกลง"
  - Destructive: ใช้คำตรง "ลบ", "ยกเลิกการสมัคร" ไม่ใช่ "ตกลง"
  - คู่ปุ่ม: Primary action ชัดเจน + Secondary ใช้ "ยกเลิก" หรือ "ย้อนกลับ"

| Pattern | ไทย | EN | ใช้เมื่อ |
|---------|-----|-----|---------|
| Verb-only | บันทึก | Save | Action ชัดเจนจาก context |
| Verb + Object | บันทึกที่อยู่ | Save address | ต้องการความชัดเจน |
| Verb + Benefit | เริ่มทดลองฟรี | Start free trial | CTA ที่ต้องการ conversion |

### Pattern 3: Descriptions (คำอธิบาย)
- **หน้าที่**: อธิบายเพิ่มเติมจาก title
- **ความยาว**: < 40 ตัวอักษรกว้าง, ไม่เกิน 3 บรรทัด
- **กฎ**: ตอบ "ทำไมต้องสนใจ?" ไม่ใช่ "มันคืออะไร?"
- **ไทย**: "เพิ่มที่อยู่จัดส่งเพื่อให้สั่งซื้อได้เร็วขึ้น"
- **EN**: "Add a shipping address to check out faster"

### Pattern 4: Empty States
- **สูตร**: "หากต้องการ [ผลลัพธ์] ให้ [ทำ action]"
- **หน้าที่**: บอก (1) สิ่งที่จะอยู่ตรงนี้ + (2) วิธีให้มัน appear
- **ไทย**: "ยังไม่มีรายการโปรด แตะ ♡ บนสินค้าที่ชอบ"
- **EN**: "No favorites yet. Tap ♡ on items you like"
- **ห้าม**: ไม่ใช้ "ไม่มีข้อมูล" / "No data" — ไม่ช่วยอะไร

### Pattern 5: Labels (ป้ายกำกับ)
- **หน้าที่**: ระบุชื่อ element อย่างชัดเจน
- **ความยาว**: 1-3 คำ
- **กฎ**: ใช้ noun, ไม่ลงท้ายด้วย : (colon)
- **ไทย**: "ชื่อ", "อีเมล", "เบอร์โทรศัพท์"
- **EN**: "Name", "Email", "Phone number"

### Pattern 6: Controls (ตัวควบคุม)
- **หน้าที่**: อธิบาย toggle, checkbox, radio, dropdown
- **กฎ**: ใช้ phrase ที่อ่านเป็นประโยคได้เมื่อรวมกับ control
  - Toggle: "รับการแจ้งเตือน" → on = ใช่ / off = ไม่
  - Checkbox: "ฉันยอมรับเงื่อนไขการใช้งาน"
  - Radio: แต่ละตัวเลือกเป็น noun phrase
- **ไทย**: "รับข่าวสารทางอีเมล", "จดจำอุปกรณ์นี้"
- **EN**: "Receive email updates", "Remember this device"

### Pattern 7: Text Input Fields (ช่อง input)
- **องค์ประกอบ**: Label + Placeholder + Helper + Error
- **Placeholder**: ใช้ตัวอย่างจริง ไม่ใช่ "กรอก..."
  - ✅ "name@example.com"
  - ❌ "กรอกอีเมลของคุณ"
- **Helper text**: แสดงก่อนกรอก (format, ข้อจำกัด)
  - ✅ "ใช้ตัวอักษร 8-20 ตัว รวมตัวเลขอย่างน้อย 1 ตัว"
- **Error text**: แสดงเมื่อผิด (ดู Pattern 11)

### Pattern 8: Transitional Text (ข้อความระหว่างทาง)
- **หน้าที่**: บอก user ว่าระบบกำลังทำอะไร
- **กฎ**: บอก "กำลังทำอะไร" ไม่ใช่แค่ "กำลังโหลด"
- **ตัวอย่าง**:
  - ✅ "กำลังบันทึกการเปลี่ยนแปลง..."
  - ✅ "กำลังตรวจสอบข้อมูล..."
  - ❌ "กำลังโหลด..."
  - ❌ "กรุณารอสักครู่..."
- **Progress**: ถ้ารู้ % → บอก %, ถ้าไม่รู้ → ใช้ ... (ellipsis)

### Pattern 9: Confirmation Messages (ข้อความยืนยัน)
- **สูตร**: "[Action] + [ผลลัพธ์] + [ขั้นตอนถัดไป (ถ้ามี)]"
- **ไทย**: "สั่งซื้อเรียบร้อย จะจัดส่งภายใน 3-5 วัน"
- **EN**: "Order confirmed. You'll receive it in 3-5 days."
- **กฎ**:
  - ใช้ past tense / สำเร็จแล้ว
  - ให้ข้อมูลสำคัญ (เลขออเดอร์, เวลาจัดส่ง, อีเมลที่ส่งไป)
  - มี next step ถ้า relevant

### Pattern 10: Notifications (การแจ้งเตือน)
- **Push notification สูตร**: "[Source]: [Content] + [Action hint]"
  - ✅ "คำสั่งซื้อ #1234 กำลังจัดส่ง — ติดตามพัสดุ"
  - ❌ "มีข้อความใหม่" (ไม่ actionable)
- **In-app notification**:
  - Banner: สั้น 1 บรรทัด + action link
  - Toast: auto-dismiss 4-6 วินาที + optional undo
  - Badge: ตัวเลขเท่านั้น (ไม่มี text)
- **Permission request สูตร**: "[ทำไม] + [ประโยชน์ที่ได้]"
  - ✅ "เปิดการแจ้งเตือนเพื่อรับสถานะคำสั่งซื้อ"
  - ❌ "อนุญาตให้ส่งการแจ้งเตือน"

### Pattern 11: Error Messages
- **หลักการหลัก**: "สอนวิธีทำให้ถูก อย่าบอกว่าทำผิด"
- **ห้ามใช้คำ**: "invalid", "failed", "disabled", "ไม่ถูกต้อง", "ผิดพลาด" (ถ้าเลี่ยงได้)

**3 ประเภท Error:**

| Type | ตำแหน่ง | ตัวอย่างไทย | ตัวอย่าง EN |
|------|---------|-------------|-------------|
| **Inline** | ใต้ input ที่ผิด | "ใช้ตัวอักษร 8-20 ตัว" | "Use 8-20 characters" |
| **Detour** | Banner/Toast | "อีเมลนี้มีบัญชีแล้ว — เข้าสู่ระบบ" | "This email has an account — sign in" |
| **Blocking** | Full-screen/Dialog | "ไม่สามารถเชื่อมต่อเซิร์ฟเวอร์ ลองอีกครั้ง" | "Can't reach the server. Try again." |

**Error Message Formula:**
```
[สิ่งที่เกิดขึ้น (ถ้าจำเป็น)] + [วิธีแก้ไข]
```

- Inline: ข้ามส่วนแรก ไปที่วิธีแก้เลย
  - ✅ "ใช้ตัวอักษรอย่างน้อย 8 ตัว"
  - ❌ "รหัสผ่านสั้นเกินไป"
- Detour/Blocking: ทั้งสองส่วน
  - ✅ "การชำระเงินไม่สำเร็จ กรุณาตรวจสอบข้อมูลบัตร"

---

## 4-Phase Editing Process

ตรวจ copy ทุกครั้งด้วย 4 เฟส (จาก Nicely Said):

### Phase 1: Purposeful (มีจุดประสงค์)
- ข้อความนี้ช่วย user ทำอะไร?
- ตัดข้อความที่ไม่มีจุดประสงค์ออก
- ทุกข้อความต้อง advance user's goal

### Phase 2: Concise (กระชับ)
- ตัดคำที่ไม่เพิ่มความหมาย
- "ทำการบันทึก" → "บันทึก"
- "คุณสามารถแก้ไขได้" → "แก้ไขได้"
- "Please enter your email address" → "Enter your email"

### Phase 3: Conversational (เป็นธรรมชาติ)
- อ่านออกเสียง — ถ้าพูดแบบนี้จริงไหม?
- ใช้ contractions (EN): "you'll", "we're", "can't"
- ไม่ทางการเกินไป ไม่ casual เกินไป
- ตรวจ: "ถ้าพูดกับเพื่อนจะพูดแบบนี้ไหม?"

### Phase 4: Clear (ชัดเจน)
- อ่านครั้งเดียวเข้าใจไหม?
- ตัด ambiguity ทุกจุด
- ตรวจ: "คนที่ไม่รู้ context จะเข้าใจไหม?"

---

## UX Content Heuristics Scorecard

ให้คะแนน copy ตาม 2 มิติ (น้ำหนัก: Usability 2/3, Voice 1/3):

### Usability Heuristics (2/3 น้ำหนัก)

| # | Heuristic | คำถาม | คะแนน (1-5) |
|---|-----------|-------|-------------|
| 1 | **Accessible** | ผู้พิการใช้ได้ไหม? (screen reader, alt text, aria-label) | — |
| 2 | **Findable** | หาข้อความนี้เจอง่ายไหม? อยู่ถูกที่ไหม? | — |
| 3 | **Clear** | อ่านครั้งเดียวเข้าใจไหม? ไม่ ambiguous? | — |
| 4 | **Useful** | ช่วย user ทำสิ่งที่ต้องการได้จริงไหม? | — |
| 5 | **Appropriate** | เหมาะกับ context/สถานการณ์ไหม? | — |
| 6 | **Translatable** | แปลเป็นภาษาอื่นได้ง่ายไหม? ใช้ idiom ไหม? | — |

### Voice Heuristics (1/3 น้ำหนัก)

| # | Heuristic | คำถาม | คะแนน (1-5) |
|---|-----------|-------|-------------|
| 1 | **Concepts** | ใช้ metaphor/แนวคิดตรง brand voice ไหม? | — |
| 2 | **Vocabulary** | ใช้คำศัพท์ตรง voice chart ไหม? | — |
| 3 | **Verbosity** | ความยาวเหมาะสมตาม voice chart ไหม? | — |
| 4 | **Grammar** | โครงสร้างประโยคตรง voice chart ไหม? | — |
| 5 | **Punctuation** | เครื่องหมายวรรคตอนตรง voice chart ไหม? | — |
| 6 | **Capitalization** | ตัวพิมพ์ใหญ่-เล็กตรง voice chart ไหม? | — |

### คำนวณคะแนน
```
Usability Score = average(U1-U6) × (2/3)
Voice Score = average(V1-V6) × (1/3)
Total = Usability Score + Voice Score (out of 5)
```

| คะแนน | ระดับ | ความหมาย |
|-------|-------|----------|
| 4.5-5.0 | ดีเยี่ยม | Ship ได้เลย |
| 3.5-4.4 | ดี | ปรับเล็กน้อย |
| 2.5-3.4 | ปานกลาง | ต้อง revise |
| 1.0-2.4 | ต้องปรับปรุง | เขียนใหม่ |

---

## Inclusivity & Sensitivity Rules

### ภาษาที่ควรหลีกเลี่ยง

| ❌ หลีกเลี่ยง | ✅ ใช้แทน | เหตุผล |
|---------------|-----------|--------|
| คนพิการ | ผู้พิการ / คนที่มีความพิการ | People-first language |
| ปกติ / ไม่ปกติ | ทั่วไป / พบได้น้อย | "ปกติ" imply ว่าอีกอย่างผิดปกติ |
| ง่ายๆ / แค่... | (ตัดออก) | อาจไม่ง่ายสำหรับทุกคน |
| Master/Slave | Primary/Replica | Inclusive terminology |
| Whitelist/Blacklist | Allowlist/Blocklist | Inclusive terminology |
| Hey guys | ทุกคน / Hi everyone | Gender-neutral |
| He/She | They | Gender-neutral pronoun |

### กฎ Inclusive Writing
1. ไม่สมมติเพศ, อายุ, ความสามารถ, วัฒนธรรม
2. ไม่ใช้สำนวน/idiom ที่แปลยาก (localization)
3. ใช้ภาษา positive — บอกว่า "ทำได้" ไม่ใช่ "ทำไม่ได้"
4. ตรวจ alt text ทุกรูป, aria-label ทุก interactive element
5. ไม่ใช้สีเป็นตัวสื่อความหมายเพียงอย่างเดียว

---

## Localization Considerations

### กฎ 50-67%
เมื่อเขียนภาษาอังกฤษ ใช้พื้นที่เพียง 50-67% ของที่มี — เพราะเมื่อแปลเป็นภาษาอื่น text จะยาวขึ้น 30-50%

| ภาษา EN | ภาษาอื่น (ประมาณ) | สัดส่วน |
|---------|-------------------|---------|
| "Save" | "บันทึก" | 1:1 |
| "Sign in" | "เข้าสู่ระบบ" | 1:2 |
| "Forgot password?" | "ลืมรหัสผ่านใช่ไหม?" | 1:1.5 |
| "Delete account" | "ลบบัญชีผู้ใช้" | 1:1.3 |

### Localization-Friendly Writing
- ไม่ concatenate strings: ❌ `"Hello " + name + "!"`  ✅ `"Hello {name}!"`
- ไม่ใช้ idiom: ❌ "a piece of cake"  ✅ "easy"
- ไม่ hardcode วันที่/เวลา format
- ไม่ embed text ในรูปภาพ
- รองรับ text direction (LTR/RTL)

---

## Internet Language Conventions (From "Because Internet")

### Tone Indicators ในยุคดิจิทัล
- **Period (.)**: ในข้อความสั้น "." อาจรู้สึก "โกรธ" หรือ "เย็นชา" → ใช้เฉพาะ UI formal, ไม่ใช้ใน chat/toast
- **Exclamation (!)**: 1 ตัว = กระตือรือร้น, >1 ตัว = ไม่เป็นมืออาชีพ → ใช้ไม่เกิน 1 ต่อหน้า
- **Ellipsis (...)**: สื่อ "กำลังคิด" หรือ "ยังไม่จบ" → ดีสำหรับ loading, ไม่ดีสำหรับ error
- **Emoji**: ช่วย convey tone ใน casual context → ใช้ได้ใน success/celebration, ไม่ใช้ใน error/formal
- **ALL CAPS**: = ตะโกน → ใช้เฉพาะ brand ที่ต้องการ bold personality, ไม่ใช้ใน body text

### Formal vs Informal Spectrum
```
FORMAL ←──────────────────────────────────→ INFORMAL
Legal    Banking    E-com    Social    Gaming    Chat
```

ปรับ voice ตาม product type:
- **Formal** (Banking, Legal): ไม่ใช้ contractions, ไม่ใช้ emoji, ใช้ full sentences
- **Neutral** (E-com, Productivity): Contractions OK, no emoji in errors, sentence fragments OK
- **Informal** (Social, Gaming): Emoji OK, slang OK in moderation, fragments encouraged

---

## Copy Audit Quick Reference

### Red Flags (ต้องแก้ทันที)
1. Button ที่เขียน "ตกลง" / "OK" / "Submit" — ไม่บอกว่าจะเกิดอะไร
2. Error ที่เขียน "เกิดข้อผิดพลาด" — ไม่บอกวิธีแก้
3. Empty state ที่เขียน "ไม่มีข้อมูล" — ไม่กระตุ้น action
4. Loading ที่เขียน "กำลังโหลด..." — ไม่บอกว่าโหลดอะไร
5. Permission ที่ไม่อธิบายเหตุผล
6. Title ที่ยาวเกิน 5 คำ
7. Description ที่ยาวเกิน 3 บรรทัด
8. ใช้ passive voice: "ข้อมูลถูกบันทึก" → "บันทึกแล้ว"
9. ใช้ "กรุณา" ทุกที่ → ตัดออก ใช้เฉพาะเมื่อขอสิ่งพิเศษ
10. Inconsistent terminology — เรียกสิ่งเดียวกันหลายชื่อ

### Green Flags (เขียนดีแล้ว)
1. Button text ตรงกับ context: "ลบบัญชี" ไม่ใช่ "ยืนยัน"
2. Error message บอกทั้งปัญหาและวิธีแก้
3. Empty state มี CTA ที่ actionable
4. Loading บอกว่ากำลังทำอะไร
5. Tone ตรงกับอารมณ์ของ user ณ จุดนั้น
6. ใช้ terminology เดียวกันทั้ง app
7. อ่านครั้งเดียวเข้าใจ
8. กระชับ — ตัดคำที่ไม่จำเป็นออกแล้ว
