# Visual Design Principles Reference

ความรู้เชิงลึกด้าน Visual Design — สกัดจาก UI/UX Design Library (100+ books) ครอบคลุม Visual Hierarchy, Color Theory, White Space, Typography, Composition

---

## 1. Visual Hierarchy Framework

ลำดับชั้นภาพ — สิ่งที่ดึงความสนใจก่อน:

### Hierarchy Levers (เรียงตาม impact)

| # | Lever | Effect | Example |
|---|-------|--------|---------|
| 1 | **Size** | ใหญ่กว่า = สำคัญกว่า | Heading > Body text |
| 2 | **Color/Contrast** | สีเข้ม/สด = สำคัญกว่า | Primary CTA สีสด vs Secondary สีจาง |
| 3 | **Weight** | หนาแน่น = สำคัญกว่า | Bold heading vs Regular body |
| 4 | **Position** | บน/ซ้าย = อ่านก่อน (LTR) | Title อยู่บน, details อยู่ล่าง |
| 5 | **Spacing** | มี space รอบ = โดดเด่น | CTA มี whitespace ล้อมรอบ |
| 6 | **Depth** | เงา/ชั้น = อยู่ข้างหน้า | Modal มี shadow ทับ content |
| 7 | **Motion** | เคลื่อนไหว = ดึงตา | Notification badge pulse |

### Reading Patterns

**F-Pattern (Content-heavy pages):**
```
████████████████████
████████████████████
████████████
████████████████████
████████
████████████████████
█████
```
ผู้ใช้อ่านบรรทัดแรกเต็ม → scan ซ้ายลงมา → อ่านบางจุดที่สนใจ

**Z-Pattern (Landing pages / simple layouts):**
```
█────────────────█
       ╲
        ╲
█────────────────█
```
ผู้ใช้มอง: ซ้ายบน → ขวาบน → ซ้ายล่าง → ขวาล่าง (CTA ควรอยู่ขวาล่าง)

**Gutenberg Diagram (Even content distribution):**
```
Primary Optical    Strong Fallow
Area (ซ้ายบน)     Area (ขวาบน)
        ╲
          ╲
Weak Fallow        Terminal Area
Area (ซ้ายล่าง)    (ขวาล่าง) ← CTA here
```

### Hierarchy Checklist

- [ ] มี 1 element ที่โดดเด่นที่สุดบนหน้า (hero / CTA)
- [ ] Content มี 3 ระดับ hierarchy ชัดเจน (primary, secondary, tertiary)
- [ ] Typography hierarchy ใช้ size + weight ร่วมกัน (ไม่ใช่แค่ size)
- [ ] CTA มี visual prominence สูงสุด
- [ ] Secondary actions ดู "เบากว่า" primary
- [ ] White space ช่วย group related content

---

## 2. Color Theory

### Color Wheel & Harmony

| Harmony | คู่สี | Feeling | ใช้เมื่อ |
|---------|-------|---------|---------|
| **Complementary** | ตรงข้าม (180°) | High contrast, vibrant | CTA vs background, accent |
| **Analogous** | ข้างเคียง (±30°) | Harmonious, calm | UI themes, gradients |
| **Triadic** | 3 จุด (120°) | Vibrant, balanced | Complex UI with multiple accents |
| **Split-Complementary** | 1 + 2 ข้าง complementary | Contrast + harmony | Safer than complementary |
| **Monochromatic** | สีเดียว ต่าง shade | Clean, cohesive | Minimal UI, single-brand |

### Color Psychology

| Color | Emotion | Common Use in UI |
|-------|---------|-----------------|
| **Red** | Urgency, danger, passion | Error, destructive action, sale |
| **Orange** | Energy, warmth, confidence | Warning, CTA (secondary) |
| **Yellow** | Optimism, attention, caution | Warning, highlight, badges |
| **Green** | Success, growth, safety | Success, confirm, positive |
| **Blue** | Trust, calm, professional | Primary, links, info |
| **Purple** | Luxury, creativity, wisdom | Premium, creative apps |
| **Pink** | Playful, feminine, warm | Social, lifestyle, fun |
| **Black** | Elegance, power, authority | Premium, text, luxury |
| **White** | Clean, simple, space | Background, breathing room |
| **Gray** | Neutral, professional | Text secondary, borders, disabled |

### Color in UI — Rules

1. **60-30-10 Rule**: 60% neutral (bg), 30% secondary, 10% accent (CTA)
2. **Semantic Colors**: Error=Red, Warning=Yellow/Orange, Success=Green, Info=Blue — สากล
3. **Contrast First**: Text contrast >= 4.5:1 (WCAG AA) เสมอ
4. **Color + Shape**: ห้ามใช้สีอย่างเดียว — ต้องมี icon/shape ด้วย (color-blind safe)
5. **Limit Palette**: ไม่เกิน 5-6 สีหลัก + shades
6. **Dark Mode**: ไม่ใช่แค่ invert — ต้อง reduce contrast, use muted colors

