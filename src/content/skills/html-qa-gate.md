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

นี่ไม่ใช่ QA สำหรับ production — แต่คือ **Design Thinking QA** ลด friction ระหว่าง Design <> Dev

---

## Overall Flow

```
1. Receive → 2. Read References → 3. Audit (3 Parts / 10 Points) → 4. Report → 5. Auto-fix → 6. Re-audit (loop max 3) → 7. Final Report
```

```
[รับ HTML file] → [ตรวจ 10 จุด] → ผ่านทั้งหมด? ── YES ──→ [PASS Report → ส่งให้ user]
                                        │ NO
                              [Auto-fix] → [ตรวจใหม่] → (วน max 3 รอบ) → [Final Report]
```

---

## Step 1: Receive HTML File

1. **ระบุ path โดยตรง**: ผู้ใช้บอก path ของ HTML file
2. **ต่อเนื่องจาก skill อื่น**: หลังจาก `figma-ui-design-spec` หรือ `html-presentation-slide` สร้าง HTML เสร็จ
3. **Glob search**: ค้นหา `**/*.html` เลือกไฟล์ที่ modified ล่าสุด ถามยืนยันก่อนตรวจ

อ่าน HTML file ด้วย **Read tool** แล้ว Parse แยก: `<style>`, `<body>`, `<script>`

---

## Step 2: อ่าน References

```
references/design-tokens.md           → สำหรับตรวจ color tokens, spacing tokens (อ่านเสมอ)
references/ux-principles.md           → สำหรับตรวจ usability, heuristics (อ่านเสมอ)
references/qa-gate-criteria.md        → รายละเอียดการตรวจแต่ละจุด (อ่านเสมอ)
references/ui-preview-quality-rules.md → กฎ Visual Design จาก Refactoring UI, Practical UI, Laws of UX (อ่านเสมอ)
```

---

## Step 3: Audit — 3 Part / 10 จุด

### State Management

```
round = 1, maxRounds = 3, issues = [], fixes = []
```

### PART 1: Functional Intent — ดีไซน์สื่อพฤติกรรมได้ครบ

| # | Point | สิ่งที่ตรวจ |
|---|-------|-----------|
| 1 | **User Flow Clarity** | หน้ามี purpose ชัด, primary CTA โดดเด่น, visual hierarchy ถูกต้อง |
| 2 | **State Coverage** | มีอย่างน้อย 4 states: Default, Loading, Empty, Error |
| 3 | **Interaction Intent** | Interactive elements มี cursor/hover/active, disabled ดู disabled |
| 4 | **Form Logic** | Required fields มองออก, error position ใกล้ input, overflow handling |

### PART 2: Component & Visual Readiness — ไฟล์สะอาด ใช้งานต่อได้

