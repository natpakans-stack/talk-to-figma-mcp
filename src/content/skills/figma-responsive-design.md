---
name: figma-responsive-design
description: "ออกแบบ Responsive/Adaptive Design สำหรับหลาย screen size — Mobile, Tablet, Desktop พร้อมสร้าง multiple frames ใน Figma ใช้ skill นี้เมื่อผู้ใช้ต้องการ: ออกแบบ responsive, adaptive layout, หลาย screen size, mobile + desktop, breakpoints, responsive UI, หรือเมื่อพิมพ์ 'responsive', 'adaptive', 'breakpoint', 'หลายขนาด', 'mobile tablet desktop', 'responsive design'"
---

# Responsive / Adaptive Design Skill

ออกแบบ UI ที่ทำงานได้ดีบนทุกขนาดหน้าจอ — จาก Mobile เล็กสุดไปจน Desktop จอใหญ่ พร้อมสร้างหลาย frames ใน Figma

## Overall Flow

```
1. Requirements → 2. Read References → 3. Define Breakpoints → 4. Design Adaptation Rules → 5. Preview → 6. Build in Figma
```

---

## Step 1: รวบรวม Requirements

ถามข้อมูลเหล่านี้:

- **Primary Platform**: Mobile-first หรือ Desktop-first?
- **Target Breakpoints**: ต้องการกี่ขนาด? (Mobile / Tablet / Desktop / Large Desktop)
- **Screen/Feature**: จะ responsive อะไร? (หน้าจอเดียว / ทั้ง app)
- **Content Priority**: content ไหนสำคัญสุดบน mobile?
- **Navigation**: เปลี่ยน navigation pattern ตาม size ไหม?
- **Existing Design**: มี Figma URL ของ design ที่มีอยู่ (size เดียว) ไหม?
- **Framework**: ใช้ CSS framework ไหน? (Tailwind, Bootstrap, custom)

---

## Step 2: อ่าน References

```
references/ux-principles.md       → อ่านเสมอ
references/material-design.md     → Responsive grid & navigation patterns
references/hig.md                 → Size classes & adaptive layout (iOS)
references/design-tokens.md       → Breakpoint tokens
```

---

## Step 3: Define Breakpoints

### 3.1 Standard Breakpoints

| Breakpoint | Width | Device Category | Columns | Margin | Gutter |
|------------|-------|----------------|---------|--------|--------|
| xs | < 360px | Small phone | 4 | 16px | 8px |
| sm | 360-599px | Phone | 4 | 16px | 8px |
| md | 600-904px | Tablet portrait / Foldable | 8 | 24px | 16px |
| lg | 905-1239px | Tablet landscape / Small desktop | 12 | 24px | 24px |
| xl | 1240-1439px | Desktop | 12 | 24px | 24px |
| 2xl | >= 1440px | Large desktop | 12 | auto (max-width) | 24px |

### 3.2 Common Frame Sizes สำหรับ Figma

| Device | Width | Height | Use For |
|--------|-------|--------|---------|
| iPhone SE | 375px | 667px | Small phone |
| iPhone 15 Pro | 393px | 852px | Standard phone |
| iPhone 15 Pro Max | 430px | 932px | Large phone |
| iPad Mini | 744px | 1133px | Small tablet |
| iPad Pro 11" | 834px | 1194px | Tablet |
| iPad Pro 12.9" | 1024px | 1366px | Large tablet |
| MacBook Air | 1440px | 900px | Desktop |
| Desktop HD | 1920px | 1080px | Large desktop |

### 3.3 เลือก Target Sizes

**Minimum recommended (3 sizes):**
```
Mobile:  393 x 852px   (iPhone 15 Pro)
Tablet:  834 x 1194px  (iPad Pro 11")
Desktop: 1440 x 900px  (MacBook Air)
```

**Comprehensive (5 sizes):**
```
Small Phone:  375 x 667px
Phone:        393 x 852px
Tablet:       834 x 1194px
Desktop:      1440 x 900px
Large Desktop: 1920 x 1080px
```

---

## Step 4: Design Adaptation Rules

### 4.1 Layout Adaptation Strategies

| Strategy | Description | Example |
|----------|-------------|---------|
| **Reflow** | Stack → Row | Cards stack vertical on mobile, horizontal on desktop |
| **Expand** | เพิ่ม width | Sidebar เปลี่ยนจาก icon-only เป็น full-width |
| **Reveal** | Show more content | แสดง sidebar ที่ซ่อนบน mobile |
| **Hide** | ซ่อน non-essential | ซ่อน secondary info บน mobile |
| **Resize** | เปลี่ยนขนาด | Image full-width บน mobile, fixed width บน desktop |
| **Reposition** | ย้ายตำแหน่ง | FAB บน mobile → inline button บน desktop |
| **Transform** | เปลี่ยน component | Bottom sheet บน mobile → side panel บน desktop |

