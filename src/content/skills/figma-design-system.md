---
name: figma-design-system
description: "สร้าง Design System ทั้งระบบ — component library, token system, documentation ใน Figma ใช้ skill นี้เมื่อผู้ใช้ต้องการ: สร้าง design system, component library, สร้าง UI kit, สร้าง style guide, token system, pattern library, หรือเมื่อพิมพ์ 'design system', 'component library', 'UI kit', 'style guide', 'tokens', 'pattern library'"
---

# Design System Creation Skill

สร้าง Design System ทั้งระบบ — ตั้งแต่ tokens, typography scale, color system, components จนถึง documentation — พร้อมสร้างใน Figma

## Overall Flow

```
1. Requirements → 2. Read References → 3. Define Foundations → 4. Design Components → 5. Preview (HTML) → 6. Import to Figma (HTML to Figma MCP) → 7. Document
```

---

## Step 1: รวบรวม Requirements

ถามข้อมูลเหล่านี้:

- **Brand**: มี brand guidelines อยู่แล้วไหม? (สี, font, logo)
- **Platform**: Mobile, Web, Cross-platform?
- **Base System**: ต่อยอดจาก Material Design / HIG / เริ่มจากศูนย์?
- **Scale**: ใช้กี่คน? กี่ product? (กำหนดความซับซ้อน)
- **Components Needed**: ต้องการ components อะไรบ้าง? (หรือให้แนะนำ?)
- **Theme**: ต้องรองรับ Light/Dark mode ไหม?
- **Existing Design**: มี Figma URL ของ design ที่มีอยู่แล้วไหม?

---

## Step 2: อ่าน References

```
references/design-tokens.md       → Token naming & categories (อ่านเสมอ)
references/ux-principles.md       → Consistency principle (H4)
references/material-design.md     → ถ้า base = Material
references/hig.md                 → ถ้า base = HIG
```

ถ้ามี existing design:
```
get_screenshot(fileKey, nodeId)    → ดู visual style
get_design_context(fileKey, nodeId) → อ่าน design details
get_variable_defs(fileKey, nodeId) → ดู existing tokens
```

---

## Step 3: Define Foundations (Design Tokens)

### 3.1 Color System

**Step-by-step:**

1. **เลือก Primary Color** จาก brand (หรือกำหนดใหม่)
2. **Generate Color Scale** สำหรับแต่ละ hue:
   ```
   [color]-50:  lightest (background tint)
   [color]-100: very light
   [color]-200: light
   [color]-300: medium light
   [color]-400: medium
   [color]-500: base (primary)
   [color]-600: medium dark
   [color]-700: dark
   [color]-800: very dark
   [color]-900: darkest
   [color]-950: near black
   ```

3. **กำหนด Semantic Colors**:
   ```markdown
   | Token | Light Mode | Dark Mode | Usage |
   |-------|-----------|-----------|-------|
   | color-primary | blue-600 | blue-400 | Primary actions, links |
   | color-on-primary | white | blue-950 | Text on primary |
   | color-secondary | gray-600 | gray-400 | Secondary actions |
   | color-error | red-600 | red-400 | Error states |
   | color-warning | amber-600 | amber-400 | Warning states |
   | color-success | green-600 | green-400 | Success states |
   | color-info | blue-500 | blue-300 | Informational |
   | color-surface | white | gray-900 | Backgrounds |
   | color-on-surface | gray-900 | gray-50 | Primary text |
   | color-on-surface-variant | gray-600 | gray-400 | Secondary text |
   | color-outline | gray-300 | gray-700 | Borders |
   | color-outline-variant | gray-200 | gray-800 | Subtle borders |
   ```

4. **WCAG Contrast Check** (บังคับ):
   ตรวจทุกคู่ semantic color:
   ```
   color-on-surface on color-surface → ต้อง >= 4.5:1 (AA)
   color-on-primary on color-primary → ต้อง >= 4.5:1 (AA)
   color-on-surface-variant on color-surface → ต้อง >= 4.5:1 (AA)
   ```

### 3.2 Typography Scale

**กำหนด Type Scale:**

```markdown
| Token | Size | Weight | Line Height | Letter Spacing | Usage |
|-------|------|--------|-------------|----------------|-------|
| display-lg | 57px | 400 | 64px | -0.25px | Hero text |
| display-md | 45px | 400 | 52px | 0 | Page hero |
| display-sm | 36px | 400 | 44px | 0 | Section hero |
| heading-lg | 32px | 700 | 40px | 0 | Page title |
| heading-md | 24px | 700 | 32px | 0 | Section title |
| heading-sm | 20px | 600 | 28px | 0 | Card title |
| title-lg | 18px | 600 | 28px | 0 | Subtitle |
| title-md | 16px | 500 | 24px | 0.15px | List title |
| title-sm | 14px | 500 | 20px | 0.1px | Small title |
| body-lg | 16px | 400 | 24px | 0.5px | Primary body |
| body-md | 14px | 400 | 20px | 0.25px | Secondary body |
| body-sm | 12px | 400 | 16px | 0.4px | Caption |
| label-lg | 14px | 500 | 20px | 0.1px | Button label |
| label-md | 12px | 500 | 16px | 0.5px | Tab label |
| label-sm | 11px | 500 | 16px | 0.5px | Badge label |
```