| # | Point | สิ่งที่ตรวจ |
|---|-------|-----------|
| 5 | **Component Hygiene** | ปุ่ม/input/card ใช้ style consistent, ไม่มี duplicate hex |
| 6 | **Naming & Structure** | Class names สื่อความหมาย, semantic HTML, heading hierarchy |
| 7 | **Layout & Spacing** | ใช้ 4px/8px grid, sibling spacing consistent, alignment ตรง |
| 8 | **Typography** | Text style system, heading/body แยกชัด, line-height สัมพันธ์กับ size, line length 60-80 chars, ห้ามลด contrast เพื่อ de-emphasize |
| 9 | **Color & Token** | ใช้ CSS variables, สีสถานะถูก, WCAG contrast ผ่าน, near-black/near-white (ไม่ใช่ pure #000/#FFF), 60-30-10 ratio, neutral มี hue shift |
| 10 | **Visual Design Quality** | Shadow blur=2x distance, outer padding >= inner, button padding h=2x v, nested radius=outer-gap, ไม่มี adjacent hard divides, empty state มี content |
| 11 | **Responsive Intent** | Desktop layout + mobile intent, slide viewport 16:9 (ถ้าเป็น slide) |

### PART 3: Ready to Handoff

| # | Check | PASS Criteria |
|---|-------|---------------|
| H1 | ไม่มี element "คิดเอาเอง" | ไม่มี element ที่หลุดจาก token system |
| H2 | ไม่มี style เฉพาะจุดที่ไม่อธิบาย | Inline styles ไม่เกิน 20% |
| H3 | Component ใช้ตรงกัน | ทุก component type = 1 base style |
| H4 | ไม่มี placeholder มั่ว | ไม่มี "Lorem", "test", "xxx", "TBD", "TODO" |
| H5 | Dev ไม่ต้องเดา behavior | ผ่าน Point 1-4 (Functional Intent) |

**รายละเอียดการตรวจแต่ละจุด**: ดู `references/qa-gate-criteria.md`

---

## Step 4: Report

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
| H1-H5 | [check names] | PASS/FAIL |

## Contrast Audit
| Element | Foreground | Background | Ratio | Size | AA |
|---------|-----------|------------|-------|------|----|

## Issues Detail
### [Point Name]
| # | Severity | Issue | Location | Fix Applied |
|---|----------|-------|----------|-------------|

## Changes Made (Auto-fix Log)
| # | Location | Before | After | Reason |
|---|----------|--------|-------|--------|
```

### Severity Levels
- **Critical**: ใช้งานไม่ได้, contrast FAIL, navigation broken, missing states → ต้องแก้
- **Major**: inconsistent, ไม่ตรง token, naming ไม่ดี → ควรแก้
- **Minor**: best practice, optimization → แก้ได้ก็ดี

### PASS/FAIL Logic
- **Point PASS**: ไม่มี Critical issues เหลือในจุดนั้น
- **Overall PASS**: ทุก 10 points + 5 handoff checks = PASS

---

## Step 5: Auto-fix Loop

### Loop Logic

```
สำหรับแต่ละรอบ (round 1-3):
1. ตรวจ HTML file ตาม 10 points + 5 handoff checks
2. ถ้าไม่มี Critical issues → PASS → Final Report
3. ถ้ามี Critical issues:
   a. Auto-fix ทุก issue ที่แก้ได้
   b. บันทึก changes ใน fix log
   c. เขียน HTML file กลับ (overwrite)
   d. round + 1 → ตรวจใหม่ (ถ้า round <= 3)
   e. ถ้า round > 3 → FAIL → Final Report
```

### Auto-fix Priority
1. Contrast failures → 2. Missing states → 3. Placeholder text → 4. Component inconsistency → 5. Interaction hints → 6. Naming & structure → 7. Spacing → 8. Typography → 9. Responsive → 10. Form logic

### Auto-fix Method
ใช้ **Edit tool** แก้ไข HTML file โดยตรง:
- ระบุ `old_string` → `new_string`
- แก้ทีละจุด ไม่ rewrite ทั้งไฟล์
- บันทึกทุกการแก้ไขใน fix log

---

## Step 6: Final Report

**PASS**: แสดง report → "HTML file ผ่าน QA — Dev เปิดเข้าใจทันที พร้อมส่งมอบ"

**FAIL** (หลัง 3 รอบ): แสดง report + remaining issues + recommendation → ถาม user:
1. ส่งมอบ HTML ตามที่แก้ได้ (พร้อม known issues)
2. ให้ลองแก้ manual ตาม recommendation

---

## Important Rules

1. **ตรวจทุกจุดทุกรอบ**: การแก้อาจทำให้จุดอื่นพัง
2. **ไม่ทำลาย functionality**: auto-fix ต้องไม่ทำให้ feature เดิมพัง
3. **บันทึกทุก change**: ทุก auto-fix ต้องอยู่ใน fix log
4. **Severity เป็นตัวตัดสิน**: PASS/FAIL ดูจาก Critical เท่านั้น
5. **Conservative fixes**: ถ้าไม่แน่ใจ → manual recommendation
6. **Respect design intent**: ไม่เปลี่ยนโทนสี/สไตล์
7. **Dev-first mindset**: ทุกอย่างที่ตรวจ ถามว่า "Dev เห็นแล้วเข้าใจไหม?"

---

## Troubleshooting

### Auto-fix ทำให้ feature พัง
**Cause**: แก้ CSS/JS ที่มี dependency กับส่วนอื่น
**Solution**: revert change ด้วย Edit tool แล้วรายงานเป็น manual fix

### Contrast check ให้ผลผิด
**Cause**: สีมาจาก gradient หรือ rgba overlay
**Solution**: ใช้สี dominant ของ gradient มาคำนวณ ถ้าไม่แน่ใจ → skip + report

### ตรวจ state coverage ไม่เจอ states ที่มีอยู่
**Cause**: states อาจใช้ class toggle แทน data-state
**Solution**: ตรวจทั้ง data-state attributes และ CSS class patterns (.loading, .empty, .error)
