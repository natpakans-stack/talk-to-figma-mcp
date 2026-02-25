# UI Preview Quality Rules

กฎ Visual Design สำหรับสร้าง HTML Preview คุณภาพสูง — สกัดจาก **Refactoring UI**, **Practical UI**, **Laws of UX**, **Don't Make Me Think**, **Design of Everyday Things**, **Designing Interfaces** + 60 เล่ม (ytx-readings/design-ui-ux + justinhartman/ui-ux-design-library)

**ใช้เมื่อ**: สร้าง HTML Preview, ตรวจ QA, Review Design, สร้าง Handoff Spec

---

## 1. Visual Hierarchy (จาก Refactoring UI + NNGroup)

### กฎ Hierarchy
- **Size ไม่ใช่เครื่องมือเดียว** — ใช้ font weight + color + spacing ร่วมกัน
- **De-emphasize ตัวรอง** สำคัญกว่า emphasize ตัวหลัก — ลด contrast/weight ของ secondary content
- **Labels เป็นทางเลือกสุดท้าย** — ถ้า visual design ชัดเจนพอ ไม่ต้องมี label
- **3 ระดับ hierarchy เพียงพอ** — Primary, Secondary, Tertiary (ไม่เกิน 3 size levels)
- **CTA ต้อง pop** — Von Restorff Effect: สิ่งที่แตกต่างจะถูกสังเกต

### Reading Patterns
- **F-Pattern**: สำหรับ content-heavy (list, feed) — อ่านบรรทัดแรกเต็ม แล้ว scan ซ้ายลงมา
- **Z-Pattern**: สำหรับ landing page — ซ้ายบน → ขวาบน → ซ้ายล่าง → ขวาล่าง (CTA ที่ขวาล่าง)

---

## 2. Color Rules (จาก Refactoring UI + Color Theory books)

### พื้นฐาน
- **60-30-10**: 60% neutral (bg), 30% secondary, 10% accent (CTA)
- **จำกัด 3 สีหลัก** + shades (9-10 shades ต่อ hue)
- **ใช้ HSL ไม่ใช่ hex** สำหรับสร้าง shade — ปรับ saturation + lightness ได้ intuitive
- **Near-black/near-white** แทน pure #000/#FFF — เช่น #1B1D22 แทน #000000
- **Neutral ไม่จำเป็นต้อง gray แท้** — เติม warm/cool hue เล็กน้อย (saturation < 5% ใน HSB)
- **สีต่าง hue ต้องมี distinct brightness** — ป้องกัน visual competition
- **Saturate neutrals ทิศทางเดียว** — warm ทั้งหมด หรือ cool ทั้งหมด ห้ามผสม

### Semantic Colors (สากล)
| สี | ใช้สำหรับ | ห้ามใช้สำหรับ |
|----|----------|-------------|
| Red | Error, destructive, urgent | Success, neutral info |
| Green | Success, positive, confirm | Error, warning |
| Yellow/Amber | Warning, caution | Error, success |
| Blue | Info, primary action, links | Error, warning |

### Dark Mode Rules
- ไม่ใช่แค่ invert สี — ต้อง reduce contrast, ใช้ muted colors
- **Container brightness ต่างกันไม่เกิน 12%** (HSB) ใน dark mode, 7% ใน light mode
- **Lighter = ใกล้ผู้ใช้** — surface ที่ "ลอย" ต้องสว่างกว่า background
- **ไม่ใช้ shadow** ใน dark mode — ไม่สมเหตุผลและมองไม่เห็น
- **Font เล็ก อ่านยากขึ้น** ใน dark mode — ควรเพิ่ม weight หรือ size

---

## 3. Typography Rules (จาก Refactoring UI + Typography books)

### Scale
- **Proportional type scale** — ใช้ ratio เดียวกัน (เช่น 1.25) ห้ามสุ่มขนาด
- **Body text >= 16px** — ไม่เล็กกว่านี้บน mobile
- **Max 2 typefaces** — heading + body (เดียวกันก็ได้ถ้า weight ต่างกัน)
- **2-3 weights เพียงพอ** — Regular, Semibold/Bold, Heavy (ไม่ต้องใช้ทุก weight)