**Font Family:**
- Primary: [brand font or system font]
- Mono: [monospace font for code/data]
- ระบุ fallback stack เสมอ

### 3.3 Spacing System

ใช้ 4px base unit:

```markdown
| Token | Value | Usage |
|-------|-------|-------|
| space-0 | 0px | — |
| space-1 | 4px | Icon padding, micro gaps |
| space-2 | 8px | Inline elements, tight |
| space-3 | 12px | List item internal |
| space-4 | 16px | Content padding (default) |
| space-5 | 20px | Card padding |
| space-6 | 24px | Section gaps |
| space-8 | 32px | Large gaps |
| space-10 | 40px | Section breaks |
| space-12 | 48px | Page sections |
| space-16 | 64px | Hero spacing |
| space-20 | 80px | Page top/bottom |
```

### 3.4 Shape (Corner Radius)

```markdown
| Token | Value | Usage |
|-------|-------|-------|
| radius-none | 0px | Sharp corners |
| radius-xs | 4px | Tags, badges, chips |
| radius-sm | 8px | Buttons, inputs, small cards |
| radius-md | 12px | Cards, dialogs |
| radius-lg | 16px | Large cards, FABs |
| radius-xl | 24px | Bottom sheets |
| radius-full | 9999px | Pills, avatars, circles |
```

### 3.5 Elevation

```markdown
| Token | Shadow | Usage |
|-------|--------|-------|
| elevation-0 | none | Flat surfaces |
| elevation-1 | 0 1px 3px rgba(0,0,0,0.12) | Cards (rest) |
| elevation-2 | 0 4px 6px rgba(0,0,0,0.1) | Dropdowns, popovers |
| elevation-3 | 0 8px 16px rgba(0,0,0,0.1) | FAB, bottom sheets |
| elevation-4 | 0 12px 24px rgba(0,0,0,0.12) | Dialogs, modals |
```

---

## Step 4: Design Components

### Atomic Design Hierarchy

```
Atoms → Molecules → Organisms → Templates → Pages
```

### 4.1 Atoms (พื้นฐาน)

| Component | Variants | States |
|-----------|----------|--------|
| Button | filled, outlined, text, tonal, icon | default, hover, pressed, focused, disabled, loading |
| Icon Button | filled, outlined, standard | default, hover, pressed, focused, disabled |
| Text Field | filled, outlined | default, focused, filled, error, disabled |
| Checkbox | — | unchecked, checked, indeterminate, disabled |
| Radio Button | — | unselected, selected, disabled |
| Toggle/Switch | — | off, on, disabled |
| Badge | number, dot | — |
| Chip | assist, filter, input, suggestion | default, selected, disabled |
| Divider | full-width, inset | — |
| Avatar | image, initials, icon | sizes: sm, md, lg |

### 4.2 Molecules (ประกอบจาก atoms)

| Component | Description |
|-----------|-------------|
| Search Bar | input + icon + clear button |
| List Item | avatar + text + trailing action |
| Form Field | label + input + helper text + error text |
| Menu Item | icon + label + shortcut |
| Snackbar / Toast | text + optional action button |
| Tab | icon + label + indicator |

### 4.3 Organisms (complex components)

| Component | Description |
|-----------|-------------|
| Top App Bar | nav icon + title + action icons |
| Bottom Navigation | 3-5 tab items |
| Navigation Rail | icon + label items |
| Navigation Drawer | header + menu items |
| Card | header + content + actions |
| Dialog / Modal | title + body + action buttons |
| Bottom Sheet | handle + content |
| Data Table | header + rows + pagination |
| Form | grouped form fields + submit |

### Component Spec Template

สำหรับแต่ละ component กำหนด:

```markdown
## Component: [Name]

### Anatomy
[รายการ sub-elements]

### Variants
| Variant | Visual Difference | When to Use |
|---------|------------------|-------------|
| Filled | Solid background | Primary actions |
| Outlined | Border only | Secondary actions |

### Sizes
| Size | Height | Padding | Font | Icon |
|------|--------|---------|------|------|
| Small | 32px | 12px H | label-md | 16px |
| Medium | 40px | 16px H | label-lg | 20px |
| Large | 48px | 20px H | body-lg | 24px |

### States
| State | Background | Text | Border | Opacity |
|-------|-----------|------|--------|---------|
| Default | primary | on-primary | — | 100% |
| Hover | primary-dark | on-primary | — | 100% |
| Pressed | primary-darker | on-primary | — | 100% |
| Focused | primary | on-primary | focus-ring | 100% |
| Disabled | on-surface | on-surface | — | 38% |
| Loading | primary | — | — | 70% + spinner |

### Accessibility
- Min touch target: 48x48dp / 44x44pt
- Focus indicator: 2px ring
- Disabled: opacity 38%, not focusable
- Screen reader: role="button", aria-label if icon-only

### Spacing Rules
- Internal padding: [values]
- Min gap between buttons: space-2 (8px)
- Margin from screen edge: space-4 (16px)
```

