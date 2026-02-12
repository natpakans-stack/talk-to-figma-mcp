---
name: figma-design-critique
description: "วิเคราะห์และ review design ที่มีอยู่แล้ว ให้ feedback ตาม UX principles, ให้คะแนน, ระบุจุดแข็ง/จุดอ่อน, เสนอ improvement ใช้ skill นี้เมื่อผู้ใช้ต้องการ: review design, วิเคราะห์ UI, critique หน้าจอ, ตรวจ design, ให้ feedback design, design audit, UX review, หรือเมื่อพิมพ์ 'review', 'critique', 'วิเคราะห์ design', 'ตรวจ UI', 'ให้ feedback', 'design review', 'UX audit'"
---

# Design Critique / Review Skill

วิเคราะห์ design ที่มีอยู่อย่างเป็นระบบ ให้ feedback เชิงลึกตาม UX principles พร้อมเสนอ improvement ที่ทำได้จริง

## Overall Flow

```
1. Capture → 2. Read Principles → 3. Analyze → 4. Score → 5. Report → 6. Fix (Optional)
```

1. **Capture**: รับ design จากผู้ใช้ (Figma URL, screenshot, หรือ selection)
2. **Read Principles**: อ่าน reference files เพื่อใช้วิเคราะห์
3. **Analyze**: วิเคราะห์ทุกมิติอย่างละเอียด
4. **Score**: ให้คะแนนแต่ละด้าน
5. **Report**: สรุปเป็น report พร้อม action items
6. **Fix**: ถ้าผู้ใช้ต้องการ → แก้ไขตรงใน Figma ผ่าน MCP

---

## Step 1: Capture Design

ถามผู้ใช้ (ถ้ายังไม่ได้ระบุ):

- **Source**: Figma URL, screenshot path, **HTML preview file (.html)**, หรือจะเลือกใน Figma ตอนนี้?
- **Context**: หน้าจอนี้ใช้ทำอะไร? target user เป็นใคร?
- **Platform**: Mobile (iOS/Android), Web, Desktop?
- **Scope**: Review ทั้งหน้า หรือเฉพาะบาง component?
- **Focus Area**: มีจุดที่กังวลเป็นพิเศษไหม?

### วิธีอ่าน Design:

**จาก Figma URL:**
```
get_screenshot(fileKey, nodeId)       → ดู visual
get_design_context(fileKey, nodeId)   → อ่าน design details (สี, font, spacing)
get_metadata(fileKey, nodeId)         → ดู structure
get_variable_defs(fileKey, nodeId)    → ดู design tokens ที่ใช้
```

**จาก Figma Selection (TalkToFigma MCP):**
```
read_my_design()                      → อ่าน design ที่เลือกอยู่
get_node_info(nodeId)                 → ดูรายละเอียด node
scan_text_nodes(nodeId)               → scan text ทั้งหมด
scan_nodes_by_types(nodeId, types)    → scan components ตาม type
```

**จาก HTML Preview File:**
- อ่านไฟล์ `.html` preview ด้วย Read tool
- วิเคราะห์ CSS styles, layout structure, colors, typography จาก source code
- ตรวจ contrast, spacing, consistency จาก CSS values โดยตรง

---

## Step 2: อ่าน Design Principles

อ่าน reference files เหล่านี้ก่อนวิเคราะห์:

```
references/ux-principles.md        → Nielsen's Heuristics + Laws of UX + Gestalt (อ่านเสมอ)
references/material-design.md      → ถ้า Android/Web
references/hig.md                  → ถ้า iOS/macOS
references/design-tokens.md        → ถ้ามี custom design system
```

---

## Step 3: Analyze — วิเคราะห์ 8 มิติ

### 3.1 Visual Hierarchy & Layout
- มี clear hierarchy ไหม? (primary → secondary → tertiary)
- Information architecture เหมาะสมไหม?
- Alignment และ grid consistency
- White space usage — แน่นไปหรือโล่งไป?
- Gestalt principles: Proximity, Similarity, Continuity

### 3.2 Typography
- Type scale เหมาะสมไหม? (ใช้กี่ขนาด, มี hierarchy ชัดเจนไหม)
- Font weight contrast เพียงพอไหม?
- Line height / letter spacing อ่านสบายไหม?
- จำนวน font families (ยิ่งน้อยยิ่งดี, ไม่ควรเกิน 2)

### 3.3 Color & Contrast
- **WCAG Contrast Check** (บังคับ):
  ```
  Contrast Ratio = (L1 + 0.05) / (L2 + 0.05)
  Relative Luminance = 0.2126*R + 0.7152*G + 0.0722*B
  ```
  - Normal text: ต้อง >= 4.5:1 (AA)
  - Large text (>= 18pt bold / >= 24pt regular): ต้อง >= 3:1
  - UI components: ต้อง >= 3:1
- Color palette consistency — ใช้กี่สี, มี system ไหม?
- Semantic color usage — error=red, success=green ถูกต้องไหม?
- Dark mode compatibility (ถ้ามี)

