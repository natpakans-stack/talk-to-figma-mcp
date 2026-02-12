---
name: figma-ui-design-spec
description: "สร้าง UI Design Specification document สำหรับนำไปใช้งานใน Figma โดยอ้างอิง Design Principles หลักๆ ได้แก่ Material Design, Human Interface Guidelines (Apple), Nielsen's Heuristics, Laws of UX และ Custom Design System ของทีม ใช้ skill นี้เมื่อผู้ใช้ต้องการ: ออกแบบ UI, สร้าง design spec, สร้าง wireframe spec, สร้าง hi-fi UI spec, ออกแบบหน้าจอแอป, ออกแบบ component, ทำ design document สำหรับ Figma, หรือเมื่อถูกพิมพ์ 'ออกแบบ UI', 'design spec', 'Figma design', 'wireframe', 'mockup spec', 'UI specification', 'component design', 'design system', 'layout design' ไม่ผู้ใช้จะไม่ได้ระบุคำว่า 'Figma' โดยตรง ให้ trigger skill นี้เมื่อให้ค่าว่าเป็นงาน UI/UX design"
---

# Figma UI Design Specification Skill

สร้างเอกสาร UI Design Specification ที่ครบถ้วน อ้างอิงหลักการออกแบบที่ได้มาตรฐาน พร้อม preview และสร้างหน้าจอจริงใน Figma ได้

## Overall Flow

```
1. Requirements → 2. Read Design Principles → 3. Preview (HTML) → 4. Iterate (Browser) → 5. Import to Figma (HTML to Figma MCP)
```

ทั้ง 5 ขั้นตอนคือ flow หลักของ skill:

1. **Requirements**: รวบรวมความต้องการจากผู้ใช้ (หรือจาก Jira card ผ่าน jira-req-analysis skill)
2. **Design Principles**: อ่าน references เพื่อออกแบบตามหลักการ
3. **Preview**: สร้าง Static HTML file (.html) ให้ดูหน้าจอจริงใน browser ก่อน import เข้า Figma
4. **Iterate**: User เปิด HTML ใน browser + บอก Claude แก้ไข → refresh ดูผลทันที
5. **Import to Figma**: ใช้ html-to-design MCP ส่ง HTML ไป Figma โดยตรง (`import_html` / `import_url`)

---

## Step 1: รวบรวม Requirements

Requirements อาจมาจาก:
- **User บอกตรง** → ถามข้อมูลเพิ่มตามรายการด้านล่าง
- **Jira card analysis** → ถ้า user ผ่าน `jira-req-analysis` skill มาแล้ว จะมี structured data (User Stories, Screen List, State Matrix, Components, User Flow) พร้อมใช้ — ข้ามไป Step 2 ได้เลย
- **Figma reference design** → ใช้ get_screenshot/get_design_context อ่าน

ถ้ายังไม่มี structured requirements ถามข้อมูลเหล่านี้:

- **Platform**: Mobile (iOS/Android), Web, Desktop, หรือ Cross-platform?
- **Screen/Component**: จะออกแบบหน้าจอหรือ component อะไร?
- **User Goal**: ผู้ใช้ต้องการทำอะไรบนหน้าจอนี้?
- **Detail Level**: ต้องการ Wireframe (Lo-fi) หรือ Hi-fi UI spec?
- **Design System**: ใช้ Material Design, HIG, หรือ custom design system?
- **Constraints**: มี brand guidelines, สี, font ที่กำหนดไว้ไหม?
- **Reference Design**: มี Figma URL ที่อยากให้ดูเป็น reference ไหม? (ใช้ get_screenshot/get_design_context อ่านได้)

---

## Step 2: อ่าน Design Principles

อ่าน reference files ตาม platform:

```
references/ux-principles.md        → อ่านเสมอ (Nielsen's + Laws of UX + Gestalt)
references/material-design.md      → สำหรับ Android / Web (Material Design 3)
references/hig.md                  → สำหรับ iOS / macOS (Apple HIG)
references/design-tokens.md        → สำหรับ Custom Design System tokens
```

อ่าน `references/ux-principles.md` **เสมอทุกครั้ง**