### Contrast Calculation

```
Relative Luminance (L):
  L = 0.2126 × R_linear + 0.7152 × G_linear + 0.0722 × B_linear

  where:
    sRGB <= 0.03928 → linear = sRGB / 12.92
    sRGB > 0.03928  → linear = ((sRGB + 0.055) / 1.055) ^ 2.4

Contrast Ratio = (L_lighter + 0.05) / (L_darker + 0.05)
```

| Element | WCAG AA | WCAG AAA |
|---------|---------|----------|
| Normal text | 4.5:1 | 7:1 |
| Large text (>= 18pt / 14pt bold) | 3:1 | 4.5:1 |
| UI components | 3:1 | — |

---

## 3. White Space (Negative Space)

### Types of White Space

| Type | Description | Example |
|------|-------------|---------|
| **Micro white space** | ระหว่าง elements เล็กๆ | Letter spacing, line height, padding ใน button |
| **Macro white space** | ระหว่าง sections ใหญ่ | Section gaps, page margins, content blocks |
| **Active white space** | ตั้งใจเว้น เพื่อ guide attention | Space รอบ CTA, hero section breathing room |
| **Passive white space** | เกิดตามธรรมชาติ | Space ระหว่าง paragraphs, list items |

### White Space Rules

1. **More space = More importance**: element ที่มี space รอบมากกว่า = สำคัญกว่า
2. **Group by proximity**: elements ที่ใกล้กัน = เกี่ยวข้องกัน (Gestalt: Proximity)
3. **Consistent spacing**: ใช้ spacing system (4px/8px grid)
4. **Don't fear empty**: white space ไม่ใช่ "ว่าง" — มันคือ design element
5. **Content density balance**: mobile ต้องการ space มากกว่า desktop (touch targets)

### Spacing Ratios

| Relationship | Ratio | Example |
|-------------|-------|---------|
| Related elements | 1x | Items ใน card: 8px gap |
| Semi-related | 2x | Card padding: 16px |
| Sections | 3-4x | Section gap: 24-32px |
| Major sections | 5-6x | Page sections: 40-48px |

---

## 4. Typography Principles

### Type Scale

**Modular Scale (recommended):**
ใช้ ratio เดียวกันทั้ง scale เพื่อ harmony

| Ratio | Name | Scale Example (base 16px) |
|-------|------|---------------------------|
| 1.125 | Major Second | 16, 18, 20, 23, 25, 28 |
| 1.200 | Minor Third | 16, 19, 23, 28, 33, 40 |
| 1.250 | Major Third | 16, 20, 25, 31, 39, 49 |
| 1.333 | Perfect Fourth | 16, 21, 28, 38, 50, 67 |
| 1.500 | Perfect Fifth | 16, 24, 36, 54, 81 |

### Typography Rules for UI

1. **Body text minimum**: 16px (mobile), 14px (desktop — ถ้าจำเป็น)
2. **Line height**: body 1.4-1.6, heading 1.1-1.3
3. **Line length**: 45-75 characters (optimal: 66)
4. **Font families**: ไม่เกิน 2 (heading + body)
5. **Font weights**: ใช้ 2-3 weights max (Regular, Medium/Semibold, Bold)
6. **All caps**: ใช้เฉพาะ labels/buttons สั้นๆ ไม่ใช่ paragraphs
7. **Alignment**: Left-aligned ดีที่สุด (Thai + English), avoid justified
8. **Paragraph spacing**: >= line height × 0.5 ระหว่าง paragraphs

### Font Pairing Principles

| Strategy | Example | Effect |
|----------|---------|--------|
| Serif + Sans-serif | Playfair + Open Sans | Classic + modern |
| Same family, different weights | Inter Bold + Inter Regular | Clean, consistent |
| Geometric + Humanist | Poppins + Source Sans | Modern + friendly |
| Display + Text | Lobster + Roboto | Personality + readability |

### Thai Typography Notes

- **LINE Seed Sans TH**: sans-serif ที่ design สำหรับ digital Thai
- Thai characters สูงกว่า Latin → ต้องเพิ่ม line-height (1.5-1.8 for body)
- Thai ไม่มี spaces ระหว่างคำ → word-break: break-all ไม่เหมาะ
- Thai numbers vs Arabic numbers: ใช้ตามที่ target audience คุ้นเคย

---

## 5. Gestalt Principles for UI

| Principle | Description | UI Application |
|-----------|-------------|---------------|
| **Proximity** | ใกล้กัน = เกี่ยวข้องกัน | Group form fields, card content |
| **Similarity** | เหมือนกัน = ประเภทเดียวกัน | Same style buttons = same importance |
| **Continuity** | ตาเคลื่อนตาม path | Aligned elements, step indicators |
| **Closure** | สมองเติมส่วนที่ขาด | Card with partial image (hint scroll) |
| **Figure-Ground** | แยก foreground จาก background | Modal overlay, card elevation |
| **Common Region** | ล้อมรอบด้วยกรอบเดียวกัน = กลุ่มเดียวกัน | Cards, containers, sections |
| **Common Fate** | เคลื่อนไหวเหมือนกัน = กลุ่มเดียวกัน | Carousel items, list animations |

