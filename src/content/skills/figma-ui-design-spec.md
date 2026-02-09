---
name: figma-ui-design-spec
description: "สร้าง UI Design Specification document สำหรับนำไปใช้งานใน Figma โดยอ้างอิง Design Principles หลักๆ ได้แก่ Material Design, Human Interface Guidelines (Apple), Nielsen's Heuristics, Laws of UX และ Custom Design System ของทีม ใช้ skill นี้เมื่อผู้ใช้ต้องการ: ออกแบบ UI, สร้าง design spec, สร้าง wireframe spec, สร้าง hi-fi UI spec, ออกแบบหน้าจอแอป, ออกแบบ component, ทำ design document สำหรับ Figma, หรือเมื่อถูกพิมพ์ 'ออกแบบ UI', 'design spec', 'Figma design', 'wireframe', 'mockup spec', 'UI specification', 'component design', 'design system', 'layout design' ไม่ผู้ใช้จะไม่ได้ระบุคำว่า 'Figma' โดยตรง ให้ trigger skill นี้เมื่อให้ค่าว่าเป็นงาน UI/UX design"
---

# Figma UI Design Specification Skill

สร้างเอกสาร UI Design Specification ที่ครบถ้วน อ้างอิงหลักการออกแบบที่ได้มาตรฐาน พร้อม preview และสร้างหน้าจอจริงใน Figma ได้

## Overall Flow

```
1. Requirements → 2. Read Design Principles → 3. Preview (React) → 4. Iterate → 5. Build in Figma (MCP)
```

ทั้ง 5 ขั้นตอนคือ flow หลักของ skill:

1. **Requirements**: รวบรวมความต้องการจากผู้ใช้
2. **Design Principles**: อ่าน references เพื่อออกแบบตามหลักการ
3. **Preview**: สร้าง React component (.jsx) ให้ดูหน้าจอจริงก่อนสร้างใน Figma
4. **Iterate**: แก้ไข preview จนผู้ใช้พอใจ
5. **Build in Figma**: ใช้ Figma MCP สร้างหน้าจอจริงใน Figma

---

## Step 1: รวบรวม Requirements

ถามข้อมูลเหล่านี้ (ถ้ายังไม่ได้ระบุ):

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
references/figma-mcp-commands.md   → สำหรับ Step 5 (สร้างใน Figma)
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

## Step 3: สร้าง Interactive Preview (React .jsx)

สร้างไฟล์ `.jsx` ที่ render หน้าจอจริงได้ทันทีเพื่อให้ผู้ใช้เห็นหน้าตาก่อนสร้างใน Figma

### Preview ต้องมี:

1. **iPhone/Android frame** จำลอง (เช่น 393x852 สำหรับ iPhone 15 Pro)
2. **Status bar** จำลอง (เวลา, battery, signal)
3. **ทุก component** ตาม spec — สี, ขนาด, spacing ถูกต้อง
4. **Light/Dark mode toggle** สลับ theme ได้
5. **State switcher** — ปุ่มเปลี่ยน state (empty, filled, error, loading, success)
6. **Interactive elements** — กรอก input, กดปุ่ม ดู state จริง
7. **Spec info panel** — แสดงค่าสำคัญ (frame size, font, spacing, colors)

### Guidelines สำหรับ React Preview:

- ใช้ inline styles (ไม่ใช้ external CSS framework)
- ใช้ system font stack ที่ใกล้เคียง platform font
- สีทั้งหมดต้องเป็น object `colors = { light: {...}, dark: {...} }`
- ทุก interactive element ต้อง functional (input, toggle, button)
- ใช้ SVG สำหรับ icons (ไม่ import external icon libraries)
- Animation ใช้ CSS keyframes (ผ่าน `<style>` tag ภายใน component)

### ตั้งชื่อไฟล์: `[screen-name]-preview.jsx`

---

## Step 4: Iterate จนพอใจ

- ผู้ใช้ดู preview แล้วขอแก้ไข
- แก้ไข .jsx แล้วให้ดูใหม่
- วนจนกว่าผู้ใช้พอใจ
- เมื่อพอใจแล้ว ถามผู้ใช้: "พร้อมจะสร้างใน Figma ไหมครับ?"

---

## Step 5: สร้างใน Figma ผ่าน MCP

เมื่อผู้ใช้พร้อม ให้อ่าน `references/figma-mcp-commands.md` แล้วทำตามขั้นตอน:

### 5.1 Connect

ถามผู้ใช้:
> "กรุณาเปิด Talk to Figma Plugin ใน Figma แล้วบอก channel ID ให้หน่อยครับ"

จากนั้นเรียก:
```
join_channel(channel_id)
```

### 5.2 Prepare

1. เรียก `get_document_info()` เพื่อดู structure ของ file ปัจจุบัน
2. ถามผู้ใช้ว่าจะสร้างใน page ไหน
3. **หมายเหตุ**: MCP ไม่สามารถสร้าง/ลบ page ได้ ต้องทำใน Figma โดยตรง