สำหรับ platform-specific:
- Android / Material → อ่านเพิ่ม `references/material-design.md`
- iOS / Apple → อ่านเพิ่ม `references/hig.md`
- Cross-platform → อ่านทั้งสองไฟล์

ถ้าผู้ใช้มี reference design URL:
- ใช้ `get_screenshot(fileKey, nodeId)` เพื่อดู visual
- ใช้ `get_design_context(fileKey, nodeId)` เพื่ออ่าน design details
- ใช้ `get_metadata(fileKey, nodeId)` เพื่อดู structure

---

## Step 3: สร้าง Interactive Preview (Static HTML)

สร้างไฟล์ `.html` self-contained ที่เปิดใน browser ได้ทันที เพื่อให้ผู้ใช้เห็นหน้าตาก่อน import เข้า Figma

### Preview ต้องมี:

1. **iPhone/Android frame** จำลอง (เช่น 393x852 สำหรับ iPhone 15 Pro) — CSS-only
2. **Status bar** จำลอง (เวลา, battery, signal) — HTML+CSS
3. **ทุก component** ตาม spec — สีจาก Design Tokens (CSS Variables)
4. **Light/Dark mode toggle** สลับ theme ได้ (vanilla JS)
5. **State switcher** — ปุ่มเปลี่ยน state: empty, filled, error, loading, success (vanilla JS)
6. **Interactive elements** — กรอก input, กดปุ่ม ดู state จริง (vanilla JS)
7. **Spec info panel** — แสดงค่าสำคัญ (frame size, font, spacing, colors)

### HTML Template:

```html
<!DOCTYPE html>
<html lang="th">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>[Screen Name] Preview</title>
  <link href="https://fonts.googleapis.com/css2?family=LINE+Seed+Sans+TH:wght@400;700;800&display=swap" rel="stylesheet">
  <style>
    :root {
      /* Design Tokens — จาก semantic system (references/design-tokens.md) */
      --primary-fg-high: #EC599D;
      --primary-fg-low: #FDEFF5;
      --primary-bg-mid: #EC599D;
      --primary-bg-low: #FBD5E5;
      --primary-bg-lowest: #FDEFF5;
      --secondary-fg-high: #7279FB;
      --secondary-bg-mid: #7279FB;
      --secondary-bg-lowest: #EEEFFE;
      --gray-fg-high: #1B1D22;
      --gray-fg-mid-on-white: #6A6E83;
      --gray-fg-mid-on-gray: #3F414E;
      --gray-fg-low: #9A9DAD;
      --gray-fg-white: #FFFFFF;
      --gray-bg-white: #FFFFFF;
      --gray-bg-lightgray: #F8F8F9;
      --gray-bg-midgray: #EBECEF;
      --gray-bg-darkgray: #CFD1D9;
      --gray-bg-black: #1B1D22;
      --gray-border-midgray: #EBECEF;
      --gray-border-darkgray: #CFD1D9;
      --error-fg-high: #EA244F;
      --error-bg-lowest: #FDECF0;
      --warning-fg-high: #F8C135;
      --warning-bg-lowest: #FEF8E8;
      --success-fg-high: #559652;
      --success-bg-lowest: #EEF6EE;
      --info-fg-high: #0386B3;
      --info-bg-lowest: #E6F4F9;

      /* Typography — LINE Seed Sans TH */
      --font-family: 'LINE Seed Sans TH', sans-serif;
      --heading-1: 800 48px/56px var(--font-family);
      --heading-2: 700 40px/48px var(--font-family);
      --heading-3: 700 32px/40px var(--font-family);
      --label-1: 700 20px/28px var(--font-family);
      --label-2: 700 18px/24px var(--font-family);
      --label-3: 700 16px/22px var(--font-family);
      --label-4: 700 14px/20px var(--font-family);
      --caption-1: 400 20px/28px var(--font-family);
      --caption-2: 400 18px/24px var(--font-family);
      --caption-3: 400 16px/22px var(--font-family);
      --caption-4: 400 14px/20px var(--font-family);

      /* Spacing */
      --space-xs: 4px;
      --space-sm: 8px;
      --space-md: 12px;
      --space-lg: 16px;
      --space-xl: 20px;
      --space-2xl: 24px;
      --space-3xl: 32px;

      /* Shape */
      --radius-sm: 8px;
      --radius-md: 12px;
      --radius-lg: 16px;
      --radius-full: 9999px;
    }

    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: var(--font-family); background: #E5E5E5; display: flex; justify-content: center; padding: 20px; }

    /* ใช้ flexbox layout (ไม่ใช้ absolute positioning) */
    /* ใช้ semantic HTML: header, main, nav, section, footer */
    /* Class names ตั้งชื่อมีความหมาย (จะกลายเป็น Figma layer names) */
  </style>
</head>
<body>
  <!-- Phone Frame -->
  <div class="phone-frame" style="width:393px; min-height:852px; background:var(--gray-bg-white); border-radius:40px; overflow:hidden; box-shadow:0 8px 32px rgba(0,0,0,0.12); display:flex; flex-direction:column;">
    <!-- Status Bar -->
    <div class="status-bar" style="display:flex; justify-content:space-between; align-items:center; padding:12px 24px; font:var(--caption-4); color:var(--gray-fg-high);">
      <span>9:41</span>
      <span><!-- signal + wifi + battery icons --></span>
    </div>

    <!-- Main Content -->
    <main style="flex:1; display:flex; flex-direction:column; padding:0 var(--space-lg);">
      <!-- Content here -->
    </main>
  </div>

  <!-- Control Panel (outside phone frame) -->
  <div class="control-panel" style="margin-left:24px; padding:16px; background:white; border-radius:12px; height:fit-content;">
    <button onclick="toggleTheme()">Light/Dark</button>
    <button onclick="setState('default')">Default</button>
    <button onclick="setState('filled')">Filled</button>
    <button onclick="setState('error')">Error</button>
    <button onclick="setState('loading')">Loading</button>
    <button onclick="setState('success')">Success</button>
    <button onclick="setState('empty')">Empty</button>
  </div>

  <script>
    // Vanilla JS สำหรับ toggle, state switch, interactions
    let currentTheme = 'light';
    let currentState = 'default';

    function toggleTheme() {
      currentTheme = currentTheme === 'light' ? 'dark' : 'light';
      document.body.setAttribute('data-theme', currentTheme);
      // Update CSS variables for dark mode
    }

    function setState(state) {
      currentState = state;
      document.querySelectorAll('[data-state]').forEach(el => {
        el.style.display = el.dataset.state === state ? '' : 'none';
      });
    }
  </script>
</body>
</html>
```

### Guidelines สำหรับ HTML Preview:

- ใช้ **CSS Variables** ตาม Design Tokens (`references/design-tokens.md`) — ห้าม hardcode สีตรง
- ใช้ **flexbox/grid** layout (ไม่ใช้ absolute position) → จะกลายเป็น Auto Layout ใน Figma
- ตั้ง **class names** ให้มีความหมาย → จะกลายเป็น Figma layer names
- ใช้ **semantic HTML**: `<header>`, `<main>`, `<nav>`, `<section>`, `<footer>`
- ใช้ **Google Fonts** (LINE Seed Sans TH) — load ผ่าน `<link>`
- ใช้ **inline SVG** หรือ placeholder สำหรับ icons/images
- **ห้ามใช้** external CSS frameworks (Bootstrap, Tailwind) — ใช้ CSS ตรงๆ
- **ห้ามใช้** React, Vue, หรือ JS framework ใดๆ — ใช้ vanilla JS เท่านั้น
- Animation ใช้ **CSS keyframes** ใน `<style>` tag
- Keep DOM structure clean → clean Figma layer hierarchy

### HTML Best Practices สำหรับ HTML to Figma:

| HTML/CSS | Figma Result |
|----------|-------------|
| `display: flex` | Auto Layout |
| `flex-direction: column` | Vertical Auto Layout |
| `gap: 16px` | Item Spacing = 16 |
| `padding: 16px` | Padding = 16 |
| `border-radius: 12px` | Corner Radius = 12 |
| `width: 100%` (ใน flex child) | Layout Sizing = Fill |
| Class name (เช่น `login-button`) | Layer name = "login-button" |
| Nested `<div>` | Nested frames |

