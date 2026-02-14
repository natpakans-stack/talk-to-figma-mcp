---
name: html-presentation-slide
description: "สร้าง HTML Presentation Slide (16:9) แบบ self-contained พร้อม Navigation ครบชุด ใช้สำหรับ Weekly Update, Sprint Review, Project Demo หรือ Presentation ใดๆ ใช้ skill นี้เมื่อผู้ใช้ต้องการ: สร้าง slide, ทำ presentation, weekly update slide, sprint review deck, สร้าง deck, project presentation, หรือเมื่อพิมพ์ 'slide', 'presentation', 'deck', 'weekly update', 'sprint review', 'present'"
---

# HTML Presentation Slide Skill

สร้างไฟล์ `.html` self-contained เปิดใน browser ได้ทันที เป็น Presentation Slide 16:9 พร้อม Navigation ครบชุด

---

## Overall Flow

```
1. Requirements → 2. Read Design Tokens → 3. สร้าง HTML Slide → 4. Iterate → 5. Push to GitHub
```

1. **Requirements**: ถามเนื้อหา, จำนวนหน้า, theme
2. **Design Tokens**: อ่าน references/design-tokens.md สำหรับ color/typography
3. **สร้าง HTML**: สร้างไฟล์ .html ที่เปิดได้ใน browser ทันที
4. **Iterate**: User เปิดดู → บอก Claude แก้ → refresh
5. **Push**: commit และ push ขึ้น GitHub

---

## Step 1: รวบรวม Requirements

ถามข้อมูลเหล่านี้ (ถ้ายังไม่ระบุ):

- **หัวข้อ Presentation**: เช่น Weekly Update — Week 1
- **จำนวน Slide โดยประมาณ**: ปกติ 10-20 หน้า
- **เนื้อหาแต่ละหน้า**: Agenda, Planning, Outcome, Demo, Nextstep ฯลฯ
- **รูปภาพ**: มี path ของรูปที่ต้องใส่ไหม?
- **Theme**: ใช้ Design Token ของโปรเจกต์ หรือ custom?
- **Project Logo**: มี SVG logo ไหม?

---

## Step 2: อ่าน Design Tokens

```
references/design-tokens.md → อ่านเสมอ สำหรับ color, typography, spacing, radius
```

---

## Step 3: สร้าง HTML Slide

### Architecture: Single HTML File

ไฟล์ `.html` เดียว self-contained ทั้ง CSS + JS ไม่ต้องพึ่ง external library ใดๆ (ยกเว้น Google Fonts)

### CSS/HTML/JS Templates

ดูรายละเอียด templates ทั้งหมดที่ `references/slide-templates.md`:

- **Design Tokens (CSS Variables)** — `:root` variables สำหรับ color, spacing, radius, shadow, motion
- **Slide Viewport (16:9)** — Container หลักรักษา aspect ratio
- **Slide Structure** — `<div class="slide" data-slide="N">` format
- **Slide Transition CSS** — Smooth slide-left/slide-right animation
- **Background Gradient Presets** — สลับ gradient แต่ละ slide
- **Decorative Elements** — Circle blur + dot pattern
- **Content Layouts** — Header bar, content area, layout variants
- **Typography** — `clamp()` responsive font sizes

---

## Step 4: Navigation Components

ดูรายละเอียด CSS/HTML ที่ `references/slide-templates.md` > Navigation Components

### ต้องมีทั้ง 3 ส่วน:

1. **Top Bar** (absolute top-right ใน viewport):
   - **Present Button** — แสดงเฉพาะ Cover Slide เมื่อไม่ได้ fullscreen
   - **Pages Dropdown** — แสดงทุกหน้ายกเว้น Cover (ยกเว้น fullscreen แสดงทุกหน้า)

2. **Bottom Nav Bar** (absolute bottom ใน viewport):
   - Home button (ไปหน้าแรก)
   - Prev/Next buttons
   - Counter (1/16)

