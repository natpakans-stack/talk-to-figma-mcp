---
name: html-qa-gate
description: "ตรวจคุณภาพ HTML file อัตโนมัติก่อนส่งมอบ (Pre-Dev Design Review) ครอบคลุม Functional Intent, Component & Visual Readiness, Handoff Check พร้อม auto-fix และวนตรวจซ้ำ (max 3 รอบ) ใช้ skill นี้เมื่อผู้ใช้ต้องการ: ตรวจ HTML, QA check, ตรวจงาน, เช็คคุณภาพ, validate HTML, ตรวจก่อนส่ง, design review, handoff check, หรือเมื่อพิมพ์ 'QA', 'qa gate', 'ตรวจงาน', 'check html', 'validate', 'ตรวจคุณภาพ', 'quality check', 'เช็คงาน', 'handoff', 'pre-dev'"
---

# HTML QA Gate Skill

Pre-Dev Design Review — ตรวจคุณภาพ HTML file ก่อนส่งมอบ 3 Part / 10 จุดตรวจ
แก้ไขอัตโนมัติ แล้ววนตรวจใหม่จนผ่าน (สูงสุด 3 รอบ)

## Pipeline Position

```
Jira BA → IA + User Flow → UI Design → [QA Gate] → ส่งมอบ
                                          ▲ อยู่ตรงนี้ (ด่านสุดท้ายก่อนส่งมอบ)
```

Skill นี้เป็น **ด่านสุดท้าย** ก่อนที่ HTML จะถึงมือ user — ตรวจทุก HTML file ที่ผ่านมาจาก:
- **figma-ui-design-spec** → HTML preview ของหน้าจอ app/web
- **html-presentation-slide** → HTML presentation slides
- **file อื่นๆ** → HTML file ใดๆ ที่ต้องการ QA

## เป้าหมาย

```
Dev เปิด Figma แล้ว "เข้าใจทันที"
ไม่มีคำถามซ้ำเรื่อง spacing / state / behavior
ลด loop แก้งานระหว่าง Design <> Dev
```

นี่ไม่ใช่ QA สำหรับ production และไม่ใช่ Dev spec
แต่มันคือ **Design Thinking QA** — ลด friction ระหว่าง Design <> Dev
ทำให้ HTML/Figma เป็น single source of truth

---

## Overall Flow

```
1. Receive → 2. Read References → 3. Audit (3 Parts / 10 Points) → 4. Report → 5. Auto-fix → 6. Re-audit (loop max 3) → 7. Final Report
```

```
[รับ HTML file] → [ตรวจ 10 จุด] → ผ่านทั้งหมด? ── YES ──→ [PASS Report → ส่งให้ user]
                                        │ NO
                                        ↓
                              [Auto-fix แก้ issues]
                                        ↓
                              [ตรวจใหม่ (รอบ 2)]  → ผ่าน? ── YES ──→ [PASS Report]
                                        │ NO
                                        ↓
                              [Auto-fix อีกรอบ]
                                        ↓
                              [ตรวจใหม่ (รอบ 3)]  → ผ่าน? ── YES ──→ [PASS Report]
                                        │ NO
                                        ↓
                              [FAIL Report + issues ที่เหลือ → ส่งให้ user ตัดสินใจ]
```

---

## Step 1: Receive HTML File

### วิธีรับ file:

1. **ระบุ path โดยตรง**: ผู้ใช้บอก path ของ HTML file
2. **ต่อเนื่องจาก skill อื่น**: หลังจาก `figma-ui-design-spec` หรือ `html-presentation-slide` สร้าง HTML เสร็จ ให้ใช้ QA Gate ตรวจต่อทันที
3. **Glob search**: ค้นหา HTML file ล่าสุดใน project

```
ถ้าไม่ระบุ file → ใช้ Glob tool ค้นหา:
- pattern: "**/*.html"
- เลือกไฟล์ที่ modified ล่าสุด
- ถามยืนยันกับ user ก่อนตรวจ
```

### อ่าน HTML file:
- ใช้ **Read tool** อ่าน HTML file ทั้งหมด
- Parse แยก: `<style>` (CSS), `<body>` (HTML structure), `<script>` (JS)
- เก็บ source code ไว้สำหรับ auto-fix

---

## Step 2: อ่าน References

อ่าน reference files เหล่านี้ก่อนตรวจ:

