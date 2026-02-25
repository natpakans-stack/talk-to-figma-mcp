---
name: design-handoff-spec
description: "สร้าง Developer Handoff Documentation อย่างครบถ้วน — ครอบคลุม design specs, component inventory, interaction annotations, responsive behavior, edge cases, asset list, API mapping เพื่อให้ dev implement ได้ตรงตาม design โดยไม่ต้องถาม ใช้ skill นี้เมื่อผู้ใช้ต้องการ: ส่งงานให้ dev, สร้าง handoff doc, spec sheet, design spec, component spec, ส่งมอบ design, หรือเมื่อพิมพ์ 'handoff', 'ส่งงาน', 'dev handoff', 'design spec', 'spec sheet', 'ส่งมอบ', 'handoff doc', 'component spec', 'dev spec'"
---

# Design Handoff Specification Skill

สร้าง Developer Handoff Document ที่ครบถ้วน — ให้ dev implement ได้ตรง design โดยไม่ต้องถามซ้ำ

---

## Pipeline Position

```
UI Design → QA Gate (pass) → ★ Design Handoff ★ → Developer
```

---

## Overall Flow

```
1. รับ Design ──▶ 2. วิเคราะห์ ──▶ 3. สร้าง Spec ──▶ 4. สร้าง Handoff Doc ──▶ 5. Output
```

---

## Step 1: รับ Design

ถามผู้ใช้:

- **Source**: Figma URL, HTML preview?
- **Scope**: ทั้ง feature หรือเฉพาะบาง screen?
- **Tech Stack**: dev ใช้อะไร? (React Native, Flutter, SwiftUI, Web?)
- **Design System**: มี shared component library ไหม?
- **Previous Handoff**: เคยส่ง handoff ก่อนหน้าไหม? มี pattern ที่ dev คุ้นเคย?

### วิธีอ่าน Design:

**จาก Figma:**
- get_design_context → อ่าน design details (สี, font, spacing, components)
- get_metadata → ดู structure + layer naming
- get_screenshot → ดู visual
- get_variable_defs → ดู design tokens

**จาก HTML Preview:**
- อ่านไฟล์ .html ด้วย Read tool
- Extract styles, colors, fonts, spacing จาก source

### อ่าน References:
```
references/design-tokens.md              → Token mapping (อ่านเสมอ)
references/ui-preview-quality-rules.md   → Visual design rules สำหรับ spec ให้ dev (อ่านเสมอ)
```

---

## Step 2: วิเคราะห์ Design

### 2.1 Screen Inventory

สำรวจทุก screen + states:

| # | Screen | States | Components | Notes |
|---|--------|--------|------------|-------|
| 1 | Login | default, filled, error, loading | Input×2, Button, Link | Social login options |
| 2 | Home | default, loading, empty, error | Header, Card×N, TabBar | Infinite scroll |

### 2.2 Component Inventory

สำรวจทุก component ที่ใช้:

| Component | Variants | States | Props |
|-----------|----------|--------|-------|
| Button | Primary, Secondary, Tertiary | Default, Pressed, Disabled, Loading | label, icon?, size, isLoading |
| Input | Text, Password, Email, Search | Default, Focused, Filled, Error, Disabled | label, placeholder, helper, error, type |
| Card | Default, Compact, Featured | Default, Pressed | title, subtitle, image?, badge? |

### 2.3 Token Mapping

จับคู่ design values กับ tokens:

| Property | Design Value | Token Name | CSS Variable |
|----------|-------------|------------|-------------|
| Primary color | #EC599D | primary/bg/mid | --color-primary |
| Body text | #1B1D22 | gray-neutral/fg/high | --color-text-primary |
| Card padding | 16px | spacing-4 | --spacing-4 |
| Card radius | 12px | radius-lg | --radius-lg |
| Body font | 16px/24px Regular | caption-3 | --font-body |

---

## Step 3: สร้าง Spec แต่ละ Component

### 3.1 Visual Spec

สำหรับแต่ละ component/screen ระบุ:

```
┌─────────────────────────────────────────────┐
│  Component Name: [PrimaryButton]            │
│                                             │
│  ┌─────────────────────────────┐            │
│  │                             │            │
│  │  ┌───────────────────────┐  │  height: 48px
│  │  │     Label Text        │  │  font: Label.3 (16/24 Bold)
│  │  │     #FFFFFF            │  │  color: white
│  │  └───────────────────────┘  │
│  │                             │  padding: 12px 24px
│  │  bg: #EC599D (primary)      │  radius: 8px (radius-md)
│  │  min-width: 120px           │
│  └─────────────────────────────┘            │
│                                             │
│  States:                                    │
│  ├── Default:  bg #EC599D                   │
│  ├── Pressed:  bg #D14A8A (darken 10%)     │
│  ├── Disabled: bg #EBECEF, text #9A9DAD    │
│  └── Loading:  bg #EC599D + spinner        │
│                                             │
│  Animation:                                 │
│  ├── Press: scale(0.97) 100ms ease-out     │
│  └── Loading: spinner rotate 1s linear     │
└─────────────────────────────────────────────┘
```

### 3.2 Spacing Spec

แต่ละ screen ระบุ spacing:

```
┌─ Screen: Login ─────────────────────────────┐
│                                             │
│  ┌─ Header ──────────────────────┐ pt: 48px │
│  │  Logo (40x40)                 │          │
│  └───────────────────────────────┘          │
│                                    gap: 32px │
│  ┌─ Form ────────────────────────┐          │
│  │  Email Input                  │          │
│  │                      gap: 16px│          │
│  │  Password Input               │          │
│  │                      gap: 8px │          │
│  │  Forgot Password Link         │          │
│  │                      gap: 24px│          │
│  │  Login Button                 │          │
│  │                      gap: 16px│          │
│  │  "or continue with"           │          │
│  │                      gap: 16px│          │
│  │  Social Login Row             │          │
│  └───────────────────────────────┘          │
│                                    gap: 24px │
│  ┌─ Footer ──────────────────────┐          │
│  │  "Don't have account?" Link   │          │
│  └───────────────────────────────┘ pb: 34px │
│                                             │
│  margin-x: 24px                             │
└─────────────────────────────────────────────┘
```

### 3.3 Interaction Spec (Per Component)

| Element | Trigger | Action | Animation | Duration |
|---------|---------|--------|-----------|----------|
| Login Button | Tap | Validate → API call → Navigate | Press scale → Loading → Success | 100ms → ∞ → 300ms |
| Email Input | Focus | Show keyboard, scroll into view | Border color change | 200ms |
| Password Eye | Tap | Toggle visibility | Icon swap | instant |
| Forgot PW | Tap | Navigate to reset flow | Push right | 300ms |
| Social Login | Tap | Open OAuth webview | Scale press → slide up | 100ms → 300ms |

### 3.4 Responsive Behavior

| Breakpoint | Layout Change | Notes |
|------------|--------------|-------|
| Mobile (< 640px) | Single column, full-width buttons | Default design |
| Tablet (768px) | Center content, max-width 400px | Card-like container |
| Desktop (1024px+) | Split layout: illustration left, form right | 50/50 split |

### 3.5 Edge Cases & Error States

| Case | UI Behavior | Copy | Design |
|------|------------|------|--------|
| Empty email | Inline error below input | "กรุณากรอกอีเมล" | Red border + error text |
| Invalid email format | Inline error | "รูปแบบอีเมลไม่ถูกต้อง" | Red border |
| Wrong password | Inline error + shake | "รหัสผ่านไม่ถูกต้อง" | Shake animation 300ms |
| Network error | Toast notification | "ไม่สามารถเชื่อมต่อได้ ลองอีกครั้ง" | Error toast bottom |
| Server 500 | Full-screen error | "เกิดข้อผิดพลาด" + retry button | Error illustration |
| Account locked | Alert dialog | "บัญชีถูกล็อค" + support link | Warning dialog |
| Long email (overflow) | Text ellipsis | — | Truncate with ... |

---

## Step 4: สร้าง Handoff Document

### Handoff Document Structure