### 3.4 Component Design
- ปฏิบัติตาม platform conventions ไหม? (Jakob's Law)
- Button hierarchy ชัดเจนไหม? (primary, secondary, tertiary)
- Input fields มี label, placeholder, helper text, error state ครบไหม?
- Card/container design consistent ไหม?
- Interactive elements มี visual affordance ชัดเจนไหม?

### 3.5 Spacing & Consistency
- ใช้ spacing system (4px/8px grid) ไหม?
- Padding/margin consistent ทั้งหน้าจอไหม?
- Component spacing มี pattern ที่ชัดเจนไหม?

### 3.6 UX Heuristics (Nielsen's 10)
ตรวจทุกข้อ:
- H1: Visibility of System Status — มี feedback ครบไหม?
- H2: Match Real World — ใช้ภาษาผู้ใช้ไหม?
- H3: User Control — มีทางกลับ/undo ไหม?
- H4: Consistency — follow platform standards ไหม?
- H5: Error Prevention — ป้องกัน error ไหม?
- H6: Recognition > Recall — ข้อมูลเห็นได้ง่ายไหม?
- H7: Flexibility — รองรับ novice & expert ไหม?
- H8: Aesthetic & Minimalist — มีข้อมูลเกินไหม?
- H9: Error Recovery — error message ดีไหม?
- H10: Help & Documentation — มี guidance ไหม?

### 3.7 Accessibility
- Touch targets >= 44pt (iOS) / 48dp (Android)?
- Color not the only indicator?
- Screen reader friendly? (labels, roles)
- Sufficient contrast? (checked in 3.3)

### 3.8 Edge Cases
- Empty state มีไหม?
- Loading state มีไหม?
- Error state มีไหม?
- Long text / overflow handling?
- No data / no results state?

---

## Step 4: Score — ให้คะแนน

### Scoring Matrix

| มิติ | Weight | คะแนน (1-10) | หมายเหตุ |
|------|--------|-------------|----------|
| Visual Hierarchy & Layout | 15% | — | — |
| Typography | 10% | — | — |
| Color & Contrast | 15% | — | — |
| Component Design | 15% | — | — |
| Spacing & Consistency | 10% | — | — |
| UX Heuristics | 20% | — | — |
| Accessibility | 10% | — | — |
| Edge Cases | 5% | — | — |
| **Weighted Total** | **100%** | **—/10** | — |

### Rating Scale
- **9-10**: World-class — ไม่ต้องแก้อะไร
- **7-8**: ดี — มี minor improvements
- **5-6**: ปานกลาง — ต้องแก้หลายจุด
- **3-4**: ต้องปรับปรุง — มีปัญหาพื้นฐาน
- **1-2**: ต้อง redesign — ปัญหาร้ายแรง

---

## Step 5: Report — สรุปผล

### Report Template

```markdown
# Design Review Report: [Screen Name]

## Overview
- **Platform**: [iOS/Android/Web]
- **Screen**: [Screen description]
- **Reviewed**: [Date]
- **Overall Score**: [X/10]

## Score Breakdown
[Scoring Matrix table from Step 4]

## Strengths (สิ่งที่ดี)
1. [จุดแข็ง + เหตุผล]
2. [จุดแข็ง + เหตุผล]
3. [จุดแข็ง + เหตุผล]

## Issues Found (จุดที่ต้องแก้)

### Critical (ต้องแก้ทันที)
| # | Issue | มิติ | Principle | Impact | Recommendation |
|---|-------|------|-----------|--------|----------------|
| 1 | [ปัญหา] | [มิติ] | [H1-H10/Law] | สูง | [วิธีแก้] |

### Major (ควรแก้)
| # | Issue | มิติ | Principle | Impact | Recommendation |
|---|-------|------|-----------|--------|----------------|

### Minor (แก้ได้ก็ดี)
| # | Issue | มิติ | Principle | Impact | Recommendation |
|---|-------|------|-----------|--------|----------------|

## Contrast Audit
| Color Pair | Foreground | Background | Ratio | Result |
|------------|-----------|------------|-------|--------|
| [ชื่อ] | [hex] | [hex] | [X:1] | [AA/AAA/FAIL] |

## Action Items (เรียงตาม Priority)
- [ ] [Critical fix 1]
- [ ] [Critical fix 2]
- [ ] [Major fix 1]
- [ ] [Minor fix 1]
```

---

## Step 6: Fix in Figma (Optional)

ถ้าผู้ใช้ต้องการแก้ไข:

1. อ่าน `references/figma-mcp-commands.md`
2. แก้ไขตาม action items:
   - `set_fill_color` / `set_stroke_color` — แก้สีที่ contrast ไม่ผ่าน
   - `set_corner_radius` — แก้ radius ให้ consistent
   - `set_text_content` — แก้ copy/text
   - `resize_node` — แก้ขนาด touch targets
   - `set_padding` / `set_item_spacing` — แก้ spacing
   - `move_node` — แก้ alignment
3. ใช้ `set_multiple_annotations` ใส่ annotation อธิบายการแก้ไข
4. `set_focus(nodeId)` ให้ผู้ใช้ดูผลลัพธ์

---

## หลักการสำคัญ

1. **Objective First**: วิเคราะห์ตามหลักการ ไม่ใช่ความชอบส่วนตัว
2. **Evidence-Based**: ทุก feedback ต้องอ้างอิง principle + ให้ค่าตัวเลขได้
3. **Actionable**: ทุก issue ต้องมี recommendation ที่ทำได้จริง
4. **Balanced**: ชมจุดดีด้วย ไม่ใช่แค่จับผิด
5. **Prioritized**: แยก Critical / Major / Minor ชัดเจน
6. **WCAG Verified**: ตรวจ contrast ทุกคู่สีเสมอ