```
references/design-tokens.md    → สำหรับตรวจ color tokens, spacing tokens (อ่านเสมอ)
references/ux-principles.md    → สำหรับตรวจ usability, heuristics (อ่านเสมอ)
```

---

## Step 3: Audit — ตรวจ 3 Part / 10 จุด

### State Management

```
round = 1          (รอบปัจจุบัน, max 3)
maxRounds = 3      (จำนวนรอบสูงสุด)
issues = []        (รวม issues ทั้งหมดที่เจอ)
fixes = []         (รวม fixes ที่ทำไปแล้ว)
```

---

# PART 1: Functional Intent (Design-level)

ตรวจว่า "ดีไซน์สื่อพฤติกรรมได้ครบ" — Dev ต้องเดาไม่มั่ว

---

### 1. User Flow Clarity

ตรวจว่าหน้านี้สื่อสาร purpose ชัดเจน:

```
ตรวจ:
- หน้านี้คือหน้าอะไร → purpose ชัดจาก layout (มี heading, context)
- Primary action คืออะไร → ต้องมี 1 main CTA ที่โดดเด่นที่สุด
- Secondary action ไม่แย่งสายตา → ขนาด/สี/น้ำหนักต่ำกว่า primary
- Flow หลักดูได้จากสายตา → visual hierarchy ลำดับถูกต้อง (top-down หรือ left-right)
```

**วิธีเช็ก**: Dev เปิดหน้า → ต้องบอกได้ทันทีว่า "ผู้ใช้ต้องทำอะไร"

```
ตรวจใน HTML:
- มี <h1> หรือ heading ที่บอก purpose ของหน้า
- มี element ที่เป็น primary action (ปุ่มหลัก): ต้องมีขนาดใหญ่สุด / สีเข้มสุด / ตำแหน่งเด่นสุด
- ถ้ามี secondary actions (ปุ่มรอง): ต้อง visually subdued กว่า primary
  (เช่น outline style, สีอ่อนกว่า, ขนาดเล็กกว่า)
- ไม่มีปุ่มหลาย CTA ที่แข่งกัน (ขนาด/สี/น้ำหนักเท่ากัน > 1 ตัว = red flag)
```

**Auto-fix**: ปรับ visual weight ของ secondary buttons ให้ต่ำกว่า primary (เช่น เปลี่ยนเป็น outline, ลด font-weight, ลดขนาด)

---

### 2. State Coverage

อย่างน้อยต้องมี 4 states หลัก:

| State | คำอธิบาย | ต้องมี? |
|-------|---------|---------|
| Default | หน้าตาตอนเปิดหน้า (มีข้อมูลปกติ) | ต้องมี |
| Loading | skeleton / spinner / placeholder | ต้องมี |
| Empty | ไม่มีข้อมูล — หน้าตาเป็นยังไง | ต้องมี |
| Error | อย่างน้อย 1 ตัวอย่าง (API fail, validation) | ต้องมี |

```
ตรวจใน HTML:
- มี [data-state="default"] หรือ default view ที่แสดงตอนโหลด
- มี [data-state="loading"] หรือ loading indicator (skeleton, spinner, .loading class)
- มี [data-state="empty"] หรือ empty state UI (ข้อความ + illustration/icon)
- มี [data-state="error"] หรือ error UI (error message, retry button)
- ถ้ามี setState() function → ตรวจว่า handle อย่างน้อย 4 states ข้างต้น
```

**Red flags**:
- วาดแต่ happy path อย่างเดียว (มีแค่ default state)
- เขียนว่า "แล้วแต่ระบบ" โดยไม่มี visual hint

**Auto-fix**: ถ้าขาด state → เพิ่ม placeholder state ที่มี:
- Loading: skeleton placeholder
- Empty: icon + "ยังไม่มีข้อมูล" message
- Error: error icon + message + retry button
- เพิ่ม state switcher buttons ใน control panel

---

### 3. Interaction Intent

ไม่ต้อง motion ละเอียด แต่ต้องสื่อเจตนา:

```
ตรวจ:
- Interactive elements (button, link, input) ต้องมี visual cue ว่า "กดได้"
  → มี cursor: pointer
  → มี hover state (background/color/shadow เปลี่ยน)
  → มี :active / :pressed feedback
- Disabled elements ต้อง look disabled
  → opacity ลดลง, cursor: not-allowed, สี subdued
- Static vs Dynamic elements แยกชัด
  → text ธรรมดา ไม่มี hover effect
  → interactive elements มี hover/active
- Modal / Drawer / Dropdown: ต้องระบุใน HTML ว่าเปิดจากตรงไหน
  → มี data-trigger, onclick, หรือ aria-controls attribute ชี้ไปที่ modal
```

**Auto-fix**:
- เพิ่ม `cursor: pointer` ให้ clickable elements ที่ขาด
- เพิ่ม hover styles ให้ buttons/links ที่ไม่มี (:hover { opacity: 0.85 })
- เพิ่ม `opacity: 0.5; cursor: not-allowed;` ให้ disabled elements ที่ไม่มี visual cue

---

### 4. Form Logic (ระดับ Design)

ไม่ต้อง validate rule ละเอียด แค่บอก Dev ว่า design คิดเรื่องนี้แล้ว:

```
ตรวจ (ถ้ามี form/input ในหน้า):
- Required fields มองออก
  → มี * หรือ (required) label หรือ visual indicator
  → มี required attribute ใน <input>
- Error message มีตำแหน่ง
  → มี error message element (แม้จะ hidden อยู่)
  → ตำแหน่ง error ใกล้กับ input ที่เกี่ยวข้อง (ไม่ใช่ไปอยู่ห่าง)
- Disabled state ถูกวางไว้แล้ว
  → มี disabled attribute หรือ .disabled class สำหรับ conditional inputs
- Long text / short text ไม่พัง layout
  → input มี max-width หรืออยู่ใน container ที่ constrain width
  → text ที่อาจยาว มี overflow handling (ellipsis, word-break, scroll)
```

**Auto-fix**:
- เพิ่ม `required` attribute ที่ input ที่มี * label
- เพิ่ม error message placeholder (`<span class="error-msg" style="display:none">`)
- เพิ่ม `overflow: hidden; text-overflow: ellipsis;` ที่ text ที่อาจยาว

---

# PART 2: Component & Visual Readiness (For Dev Handoff)

ตรวจว่า "ไฟล์สะอาด ใช้งานต่อได้"

---

### 5. Component Hygiene

```
ตรวจ:
- ปุ่มทั้งหน้าใช้ style เดียวกัน (ไม่มีปุ่มหน้าละ style)
  → ทุก <button> / .btn ใช้ class เดียวกัน หรือ variant ของ class เดียวกัน
  → Primary button: 1 style, Secondary button: 1 style, Tertiary: 1 style
- Input fields ใช้ style เดียวกัน
  → ทุก <input>, <select>, <textarea> มี base style ร่วมกัน
- Card / container ใช้ pattern เดียวกัน
  → border-radius, padding, shadow consistent
- สีเดียวกันต้องเป็น token เดียวกัน (ไม่ใช่คนละ hex)
  → เช็คว่าไม่มี hardcoded hex ที่ใกล้เคียงกัน แต่ไม่เท่ากัน
  → เช่น #EC599D กับ #EC589D = red flag (ควรเป็น var เดียวกัน)
```

**Red flags**:
- ปุ่มหน้าละ style
- สีเดียวกันแต่เป็นคนละ token / hex value
- Component ที่ copy แล้วแก้มั่วจนหลุดระบบ

**Auto-fix**:
- Normalize button styles → ใช้ class เดียวกัน
- แปลง duplicate hex → CSS variable เดียวกัน
- ทำให้ card/container padding + radius consistent

---

### 6. Naming & Structure (Dev-friendly)

```
ตรวจ:
- Class names สื่อความหมาย (ไม่ใช่ .div1, .box2, .temp)
  → ชื่อบอกว่า element นี้คืออะไร: .login-form, .product-card, .nav-bar
- HTML structure เป็น semantic
  → ใช้ <header>, <main>, <nav>, <section>, <footer>, <aside> ตามเหมาะสม
  → ไม่ใช่ <div> ซ้อน <div> ทั้งหมด
- Heading hierarchy ถูกต้อง
  → h1 → h2 → h3 ไม่กระโดดข้าม
- <html> มี lang attribute
```

เป้าหมาย: Dev ไม่ต้องถามว่า "อันไหนใช้จริง?"

