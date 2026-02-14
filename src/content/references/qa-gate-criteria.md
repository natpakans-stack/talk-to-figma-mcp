# QA Gate Audit Criteria Reference

รายละเอียดการตรวจแต่ละจุดของ html-qa-gate skill — 3 Part / 10 Point

---

## PART 1: Functional Intent

### 1. User Flow Clarity — รายละเอียดตรวจ

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

### 2. State Coverage — รายละเอียดตรวจ

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

### 3. Interaction Intent — รายละเอียดตรวจ

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

### 4. Form Logic — รายละเอียดตรวจ

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

## PART 2: Component & Visual Readiness

### 5. Component Hygiene — รายละเอียดตรวจ

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

**Red flags**: ปุ่มหน้าละ style, สีเดียวกันแต่คนละ hex, component ที่ copy แล้วหลุดระบบ

**Auto-fix**:
- Normalize button styles → ใช้ class เดียวกัน
- แปลง duplicate hex → CSS variable เดียวกัน
- ทำให้ card/container padding + radius consistent

---

### 6. Naming & Structure — รายละเอียดตรวจ

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

### 7. Layout & Spacing — รายละเอียดตรวจ

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

### 8. Typography — รายละเอียดตรวจ

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

### 9. Color & Token — รายละเอียดตรวจ

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

### 10. Responsive Intent — รายละเอียดตรวจ

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

## PART 3: Handoff Check — รายละเอียดตรวจ

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

## Design Token Quick Lookup

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
