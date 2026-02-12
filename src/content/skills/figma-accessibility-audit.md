---
name: figma-accessibility-audit
description: "ตรวจสอบ Accessibility อย่างละเอียดตาม WCAG 2.1 guidelines ครอบคลุม contrast, touch targets, screen reader, keyboard nav, cognitive accessibility, color blindness ใช้ skill นี้เมื่อผู้ใช้ต้องการ: ตรวจ accessibility, a11y audit, WCAG check, ตรวจ contrast, ตรวจ touch target, screen reader test, หรือเมื่อพิมพ์ 'accessibility', 'a11y', 'WCAG', 'accessible', 'ตรวจการเข้าถึง'"
---

# Accessibility Audit Skill

ตรวจสอบ Accessibility อย่างครบถ้วนตาม WCAG 2.1 AA/AAA — ครอบคลุมทุกมิติ ไม่ใช่แค่สี

## Overall Flow

```
1. Capture → 2. Read Guidelines → 3. Audit (7 Categories) → 4. Score → 5. Report → 6. Fix
```

---

## Step 1: Capture Design

เหมือน Design Critique skill:

- **Figma URL** → `get_screenshot`, `get_design_context`, `get_metadata`
- **Figma Selection** → `read_my_design`, `scan_text_nodes`, `scan_nodes_by_types`
- **HTML Preview File** → อ่านไฟล์ `.html` ด้วย Read tool แล้วตรวจ contrast, touch targets, semantic HTML, ARIA attributes จาก source code โดยตรง (ตรวจได้ก่อน import Figma)
- **Context**: ถามว่า target WCAG level คือ AA หรือ AAA?

---

## Step 2: อ่าน Guidelines

```
references/ux-principles.md     → Accessibility sections
references/hig.md               → iOS Accessibility guidelines
references/material-design.md   → Material Accessibility guidelines
```

---

## Step 3: Audit — ตรวจ 7 หมวด

### Category 1: Color Contrast (WCAG 1.4.3 / 1.4.6)

**วิธีคำนวณ Contrast Ratio:**
```
Contrast Ratio = (L1 + 0.05) / (L2 + 0.05)

Relative Luminance = 0.2126*R + 0.7152*G + 0.0722*B
โดย R, G, B linearized:
  sRGB <= 0.03928 → linear = sRGB / 12.92
  sRGB > 0.03928  → linear = ((sRGB + 0.055) / 1.055) ^ 2.4
```

**เกณฑ์:**

| Element | AA (ขั้นต่ำ) | AAA (แนะนำ) |
|---------|-------------|-------------|
| Normal text (< 18pt / < 14pt bold) | 4.5:1 | 7:1 |
| Large text (>= 18pt / >= 14pt bold) | 3:1 | 4.5:1 |
| UI components & icons | 3:1 | — |
| Non-text contrast (borders, inputs) | 3:1 | — |

**ตรวจทุกคู่สี:**
- Text on background (primary, secondary, tertiary, disabled)
- Text on cards / colored surfaces
- Text on images (ต้องมี overlay)
- Icon on background
- Button text on button fill
- Placeholder text on input background
- Link text vs surrounding text
- Focus indicator contrast
- Border / divider visibility

**Output Table:**
```markdown
| Element | Foreground | Background | Ratio | Size | AA | AAA |
|---------|-----------|------------|-------|------|----|-----|
| Body text | #1A1A1A | #FFFFFF | 16.6:1 | 14px | PASS | PASS |
| Secondary text | #666666 | #FFFFFF | 5.7:1 | 14px | PASS | FAIL |
| Button label | #FFFFFF | #007AFF | 4.6:1 | 14pt bold | PASS | PASS |
| Placeholder | #999999 | #F5F5F5 | 2.1:1 | 14px | FAIL | FAIL |
```

### Category 2: Touch Targets (WCAG 2.5.5 / 2.5.8)

**เกณฑ์:**

| Platform | Minimum Size | Recommended | Spacing |
|----------|-------------|-------------|---------|
| iOS | 44 x 44pt | 56 x 56pt (primary) | >= 8pt |
| Android | 48 x 48dp | 56 x 56dp (primary) | >= 8dp |
| Web | 44 x 44px (WCAG) | 48 x 48px | >= 8px |

**ตรวจ:**
- ทุก button, link, icon button, toggle, checkbox, radio
- ทุก interactive element ใน list (row tap area)
- Close buttons, back buttons
- Form elements (input tap area, dropdown)
- Navigation items (tab bar, nav bar buttons)

**Output Table:**
```markdown
| Element | Actual Size | Min Required | Status | Note |
|---------|------------|--------------|--------|------|
| Back button | 44x44pt | 44x44pt | PASS | — |
| Star rating icon | 24x24pt | 44x44pt | FAIL | Add padding to 44pt |
| List row | 44pt height | 44pt | PASS | Full-width tap area |
```