**Auto-fix**:
- Rename generic classes → semantic names (เดาจาก context)
- เพิ่ม `lang="th"` ที่ `<html>` ถ้าไม่มี
- แปลง `<div>` ที่ชัดเจนเป็น semantic tags (เช่น div ที่มี class nav → `<nav>`)

---

### 7. Layout & Spacing Consistency

```
ตรวจ:
- Spacing ใช้ระบบ 4px/8px grid
  → padding, margin, gap ควรเป็นค่าที่ตรง: 0, 2, 4, 8, 12, 16, 20, 24, 32, 40, 48px
  → หรือใช้ var(--spacing-*) tokens
  → ค่า %, vw, vh, clamp(), auto → OK (responsive values ไม่ต้องตรวจ)
- Padding/margin ไม่สุ่ม
  → sibling elements ที่เหมือนกัน (เช่น .card หลายตัว) ต้อง spacing เท่ากัน
  → section padding ทั้งหน้าควรใช้ค่าเดียวกัน
- Alignment ตรง (ไม่ลอย 1-2px แบบไม่มีเหตุผล)
  → elements ใน flex/grid container ควร align consistently
- Grid / column ชัด (โดยเฉพาะ desktop layout)
  → มี grid system หรือ flex layout ที่ชัดเจน
```

ไม่ต้อง pixel perfect แต่ต้อง **มีเหตุผล**

**Auto-fix**:
- แปลง magic numbers → ค่า grid ที่ใกล้ที่สุด (เช่น 15px → 16px/var(--spacing-4))
- ทำให้ sibling spacing consistent
- แปลง hardcoded spacing → CSS variables

---

### 8. Typography Readiness

```
ตรวจ:
- ใช้ text style system (CSS class หรือ CSS variable)
  → ไม่พิมพ์ font-size/font-weight สดทุกที่
  → ควรมี .title-xl, .title-lg, .body-md ฯลฯ หรือ font shorthand variables
- Heading / body / caption แยกชัด
  → font-size ต่างกันอย่างน้อย 2px ระหว่าง levels
  → font-weight ต่างกัน (heading = bold/800, body = regular/400)
- Line height อ่านสบาย
  → body text: line-height >= 1.4 (แนะนำ 1.5)
  → heading: line-height >= 1.15
- ตัวหนังสือไม่ชนขอบ
  → text container มี padding อย่างน้อย 8px
  → ไม่มี text ที่ถูก clip/hidden โดยไม่ตั้งใจ
```

**ภาษาไทยเพิ่มเติม**:
- วรรณยุกต์ไม่ชน → line-height เพียงพอ (>= 1.5 สำหรับ Thai body text)
- ข้อความยาวแล้วไม่แตก → word-break ถูกต้อง

**Auto-fix**:
- แปลง inline font styles → text style classes
- ปรับ line-height ที่ต่ำเกินไป
- เพิ่ม padding ให้ text ที่ชนขอบ

---

### 9. Color & Token Discipline

```
ตรวจ:
- ใช้สีจาก CSS variable system (ไม่ hardcode hex ตรง)
  → ทุก color property ควรเป็น var(--xxx)
  → ยกเว้น: gradient stops, rgba overlays, #fff, #000
- สีสถานะถูกต้อง
  → error/danger = โทนแดง (--error-fg-high)
  → success = โทนเขียว (--success-fg-high)
  → warning = โทนเหลือง/ส้ม (--warning-fg-high)
  → info = โทนฟ้า (--info-fg-high)
  → ไม่ใช้สีมั่ว (เช่น success เป็นสีแดง)
- ไม่ใช้สีใกล้กันจนแยกไม่ออก
  → 2 สีที่ใช้ต่างกันต้อง contrast >= 3:1 ระหว่างกัน
  → ไม่มี 2 สีที่ hex ต่างกัน < 10% แต่ใช้ต่างบทบาท
- Disabled state ดู disabled จริง
  → opacity <= 0.5 หรือ สี subdued ชัดเจน
  → cursor: not-allowed
```

**WCAG Contrast Check (บังคับ)**:

```
Contrast Ratio = (L1 + 0.05) / (L2 + 0.05)
Relative Luminance = 0.2126*R + 0.7152*G + 0.0722*B

เกณฑ์:
- Normal text: >= 4.5:1 (AA)
- Large text (>= 18pt bold / >= 24pt): >= 3:1
- UI components, icons: >= 3:1
```