### Readability
- **Line length 60-80 characters** (optimal: 66) — ยาวกว่านี้ตาเหนื่อย
- **Line-height สัมพันธ์กับ size** — text ใหญ่ = line-height ต่ำลง, text เล็ก = line-height สูงขึ้น
- **Letter-spacing สัมพันธ์กับ size** — heading ใหญ่อาจต้อง negative tracking
- **Left-aligned เสมอ** (Thai + English) — ห้าม justify (อ่านยาก)
- **All caps เฉพาะ labels/buttons สั้นๆ** — ห้ามใช้กับ paragraph

### Links & Text
- **ไม่จำเป็นต้องใช้สีสำหรับทุก link** — ใช้ underline หรือ weight แทนได้
- **ห้ามลด contrast เพื่อ de-emphasize text** — ใช้ font size/weight เล็กลงแทน (contrast ต่ำ = อ่านไม่ออก)

---

## 4. Spacing Rules (จาก Refactoring UI + Grid Systems)

### System
- **ใช้ spacing system** — ค่าที่ mathematically related (4px grid: 4, 8, 12, 16, 20, 24, 32, 40, 48)
- **เริ่มจาก space มากไป** แล้วค่อยลด — ไม่ใช่เริ่มแน่นแล้วเพิ่ม
- **ไม่ต้องเติมเต็มทุกพื้นที่** — white space คือ design element

### Relationships
- **Outer padding >= Inner padding** — padding นอก container ต้อง >= padding ใน container
- **วัด spacing ระหว่าง high-contrast edges** — ไม่ใช่ center-to-center
- **ห้าม ambiguous spacing** — ต้องชัดว่า element ไหนกลุ่มเดียวกัน (Gestalt: Proximity)
- **Spacing ratio**: related items = 1x, semi-related = 2x, sections = 3-4x, major sections = 5-6x

### Layout
- **12-column grid** สำหรับ horizontal layouts — divisible by 2, 3, 4, 6
- **Grids are overrated** — ใช้ flexible spacing logic ดีกว่า strict grid ทุกกรณี
- **Content ไม่จำเป็นต้องเต็ม width** — max-width ช่วย readability

---

## 5. Borders & Separation (จาก Refactoring UI)

- **ใช้ border น้อยลง** — แทนด้วย box-shadow, background contrast, หรือ spacing
- **Container border ต้อง contrast กับทั้ง fill AND background** — ไม่ใช่แค่อันเดียว
- **ห้ามมี adjacent hard divides ซ้อนกัน** — background transition + container edge + dividing line ใน 1 จุด = รกเกินไป

---

## 6. Shadows & Depth (จาก Refactoring UI + Practical UI)

- **แสงมาจากทิศเดียว** — consistent ทั้งหน้า
- **Shadow blur = 2x distance value** — เช่น offset-y: 4px → blur: 8px
- **ลด opacity เมื่อ element ใกล้ viewer** — elevated element ควรมี shadow จางกว่า
- **ใช้ shadow approach เดียว** ทั้ง project — ห้ามผสม soft/hard/no-shadow
- **ห้ามใช้ shadow ใน dark mode** — ไม่สมจริงและมองไม่เห็น
- **Lighter = ใกล้** — ทั้ง light mode และ dark mode

---

## 7. Button Design (จาก Refactoring UI + Practical UI)

- **Horizontal padding = 2x Vertical padding** — เช่น padding: 12px 24px
- **Button hierarchy ชัดเจน** — Primary (solid, bold color) > Secondary (outlined/muted) > Tertiary (text only)
- **High contrast สำหรับ important elements** — minimal contrast สำหรับ structural elements
- **Gray button อาจดูเหมือน disabled** — ระวังใช้สีเทาเป็น secondary button

---

## 8. Corner Radius (จาก Practical UI)

- **Nested radius = outer radius - gap** — ถ้า outer = 16px, gap = 8px → inner = 8px
- **Consistent radius** ทั้ง app — ห้ามผสม sharp + rounded โดยไม่มีเหตุผล

---

## 9. Icons (จาก NNGroup + Refactoring UI)

- **ลด contrast ของ icon เมื่ออยู่คู่กับ text** — ใช้ opacity หรือสีจางกว่า text
- **Icon ต้องมี text label เสมอ** — "word is worth a thousand pictures"
- **มีแค่ 3 icon ที่ universal**: home, print, magnifying glass — อื่นๆ ต้องมี label
- **ถ้าคิด icon ไม่ออกใน 5 วินาที** — concept นั้นซับซ้อนเกินกว่า icon จะสื่อได้

---

## 10. Component Patterns (จาก Designing Interfaces + Practical UI)

