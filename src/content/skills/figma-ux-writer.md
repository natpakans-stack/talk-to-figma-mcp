---
name: figma-ux-writer
description: "เขียน UX Copy ระดับมืออาชีพทั้งภาษาไทยและอังกฤษ — ครอบคลุม microcopy, error messages, onboarding, CTA, empty states, notifications, tooltips, labels ทุกจุดสัมผัสกับผู้ใช้ พร้อมตรวจคำผิด/ไวยากรณ์ทั้งไทย-อังกฤษ และสร้าง Correction Log ใช้ skill นี้เมื่อผู้ใช้ต้องการ: เขียน copy, UX writing, แก้ข้อความ, ปรับภาษา, microcopy, error message, button text, onboarding text, เขียนไทย-อังกฤษ, ตรวจคำผิด, เช็คสะกด, spell check, grammar check, ตรวจสะกด, ตรวจไวยากรณ์, proofread, หรือเมื่อพิมพ์ 'UX writing', 'copy', 'เขียน copy', 'ข้อความ', 'microcopy', 'tone of voice', 'content design', 'ตรวจคำผิด', 'spell check', 'เช็คคำผิด', 'proofread'"
---

# UX Writer Skill

เขียน UX Copy ที่ผู้ใช้อ่านแล้วเข้าใจทันที ไม่มีข้อสงสัย — ทั้งภาษาไทย (หลัก) และอังกฤษ ในระดับมืออาชีพ

## Overall Flow

```
1. Context → 2. Voice & Tone → 3. Write (11 Patterns) → 4. Edit (4 Phases) → 5. Score → 6. Apply (Optional)
```

1. **Context**: เข้าใจหน้าจอ, ผู้ใช้, สถานการณ์
2. **Voice & Tone**: กำหนด voice/tone ด้วย Voice Chart (6 dimensions)
3. **Write**: เขียน copy ตาม 11 UX Text Patterns — ทั้งไทยและอังกฤษ
4. **Edit**: ตรวจด้วย 4-Phase Editing (Purposeful → Concise → Conversational → Clear) + ตรวจคำผิด/ไวยากรณ์
5. **Score**: ให้คะแนนด้วย UX Content Heuristics Scorecard
6. **Apply**: ใส่ text เข้า HTML preview หรือ Figma (optional)

### อ่าน References:
```
references/ux-writing-spellcheck.md    → ตารางคำผิด + Correction Log format (อ่านเสมอ)
references/ux-writing-patterns.md      → Voice Chart, 11 Patterns, 4-Phase Editing, Scorecard (อ่านเสมอ)
```

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

### 2.2 Voice Chart (6 Dimensions)

สำหรับ brand ที่ต้องการกำหนด voice ละเอียด ใช้ Voice Chart จาก `references/ux-writing-patterns.md`:

| Dimension | Standard Voice Default |
|-----------|----------------------|
| **Concepts** | ใช้คำเรียบง่าย ไม่ใช้ metaphor ซับซ้อน |
| **Vocabulary** | คำทั่วไปที่คนทุกวัยเข้าใจ |
| **Verbosity** | กระชับ ตรงประเด็น 1-2 ประโยค |
| **Grammar** | Active voice, ประโยคสั้น |
| **Punctuation** | ใช้ ... สำหรับ loading, ! ไม่เกิน 1/หน้า |
| **Capitalization** | Sentence case (EN) |

ถ้าผู้ใช้มี brand voice → ให้สร้าง Voice Chart ครบ 6 dimensions ก่อนเขียน copy

### 2.3 Tone ตามสถานการณ์

| สถานการณ์ | Tone | ตัวอย่าง (ไทย) | ตัวอย่าง (EN) |
|-----------|------|----------------|---------------|
| สำเร็จ / ยินดี | อบอุ่น, ยินดีด้วย | "สมัครสมาชิกเรียบร้อยแล้ว" | "You're all set!" |
| ข้อผิดพลาด | สงบ, ช่วยเหลือ | "กรอกอีเมลไม่ถูกรูปแบบ ลองตรวจอีกครั้ง" | "That email doesn't look right." |
| คำเตือน | จริงจัง, ชัดเจน | "ลบแล้วจะกู้คืนไม่ได้" | "This can't be undone." |
| รอ / โหลด | ผ่อนคลาย | "กำลังเตรียมข้อมูลให้..." | "Getting things ready..." |
| ว่างเปล่า | ให้กำลังใจ | "ยังไม่มีรายการ เริ่มเพิ่มตัวแรกกันเลย" | "Nothing here yet." |
| Onboarding | ตื่นเต้น | "มาเริ่มกันเลย!" | "Let's get you started!" |
| ขออนุญาต | เปิดเผย | "เราต้องใช้ตำแหน่งเพื่อแสดงร้านค้าใกล้เคียง" | "We need your location." |