คู่สีที่ต้องตรวจ:
- Text on background (ทุก element)
- Button text on button fill
- Placeholder on input background
- Nav text on nav background
- Dark slide text on dark gradient
- Badge/tag text on badge background
- Disabled text on background (ไม่ต้องผ่าน WCAG แต่ต้อง readable)

**Auto-fix**:
- แปลง hardcoded hex → CSS variable ที่ใกล้เคียงที่สุด
- ปรับ contrast ให้ผ่าน WCAG AA (ปรับ text ให้เข้มขึ้น/อ่อนลง โดยไม่เปลี่ยน design intent)
- เพิ่ม opacity + cursor: not-allowed ให้ disabled elements

---

### 10. Responsive Intent

ไม่ต้องวาดครบทุก breakpoint แต่ต้องมีอย่างน้อย:

```
ตรวจ:
- Desktop layout มีอยู่ (เป็น default)
- Mobile intent ชัดเจน → Dev ต้องดูออกว่า:
  → อะไร stack (flex-direction: column)
  → อะไรซ่อน (display: none ที่ breakpoint)
  → อะไรเลื่อน (overflow-x: auto/scroll)
```

**สำหรับ HTML preview (mobile app)**:
```
ตรวจ:
- มี phone frame container (width ~393px)
- Content อยู่ใน frame ไม่ overflow
- ทุก element มี max-width: 100% หรือ constrained width
```

**สำหรับ HTML presentation (slide)**:
```
ตรวจ:
- viewport 16:9 ด้วย max-height: 100vh + max-width: 177.78vh
- Typography ใช้ clamp() responsive
- Images มี object-fit
- Touch targets >= 44px (nav buttons)
```

**Slide-specific Navigation** (ตรวจเฉพาะเมื่อเป็น slide):
```
ตรวจ:
- ทุก slide มี data-slide attribute เรียง 0, 1, 2, ...
- Slide แรกมี class "active"
- slideTitles array ตรงกับจำนวน slide
- Keyboard: ArrowRight/Left, Space, Home, End, F
- Touch: swipe support
- Fullscreen: requestFullscreen + exitFullscreen
- Nav components: Home, Prev/Next, Counter, Dropdown, Present btn
- Transition CSS: .slide.active, .exit-left, .exit-right
```

**Auto-fix**:
- เพิ่ม `max-width: 100%` ให้ elements ที่ overflow
- เพิ่ม `object-fit: cover/contain` ให้ images
- แก้ slide data attributes, slideTitles array
- เพิ่ม keyboard/touch handlers ถ้าขาด

---

# PART 3: "Ready to Handoff" Check

ถ้าผ่าน 5 ข้อนี้ = ส่ง Dev ได้

### Handoff Checklist:

| # | Check | Description | PASS Criteria |
|---|-------|-------------|---------------|
| H1 | ไม่มี element "คิดเอาเอง" | ทุก element มีเหตุผลจาก design system / UX | ไม่มี element ที่หลุดจาก token system |
| H2 | ไม่มี style เฉพาะจุดที่ไม่ได้อธิบาย | ทุก custom style มี comment หรือ class name อธิบาย | ไม่มี inline style ลอยๆ ที่ไม่ใช่ override |
| H3 | ไม่มี component ที่ใช้ไม่ตรงกัน | ปุ่ม/input/card ใช้ style เดียวกันทั้งไฟล์ | ทุก component type = 1 base style |
| H4 | ไม่มีข้อความ placeholder มั่ว | Text content ต้องสมจริง ไม่ใช่ Lorem ipsum | ไม่มี "Lorem", "test", "xxx", "placeholder" |
| H5 | Dev ไม่ต้องเดา behavior หลัก | มี state coverage + interaction hints ครบ | ผ่าน Point 1-4 (Functional Intent) |

```
ตรวจ:
- Inline styles: นับ inline style ทั้งหมด → ถ้า > 20% ของ styled elements = red flag
- Placeholder text: scan หา "Lorem", "ipsum", "test", "xxx", "placeholder", "TBD", "TODO"
  → ถ้าเจอ = FAIL (ยกเว้นอยู่ใน comment)
- Component consistency: เปรียบเทียบ styles ของ elements ที่เป็น type เดียวกัน
  → ทุก button ต้อง share base class
  → ทุก input ต้อง share base class
  → ทุก card ต้อง share base class
```