3. **Present Hint Text** — เฉพาะ Cover Slide: "กดปุ่ม F เพื่อเข้าโหมด Present"

---

## Step 5: JavaScript (Navigation Engine)

ดูรายละเอียด JS code ที่ `references/slide-templates.md` > JavaScript (Navigation Engine)

**ต้องมีเสมอ** — ใส่ก่อน `</body>`:

- **goToSlide(index)** — transition animation
- **nextSlide() / prevSlide()** — increment/decrement
- **updateNavBar()** — update counter, dark mode, dropdown visibility
- **Keyboard**: ArrowRight/Left/Up/Down, Space, Home, End, F
- **Touch**: swipe left/right (threshold 50px)
- **Fullscreen**: enterPresent() toggle
- **Pages Dropdown**: buildDropdownMenu(), togglePageDropdown()
- **slideTitles[]** array — ชื่อ slide ทั้งหมด

---

## Visibility Rules Summary

| Component | Cover (ไม่ fullscreen) | Cover (fullscreen) | หน้าอื่นๆ |
|-----------|-----|-----|-----|
| Present Button | แสดง | ซ่อน | ซ่อน |
| Pages Dropdown | ซ่อน | แสดง | แสดง |
| Nav Bar (Home + Prev/Next) | แสดง | แสดง | แสดง |
| Present Hint Text | แสดง (ใน cover) | แสดง | ไม่มี |

---

## Slide Type Templates

### Cover Slide
- gradient background + decorative circles
- โลโก้โปรเจกต์ (SVG)
- วันที่ + ชื่อ Presentation + subtitle
- tags (project name, topic)
- character image (ถ้ามี)
- present hint text

### Content Slide (Two Column)
- slide-header (logo + section label)
- `.slide-content.two-col` → `.col-text` + `.col-visual`

### Content Slide (Full Width)
- slide-header
- `.slide-content` → เนื้อหา full width (timeline, calendar, grid, etc.)

### Image Gallery Slide
- slide-header
- grid ของรูปภาพ (CSS Grid)

### Thank You Slide
- gradient background + decorative circles
- "Thank you!" title + "Questions & Discussion"

---

## Checklist ก่อนส่งมอบ

- [ ] ทุก slide มี `data-slide` attribute เรียงลำดับ 0, 1, 2, ...
- [ ] Slide แรกมี class `active`
- [ ] `slideTitles` array ตรงกับจำนวนและลำดับ slide
- [ ] Background gradient สลับกันทุก slide (ไม่ซ้ำติดกัน)
- [ ] Dark slide มี class `dark-slide` เพื่อ toggle nav theme
- [ ] Navigation ครบ: Home btn, Prev/Next, Counter, Pages dropdown, Present btn
- [ ] Keyboard shortcuts ทำงาน: Arrow keys, Space, Home, End, F
- [ ] Touch swipe ทำงาน
- [ ] Fullscreen mode ทำงาน + nav ยังแสดง
- [ ] Typography ใช้ `clamp()` ทั้งหมด
- [ ] รูปภาพมี `object-fit: contain` หรือ `cover` ตามเหมาะสม

---

## Troubleshooting

### Slide transition กระตุก
**Cause**: CSS transition conflict หรือ reflow ไม่ trigger
**Solution**: ตรวจว่ามี `newSlide.offsetHeight;` ก่อน remove enter-from class

### Nav bar ไม่เปลี่ยนเป็น dark mode
**Cause**: slide ไม่มี class `dark-slide`
**Solution**: เพิ่ม `dark-slide` class ให้ slide ที่ background เข้ม

### Fullscreen ไม่ทำงาน
**Cause**: Browser block fullscreen ถ้าไม่ได้เกิดจาก user gesture
**Solution**: enterPresent() ต้องเรียกจาก onclick/onkeydown เท่านั้น

### Pages Dropdown แสดงผิดจำนวน
**Cause**: slideTitles array ไม่ตรงกับจำนวน slide
**Solution**: นับ `data-slide` attributes ให้ตรงกับ slideTitles.length
