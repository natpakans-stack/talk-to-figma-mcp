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

ใช้รูปแบบ: `{category}-{property}-{variant}-{state}`

ตัวอย่าง:
```
color-primary-default          → #6200EE
color-primary-hover            → #3700B3
color-text-primary             → #1A1A1A
color-text-secondary           → #666666
color-bg-surface               → #FFFFFF
color-bg-surface-dark          → #121212

spacing-xs                     → 4px
spacing-sm                     → 8px
spacing-md                     → 16px
spacing-lg                     → 24px

font-size-body-md              → 14px
font-weight-heading            → 700
font-family-primary            → "Inter"

radius-sm                      → 4px
radius-md                      → 8px
radius-lg                      → 16px
radius-full                    → 9999px

shadow-sm                      → 0 1px 2px rgba(0,0,0,0.1)
shadow-md                      → 0 4px 8px rgba(0,0,0,0.12)

z-index-dropdown               → 100
z-index-modal                  → 200
z-index-toast                  → 300
```

---

## Token Categories

### 1. Color Tokens

#### Semantic Colors (ต้องมีเสมอ)
| Token | Description | Example |
|-------|-------------|---------|
| color-primary | Brand primary | #6200EE |
| color-primary-variant | Darker/lighter primary | #3700B3 |
| color-secondary | Brand secondary | #03DAC6 |
| color-error | Error states | #B00020 |
| color-warning | Warning states | #FF8800 |
| color-success | Success states | #00C853 |
| color-info | Informational | #2196F3 |

#### Surface Colors
| Token | Description |
|-------|-------------|
| color-bg-primary | Main page background |
| color-bg-secondary | Card/section background |
| color-bg-tertiary | Nested containers |
| color-bg-inverse | Inverted background (dark on light) |

#### Text Colors
| Token | Description |
|-------|-------------|
| color-text-primary | Main body text |
| color-text-secondary | Supporting text |
| color-text-disabled | Disabled text |
| color-text-inverse | Text on dark backgrounds |
| color-text-link | Clickable text |
| color-text-error | Error message text |

#### Border Colors
| Token | Description |
|-------|-------------|
| color-border-default | Default borders |
| color-border-focus | Focus ring |
| color-border-error | Error field border |
| color-border-subtle | Subtle dividers |

### 2. Typography Tokens
| Token | Value |
|-------|-------|
| font-family-primary | "Inter", "SF Pro", "Roboto" |
| font-family-mono | "JetBrains Mono", "SF Mono" |
| font-size-xs | 11px |
| font-size-sm | 12px |
| font-size-md | 14px |
| font-size-lg | 16px |
| font-size-xl | 20px |
| font-size-2xl | 24px |
| font-size-3xl | 32px |
| font-size-4xl | 40px |
| font-weight-regular | 400 |
| font-weight-medium | 500 |
| font-weight-semibold | 600 |
| font-weight-bold | 700 |
| line-height-tight | 1.25 |
| line-height-normal | 1.5 |
| line-height-relaxed | 1.75 |

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
| Token | Light | Dark | Usage |
|-------|-------|------|-------|
| color-primary | #2563EB | #60A5FA | Primary actions |
| color-text-primary | #111827 | #F9FAFB | Body text |
| ... | ... | ... | ... |

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