**Auto-fix**:
- แทนที่ placeholder text → ข้อความสมจริง (เดาจาก context ของหน้า)
- ย้าย inline styles → CSS class (ถ้า pattern ชัดเจน)

---

## Step 4: Report — สร้างรายงาน

### Report Template

```markdown
# QA Gate Report: [filename.html]

## Summary
- **Round**: [N/3]
- **Status**: PASS / FAIL
- **Result**: [X/10] points passed

## Score Board

### PART 1: Functional Intent
| # | Point | Status | Issues | Auto-fixed | Remaining |
|---|-------|--------|--------|------------|-----------|
| 1 | User Flow Clarity | PASS/FAIL | N | N | N |
| 2 | State Coverage | PASS/FAIL | N | N | N |
| 3 | Interaction Intent | PASS/FAIL | N | N | N |
| 4 | Form Logic | PASS/FAIL | N | N | N |

### PART 2: Component & Visual Readiness
| # | Point | Status | Issues | Auto-fixed | Remaining |
|---|-------|--------|--------|------------|-----------|
| 5 | Component Hygiene | PASS/FAIL | N | N | N |
| 6 | Naming & Structure | PASS/FAIL | N | N | N |
| 7 | Layout & Spacing | PASS/FAIL | N | N | N |
| 8 | Typography | PASS/FAIL | N | N | N |
| 9 | Color & Token | PASS/FAIL | N | N | N |
| 10 | Responsive Intent | PASS/FAIL | N | N | N |

### PART 3: Ready to Handoff
| # | Check | Status |
|---|-------|--------|
| H1 | ไม่มี element "คิดเอาเอง" | PASS/FAIL |
| H2 | ไม่มี style เฉพาะจุดไม่อธิบาย | PASS/FAIL |
| H3 | Component ใช้ตรงกัน | PASS/FAIL |
| H4 | ไม่มี placeholder มั่ว | PASS/FAIL |
| H5 | Dev ไม่ต้องเดา behavior | PASS/FAIL |

## Contrast Audit
| Element | Foreground | Background | Ratio | Size | AA |
|---------|-----------|------------|-------|------|----|
| [name] | [hex] | [hex] | [X:1] | [px] | PASS/FAIL |

## Issues Detail

### [Point Name]
| # | Severity | Issue | Location | Fix Applied |
|---|----------|-------|----------|-------------|
| 1 | Critical/Major/Minor | [คำอธิบาย] | [selector/line] | [YES/NO + วิธี] |

## Changes Made (Auto-fix Log)
| # | Location | Before | After | Reason |
|---|----------|--------|-------|--------|
| 1 | [selector] | [old] | [new] | [why] |
```

### Severity Levels:
- **Critical**: ใช้งานไม่ได้, contrast FAIL, navigation broken, missing states → ต้องแก้
- **Major**: inconsistent, ไม่ตรง token, naming ไม่ดี, missing interaction hint → ควรแก้
- **Minor**: best practice, optimization, placeholder text → แก้ได้ก็ดี

### Point PASS/FAIL Logic:
- **PASS**: ไม่มี Critical issues เหลือในจุดนั้น
- **FAIL**: ยังมี Critical issues อย่างน้อย 1 ข้อ

### Overall PASS/FAIL:
- **PASS**: ทุก 10 points + 5 handoff checks = PASS
- **FAIL**: มี point ที่ FAIL อย่างน้อย 1 จุด

---

## Step 5: Auto-fix Loop

### Loop Logic:

```
สำหรับแต่ละรอบ (round 1-3):

1. ตรวจ HTML file ตาม 10 points + 5 handoff checks
2. รวบรวม issues ทั้งหมด
3. ถ้าไม่มี Critical issues → PASS → ไปขั้นตอนสุดท้าย
4. ถ้ามี Critical issues:
   a. Auto-fix ทุก issue ที่แก้ได้
   b. บันทึก changes ใน fix log
   c. เขียน HTML file กลับ (overwrite)
   d. เพิ่ม round + 1
   e. ถ้า round <= 3 → กลับไปข้อ 1
   f. ถ้า round > 3 → FAIL → ไปขั้นตอนสุดท้าย
```