### Cards
- ใช้สำหรับ **browsing** heterogeneous content (ไม่เหมาะกับ search/comparison)
- **Variable height, consistent width** — ไม่ force เท่ากันหมด
- **Summary + link** pattern: condensed teaser → fuller details

### Forms
- **Label ต้องเห็นตลอด** — ห้ามใช้ placeholder แทน label
- **Floating labels ได้** แต่ยังมี issues — visible label ดีกว่าเสมอ
- **Placeholder = hint format** ไม่ใช่ label (strain short-term memory, สับสนกับ default value)
- **Error ต้องอยู่ใกล้ input** — ใช้สีแดง + icon + text (ไม่ใช่แค่สี)
- **ห้ามลบ input ที่ user กรอก** เมื่อเกิด error — preserve user input เสมอ

### Toggles
- **Immediate effect** ไม่ต้องกด Save — ถ้าต้อง Save → ใช้ radio/checkbox แทน
- **Label อธิบาย ON state** — ไม่ใช่คำถาม

### Modals
- **ห้ามแสดงก่อน user engage** กับ content
- **ห้ามขัดจังหวะ critical task** กลางทาง
- **ห้ามซ้อน modal** — popup ทับ popup = nightmare
- **Focus trap บังคับ** สำหรับ modal dialog — keyboard ต้องอยู่ใน modal

### Empty States
- **ห้ามปล่อยว่าง** — ต้องมี: status message + learning cue + actionable pathway
- **ใช้เป็นโอกาส** สอน user ว่า feature ทำอะไร

### Loading States
| ระยะเวลา | Pattern | Notes |
|----------|---------|-------|
| < 1 วินาที | ไม่ต้อง | ให้รู้สึก instant |
| 1-3 วินาที | Spinner / inline text | สำหรับ individual actions |
| 2-10 วินาที | Skeleton screen | Mirror final layout structure |
| > 10 วินาที | Progress bar | ต้อง determinate |

---

## 11. Accessibility Quick Rules

- **Text contrast >= 4.5:1** (WCAG AA) — ตรวจทุกคู่สี
- **Touch target >= 44px** + spacing >= 2mm (8px)
- **สีไม่ใช่ตัวบ่งชี้เดียว** — ต้องมี icon/shape/text ด้วย
- **Focus indicator ต้องเห็นชัด** (contrast >= 3:1)
- **รองรับ prefers-reduced-motion** สำหรับทุก animation

---

## 12. Animation Rules

- **ทุก animation ต้องมี purpose** — guide attention, show connection, provide feedback
- **User-triggered < 0.1s** เริ่มต้น — Doherty Threshold
- **Animation ที่เล่นซ้ำกลายเป็น roadblock** — ห้าม force animation ที่ user เจอบ่อย
- **Background = ช้ากว่า, Foreground = เร็วกว่า** — direct interaction ต้องเร็ว
- **No animation > bad animation** — ถ้าไม่มีเหตุผล อย่ามี
- **Reduced-motion alternative เสมอ**

---

## 13. UX Writing Quick Rules (จาก Don't Make Me Think + Strategic Writing)

- **User scan ไม่ได้อ่าน** — ออกแบบสำหรับ scanning (F/Z pattern)
- **2 คำแรกของ heading/link สำคัญที่สุด** — front-load keyword
- **Plain language** — หลีกเลี่ยง jargon แม้กับ expert audience
- **Error = ปัญหา + วิธีแก้** ด้วยน้ำเสียงไม่ตำหนิ
- **Button = action verb** — "บันทึก" ไม่ใช่ "ตกลง"
- **Link = promise** — text ต้องบอกว่าไปไหน (ห้าม "Click here", "Learn More")
- **ตัวเลขใช้ digits** ไม่ใช่คำ ในสื่อ digital

---

## 14. Don't Make Me Think — Core Principles