### 4.2 Navigation Adaptation

| Size | Primary Nav | Secondary Nav |
|------|-------------|---------------|
| Mobile (< 600) | Bottom Tab Bar (3-5 items) | Hamburger → Drawer |
| Tablet (600-904) | Navigation Rail (side icons) | Tab bar |
| Desktop (905+) | Sidebar Navigation (full) | Top tabs |

### 4.3 Content Adaptation Rules

สำหรับแต่ละ section กำหนด:

```markdown
## Content Adaptation

### Hero Section
| Breakpoint | Layout | Image | Text |
|------------|--------|-------|------|
| Mobile | Stack (image top, text bottom) | Full-width, 16:9 | heading-md, body-md |
| Tablet | Side-by-side (50/50) | 1:1 | heading-lg, body-lg |
| Desktop | Side-by-side (40/60) | Custom crop | display-sm, body-lg |

### Card Grid
| Breakpoint | Columns | Card Width | Gap |
|------------|---------|------------|-----|
| Mobile | 1 | 100% | 16px |
| Tablet | 2 | calc(50% - 12px) | 24px |
| Desktop | 3-4 | calc(33% - 16px) | 24px |

### Data Table
| Breakpoint | Adaptation |
|------------|------------|
| Mobile | Transform to card list (stack rows) |
| Tablet | Horizontal scroll with sticky first column |
| Desktop | Full table view |

### Form Layout
| Breakpoint | Columns | Input Width |
|------------|---------|-------------|
| Mobile | 1 | 100% |
| Tablet | 2 (side-by-side for short fields) | 50% |
| Desktop | 2-3 | 33-50% |
```

### 4.4 Typography Adaptation

```markdown
## Typography Scale by Breakpoint

| Token | Mobile | Tablet | Desktop |
|-------|--------|--------|---------|
| display | 36px | 45px | 57px |
| heading-lg | 24px | 28px | 32px |
| heading-md | 20px | 22px | 24px |
| body | 16px | 16px | 16px |
| body-sm | 14px | 14px | 14px |
```

Body text ไม่ค่อยเปลี่ยน ส่วน headings/display scale ขึ้นตามหน้าจอ

### 4.5 Spacing Adaptation

```markdown
## Spacing by Breakpoint

| Token | Mobile | Tablet | Desktop |
|-------|--------|--------|---------|
| page-margin | 16px | 24px | 24px (or auto center) |
| section-gap | 24px | 32px | 48px |
| card-padding | 16px | 20px | 24px |
| content-padding | 16px | 24px | 24px |
```

### 4.6 Touch Target Adaptation

| Breakpoint | Min Target | Reason |
|------------|-----------|--------|
| Mobile | 48 x 48px | Touch (finger) |
| Tablet | 44 x 44px | Touch + stylus |
| Desktop | 32 x 32px (click) | Mouse (but keep 44px accessible) |

---

## Step 5: Preview (React .jsx)

สร้าง React preview ที่ **resize ได้**:

### Preview ต้องมี:

1. **Responsive Container** — ลาก resize ได้ หรือมีปุ่มสลับ breakpoint
2. **Breakpoint Indicator** — แสดง current breakpoint (xs/sm/md/lg/xl)
3. **Side-by-side View** — แสดง Mobile + Tablet + Desktop พร้อมกัน
4. **Layout Annotations** — แสดง grid columns, margins, gaps
5. **Light/Dark Toggle** — สลับ theme ได้
6. **Content Priority Highlight** — แสดงว่า content ไหนหาย/ย้ายเมื่อ resize

### Guidelines:

- ใช้ CSS media queries (หรือ container queries) จริง
- แสดง breakpoint badge ที่มุมบนซ้าย
- มี ruler/grid overlay toggle
- ทุก adaptation rule ต้องเห็นผลจริงเมื่อ resize

ตั้งชื่อ: `[screen-name]-responsive-preview.jsx`

---

## Step 6: Build in Figma

อ่าน `references/figma-mcp-commands.md` แล้วสร้าง:

### 6.1 Frame Structure

สร้าง frame สำหรับแต่ละ breakpoint:

```
📄 [Screen Name] - Responsive
├── 🖼 Mobile (393 x 852)
│   ├── Status Bar
│   ├── Content
│   └── Bottom Nav
├── 🖼 Tablet (834 x 1194)
│   ├── Top App Bar
│   ├── Navigation Rail + Content
│   └── Footer
└── 🖼 Desktop (1440 x 900)
    ├── Top App Bar
    ├── Sidebar + Content + Side Panel
    └── Footer
```

### 6.2 สร้างแต่ละ Frame