---

## Step 5: Preview (Static HTML)

สร้าง HTML preview แสดง Design System Overview — เปิดใน browser ได้ทันที:

### Preview ต้องมี:

1. **Color Palette** — แสดงทุก color token พร้อม hex (CSS Variables)
2. **Typography Scale** — แสดงทุก type style (Google Fonts: LINE Seed Sans TH)
3. **Spacing Scale** — visual representation
4. **Component Gallery** — ทุก component, ทุก variant, ทุก state
5. **Light/Dark Toggle** — สลับ theme ได้ (vanilla JS)
6. **Component State Switcher** — เปลี่ยน state ได้ (vanilla JS)

### Guidelines:

- ใช้ **CSS Variables** ตาม Design Tokens (`references/design-tokens.md`)
- ใช้ **flexbox/grid** layout → จะกลายเป็น Auto Layout ใน Figma
- ตั้ง **class names** ให้มีความหมาย → จะกลายเป็น Figma layer names
- ใช้ **semantic HTML** (`<header>`, `<section>`, `<main>`)
- **ห้ามใช้** React, Vue, หรือ JS framework — ใช้ vanilla JS เท่านั้น
- ใช้ **inline SVG** หรือ placeholder สำหรับ icons

ตั้งชื่อ: `[system-name]-design-system-preview.html`

---

## Step 6: Import เข้า Figma (HTML to Figma MCP)

ใช้ **html-to-design MCP** ส่ง HTML ไป Figma โดยตรง:

1. ตรวจว่า user เปิด html.to.design plugin ใน Figma → tab MCP → STATUS: connected
2. ใช้ `import_html` ส่ง HTML ไป Figma:
   ```
   import_html({ html: "...", css: "...", name: "Design System Overview" })
   ```
   หรือ serve file แล้วใช้ `import_url`:
   ```
   import_url({ url: "http://localhost:3000/design-system-preview.html", name: "Design System" })
   ```
3. Plugin แปลง HTML → Figma layers อัตโนมัติ
4. ปรับ fine-tune ใน Figma:
   - ตรวจ font — เปลี่ยนเป็น LINE Seed Sans TH ถ้าต้องการ
   - ตรวจ sizing mode (FILL/HUG/FIXED)
   - ปรับ layer names ถ้าต้องการ
   - สร้าง components, variants, styles ตาม design system

---

## Step 7: Document

### Design System Documentation Template

```markdown
# [System Name] Design System

## 1. Principles
- [Design principle 1]
- [Design principle 2]
- [Design principle 3]

## 2. Foundations
### Colors
[Color token table with light/dark modes]

### Typography
[Type scale table]

### Spacing
[Spacing scale]

### Shape & Elevation
[Radius and shadow tables]

## 3. Components
### [Component Name]
- Anatomy
- Variants (visual)
- States (interactive)
- Sizes
- Accessibility
- Usage guidelines (Do/Don't)

## 4. Patterns
### Common patterns
- Form layout
- List layout
- Navigation patterns
- Empty states
- Loading states
- Error handling

## 5. Accessibility Standards
- WCAG level target
- Contrast requirements
- Touch target requirements
- Screen reader guidelines
```

---

## Output Files

| Output | Format | เมื่อไหร่ |
|--------|--------|----------|
| Design Tokens | Markdown tables | เสมอ |
| Component Specs | Markdown with variants/states | เสมอ |
| Preview | `.html` (Static HTML — เปิดใน browser) | เสมอ |
| Figma Design | Import ผ่าน html-to-design MCP (`import_html` / `import_url`) | เมื่อ import เข้า Figma |
| Documentation | `.md` | เมื่อผู้ใช้ต้องการ |

---

## หลักการสำคัญ

1. **Token-First**: กำหนด tokens ก่อนออกแบบ component
2. **Consistent Naming**: ใช้ `{category}-{property}-{variant}` เสมอ
3. **Scalable**: ออกแบบให้เพิ่ม variant/component ได้ง่าย
4. **Accessible by Default**: ทุก component ต้องผ่าน WCAG AA
5. **Theme-Ready**: ทุก color token ต้องมี Light + Dark mode
6. **Platform-Aware**: ปรับ sizing/spacing ตาม platform (pt vs dp vs px)
7. **Document Everything**: ทุก component ต้องมี usage guideline
8. **Less is More**: เริ่มจาก minimal set แล้วค่อยเพิ่ม