### Category 3: Screen Reader / Assistive Technology (WCAG 1.1.1 / 4.1.2)

**ตรวจ:**

| Check | Description | How to verify |
|-------|-------------|---------------|
| Image alt text | ทุก meaningful image ต้องมี alt text | ดู image nodes |
| Decorative images | ต้อง hide จาก screen reader | ดูว่าเป็น decorative ไหม |
| Button labels | ทุก button ต้องมี accessible label | ดู text content |
| Icon-only buttons | ต้องมี accessibilityLabel | เช็คว่ามี visible label หรือ aria-label |
| Form labels | ทุก input ต้อง associate กับ label | ดู label-input relationship |
| Heading structure | ต้องมี proper heading hierarchy (h1→h2→h3) | ดู text hierarchy |
| Reading order | ต้องอ่านตามลำดับที่ make sense | ดู visual order vs DOM order |
| Focus order | tab order ต้อง logical | ดู interactive element order |
| Link purpose | link text ต้องบอกว่าไปไหน (ไม่ใช่ "click here") | ดู link text |
| Error announcements | error ต้อง announce ให้ screen reader | ดู error handling |

**Output Table:**
```markdown
| Element | Check | Status | Issue | Fix |
|---------|-------|--------|-------|-----|
| Search icon | Label | FAIL | No accessible label | Add "Search" label |
| Hero image | Alt text | FAIL | Missing alt | Add descriptive alt |
| Email field | Form label | PASS | Has visible label | — |
| "Click here" link | Link purpose | FAIL | Vague text | Change to "View pricing" |
```

### Category 4: Color Independence (WCAG 1.4.1)

สีต้องไม่เป็นตัวบ่งชี้เพียงอย่างเดียว:

**ตรวจ:**
- Error states: มี icon หรือ text ประกอบ ไม่ใช่แค่สีแดง?
- Success states: มี checkmark ไม่ใช่แค่สีเขียว?
- Required fields: มี * หรือ text ไม่ใช่แค่สี?
- Active/selected states: มี indicator อื่นนอกจากสี?
- Charts/graphs: มี pattern/label ไม่ใช่แค่สี?
- Links in text: มี underline ไม่ใช่แค่สีฟ้า?
- Status badges: มี icon + text ไม่ใช่แค่สี?

**Color Blindness Simulation:**

ตรวจว่า design ยังใช้งานได้กับ color vision deficiencies:
- Protanopia (red-blind, ~1% males)
- Deuteranopia (green-blind, ~1% males)
- Tritanopia (blue-blind, rare)
- Achromatopsia (total color blind, very rare)

จุดที่ต้องระวัง:
- Red vs Green (เช่น error vs success) — ต้องมี shape/icon ด้วย
- Red vs Brown, Green vs Brown
- Blue vs Purple
- Light Green vs Light Yellow

### Category 5: Keyboard Navigation (WCAG 2.1.1 / 2.1.2 / 2.4.7)

สำหรับ Web / Desktop:

**ตรวจ:**
| Check | Description |
|-------|-------------|
| All interactive reachable | ทุก interactive element ต้อง tab ถึงได้ |
| Focus visible | focus indicator ต้องเห็นชัด (contrast >= 3:1) |
| Focus order | tab order logical ตาม visual layout |
| No keyboard trap | ต้องออกจากทุก element ได้ (especially modals) |
| Skip links | มี "Skip to main content" link |
| Shortcuts | keyboard shortcuts ไม่ conflict กับ screen reader |
| Modal focus trap | focus ต้อง trap ใน modal เมื่อเปิด แต่ออกได้เมื่อปิด |

**Focus Indicator Style:**
```
Focus ring: 2px solid, contrast >= 3:1 vs background AND focused element
Recommended: #005FCC (blue) on light, #66B2FF on dark
Offset: 2px from element edge
```

### Category 6: Text & Readability (WCAG 1.4.4 / 1.4.8 / 1.4.12)

**ตรวจ:**
| Check | Criteria |
|-------|----------|
| Text resize | ต้องรองรับ zoom 200% โดยไม่เสีย content |
| Line height | >= 1.5x font size สำหรับ body text |
| Paragraph spacing | >= 2x font size |
| Letter spacing | ต้อง adjust ได้ (ไม่ lock ใน image) |
| Text alignment | ไม่ justify (justified text อ่านยาก) |
| Line length | 45-75 characters per line (optimal: 66) |
| Font size minimum | >= 16px/16sp/16pt สำหรับ body text |
| Dynamic Type (iOS) | รองรับ Dynamic Type scaling |
| Text in images | หลีกเลี่ยง — ใช้ real text แทน |

### Category 7: Motion & Cognitive (WCAG 2.3.1 / 2.3.3)