```
สำหรับแต่ละ breakpoint:

1. create_frame({
     name: "[Screen] - Mobile",
     width: 393, height: 852,
     fillColor: { r: 1, g: 1, b: 1 },
     layoutMode: "VERTICAL"
   })

2. สร้าง child elements ตาม adaptation rules
   - ใช้ parentId ใส่ elements
   - ใช้ layoutMode: "VERTICAL" สำหรับ mobile stacking
   - ใช้ layoutMode: "HORIZONTAL" สำหรับ desktop side-by-side

3. set_layout_sizing สำหรับ auto-layout children:
   - Mobile: layoutSizingHorizontal: "FILL" (full-width)
   - Desktop: layoutSizingHorizontal: "FIXED" (fixed sidebar)
```

### 6.3 จัด Layout

วาง frames เรียงกัน:
```
Mobile:  x=0,    y=0
Tablet:  x=450,  y=0
Desktop: x=1340, y=0
```

ระยะห่างระหว่าง frames: ~50px

### 6.4 Annotate Adaptation Rules

```
set_multiple_annotations({
  nodeId: "responsive-container",
  annotations: [
    {
      nodeId: "mobile-nav",
      labelMarkdown: "**Navigation**\nMobile: Bottom Tab Bar\nTablet: Navigation Rail\nDesktop: Full Sidebar"
    },
    {
      nodeId: "mobile-cards",
      labelMarkdown: "**Card Grid**\nMobile: 1 column\nTablet: 2 columns\nDesktop: 3 columns"
    }
  ]
})
```

### 6.5 Connection Lines (Optional)

ใช้ `create_connections` เชื่อมแสดงว่า element เดียวกัน adapt อย่างไร:
```
create_connections({
  connections: [
    { startNodeId: "mobile-nav", endNodeId: "tablet-nav", text: "Tab → Rail" },
    { startNodeId: "tablet-nav", endNodeId: "desktop-nav", text: "Rail → Sidebar" }
  ]
})
```

---

## Responsive Design Checklist

ตรวจสอบก่อนส่งมอบ:

### Layout
- [ ] ทุก breakpoint มี consistent visual identity
- [ ] Content priority ถูกต้อง (สำคัญสุดเห็นก่อน)
- [ ] Grid system consistent (columns, margins, gutters)
- [ ] Max-width กำหนดสำหรับ large screens (ไม่ stretch จนอ่านยาก)
- [ ] Line length ไม่เกิน 75 characters

### Navigation
- [ ] Navigation pattern เหมาะกับ screen size
- [ ] Navigation transitions smooth (ไม่ jump)
- [ ] ทุก page reachable จากทุก breakpoint

### Typography
- [ ] Display/heading sizes scale ตาม breakpoint
- [ ] Body text readable (>= 16px) ทุก size
- [ ] Line height comfortable ทุก size

### Touch & Interaction
- [ ] Touch targets >= 48px บน mobile/tablet
- [ ] Hover states สำหรับ desktop
- [ ] Touch-friendly spacing บน mobile

### Images & Media
- [ ] Images responsive (ไม่ overflow)
- [ ] Art direction ถูกต้อง (crop เหมาะสมกับ size)
- [ ] Video/media ไม่ทำให้ layout เพี้ยน

### Accessibility
- [ ] WCAG contrast ผ่านทุก breakpoint
- [ ] Focus order logical ทุก size
- [ ] Screen reader order ถูกต้อง

---

## Output Files

| Output | Format | เมื่อไหร่ |
|--------|--------|----------|
| Breakpoint Definition | Markdown tables | เสมอ |
| Adaptation Rules | Markdown tables per section | เสมอ |
| Responsive Preview | `.jsx` (React, resizable) | เสมอ |
| Figma Frames | Multiple frames per breakpoint | เมื่อ build ใน Figma |
| Annotations | Figma annotations | เมื่อ build ใน Figma |

---

## หลักการสำคัญ

1. **Content First**: เริ่มจาก content priority ไม่ใช่ layout
2. **Mobile First**: ออกแบบ mobile ก่อน แล้ว enhance ขึ้นไป (ถ้า primary = mobile)
3. **Progressive Enhancement**: เพิ่ม features/content ตาม screen ที่ใหญ่ขึ้น
4. **Consistent Identity**: ทุก breakpoint ต้องรู้สึกเป็น app เดียวกัน
5. **Test Real Content**: ใช้ real content length ทดสอบ ไม่ใช่ Lorem Ipsum
6. **Performance**: Mobile ต้องเร็ว — ลด content, optimize images
7. **Fluid > Fixed**: ใช้ relative units (%, fr, auto) มากกว่า fixed pixels
8. **Breakpoints ≠ Devices**: ออกแบบตาม content ไม่ใช่ตาม device ที่เฉพาะเจาะจง