### ตั้งชื่อไฟล์: `[screen-name]-preview.html`

---

## Step 4: Iterate จนพอใจ (Browser + Claude)

1. **User เปิด `.html` ใน browser** — double-click ไฟล์ หรือใช้ Live Preview ใน VSCode
2. **User ดูผล** แล้วบอก Claude ให้แก้ไข (เช่น "ปรับสีปุ่มเป็นสีเขียว", "เพิ่ม padding", "เปลี่ยน layout")
3. **Claude แก้ไฟล์ `.html`** → User refresh browser เห็นผลทันที
4. **วนจนพอใจ** — ปรับ layout, สี, ขนาด, spacing, state ต่างๆ
5. เมื่อพอใจแล้ว ถามผู้ใช้: "พร้อม import เข้า Figma ไหมครับ?"

---

## Step 5: Import เข้า Figma (HTML to Figma MCP)

เมื่อผู้ใช้พอใจกับ HTML preview แล้ว ใช้ **html-to-design MCP** ส่ง HTML ไป Figma โดยตรง

### 5.1 เตรียมตัว

1. ตรวจว่า user เปิด **html.to.design** plugin ใน Figma → tab **MCP** → toggle **"Enable MCP endpoint"** เปิดอยู่ (STATUS: connected)
2. ตรวจว่า HTML file พร้อม import:
   - ใช้ flexbox/grid (ไม่ใช้ absolute position)
   - Class names มีความหมาย
   - สีใช้ CSS Variables
   - DOM structure clean

### 5.2 Import ผ่าน MCP

ใช้ `import_html` ส่ง HTML ไป Figma โดยตรง:

```
import_html({
  html: "<div class='login-screen'>...</div>",
  css: ".login-screen { display: flex; ... }",
  name: "Login Screen"
})
```

หรือถ้า HTML ซับซ้อน/มี external assets ให้ serve file แล้วใช้ `import_url`:

```
import_url({
  url: "http://localhost:3000/login-preview.html",
  name: "Login Screen"
})
```

Plugin แปลง HTML → Figma layers:
- `display: flex` → Auto Layout
- `gap` → Item Spacing
- `padding` → Padding
- `border-radius` → Corner Radius
- Class names → Layer names
- Colors → Fill colors
- Text → Text nodes with font size/weight

### 5.3 Fine-tune ใน Figma

หลัง import:
1. ตรวจ Auto Layout structure — อาจต้องปรับ sizing mode (FILL/HUG/FIXED)
2. ตรวจ font — อาจต้องเปลี่ยนเป็น LINE Seed Sans TH ใน Figma
3. ตรวจ colors — ควรตรงกับ HTML preview
4. ปรับ layer names ถ้าต้องการ
5. เพิ่ม components, variants, styles ตามต้องการ

---

## Output Files

Skill นี้สร้าง output ได้หลายแบบ ขึ้นกับ step ที่อยู่:

| Step | Output | Format |
|------|--------|--------|
| 3 | Interactive Preview | `.html` (Static HTML — เปิดใน browser) |
| 3 | Design Spec Document | `.md` (optional, ถ้าผู้ใช้ขอ) |
| 5 | Figma Design | Import ผ่าน html-to-design MCP (`import_html` / `import_url`) |

---

## Design Spec Templates

ถ้าผู้ใช้ต้องการเอกสาร spec เพิ่มจาก preview ให้สร้าง `.md` ตาม template:

### Wireframe (Lo-fi) Template

```markdown
# [Screen Name] — Wireframe Specification

## 1. Overview
## 2. Layout Structure (with ASCII wireframe)
## 3. Component List (table)
## 4. Navigation Flow
## 5. UX Principles Applied (table with principle + rationale)
## 6. Notes for Figma Implementation
```

### Hi-fi Template

ใช้ Wireframe template + เพิ่ม:

```markdown
## 7. Visual Design (Colors, Typography, Spacing, Elevation)
## 8. Design Tokens (ถ้าใช้ custom design system)
## 9. Component Specifications (ทุก state: default, hover, pressed, focused, disabled, error)
## 10. Accessibility (contrast, touch targets, VoiceOver/TalkBack labels)
## 11. Responsive Behavior
## 12. Motion & Haptic (iOS)
```

---

## WCAG Color Contrast Checker (บังคับ)

ทุกครั้งที่เลือกสี **ต้องตรวจสอบ WCAG Color Contrast** ก่อนใช้งาน:

### เกณฑ์ที่ต้องผ่าน (WCAG 2.1)

| ประเภท | AA (ขั้นต่ำ) | AAA (แนะนำ) |
|--------|-------------|-------------|
| Normal text (< 18pt) | 4.5:1 | 7:1 |
| Large text (>= 18pt bold / >= 24pt regular) | 3:1 | 4.5:1 |
| UI components & icons | 3:1 | — |

### วิธีคำนวณ Contrast Ratio

ใช้สูตร relative luminance ในการคำนวณ:

```
Contrast Ratio = (L1 + 0.05) / (L2 + 0.05)
โดย L1 = luminance ของสีที่สว่างกว่า, L2 = luminance ของสีที่มืดกว่า

Relative Luminance = 0.2126 * R + 0.7152 * G + 0.0722 * B
โดย R, G, B ผ่าน linearization:
  - ถ้า sRGB <= 0.03928 → linear = sRGB / 12.92
  - ถ้า sRGB > 0.03928 → linear = ((sRGB + 0.055) / 1.055) ^ 2.4
```

### ขั้นตอนการตรวจสอบ (ทำทุกครั้ง)

1. **ก่อนเลือกสี**: คำนวณ contrast ratio ระหว่าง text color กับ background color
2. **ระบุค่า contrast ratio** ใน spec เสมอ เช่น: `#F0E8FF on #0D0A14 → 15.2:1 ✅ AAA`
3. **ถ้าไม่ผ่าน AA**: ปรับสีให้ผ่านก่อนใช้ — ห้ามใช้สีที่ไม่ผ่านเกณฑ์
4. **สรุปตาราง contrast** ไว้ใน preview spec info panel

### ตัวอย่างการตรวจสอบ

```
✅ ผ่าน:
  #F0E8FF on #0D0A14 → 15.2:1 (AAA) — primary text on dark bg
  #4ADE80 on #0D2818 → 6.8:1 (AA)  — positive text on green bg

❌ ไม่ผ่าน:
  #7E6E98 on #1E1830 → 2.8:1 (FAIL) — ต้องปรับให้สว่างขึ้น
```

### ใช้กับทุก color pair ที่สำคัญ:

- Text on background (ทุก text level: primary, secondary, tertiary)
- Text on card surfaces
- Text on colored sections (DO/DON'T cards, alerts)
- Icon on background
- Button text on button background
- Placeholder text on input background

---

## หลักการสำคัญ

1. **เจาะจงและวัดผลได้**: ระบุค่าได้ตัวเลขเสมอ (px, dp, pt, hex color)
2. **อ้างอิง Design Principle**: ทุกการตัดสินใจต้องมีเหตุผลหลักการ
3. **Edge Cases**: empty, loading, error, long text, no data
4. **Accessibility First**: contrast ratio, touch target, screen reader
5. **WCAG Contrast Verified**: ทุกคู่สี text/bg ต้องผ่าน WCAG AA ขั้นต่ำ พร้อมระบุค่า ratio
6. **Platform-Aware**: เคารพ platform conventions
7. **Preview First**: ให้ดู HTML preview ใน browser ก่อน import เข้า Figma เสมอ
8. **Figma-Ready HTML**: ใช้ flexbox/grid, class names มีความหมาย, CSS Variables ตาม tokens
9. **HTML to Figma MCP**: ใช้ html-to-design MCP (`import_html` / `import_url`) ส่ง HTML ไป Figma โดยตรง
10. **Font ตั้งใน HTML**: ใช้ Google Fonts (LINE Seed Sans TH) — font อาจต้องปรับหลัง import Figma