**ตรวจ:**
| Check | Criteria |
|-------|----------|
| Reduce Motion | มี alternative เมื่อ Reduce Motion เปิด? |
| Auto-play | ไม่ auto-play video/animation > 5 วินาที |
| Flashing | ไม่มี content flash > 3 ครั้ง/วินาที |
| Parallax | ลดหรือเอาออกเมื่อ Reduce Motion |
| Timeout | แจ้งเตือนก่อน session timeout |
| Cognitive load | ข้อมูลต่อหน้าจอไม่มากเกินไป |
| Plain language | ใช้ภาษาง่าย ชัดเจน |
| Consistent layout | layout consistent ทั้ง app |
| Error recovery | ง่ายต่อการ recover จาก error |
| Predictable | interactions ทำงานตามที่คาดหวัง |

---

## Step 4: Score

### Scoring Matrix

| Category | Weight | Score (1-10) | Critical Issues | Notes |
|----------|--------|-------------|-----------------|-------|
| Color Contrast | 25% | — | — | — |
| Touch Targets | 15% | — | — | — |
| Screen Reader | 20% | — | — | — |
| Color Independence | 10% | — | — | — |
| Keyboard Navigation | 10% | — | — | — |
| Text & Readability | 10% | — | — | — |
| Motion & Cognitive | 10% | — | — | — |
| **Weighted Total** | **100%** | **—/10** | — | — |

### WCAG Compliance Level

| Level | Requirements |
|-------|-------------|
| A | ขั้นต่ำสุด — must fix |
| AA | มาตรฐานทั่วไป — target level |
| AAA | สูงสุด — recommended for government/health |

---

## Step 5: Report

### Report Template

```markdown
# Accessibility Audit Report: [Screen/App Name]

## Overview
- **Platform**: [iOS/Android/Web]
- **Target Level**: [WCAG 2.1 AA / AAA]
- **Audited**: [Date]
- **Overall Score**: [X/10]
- **WCAG Compliance**: [A / AA / Not Compliant]

## Executive Summary
[2-3 sentences: สรุปสถานะ a11y โดยรวม — มีอะไรดี มีอะไรต้องแก้]

## Score Breakdown
[Scoring Matrix table]

## Detailed Findings

### 1. Color Contrast
[Contrast audit table — ทุกคู่สี]

### 2. Touch Targets
[Touch target audit table]

### 3. Screen Reader
[Screen reader check table]

### 4. Color Independence
[Color-only indicators found]

### 5. Keyboard Navigation
[Keyboard nav checks — web/desktop only]

### 6. Text & Readability
[Text metrics checks]

### 7. Motion & Cognitive
[Motion/cognitive checks]

## WCAG Violations Summary

| # | WCAG Criterion | Level | Issue | Element | Fix |
|---|---------------|-------|-------|---------|-----|
| 1 | 1.4.3 Contrast | AA | Ratio 2.1:1 | Placeholder text | Darken to #767676 |
| 2 | 2.5.5 Target Size | AAA | 30x30pt | Star icon | Increase tap area to 44pt |

## Priority Action Items

### P0 — Legal Risk (WCAG A violations)
- [ ] [Fix 1]

### P1 — Must Fix (WCAG AA violations)
- [ ] [Fix 1]
- [ ] [Fix 2]

### P2 — Should Fix (WCAG AAA / Best Practices)
- [ ] [Fix 1]

### P3 — Nice to Have
- [ ] [Fix 1]
```

---

## Step 6: Fix in Figma

ถ้าผู้ใช้ต้องการแก้ไข:

อ่าน `references/figma-mcp-commands.md` แล้ว:

**Contrast fixes:**
- `set_fill_color(nodeId, r, g, b)` — เปลี่ยน text color ให้ contrast ผ่าน
- `set_fill_color(bgNodeId, r, g, b)` — เปลี่ยน background color

**Touch target fixes:**
- `resize_node(nodeId, width, height)` — ขยาย interactive elements
- `set_padding(nodeId, ...)` — เพิ่ม padding ให้ tap area ใหญ่ขึ้น

**Screen reader fixes:**
- `set_annotation(nodeId, labelMarkdown)` — เพิ่ม accessibility notes
- `set_text_content(nodeId, text)` — แก้ link text ให้ descriptive

**Visual indicator fixes:**
- `create_text(...)` — เพิ่ม text labels ให้ color-coded elements
- `create_rectangle(...)` — เพิ่ม icons/shapes ประกอบสี

---

## หลักการสำคัญ

1. **WCAG AA เป็นขั้นต่ำ**: ทุก design ต้องผ่าน AA เสมอ
2. **ไม่ใช่แค่สี**: Accessibility ครอบคลุม 7 หมวด ไม่ใช่แค่ contrast
3. **Test with Users**: ผลวิเคราะห์เป็น guideline ต้อง test กับ real users ด้วย
4. **Progressive Enhancement**: แก้ P0/P1 ก่อน แล้วค่อยทำ P2/P3
5. **Document Everything**: ทุก finding ต้อง reference WCAG criterion
6. **Inclusive Design**: Accessibility ดีขึ้น = UX ดีขึ้นสำหรับทุกคน
