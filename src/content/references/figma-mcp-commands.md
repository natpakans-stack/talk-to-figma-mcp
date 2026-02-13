<!-- Version: 2.0.0 | Updated: 2026-02-13 -->
# Figma MCP Commands Reference

คู่มือ commands ทั้งหมดที่ใช้ได้จริงสำหรับทำงานกับ Figma ผ่าน MCP Servers 2 ตัว

---

## MCP Servers ที่ใช้

| Server | ประเภท | หน้าที่หลัก |
|--------|--------|------------|
| **figma** (remote) | Figma API | อ่าน design, screenshot, generate code, diagrams |
| **html-to-design** (remote) | html.to.design Plugin | ส่ง HTML ไปสร้างเป็น Figma layers อัตโนมัติ |

### Architecture

```
Claude ─┬─→ Figma MCP (read)           → อ่าน design, screenshot, metadata
        └─→ html-to-design MCP (write)  → ส่ง HTML/CSS ไปสร้างใน Figma
```

---

## Table of Contents

### Figma Remote MCP (อ่าน Design)
1. [Screenshot & Design Context](#1-screenshot--design-context)
2. [Diagrams](#2-diagrams)
3. [Code Connect](#3-code-connect)

### html-to-design MCP (สร้าง Design)
4. [Import HTML to Figma](#4-import-html-to-figma)

### Workflow & Patterns
5. [Design Workflow](#5-design-workflow)
6. [HTML Best Practices สำหรับ Figma](#6-html-best-practices-สำหรับ-figma)
7. [CSS-to-Figma Mapping Table](#7-css-to-figma-mapping-table)
8. [Post-Import Verification](#8-post-import-verification)
9. [Font Handling](#9-font-handling)
10. [Icon Pattern](#10-icon-pattern)

---

## 1. Screenshot & Design Context (Figma Remote MCP)

ใช้ server `figma` (remote) — ต้องมี fileKey และ nodeId จาก URL

### แยก fileKey และ nodeId จาก URL

```
URL: https://figma.com/design/ABC123/MyFile?node-id=1-2
→ fileKey = "ABC123"
→ nodeId = "1:2"  (เปลี่ยน - เป็น :)
```

| Command | Parameters | Description |
|---------|-----------|-------------|
| `get_screenshot` | `fileKey, nodeId` | ถ่ายภาพหน้าจอของ node |
| `get_design_context` | `fileKey, nodeId` | อ่าน design + generate UI code |
| `get_metadata` | `fileKey, nodeId` | ดู structure ในรูปแบบ XML (node IDs, types, positions) |
| `get_variable_defs` | `fileKey, nodeId` | ดู design variables ที่ใช้ใน node |
| `whoami` | — | ดูข้อมูลผู้ใช้ที่ login อยู่ |

### Use Cases

- **get_screenshot**: ดู preview ของ design ที่สร้างแล้ว หรือ reference design
- **get_design_context**: อ่าน design เพื่อ generate code หรือทำความเข้าใจ design
- **get_metadata**: ดู structure ของ file เพื่อหา node IDs
- **get_variable_defs**: ดู design tokens/variables ที่ใช้ใน design

---

## 2. Diagrams (Figma Remote MCP)

| Command | Parameters | Description |
|---------|-----------|-------------|
| `generate_diagram` | `name, mermaidSyntax, userIntent?` | สร้าง diagram ใน FigJam จาก Mermaid.js |

รองรับ: flowchart, sequenceDiagram, stateDiagram, gantt

---

## 3. Code Connect (Figma Remote MCP)

| Command | Parameters | Description |
|---------|-----------|-------------|
| `get_code_connect_map` | `fileKey, nodeId` | ดู mapping ระหว่าง Figma node กับ code component |
| `get_code_connect_suggestions` | `fileKey, nodeId` | ดูคำแนะนำ mapping |
| `add_code_connect_map` | `fileKey, nodeId, source, componentName, label` | เพิ่ม mapping |
| `send_code_connect_mappings` | `fileKey, nodeId, mappings[]` | ส่ง mappings หลายตัว |
| `create_design_system_rules` | — | สร้าง design system rules สำหรับ repo |

---

## 4. Import HTML to Figma (html-to-design MCP)

ใช้ server `html-to-design` (remote) — ส่ง HTML ไปสร้างเป็น Figma layers ได้โดยตรงจาก Claude

### Prerequisites

1. ติดตั้ง plugin **html.to.design** (by divRIOTS) ใน Figma
2. เปิด plugin → tab **MCP** → เปิด toggle **"Enable MCP endpoint"**
3. ตรวจว่า **STATUS: connected** (จุดเขียว) ใน plugin

### Available Tools

| Command | Parameters | Description |
|---------|-----------|-------------|
| `import_html` | `html, css?, js?, name?` | ส่ง HTML code ไปสร้างเป็น Figma layers |
| `import_url` | `url, name?` | ส่ง URL ไป import ทั้งหน้าเว็บเป็น Figma layers |

### import_html — ส่ง HTML Code

```
import_html({
  html: "<div class='card'>...</div>",
  css: ".card { display: flex; ... }",
  name: "Login Screen"
})
```

- ส่ง HTML + CSS ไปตรง → plugin แปลงเป็น Figma layers ทันที
- **ไม่ต้อง** serve file ผ่าน URL
- **ไม่ต้อง** manual copy/paste ใน plugin
- Class names จะกลายเป็น Figma layer names

### import_url — ส่ง URL

```
import_url({
  url: "http://localhost:3000/login-preview.html",
  name: "Login Screen"
})
```

- ส่ง URL ของหน้าเว็บ → plugin import ทั้งหน้า
- ต้อง serve file ก่อน (Live Server, `npx serve .`)
- เหมาะกับ HTML preview ที่ซับซ้อน (multi-page, external assets)

### Tips

- ใช้ `import_html` เมื่อ HTML ไม่ซับซ้อนมาก (single component, single screen)
- ใช้ `import_url` เมื่อ HTML มี external assets (fonts, images) หรือหลายหน้า
- บอก "send to Figma" หรือ "send to html.to.design" ใน prompt เพื่อ trigger import
- ตรวจว่า plugin เปิด MCP endpoint อยู่ก่อน import

---

## 5. Design Workflow

### Standard Flow: Claude → HTML → Figma

```
1. Claude สร้าง HTML preview (Static HTML file)
2. User เปิดใน browser + review + iterate จนพอใจ
3. Claude ส่ง HTML ไป Figma ผ่าน import_html หรือ import_url
4. Plugin แปลง HTML → Figma layers อัตโนมัติ
5. User fine-tune ใน Figma (font, sizing, components)
```

### Pattern 1: สร้างหน้าจอ Mobile (iPhone 15 Pro)

```html
<!-- สร้าง HTML preview 393x852 -->
<div class="login-screen" style="width:393px; min-height:852px; display:flex; flex-direction:column; background:#fff;">
  <header class="status-bar" style="display:flex; justify-content:space-between; padding:12px 24px;">
    <span>9:41</span>
    <span>...</span>
  </header>
  <main style="flex:1; display:flex; flex-direction:column; padding:0 16px; gap:16px;">
    <!-- Content -->
  </main>
</div>
```

จากนั้นส่งเข้า Figma:
```
import_html({ html: "...", css: "...", name: "Login Screen" })
```

### Pattern 2: สร้าง Component (Button)

```html
<button class="login-button" style="
  display:flex; align-items:center; justify-content:center;
  width:361px; height:50px;
  background:#007AFF; color:#fff;
  border:none; border-radius:12px;
  font-size:17px; font-weight:700;
">Log In</button>
```

### Pattern 3: สร้าง Card

```html
<div class="notification-card" style="
  display:flex; flex-direction:column; gap:8px;
  width:361px; padding:16px;
  background:#fff; border:1px solid #E3E3E8; border-radius:12px;
">
  <h3 class="card-title" style="font-size:16px; font-weight:700; color:#1B1D22;">Title</h3>
  <p class="card-body" style="font-size:14px; color:#6A6E83;">Description text here</p>
</div>
```

### Pattern 4: สร้าง Text Field

```html
<div class="email-field" style="
  display:flex; align-items:center; gap:10px;
  width:361px; height:50px; padding:0 12px;
  background:rgba(118,118,128,0.12); border-radius:10px;
">
  <span class="field-placeholder" style="font-size:17px; color:rgba(60,60,67,0.6);">Email address</span>
</div>
```

### Pattern 5: อ่าน Design เดิม แล้วสร้างใหม่

```
// 1. อ่าน design จาก Figma
get_screenshot(fileKey, nodeId)
get_design_context(fileKey, nodeId)

// 2. Claude วิเคราะห์ design → สร้าง HTML preview

// 3. User review + iterate

// 4. ส่งเข้า Figma
import_html({ html: "...", css: "...", name: "Redesigned Screen" })
```

### Pattern 6: Responsive Design (หลาย breakpoint)

```
// ส่งแต่ละ breakpoint แยก
import_html({ html: "...", css: "...", name: "Login - Mobile (393px)" })
import_html({ html: "...", css: "...", name: "Login - Tablet (834px)" })
import_html({ html: "...", css: "...", name: "Login - Desktop (1440px)" })
```

---

## 6. HTML Best Practices สำหรับ Figma

เพื่อให้ผลลัพธ์ใน Figma ดีที่สุด ให้เขียน HTML/CSS ตามกฎเหล่านี้:

### สิ่งที่ควรทำ

- ใช้ **flexbox/grid** (ไม่ใช้ absolute position) → Auto Layout
- ใช้ **CSS Variables** สำหรับ colors → ง่ายต่อการปรับ
- ตั้ง **class names** ให้มีความหมาย → Figma layer names ที่อ่านได้
- ใช้ **semantic HTML** (`<header>`, `<main>`, `<section>`) → clean hierarchy
- ใช้ **Google Fonts** → font จะถูก map (อาจต้องปรับใน Figma)
- ใช้ **inline SVG** สำหรับ icons → จะกลายเป็น vector ใน Figma
- ใช้ **CSS hex colors** ตรง → สีจะแม่นยำ

### สิ่งที่ควรหลีกเลี่ยง

- **absolute/fixed position** → จะไม่ได้ Auto Layout
- **Tailwind/Bootstrap class names** → layer names ไม่มีความหมาย
- **Complex CSS animations** → ไม่รองรับใน Figma
- **External images via URL** → อาจโหลดไม่ได้ ใช้ inline SVG หรือ base64 แทน
- **Nested flex ลึกเกินไป** → Figma layer hierarchy จะซับซ้อน

### Class Names → Layer Names

Plugin จะใช้ class name เป็น layer name ใน Figma:

```html
<!-- ✅ ดี — layer name มีความหมาย -->
<div class="login-form">
  <input class="email-field" />
  <button class="login-button">เข้าสู่ระบบ</button>
</div>

<!-- ❌ ไม่ดี — layer name ไม่มีความหมาย -->
<div class="flex-col p-4">
  <input class="w-full" />
  <button class="bg-pink-500">เข้าสู่ระบบ</button>
</div>
```

---

## 7. CSS-to-Figma Mapping Table

### Layout Direction

| CSS | Figma Result |
|-----|-------------|
| `display: flex; flex-direction: row` | Horizontal Auto Layout |
| `display: flex; flex-direction: column` | Vertical Auto Layout |
| `display: block` (default) | No Auto Layout |

### Spacing

| CSS | Figma Result |
|-----|-------------|
| `gap: 12px` | Item Spacing = 12 |
| `padding: 16px` | Padding = 16 (all sides) |
| `padding: 12px 16px` | paddingTop/Bottom = 12, Left/Right = 16 |

### Sizing

| CSS | Figma Result | หมายเหตุ |
|-----|-------------|----------|
| `width: 393px` | Fixed Width = 393 | ขนาดคงที่ |
| `height: 852px` | Fixed Height = 852 | ขนาดคงที่ |
| `width: 100%` (flex child) | Layout Sizing = Fill | ยืดเต็ม parent |
| `height: auto` / `fit-content` | Layout Sizing = Hug | ขนาดตาม content |
| `flex: 1` | Layout Sizing = Fill | ขยายเต็มพื้นที่ว่าง |

### Alignment

| CSS | Figma Result |
|-----|-------------|
| `justify-content: flex-start` | Primary Align = Min |
| `justify-content: center` | Primary Align = Center |
| `justify-content: flex-end` | Primary Align = Max |
| `justify-content: space-between` | Primary Align = Space Between |
| `align-items: flex-start` | Counter Align = Min |
| `align-items: center` | Counter Align = Center |
| `align-items: flex-end` | Counter Align = Max |
| `align-items: baseline` | Counter Align = Baseline |

### Visual Properties

| CSS | Figma Result |
|-----|-------------|
| `background-color: #F5F5F5` | Fill Color |
| `color: #333` | Text Color |
| `border: 1px solid #ccc` | Stroke + Stroke Weight |
| `border-radius: 12px` | Corner Radius = 12 |
| `box-shadow: ...` | Drop Shadow (บาง plugin รองรับ) |
| `font-size: 17px` | Font Size = 17 |
| `font-weight: bold` / `700` | Font Weight = Bold |

### Wrap

| CSS | Figma Result |
|-----|-------------|
| `flex-wrap: nowrap` | Wrap = No Wrap |
| `flex-wrap: wrap` | Wrap = Wrap |

### CSS ≠ Figma (ข้อควรระวัง)

| CSS Behavior | Figma Behavior | วิธีแก้ |
|-------------|----------------|---------|
| `margin` สร้าง space รอบ element | ไม่มี margin — ใช้ gap ของ parent | ใช้ `gap` ที่ parent container |
| `margin: auto` จัดกลาง | ไม่มี — ใช้ alignment | ใช้ `justify-content: center` |
| `position: absolute` | ใส่ไม่ได้ Auto Layout | ใช้ flex layout แทน |
| `overflow: hidden` | Figma clip content อยู่แล้ว | ไม่ต้องทำอะไร |
| `box-sizing: border-box` | Figma ทำ border-box เสมอ | ไม่ต้องทำอะไร |

---

## 8. Post-Import Verification

หลัง import HTML ไป Figma ทุกครั้ง ควร verify ว่าผลลัพธ์ตรงกับ preview

### Pattern: Verify ด้วย Screenshot

```
// หลัง import เสร็จ — ใช้ Figma Remote MCP ตรวจ
get_screenshot(fileKey, nodeId)

// เทียบกับ HTML preview:
// - Layout structure ถูกต้อง (Auto Layout direction, spacing)
// - สีถูกต้อง (fill, text color, border)
// - ขนาดถูกต้อง (width, height)
// - Text content ครบ
```

### สิ่งที่ต้องตรวจหลัง Import

| จุดตรวจ | วิธีตรวจ |
|---------|---------|
| Layout structure | `get_screenshot` → เทียบ visual |
| Colors | `get_design_context` → ตรวจ fill/stroke values |
| Dimensions | `get_metadata` → ตรวจ width/height |
| Text content | `get_design_context` → ตรวจ text nodes |
| Layer names | `get_metadata` → ตรวจว่า class names ถูกแปลง |

### สิ่งที่อาจต้องปรับหลัง Import

1. **Font**: เปลี่ยนเป็น font ที่ต้องการ (LINE Seed Sans TH, SF Pro, Roboto)
2. **Sizing mode**: ตรวจ FILL/HUG/FIXED ให้ถูกต้อง
3. **Layer names**: ปรับ rename ถ้าต้องการ
4. **Components**: แปลง repeated elements เป็น Figma components
5. **Styles**: สร้าง color styles / text styles จาก imported values

---

## 9. Font Handling

### HTML → Figma Font Flow

| ขั้นตอน | รายละเอียด |
|---------|-----------|
| HTML | ใช้ Google Fonts (เช่น LINE Seed Sans TH) ผ่าน `<link>` |
| Import | html.to.design พยายาม map font ให้ |
| หลัง Import | อาจต้องเปลี่ยน font ใน Figma ถ้า font ไม่ตรง |

### CSS fontWeight → Figma

| CSS font-weight | ค่า | Figma Result |
|----------------|-----|-------------|
| `100-300` (Thin-Light) | 100-300 | Light |
| `normal` / `400` (Regular) | 400 | Regular |
| `500` (Medium) | 500 | Medium |
| `600` (SemiBold) | 600 | SemiBold |
| `bold` / `700` (Bold) | 700 | Bold |
| `800-900` (ExtraBold-Black) | 800-900 | ExtraBold/Black |

> **หมายเหตุ**: html.to.design รองรับ font weight range กว้างกว่า approach เดิม — ไม่จำกัดแค่ 400 กับ 700

### ขั้นตอนหลัง Import

บอกผู้ใช้:
> "HTML ถูก import เข้า Figma แล้ว — font อาจต้องเปลี่ยนใน Figma:
> 1. เลือก text ทั้งหมด (Cmd+A ภายใน frame)
> 2. เปลี่ยน font ใน Properties panel ทางขวา
> 3. iOS → SF Pro / Android → Roboto / Custom → ตาม brand"

---

## 10. Icon Pattern

### ใช้ Inline SVG ใน HTML

```html
<!-- ✅ ดี — inline SVG จะกลายเป็น vector ใน Figma -->
<svg class="icon-calendar" width="20" height="20" viewBox="0 0 20 20" fill="none">
  <path d="M6 2V4M14 2V4M3 8H17M5 4H15C16.1 4 17 4.9 17 6V16C17 17.1 16.1 18 15 18H5C3.9 18 3 17.1 3 16V6C3 4.9 3.9 4 5 4Z" stroke="#6A7287" stroke-width="1.5" stroke-linecap="round"/>
</svg>

<!-- ✅ ดี — FontAwesome ผ่าน CDN (ถ้า import_url) -->
<i class="icon-calendar fa-solid fa-calendar" style="font-size:20px; color:#6A7287;"></i>
```

### Naming Convention สำหรับ Layer Names

- ตั้ง class name เป็น `icon-{name}` → Figma layer name อ่านง่าย
- ดูรายละเอียด icon ทั้งหมดที่ `references/fontawesome-icons.md`

### Placeholder (ถ้าไม่มี SVG)

```html
<!-- ใช้ emoji + class name ที่มีความหมาย -->
<span class="icon-calendar" style="font-size:20px;">📅</span>
```

---

## Quick Reference: เลือกใช้ Tool ไหน

| ต้องการทำอะไร | ใช้ Tool | Server |
|--------------|---------|--------|
| ดู design ที่มีอยู่ | `get_screenshot` | figma |
| อ่าน design details | `get_design_context` | figma |
| ดู structure | `get_metadata` | figma |
| ดู design variables | `get_variable_defs` | figma |
| สร้าง design ใหม่ | `import_html` / `import_url` | html-to-design |
| สร้าง diagram | `generate_diagram` | figma |
| ตรวจ code mapping | `get_code_connect_map` | figma |
