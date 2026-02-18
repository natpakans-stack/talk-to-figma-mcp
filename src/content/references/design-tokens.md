# Design Tokens Reference

คู่มือสร้าง Design Tokens สำหรับ Custom Design System ที่ใช้ร่วมกัน Figma

---

## Table of Contents
1. [What Are Design Tokens](#what-are-design-tokens)
2. [Token Naming Convention](#token-naming-convention)
3. [Token Categories](#token-categories)
4. [Token Template](#token-template-for-spec)
5. [Figma Integration Notes](#figma-integration-notes)

---

## What Are Design Tokens

Design Tokens คือค่าคงที่ของ design decisions ที่ใช้ร่วมกันทั้ง design (Figma) และ code — เช่น สี, font size, spacing, border-radius

เมื่อผู้ใช้มี custom design system หรือต้องการสร้างใหม่ ให้กำหนด tokens เหล่านี้ใน spec

---

## Token Naming Convention

ใช้รูปแบบ: `semantic/{category}/{property}/{variant}`

ตัวอย่าง:
```
semantic/gray-neutral/fg/high            → #1B1D22
semantic/gray-neutral/fg/mid-on-white    → #6A6E83
semantic/gray-neutral/bg/white           → #FFFFFF
semantic/gray-neutral/bg/lightgray       → #F8F8F9

semantic/primary/fg/high                 → #EC599D
semantic/primary/bg/mid                  → #EC599D
semantic/primary/border/high             → #EC599D

semantic/secondary/fg/high               → #7279FB
semantic/error/fg/high                   → #EA244F
semantic/success/bg/high                 → #559652
semantic/info/border/low                 → #CDEDF9

semantic/alpha-black/bg/mid              → #101114 @ 70%
semantic/alpha-white/fg/low              → #FFFFFF @ 50%

semantic/support/red/fg/low              → #EA244F
semantic/support/violet/bg/mid           → #AAAFFD

spacing-xs                               → 4px
spacing-sm                               → 8px
spacing-md                               → 16px
spacing-lg                               → 24px

font-size-body-md                        → 14px
font-weight-heading                      → 700
font-family-primary                      → "Inter"

radius-sm                                → 4px
radius-md                                → 8px
radius-lg                                → 16px
radius-full                              → 9999px

shadow-sm                                → 0 1px 2px rgba(0,0,0,0.1)
shadow-md                                → 0 4px 8px rgba(0,0,0,0.12)

z-index-dropdown                         → 100
z-index-modal                            → 200
z-index-toast                            → 300
```

---

## Token Categories

### 1. Color Tokens (Semantic System)

> Source: Figma Tokens export (Mode 1). Token paths use `semantic/{category}/{property}/{variant}` format.
> For alpha colors, value is shown as `hex @ opacity%`.

#### 1.1 Gray-Neutral

| Token | Hex | Alpha | Description |
|-------|-----|-------|-------------|
| semantic/gray-neutral/fg/white | #FFFFFF | 100% | White foreground |
| semantic/gray-neutral/fg/low-on-white | #9A9DAD | 100% | Low-contrast text on white |
| semantic/gray-neutral/fg/mid-on-white | #6A6E83 | 100% | Medium-contrast text on white |
| semantic/gray-neutral/fg/mid-on-gray | #3F414E | 100% | Medium-contrast text on gray |
| semantic/gray-neutral/fg/high | #1B1D22 | 100% | High-contrast foreground (near-black) |
| semantic/gray-neutral/bg/white | #FFFFFF | 100% | White background |
| semantic/gray-neutral/bg/lightgray | #F8F8F9 | 100% | Light gray background |
| semantic/gray-neutral/bg/midgray | #EBECEF | 100% | Medium gray background |
| semantic/gray-neutral/bg/darkgray | #CFD1D9 | 100% | Dark gray background |
| semantic/gray-neutral/bg/black | #1B1D22 | 100% | Black background |
| semantic/gray-neutral/border/white | #FFFFFF | 100% | White border |
| semantic/gray-neutral/border/lightgray | #F8F8F9 | 100% | Light gray border |
| semantic/gray-neutral/border/midgray | #EBECEF | 100% | Medium gray border |
| semantic/gray-neutral/border/darkgray | #CFD1D9 | 100% | Dark gray border |

#### 1.2 Disabled

| Token | Hex | Alpha | Description |
|-------|-----|-------|-------------|
| semantic/disabled/fg/on-white | #9A9DAD | 100% | Disabled foreground on white |
| semantic/disabled/bg/low | #EBECEF | 100% | Disabled background |
| semantic/disabled/border/low | #9A9DAD | 100% | Disabled border |

#### 1.3 Primary

| Token | Hex | Alpha | Description |
|-------|-----|-------|-------------|
| semantic/primary/fg/low | #F3E2EA | 100% | Primary tint foreground |
| semantic/primary/fg/high | #EC599D | 100% | Primary strong foreground |
| semantic/primary/bg/lowest | #FDEFF5 | 100% | Primary lightest background |
| semantic/primary/bg/low-on-gray | #FBDEED | 100% | Primary light bg on gray surfaces |
| semantic/primary/bg/mid | #EC599D | 100% | Primary solid background |
| semantic/primary/border/mid | #F7BDD8 | 100% | Primary medium border |
| semantic/primary/border/high | #EC599D | 100% | Primary strong border |

#### 1.4 Secondary

| Token | Hex | Alpha | Description |
|-------|-----|-------|-------------|
| semantic/secondary/fg/low | #F1F2FF | 100% | Secondary tint foreground |
| semantic/secondary/fg/high | #7279FB | 100% | Secondary strong foreground |
| semantic/secondary/bg/lowest | #F1F2FF | 100% | Secondary lightest background |
| semantic/secondary/bg/low-on-gray | #E3E4FE | 100% | Secondary light bg on gray |
| semantic/secondary/bg/mid | #7279FB | 100% | Secondary solid background |
| semantic/secondary/border/mid | #C7C9FD | 100% | Secondary medium border |
| semantic/secondary/border/high | #7279FB | 100% | Secondary strong border |

#### 1.5 Error

| Token | Hex | Alpha | Description |
|-------|-----|-------|-------------|
| semantic/error/fg/low | #FDE9ED | 100% | Error tint foreground |
| semantic/error/fg/high | #EA244F | 100% | Error strong foreground |
| semantic/error/bg/lowest | #FDE9ED | 100% | Error lightest background |
| semantic/error/bg/low | #FBD3DC | 100% | Error light background |
| semantic/error/bg/mid | #EA244F | 100% | Error solid background |
| semantic/error/bg/high | #BB1D3F | 100% | Error darkest background |
| semantic/error/border/mid | #F7A7B9 | 100% | Error medium border |
| semantic/error/border/high | #EA244F | 100% | Error strong border |

#### 1.6 Warning

| Token | Hex | Alpha | Description |
|-------|-----|-------|-------------|
| semantic/warning/fg/low | #FEF9EB | 100% | Warning tint foreground |
| semantic/warning/fg/high | #C69A2A | 100% | Warning strong foreground |
| semantic/warning/bg/lowest | #FEF9EB | 100% | Warning lightest background |
| semantic/warning/bg/low | #FEF3D7 | 100% | Warning light background |
| semantic/warning/bg/high | #F8C135 | 100% | Warning solid background |
| semantic/warning/border/low | #FBDA86 | 100% | Warning light border |
| semantic/warning/border/high | #F8C135 | 100% | Warning strong border |

#### 1.7 Success

| Token | Hex | Alpha | Description |
|-------|-----|-------|-------------|
| semantic/success/fg/low | #E1F2E0 | 100% | Success tint foreground |
| semantic/success/fg/high | #559652 | 100% | Success strong foreground |
| semantic/success/bg/lowest | #F0F8F0 | 100% | Success lightest background |
| semantic/success/bg/low | #E1F2E0 | 100% | Success light background |
| semantic/success/bg/high | #559652 | 100% | Success solid background |
| semantic/success/border/low | #A6D7A3 | 100% | Success light border |
| semantic/success/border/high | #559652 | 100% | Success strong border |

#### 1.8 Info

| Token | Hex | Alpha | Description |
|-------|-----|-------|-------------|
| semantic/info/fg/low | #CDEDF9 | 100% | Info tint foreground |
| semantic/info/fg/high | #026486 | 100% | Info strong foreground |
| semantic/info/bg/lowest | #E6F6FC | 100% | Info lightest background |
| semantic/info/bg/low | #CDEDF9 | 100% | Info light background |
| semantic/info/bg/mid | #68CAEC | 100% | Info medium background |
| semantic/info/bg/high | #0386B3 | 100% | Info solid background |
| semantic/info/border/low | #CDEDF9 | 100% | Info light border |
| semantic/info/border/high | #9BDCF3 | 100% | Info strong border |

#### 1.9 Alpha-Black (Overlay)

| Token | Hex | Alpha | Description |
|-------|-----|-------|-------------|
| semantic/alpha-black/bg/low | #101114 | 50% | Light overlay |
| semantic/alpha-black/bg/mid | #101114 | 70% | Medium overlay |
| semantic/alpha-black/bg/high | #101114 | 80% | Heavy overlay |

#### 1.10 Alpha-White (Inverse Overlay)

| Token | Hex | Alpha | Description |
|-------|-----|-------|-------------|
| semantic/alpha-white/fg/low | #FFFFFF | 50% | Semi-transparent white text |
| semantic/alpha-white/fg/mid | #FFFFFF | 70% | Visible white text |
| semantic/alpha-white/bg/low | #FFFFFF | 10% | Subtle white overlay |
| semantic/alpha-white/bg/mid | #FFFFFF | 35% | Light white overlay |

#### 1.11 Support Colors

> Extended palette for tags, badges, illustrations, and decorative elements.

**Red**

| Token | Hex | Description |
|-------|-----|-------------|
| semantic/support/red/fg/low | #EA244F | Red foreground |
| semantic/support/red/fg/mid | #8C162F | Red dark foreground |
| semantic/support/red/bg/lowest | #FDE9ED | Red lightest bg |
| semantic/support/red/bg/low | #FBD3DC | Red light bg |
| semantic/support/red/bg/mid | #F27C95 | Red medium bg |
| semantic/support/red/bg/high | #BB1D3F | Red dark bg |
| semantic/support/red/border/low | #FBD3DC | Red light border |
| semantic/support/red/border/mid | #FBD3DC | Red medium border |

**Orange**

| Token | Hex | Description |
|-------|-----|-------------|
| semantic/support/orange/fg/low | #EC6F45 | Orange foreground |
| semantic/support/orange/fg/mid | #8E4329 | Orange dark foreground |
| semantic/support/orange/bg/lowest | #FDF1EC | Orange lightest bg |
| semantic/support/orange/bg/low | #FBE2DA | Orange light bg |
| semantic/support/orange/bg/mid | #F4A98F | Orange medium bg |
| semantic/support/orange/bg/high | #BD5937 | Orange dark bg |
| semantic/support/orange/border/low | #FBE2DA | Orange light border |
| semantic/support/orange/border/mid | #F7C5B5 | Orange medium border |

**Yellow**

| Token | Hex | Description |
|-------|-----|-------------|
| semantic/support/yellow/fg/low | #F8C135 | Yellow foreground |
| semantic/support/yellow/fg/mid | #957420 | Yellow dark foreground |
| semantic/support/yellow/bg/lowest | #FEF9EB | Yellow lightest bg |
| semantic/support/yellow/bg/low | #FEF3D7 | Yellow light bg |
| semantic/support/yellow/bg/mid | #FBDA86 | Yellow medium bg |
| semantic/support/yellow/bg/high | #C69A2A | Yellow dark bg |
| semantic/support/yellow/border/low | #FEF3D7 | Yellow light border |
| semantic/support/yellow/border/mid | #FCE6AE | Yellow medium border |

**Green**

| Token | Hex | Description |
|-------|-----|-------------|
| semantic/support/green/fg/low | #6ABC66 | Green foreground |
| semantic/support/green/fg/mid | #40713D | Green dark foreground |
| semantic/support/green/bg/lowest | #F0F8F0 | Green lightest bg |
| semantic/support/green/bg/low | #E1F2E0 | Green light bg |
| semantic/support/green/bg/mid | #A6D7A3 | Green medium bg |
| semantic/support/green/bg/high | #559652 | Green dark bg |
| semantic/support/green/border/low | #E1F2E0 | Green light border |
| semantic/support/green/border/mid | #C3E4C2 | Green medium border |

**Sky**

| Token | Hex | Description |
|-------|-----|-------------|
| semantic/support/sky/fg/low | #36B9E6 | Sky foreground |
| semantic/support/sky/fg/mid | #026486 | Sky dark foreground |
| semantic/support/sky/bg/lowest | #E6F6FC | Sky lightest bg |
| semantic/support/sky/bg/low | #CDEDF9 | Sky light bg |
| semantic/support/sky/bg/mid | #68CAEC | Sky medium bg |
| semantic/support/sky/bg/high | #0386B3 | Sky dark bg |
| semantic/support/sky/border/low | #CDEDF9 | Sky light border |
| semantic/support/sky/border/mid | #9BDCF3 | Sky medium border |

**Blue**

| Token | Hex | Description |
|-------|-----|-------------|
| semantic/support/blue/fg/low | #2346EB | Blue foreground |
| semantic/support/blue/fg/mid | #152A8D | Blue dark foreground |
| semantic/support/blue/bg/lowest | #E9EDFD | Blue lightest bg |
| semantic/support/blue/bg/low | #D3DAFB | Blue light bg |
| semantic/support/blue/bg/mid | #7B90F3 | Blue medium bg |
| semantic/support/blue/bg/high | #1C38BC | Blue dark bg |
| semantic/support/blue/border/low | #D3DAFB | Blue light border |
| semantic/support/blue/border/mid | #A7B5F7 | Blue medium border |

**Pink**

| Token | Hex | Description |
|-------|-----|-------------|
| semantic/support/pink/fg/low | #EC599D | Pink foreground |
| semantic/support/pink/fg/mid | #8E355E | Pink dark foreground |
| semantic/support/pink/bg/lowest | #FDEEF5 | Pink lightest bg |
| semantic/support/pink/bg/low | #FBDEEB | Pink light bg |
| semantic/support/pink/bg/mid | #F49BC4 | Pink medium bg |
| semantic/support/pink/bg/high | #BD477E | Pink dark bg |
| semantic/support/pink/border/low | #FBDEEB | Pink light border |
| semantic/support/pink/border/mid | #F7BDD8 | Pink medium border |

**Violet**

| Token | Hex | Description |
|-------|-----|-------------|
| semantic/support/violet/fg/low | #7279FB | Violet foreground |
| semantic/support/violet/fg/mid | #444997 | Violet dark foreground |
| semantic/support/violet/bg/lowest | #FFFFFF | Violet lightest bg |
| semantic/support/violet/bg/low | #E3E4FE | Violet light bg |
| semantic/support/violet/bg/mid | #AAAFFD | Violet medium bg |
| semantic/support/violet/bg/high | #5B61C9 | Violet dark bg |
| semantic/support/violet/border/low | #E3E4FE | Violet light border |
| semantic/support/violet/border/mid | #C7C9FD | Violet medium border |

### 2. Typography Tokens

**Font Family:** LINE Seed Sans TH
**Weights:** Regular (400), Bold (700), ExtraBold (800)

#### Heading

| Token | Font Size | Line Height | Weight | Usage |
|-------|-----------|-------------|--------|-------|
| Heading.1 | 48px | 58px | Bold | Page titles, hero text |
| Heading.2 | 40px | 52px | Bold | Section headers |
| Heading.3 | 32px | 40px | Bold | Sub-section headers |
| Heading.4 | 28px | 36px | Bold | Card titles, dialog headers |
| Heading.5 | 24px | 32px | Bold | Small headings, list titles |

#### Label

| Token | Font Size | Line Height | Weight | Usage |
|-------|-----------|-------------|--------|-------|
| Label.1 | 20px | 28px | Bold | Large labels, prominent UI text |
| Label.2 | 18px | 26px | Bold | Medium labels |
| Label.3 | 16px | 24px | Bold | Standard labels, button text |
| Label.4 | 14px | 22px | Bold | Small labels, tags |
| Label.5 | 12px | 20px | Bold | Micro labels, badges |

#### Caption

| Token | Font Size | Line Height | Weight | Usage |
|-------|-----------|-------------|--------|-------|
| Caption.1 | 20px | 36px | Regular | Large body text |
| Caption.2 | 18px | 26px | Regular | Medium body text |
| Caption.3 | 16px | 24px | Regular | Standard body text |
| Caption.4 | 14px | 22px | Regular | Small body text, captions |
| Caption.5 | 12px | 20px | Regular | Micro text, footnotes |

### 3. Spacing Tokens
ใช้ 4px base unit (4, 8, 12, 16, 20, 24, 32, 40, 48, 64, 80, 96)

| Token | Value | Common Usage |
|-------|-------|-------------|
| spacing-0 | 0px | No spacing |
| spacing-1 | 4px | Icon gap |
| spacing-2 | 8px | Inline element gap |
| spacing-3 | 12px | List item padding |
| spacing-4 | 16px | Content padding, card padding |
| spacing-5 | 20px | iPad margins |
| spacing-6 | 24px | Section gaps |
| spacing-8 | 32px | Large section gaps |
| spacing-10 | 40px | Page section breaks |
| spacing-12 | 48px | Hero sections |

### 4. Shape / Radius Tokens
| Token | Value | Usage |
|-------|-------|-------|
| radius-none | 0px | Sharp corners |
| radius-sm | 4px | Tags, badges |
| radius-md | 8px | Buttons, inputs |
| radius-lg | 12px | Cards |
| radius-xl | 16px | Modals, large cards |
| radius-2xl | 24px | Bottom sheets |
| radius-full | 9999px | Pills, avatars |

### 5. Shadow / Elevation Tokens
| Token | Value | Usage |
|-------|-------|-------|
| shadow-none | none | Flat elements |
| shadow-xs | 0 1px 2px rgba(0,0,0,0.05) | Subtle lift |
| shadow-sm | 0 1px 3px rgba(0,0,0,0.1) | Cards (rest) |
| shadow-md | 0 4px 6px rgba(0,0,0,0.1) | Dropdowns, popovers |
| shadow-lg | 0 10px 15px rgba(0,0,0,0.1) | Modals |
| shadow-xl | 0 20px 25px rgba(0,0,0,0.1) | Dialogs |

### 6. Motion Tokens
| Token | Value | Usage |
|-------|-------|-------|
| duration-instant | 100ms | Toggle, micro feedback |
| duration-fast | 200ms | Hover, small transitions |
| duration-normal | 300ms | Standard transitions |
| duration-slow | 500ms | Complex animations |
| easing-default | ease-in-out | General transitions |
| easing-enter | ease-out | Elements appearing |
| easing-exit | ease-in | Elements disappearing |
| easing-spring | cubic-bezier(0.34, 1.56, 0.64, 1) | Bouncy interactions |

### 7. Breakpoint Tokens
| Token | Value | Layout |
|-------|-------|--------|
| breakpoint-sm | 640px | Mobile landscape |
| breakpoint-md | 768px | Tablet portrait |
| breakpoint-lg | 1024px | Tablet landscape / small desktop |
| breakpoint-xl | 1280px | Desktop |
| breakpoint-2xl | 1536px | Large desktop |

### 8. Z-Index Tokens
| Token | Value |
|-------|-------|
| z-base | 0 |
| z-dropdown | 100 |
| z-sticky | 200 |
| z-overlay | 300 |
| z-modal | 400 |
| z-popover | 500 |
| z-toast | 600 |
| z-tooltip | 700 |

---

## Token Template for Spec

เมื่อสร้าง Design Spec ที่รวม Design Tokens ให้ใช้ format นี้:

```markdown
## Design Tokens

### Colors
| Token | Value | Usage |
|-------|-------|-------|
| semantic/primary/fg/high | #EC599D | Primary actions, buttons |
| semantic/primary/bg/mid | #EC599D | Solid primary backgrounds |
| semantic/primary/bg/lowest | #FDEFF5 | Subtle primary tints |
| semantic/secondary/fg/high | #7279FB | Secondary actions |
| semantic/gray-neutral/fg/high | #1B1D22 | Body text |
| semantic/gray-neutral/fg/mid-on-white | #6A6E83 | Supporting text |
| semantic/gray-neutral/bg/white | #FFFFFF | Page background |
| semantic/error/fg/high | #EA244F | Error states |
| ... | ... | ... |

### Typography
| Token | Value | Usage |
|-------|-------|-------|
| font-family-primary | "Inter" | All UI text |
| font-size-body | 14px | Default body |
| ... | ... | ... |

### Spacing
Based on 4px grid:
| Token | Value |
|-------|-------|
| spacing-1 | 4px |
| spacing-2 | 8px |
| ... | ... |
```

---

## Figma Integration Notes

### สำหรับ Designer ที่จะทำ Tokens ให้ใช้ได้ใน Figma

1. **Figma Variables**: สร้าง Color, Number, String variables ตาม token ที่กำหนด
   - จัดกลุ่มเป็น Collections: Colors, Typography, Spacing, etc.
   - สร้าง modes: Light / Dark สำหรับ color tokens

2. **Figma Styles**: สร้าง Text Styles, Color Styles, Effect Styles
   - ใช้ชื่อตาม token naming convention

3. **Component Properties**: ใช้ Figma component properties เพื่อสร้าง variants
   - State: default, hover, pressed, focused, disabled
   - Size: small, medium, large
   - Type: primary, secondary, tertiary

4. **Auto Layout**: ใช้ spacing tokens ใน auto layout settings
   - Item spacing = spacing token
   - Padding = spacing token

5. **Plugins ที่ช่วย**:
   - Tokens Studio for Figma: จัดการ design tokens
   - Figma Variables: native Figma feature (preferred)