### 5.3 Build — สร้าง element ตาม spec ที่ออกแบบไว้

**ลำดับการสร้าง** (สำคัญมาก):

```
1. สร้าง Main Frame ด้วย create_frame (พร้อม auto layout + สี + parentId ในคำสั่งเดียว)
2. สร้าง child elements จากบนลงล่าง (ใช้ parentId ใส่เข้า parent ได้เลย)
3. แต่ละ element: create → set_corner_radius (ถ้าต้องการ)
4. ตั้ง auto layout แยก ถ้าต้องปรับทีหลัง (set_layout_mode + set_padding + set_axis_align + etc.)
```

**Best Practices**:

- **ใช้ parentId**: เมื่อสร้าง frame/text/rectangle ใส่ `parentId` เพื่อจัด hierarchy ได้เลย ไม่ต้อง insert_child แยก (ไม่มีคำสั่ง insert_child)
- **ตั้ง auto layout ตอนสร้าง**: `create_frame` รองรับ layoutMode, itemSpacing, padding, alignment ทั้งหมดในคำสั่งเดียว
- **ตั้งชื่อ layer**: ใช้ `name` parameter ให้มีความหมาย (เช่น "Email Field", "Login Button")
- **สีใช้ 0-1**: `set_fill_color` ใช้ค่า 0-1 (ไม่ใช่ 0-255) หรือใส่ `fillColor` ตอน create_frame
- **font ตั้งตอนสร้าง**: `create_text` รองรับ fontSize, fontWeight, fontColor — แก้ font หลังสร้างไม่ได้ผ่าน MCP
- **สร้างทีละ element**: แล้ว verify ก่อนไปต่อ ใช้ `get_node_info` ตรวจสอบ
- **Batch operations**: ใช้ `set_multiple_text_contents` แก้ text หลายตัวพร้อมกัน, `delete_multiple_nodes` ลบหลายตัว

**Color conversion**: Hex → Figma RGBA (0-1)
```
#007AFF → r=0, g=0.478, b=1
#FF3B30 → r=1, g=0.231, b=0.188
#000000 → r=0, g=0, b=0
#FFFFFF → r=1, g=1, b=1
```

### 5.4 Verify

หลังสร้างเสร็จ:
1. ใช้ `set_focus(nodeId)` เพื่อ scroll ไปหา design ที่สร้าง
2. ถามผู้ใช้ว่า "ดูใน Figma แล้วเป็นอย่างไรบ้างครับ?"
3. ถ้ามีแก้ → ใช้ modification commands แก้ได้:
   - `set_fill_color` / `set_stroke_color` — แก้สี
   - `set_corner_radius` — แก้มุมโค้ง
   - `set_text_content` — แก้ text
   - `move_node` / `resize_node` — ย้าย/ปรับขนาด
   - `set_layout_mode` + `set_padding` + `set_axis_align` + `set_layout_sizing` + `set_item_spacing` — แก้ auto layout
4. ถ้าต้องการสร้าง variant/state เพิ่ม → `clone_node` แล้ว modify
5. ถ้ามี reference Figma URL → ใช้ `get_screenshot(fileKey, nodeId)` เปรียบเทียบ

### 5.5 Annotate (Optional)

ถ้าผู้ใช้ต้องการ spec annotations บน Figma:
```
set_multiple_annotations({
  nodeId: "screen-id",
  annotations: [
    { nodeId: "button-id", labelMarkdown: "**Primary CTA**\n- Height: 50pt\n- Radius: 12pt" },
    { nodeId: "input-id", labelMarkdown: "**Text Field**\n- Placeholder: quaternaryLabel color" }
  ]
})
```

---

## Output Files

Skill นี้สร้าง output ได้หลายแบบ ขึ้นกับ step ที่อยู่:

| Step | Output | Format |
|------|--------|--------|
| 3 | Interactive Preview | `.jsx` (React artifact) |
| 3 | Design Spec Document | `.md` (optional, ถ้าผู้ใช้ขอ) |
| 5 | Figma Design | สร้างตรงใน Figma ผ่าน MCP |
| 5.5 | Figma Annotations | Annotations บน Figma nodes |

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
7. **Preview First**: ให้ดู preview ก่อนสร้างจริงเสมอ
8. **Figma-Ready**: element names, auto layout, proper layer structure
9. **Use parentId**: ใส่ elements เข้า parent ตอนสร้างได้เลย ไม่ต้อง insert_child แยก
10. **Font ตั้งตอนสร้าง**: fontSize, fontWeight, fontColor ตั้งได้ตอน create_text เท่านั้น

---

## MCP Limitations (สิ่งที่ต้องทำใน Figma โดยตรง)

- สร้าง/ลบ/เปลี่ยนชื่อ Page
- สร้าง Ellipse, Polygon, Star shapes
- Group/Ungroup nodes
- เปลี่ยน font family/style หลังสร้าง text แล้ว
- ตั้ง effects (shadow, blur)
- ตั้ง text decoration, line height, letter spacing
- Rename node
- ใช้ remote components (team library)