```
handoff-doc.html
├── OVERVIEW
│   ├── Feature summary (1-2 sentences)
│   ├── Screen list + state matrix
│   └── Tech requirements (platform, dependencies)
│
├── DESIGN TOKENS
│   ├── Colors used (with CSS variables)
│   ├── Typography used (with token names)
│   ├── Spacing values (with token names)
│   └── Other tokens (radius, shadow, etc.)
│
├── SCREEN SPECS (per screen)
│   ├── Full screenshot + annotated measurements
│   ├── Component breakdown (which components used)
│   ├── Spacing diagram (all margins, paddings, gaps)
│   ├── Responsive behavior table
│   └── Edge cases + error states
│
├── COMPONENT SPECS (per component)
│   ├── Visual spec (size, colors, typography)
│   ├── All states (default, hover, pressed, disabled, error, loading)
│   ├── Props / variants table
│   └── Interaction spec (triggers, animations, durations)
│
├── INTERACTION SPEC
│   ├── Screen transition map
│   ├── Gesture spec (if mobile)
│   ├── Loading states spec
│   └── Animation timing table
│
├── ASSET LIST
│   ├── Icons needed (with size + format)
│   ├── Images needed (with dimensions + format)
│   ├── Illustrations (with source)
│   └── Fonts (with weights + source)
│
├── API MAPPING (if known)
│   ├── Screen → API endpoint mapping
│   ├── Form field → API field mapping
│   └── Error code → UI state mapping
│
└── CHECKLIST
    ├── Implementation checklist (per screen)
    ├── Accessibility requirements
    └── Testing scenarios
```

### Asset Export Spec

| Asset | Format | Sizes | Naming |
|-------|--------|-------|--------|
| App icon | PNG | 1024×1024, @1x @2x @3x | app-icon |
| Tab icons | SVG or PNG | 24×24 @1x, @2x, @3x | icon-{name} |
| Illustrations | SVG or PNG | Original + @2x | illust-{name} |
| Photos | JPEG/WebP | Multiple sizes | photo-{name}-{size} |
| Logos | SVG | Original | logo-{variant} |

### Implementation Notes

สิ่งที่ dev ต้องรู้แต่ design ไม่เห็น:

```markdown
## Notes for Developers

### Behavior Notes
- [Form] Auto-save draft ทุก 30 วินาที
- [List] Infinite scroll — load 20 items per page
- [Image] Lazy load images outside viewport
- [Input] Debounce search input 300ms
- [Button] Disable after tap until API responds (prevent double-submit)

### Accessibility Notes
- All interactive elements: min 44×44pt touch target
- All images: require alt text
- Form errors: announce via screen reader (aria-live="assertive")
- Color is not the only indicator: use icons + text alongside colors
- Support Dynamic Type / font scaling

### Performance Notes
- Use skeleton screens during API calls
- Cache API responses where appropriate
- Optimize images (WebP, lazy load, srcset)
- Preload critical fonts
```

---

## Step 5: Output

### Output Format: HTML Handoff Document

สร้างไฟล์ `handoff-[feature-name].html` ที่แสดง:

1. **Overview** — feature summary + screen list
2. **Token Table** — ทุก token ที่ใช้ พร้อม CSS variable + preview สี
3. **Screen Specs** — annotated screenshots + spacing diagrams
4. **Component Specs** — visual spec + states + props
5. **Interaction Specs** — transitions + animations + gestures
6. **Asset List** — ทุก asset ที่ต้อง export
7. **Edge Cases** — ทุก error/empty/loading state
8. **Implementation Checklist** — dev ใช้ check เมื่อ implement เสร็จ

### Styling Guidelines
- ใช้ Design Tokens ของระบบ
- Component specs ใช้ real design values (px, hex, token names)
- ทุก measurement ต้องชัดเจน — ไม่มี "ประมาณ"
- ใช้ visual diagrams ไม่ใช่แค่ text descriptions

---

## หลักการสำคัญ

1. **No Ambiguity**: ทุก value ต้องระบุ exact (px, hex, token name) — ห้าม "ประมาณ"
2. **All States Covered**: ทุก component ต้องมีทุก state (default, hover, pressed, disabled, error, loading)
3. **Edge Cases First**: Edge cases สำคัญกว่า happy path — dev ต้องรู้ว่า design เมื่อ error/empty/offline
4. **Token-Based**: ทุก value ต้อง map กับ design token — ไม่ใช่ hardcode
5. **Visual > Text**: ใช้ annotated screenshots + diagrams ดีกว่าอธิบาย
6. **Dev Language**: เขียนด้วยภาษาที่ dev เข้าใจ (px, rem, CSS properties)
7. **Single Source of Truth**: Handoff doc คือ "ความจริง" — ถ้า Figma กับ doc ต่างกัน ให้ยึด doc
8. **Checklist-Driven**: dev ต้อง check ทุก item ก่อนส่ง review