---

## 6. Composition & Layout

### Grid Systems

| Grid Type | Use Case | Example |
|-----------|----------|---------|
| **Column grid** | Content alignment, responsive | 4-col mobile, 8-col tablet, 12-col desktop |
| **Modular grid** | Complex layouts, dashboards | Grid of equal cards |
| **Baseline grid** | Typography alignment | 4px/8px baseline |
| **Hierarchical grid** | Magazine-style, editorial | Featured + supporting content |

### Golden Ratio (1.618)

- Content area vs sidebar: ~62% vs ~38%
- Hero image proportion: 1.618:1
- Card image to content ratio: ~60% image, ~40% content

### Layout Principles

1. **Alignment**: ทุก element ต้อง align กับ grid line อย่างน้อย 1 ด้าน
2. **Repetition**: ใช้ pattern เดียวกันซ้ำ สร้าง consistency
3. **Contrast**: สร้างความแตกต่างเมื่อต้องการ differentiate
4. **Balance**: Symmetrical (formal) vs Asymmetrical (dynamic)

---

## 7. Flat Design Principles

### Core Characteristics

1. **No skeuomorphism**: ไม่เลียนแบบ physical world
2. **Bold, flat colors**: ไม่มี gradients (หรือมีน้อย)
3. **Simple shapes**: Geometric, clean edges
4. **Typography-driven**: Type เป็น visual element หลัก
5. **Grid-based**: Strict alignment
6. **Minimal shadows**: None หรือ subtle

### Modern Flat (Flat 2.0 / Material)

Flat design ที่เพิ่ม:
- **Subtle shadows**: เพื่อ depth/elevation
- **Micro-interactions**: เพื่อ feedback
- **Gradients**: Subtle, purposeful
- **Illustrations**: Flat-style illustrations

---

## 8. Card-Based Design Patterns

### Card Anatomy

```
┌────────────────────────┐
│  ┌──────────────────┐  │  ← Image (optional)
│  │     IMAGE        │  │
│  └──────────────────┘  │
│                        │
│  Title                 │  ← Primary text (Label.3+)
│  Subtitle/Description  │  ← Secondary text (Caption.4)
│                        │
│  [Action 1]  [Action 2]│  ← Actions (optional)
│                        │
└────────────────────────┘
```

### Card Rules

1. **One idea per card**: card = content unit
2. **Consistent structure**: ทุก card ใน grid ต้อง structure เดียวกัน
3. **Visual peek**: แสดง content ที่เหลือให้เห็นนิดหน่อย (hint scroll)
4. **Tappable area**: ทั้ง card ควร tappable (ไม่ใช่แค่ text)
5. **Shadow for elevation**: card ใช้ shadow สร้าง depth
6. **Rounded corners**: modern feel, softer than sharp corners

---

## 9. Minimalism Checklist

"Remove until it breaks, then add back one thing"

- [ ] ทุก element มีเหตุผลที่ต้องอยู่? (ถ้าเอาออกแล้วไม่เสีย = เอาออก)
- [ ] ใช้สีน้อยกว่า 5 สีไหม?
- [ ] Font families ไม่เกิน 2?
- [ ] ไม่มี decoration ที่ไม่ serve function?
- [ ] White space เพียงพอ?
- [ ] Content density ไม่แน่นจนอึดอัด?
- [ ] Navigation มี items น้อยที่สุดเท่าที่ serve user goals?
- [ ] ทุก section มี 1 clear message?

---

## 10. Von Restorff Effect (Isolation Effect)

สิ่งที่ "แตกต่าง" จากรอบข้างจะถูกจำ/สังเกตก่อน

**Application in UI:**
- Primary CTA สีต่างจาก background + secondary buttons
- Important card ใหญ่กว่า/สีต่างจาก cards อื่น
- Badge/notification ใช้สีสด (เช่น แดง) บน UI สีเรียบ
- Sale price สีแดง vs regular price สีเทา
- "Recommended" plan มี border/highlight ต่าง

---

## Quick Reference: Visual Design Checklist

### Before Shipping

- [ ] Visual hierarchy ชัดเจน — มองปราดเดียวรู้ว่าสำคัญอะไร
- [ ] Color contrast ผ่าน WCAG AA (4.5:1 text, 3:1 UI)
- [ ] Typography ใช้ 2-3 sizes max + 2-3 weights
- [ ] White space สม่ำเสมอ ใช้ spacing system
- [ ] Alignment ตรง — ทุก element อยู่บน grid
- [ ] CTA โดดเด่นที่สุดบนหน้า
- [ ] Card/component design consistent ทั้งหน้า
- [ ] Color สื่อ semantic meaning ถูกต้อง
- [ ] No unnecessary decoration
- [ ] Reading pattern (F/Z) ถูก guide ไป CTA