### 2.4 Custom Tone
ถ้าผู้ใช้กำหนด brand voice/tone → สร้าง Voice Chart 6 dimensions ก่อน จดไว้และใช้ตลอด session ปรับตาม tone matrix แต่คง brand voice

---

## Step 3: Write — เขียน Copy ตาม 11 Text Patterns

ใช้ 11 UX Text Patterns (รายละเอียดเต็มดู `references/ux-writing-patterns.md`):

### 3.1 Quick Reference — 11 Patterns

| # | Pattern | ความยาว | สูตร/กฎหลัก |
|---|---------|---------|-------------|
| 1 | **Titles** | 1-5 คำ | Noun/verb phrase บอกว่าอยู่ที่ไหน |
| 2 | **Buttons** | 1-2 คำ (best) | Verb-first, match กับ title, ห้าม "ตกลง/OK" |
| 3 | **Descriptions** | <40 chars, ≤3 lines | ตอบ "ทำไมต้องสนใจ?" |
| 4 | **Empty States** | 1-2 ประโยค | "หากต้องการ [ผลลัพธ์] ให้ [ทำ action]" |
| 5 | **Labels** | 1-3 คำ | Noun, ไม่ลงท้ายด้วย : |
| 6 | **Controls** | phrase | อ่านเป็นประโยคได้เมื่อรวมกับ control |
| 7 | **Text Inputs** | 4 ส่วน | Label + Placeholder (ตัวอย่างจริง) + Helper + Error |
| 8 | **Transitional** | สั้น + ... | บอก "กำลังทำอะไร" ไม่ใช่ "กำลังโหลด" |
| 9 | **Confirmations** | 1-2 ประโยค | [Action สำเร็จ] + [ข้อมูลสำคัญ] + [ขั้นตอนถัดไป] |
| 10 | **Notifications** | 1 บรรทัด | [Source]: [Content] + [Action hint] |
| 11 | **Errors** | 1-2 ประโยค | สอนวิธีทำให้ถูก ไม่บอกว่าทำผิด |

### 3.2 Button Best Practices (สำคัญ)

- **1-2 คำ perform ดีที่สุด** — ตัด filler words
- **Match button text กับ title**: Title "ลบบัญชี" → Button "ลบบัญชี" ไม่ใช่ "ตกลง"
- **Destructive pairs**: Primary = action ตรง ("ลบ"), Secondary = "ยกเลิก"

| Pattern | ไทย | EN |
|---------|-----|-----|
| Verb-only | บันทึก | Save |
| Verb + Object | บันทึกที่อยู่ | Save address |
| Verb + Benefit | เริ่มทดลองฟรี | Start free trial |

### 3.3 Error Writing Rules (สำคัญ)

**หลักการ**: "สอนวิธีทำให้ถูก อย่าบอกว่าทำผิด"
**ห้ามใช้**: "invalid", "failed", "disabled", "ไม่ถูกต้อง", "ผิดพลาด"

| Type | ตำแหน่ง | สูตร |
|------|---------|------|
| **Inline** | ใต้ input | ข้ามปัญหา → บอกวิธีแก้เลย: "ใช้ตัวอักษรอย่างน้อย 8 ตัว" |
| **Detour** | Banner/Toast | [ปัญหา] + [วิธีแก้]: "อีเมลนี้มีบัญชีแล้ว — เข้าสู่ระบบ" |
| **Blocking** | Full-screen | [ปัญหา] + [วิธีแก้] + [CTA]: "ไม่สามารถเชื่อมต่อ ลองอีกครั้ง" |

### 3.4 Confirmation Dialogs (Destructive)
**สูตร: [ผลที่จะเกิดขึ้น] + [ย้อนกลับได้ไหม]**
- Button = action ตรง ("ลบบัญชี") ไม่ใช่ "ตกลง"

### 3.5 Onboarding
- Step title + subtitle อธิบาย value (ไม่ใช่ feature)
- CTA + Skip option เสมอ

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

## Step 4: Edit — 4-Phase Editing Process

ตรวจ copy ทุกครั้งผ่าน 4 เฟส (จาก "Nicely Said"):

### 4.0 Four Phases

| Phase | คำถามหลัก | ทำอะไร |
|-------|----------|--------|
| **1. Purposeful** | ข้อความนี้ช่วย user ทำอะไร? | ตัดข้อความที่ไม่ advance user's goal |
| **2. Concise** | ตัดคำไหนออกได้? | "ทำการบันทึก" → "บันทึก", "คุณสามารถ...ได้" → ตัด |
| **3. Conversational** | อ่านออกเสียงแล้วเป็นธรรมชาติไหม? | ถ้าพูดกับเพื่อนจะพูดแบบนี้ไหม? |
| **4. Clear** | อ่านครั้งเดียวเข้าใจไหม? | คนที่ไม่รู้ context จะเข้าใจไหม? |

### 4.1 UX Writing Checklist (หลังผ่าน 4 Phases)