### Auto-fix Priority Order:
1. **Contrast failures** → กระทบ accessibility มากที่สุด
2. **Missing states** → Dev จะเดามั่ว ถ้าไม่มี
3. **Placeholder text** → ข้อความมั่วทำให้ Dev สับสน
4. **Component inconsistency** → ทำให้ style หลุดระบบ
5. **Interaction hints** → cursor, hover, disabled states
6. **Naming & structure** → semantic HTML, class names
7. **Spacing** → grid alignment, token usage
8. **Typography** → line-height, text styles
9. **Responsive** → overflow, sizing
10. **Form logic** → required, error placement

### Auto-fix Method:

ใช้ **Edit tool** แก้ไข HTML file โดยตรง:
- ระบุ `old_string` (code เดิม) → `new_string` (code ที่แก้แล้ว)
- แก้ทีละจุด ไม่ rewrite ทั้งไฟล์
- บันทึกทุกการแก้ไขใน fix log

---

## Step 6: Final Report

### ถ้า PASS:

```markdown
# QA Gate: PASSED

[Full report]

**สรุป**: HTML file ผ่านการตรวจ QA ทั้ง 10 จุด + Handoff Check แล้ว
Dev เปิดไฟล์นี้จะเข้าใจทันที — พร้อมส่งมอบ
```

→ แสดง report ให้ user

### ถ้า FAIL (หลัง 3 รอบ):

```markdown
# QA Gate: FAILED (after 3 rounds)

[Full report with remaining issues]

## Remaining Critical Issues
| # | Point | Issue | Attempted Fix | Why Still Failing |
|---|-------|-------|---------------|-------------------|
| 1 | [point] | [issue] | [what was tried] | [why] |

## Recommendation
[แนะนำวิธีแก้ manual สำหรับ issues ที่ auto-fix ไม่ได้]
```

→ แสดง report + ถามว่า user ต้องการ:
  1. ส่งมอบ HTML ตามที่แก้ได้ (พร้อม known issues)
  2. ให้ลองแก้ manual ตาม recommendation

---

## Design Token Reference (Quick Lookup)

### Color Tokens

```
Primary:   --primary-fg-high (#EC599D), --primary-bg-lowest (#FDEFF5)
Secondary: --secondary-fg-high (#7279FB), --secondary-bg-lowest (#F1F2FF)
Gray:      --gray-fg-high (#1B1D22), --gray-fg-mid-on-white (#6A6E83), --gray-fg-low-on-white (#9A9DAD)
           --gray-bg-white (#FFFFFF), --gray-bg-lightgray (#F8F8F9), --gray-bg-midgray (#EBECEF)
Status:    --error-fg-high (#EA244F), --success-fg-high (#559652), --warning-fg-high (#F8C135), --info-fg-high (#0386B3)
```

### Spacing Tokens

```
--spacing-1: 4px    --spacing-2: 8px    --spacing-3: 12px
--spacing-4: 16px   --spacing-5: 20px   --spacing-6: 24px
--spacing-8: 32px   --spacing-10: 40px  --spacing-12: 48px
```

### Acceptable Values (4px grid)

```
0, 2px, 4px, 8px, 12px, 16px, 20px, 24px, 32px, 40px, 48px, 56px, 64px
%, vw, vh, em, rem, clamp(), auto → OK
```

---

## Important Rules

1. **ตรวจทุกจุดทุกรอบ**: แม้แก้แค่บางจุด ก็ต้องตรวจใหม่ทุกข้อ (การแก้อาจทำให้จุดอื่นพัง)
2. **ไม่ทำลาย functionality**: auto-fix ต้องไม่ทำให้ feature เดิมพัง — ถ้าไม่แน่ใจ ให้ skip แล้วรายงาน
3. **บันทึกทุก change**: ทุก auto-fix ต้องอยู่ใน fix log
4. **Severity เป็นตัวตัดสิน**: PASS/FAIL ดูจาก Critical issues เท่านั้น — Major/Minor ไม่ block
5. **Round tracking**: แสดงเลขรอบชัดเจน
6. **Conservative fixes**: ถ้าไม่แน่ใจ → manual recommendation
7. **Respect design intent**: ไม่เปลี่ยนโทนสี/สไตล์ — แค่แก้ให้ถูก standard
8. **Dev-first mindset**: ทุกอย่างที่ตรวจ ถามตัวเองว่า "Dev เห็นแล้วเข้าใจไหม?"