1. **Self-evident > Self-explanatory > Need explanation** — ถ้าต้องคิด แปลว่ายังไม่ดีพอ
2. **ลด noise** — ทุก element ที่ไม่จำเป็นแข่งกับ element ที่จำเป็น
3. **Create clear visual hierarchy** — สิ่งสำคัญ ต้อง look important
4. **Convention ดีกว่า innovation** — ถ้า standard pattern ทำงานได้ อย่าประดิษฐ์ใหม่ (Jakob's Law)
5. **Omit needless words** — ลดข้อความ 50% แล้วลดอีก 50%

---

## 15. Laws of UX — Quick Reference

| Law | กฎ 1 บรรทัด | ตรวจอะไรใน Preview |
|-----|------------|-------------------|
| **Aesthetic-Usability** | สวย = ใช้ง่ายกว่า (รับรู้) | Polish visual details |
| **Hick's Law** | ตัวเลือกมาก = ตัดสินใจช้า | จำกัด CTA/options ต่อ section |
| **Fitts's Law** | เป้าใหญ่ + ใกล้ = เร็วกว่า | CTA ใหญ่พอ + ใกล้ cursor |
| **Miller's Law** | จำได้ 7±2 items | chunk ข้อมูลเป็นกลุ่ม 5-9 |
| **Jakob's Law** | ชอบ pattern ที่คุ้นเคย | follow platform conventions |
| **Doherty Threshold** | < 400ms = flow state | skeleton screens, instant feedback |
| **Von Restorff** | สิ่งที่ต่าง ถูกจำ | CTA ต่างจากรอบข้าง |
| **Serial Position** | จำตัวแรก + ตัวสุดท้าย | ข้อมูลสำคัญ ต้น + ท้าย list |
| **Peak-End Rule** | peak + ending = ความทรงจำ | optimize จุดสูงสุด + จุดจบ |
| **Proximity** | ใกล้ = เกี่ยวข้อง | spacing ต้อง group ถูก |
| **Similarity** | เหมือน = ประเภทเดียวกัน | consistent styling = same meaning |
| **Occam's Razor** | เรียบง่ายที่สุด ชนะ | ลบทุกอย่างที่ไม่ serve user goal |
| **Tesler's Law** | complexity ลดไม่ได้ จัดการได้ | ซ่อน complexity ไว้ในระบบ ไม่ใช่ user |

---

## MASTER CHECKLIST — ตรวจก่อนส่ง Preview

### Visual Quality
- [ ] Typography ใช้ defined scale (ไม่มีขนาดสุ่ม)
- [ ] Body text >= 16px; line length 60-80 chars
- [ ] Line-height สัมพันธ์กับ text size
- [ ] Max 2 typefaces, 2-3 weights
- [ ] Spacing ใช้ 4px grid system
- [ ] Outer padding >= inner padding
- [ ] สีจาก palette เท่านั้น; 60-30-10 ratio
- [ ] Near-black/near-white (ไม่ใช่ pure #000/#FFF)
- [ ] Neutral greys มี subtle hue shift
- [ ] Shadows consistent จาก single light source
- [ ] Shadow blur = 2x distance
- [ ] Nested corner radius = outer - gap
- [ ] ไม่มี adjacent hard divides ซ้อนกัน

### Hierarchy & Composition
- [ ] Visual hierarchy ชัดเจน 3 ระดับ
- [ ] CTA โดดเด่นที่สุดบนหน้า
- [ ] Gestalt grouping ถูกต้อง (proximity, similarity, common region)
- [ ] F/Z reading pattern ถูก guide ไป CTA

### Interaction Quality
- [ ] Interactive elements มี affordance ชัดเจน
- [ ] Button hierarchy: Primary > Secondary > Tertiary
- [ ] Button padding: horizontal = 2x vertical
- [ ] Touch targets >= 44px + spacing >= 8px
- [ ] ทุก state ครบ: default, hover, pressed, focused, disabled, error, loading
- [ ] Toggle = immediate effect (ไม่ต้อง Save)
- [ ] Form labels เห็นตลอด (ไม่หายเมื่อ focus)
- [ ] Error = adjacent + red + icon + problem + solution

### Accessibility
- [ ] Text contrast >= 4.5:1 (AA)
- [ ] สีไม่ใช่ตัวบ่งชี้เดียว
- [ ] Icon มี text label
- [ ] Focus indicators เห็นชัด
- [ ] Reduced-motion alternatives

### Content & UX Writing
- [ ] Heading: keyword-first, scannable
- [ ] Button: action verbs (ไม่ใช่ "ตกลง/OK")
- [ ] Error: non-judgmental, constructive
- [ ] Empty state: status + learning + action
- [ ] Link text: specific (ไม่ใช่ "Click here")
- [ ] Numbers: digits ไม่ใช่คำ

### Performance Perception
- [ ] Skeleton screens สำหรับ 2-10s loads
- [ ] No skeleton สำหรับ < 1s
- [ ] Progress bar สำหรับ > 10s
- [ ] Animation เริ่มใน < 0.1s
- [ ] ไม่มี gratuitous/repeated animation