| # | Check | คำถาม |
|---|-------|-------|
| 1 | **ชัดเจน** | อ่านครั้งเดียวเข้าใจไหม? (Phase 4) |
| 2 | **กระชับ** | ตัดคำไม่จำเป็นออกแล้ว? (Phase 2) |
| 3 | **มีจุดประสงค์** | ข้อความนี้ช่วย user ทำอะไร? (Phase 1) |
| 4 | **เป็นธรรมชาติ** | อ่านออกเสียงแล้วเหมือนคนพูดไหม? (Phase 3) |
| 5 | **เหมาะกับ Tone** | Tone ตรงกับสถานการณ์ + Voice Chart? |
| 6 | **ไม่โทษผู้ใช้** | ภาษาเชิงบวก/กลางๆ? ไม่ใช้ "invalid/failed"? |
| 7 | **เข้าถึงได้** | หลีกเลี่ยงศัพท์เทคนิค? inclusive? |
| 8 | **สม่ำเสมอ** | ใช้คำเดียวกันเรียกสิ่งเดียวกัน? (ดู Terminology Table) |
| 9 | **ครบทุก state** | มี copy สำหรับ success, error, empty, loading? |
| 10 | **Button ตรง context** | Button text match กับ title? ไม่ใช่ "ตกลง"? |
| 11 | **Error สอนวิธีแก้** | สอนวิธีทำให้ถูก ไม่บอกว่าทำผิด? |
| 12 | **Localization-ready** | ใช้พื้นที่ EN 50-67%? ไม่ concat strings? |
| 13 | **สะกดถูก** | ตรวจ typo, ทับศัพท์? (ดู Section 4.2) |

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

## Step 5: Score — UX Content Heuristics Scorecard

ให้คะแนน copy ตาม 2 มิติ (รายละเอียดเต็มดู `references/ux-writing-patterns.md`):

### Usability (น้ำหนัก 2/3)

| # | Heuristic | คะแนน (1-5) |
|---|-----------|-------------|
| 1 | **Accessible** — ผู้พิการใช้ได้ไหม? | — |
| 2 | **Findable** — หาข้อความเจอง่ายไหม? | — |
| 3 | **Clear** — อ่านครั้งเดียวเข้าใจไหม? | — |
| 4 | **Useful** — ช่วย user ทำสิ่งที่ต้องการได้จริง? | — |
| 5 | **Appropriate** — เหมาะกับ context? | — |
| 6 | **Translatable** — แปลเป็นภาษาอื่นได้ง่าย? | — |

### Voice (น้ำหนัก 1/3)

| # | Heuristic | คะแนน (1-5) |
|---|-----------|-------------|
| 1 | **Concepts** — ตรง brand voice? | — |
| 2 | **Vocabulary** — ใช้คำศัพท์เหมาะสม? | — |
| 3 | **Verbosity** — ความยาวเหมาะสม? | — |
| 4 | **Grammar** — โครงสร้างประโยคดี? | — |
| 5 | **Punctuation** — เครื่องหมายถูกต้อง? | — |
| 6 | **Capitalization** — ตัวพิมพ์เหมาะสม? | — |

### Rating

| คะแนน | ระดับ | Action |
|-------|-------|--------|
| 4.5-5.0 | ดีเยี่ยม | Ship ได้เลย |
| 3.5-4.4 | ดี | ปรับเล็กน้อย |
| 2.5-3.4 | ปานกลาง | ต้อง revise |
| 1.0-2.4 | ต้องปรับปรุง | เขียนใหม่ |

---

## Step 6: Apply — ใส่ Text เข้า Design (Optional)

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
3. **ทุกข้อความมีหน้าที่**: ถ้าตัดออกแล้วไม่เสียอะไร ให้ตัด (Phase 1: Purposeful)
4. **สอนวิธีทำให้ถูก อย่าบอกว่าทำผิด**: Error messages = instructive, ไม่ใช้ "invalid/failed"
5. **Button 1-2 คำ match title**: "ลบบัญชี" ไม่ใช่ "ตกลง" — ตรงกับ context
6. **ภาษาของผู้ใช้ ไม่ใช่ภาษาของระบบ**: "บันทึกแล้ว" ไม่ใช่ "Data saved successfully"
7. **Bilingual Consistency**: ไทยและอังกฤษสื่อความหมายเดียวกัน ไม่ต้องแปลตรงตัว
8. **ครบทุก State**: default, success, error, empty, loading
9. **Terminology เดียวกันทั้ง App**: ใช้ terminology table ตลอด
10. **Test ด้วยการอ่านออกเสียง**: ถ้าพูดแล้วเข้าใจ เขียนก็เข้าใจ (Phase 3: Conversational)
11. **Localization-ready**: EN ใช้พื้นที่ 50-67% / ไม่ concatenate strings / ไม่ใช้ idiom
12. **Inclusive**: ไม่สมมติเพศ/อายุ/ความสามารถ ใช้ people-first language
