# Apple Human Interface Guidelines (HIG) Reference

อ้างอิงจาก Apple Human Interface Guidelines สำหรับ iOS, iPadOS, macOS

---

## Table of Contents
1. [Design Principles](#design-principles)
2. [Typography](#typography)
3. [Color System](#color-system)
4. [Layout & Spacing](#layout--spacing)
5. [Components](#key-components)
6. [Navigation Patterns](#navigation-patterns)
7. [Motion & Animation](#motion--animation)
8. [Accessibility](#accessibility)
9. [Platform Differences](#platform-differences)

---

## Design Principles

Apple HIG ยึดหลักสำคัญ 6 ข้อ:
1. **Aesthetic Integrity** — ความสวยงามสอดคล้องกับฟังก์ชัน
2. **Consistency** — ใช้ system-provided components และ patterns
3. **Direct Manipulation** — interact กับ content โดยตรง (gestures)
4. **Feedback** — ตอบสนองทุก action ด้วย visual/haptic feedback
5. **Metaphors** — ใช้สิ่งที่คุ้นเคยในโลกจริง
6. **User Control** — ให้ผู้ใช้ควบคุม ไม่ใช้ระบบตัดสินใจเอง

---

## Typography

### iOS Type Scale (SF Pro)
| Style | Weight | Size | Leading | Tracking |
|-------|--------|------|---------|----------|
| Large Title | Bold | 34pt | 41pt | 0.37 |
| Title 1 | Bold | 28pt | 34pt | 0.36 |
| Title 2 | Bold | 22pt | 28pt | 0.35 |
| Title 3 | Semibold | 20pt | 25pt | 0.38 |
| Headline | Semibold | 17pt | 22pt | -0.41 |
| Body | Regular | 17pt | 22pt | -0.41 |
| Callout | Regular | 16pt | 21pt | -0.32 |
| Subheadline | Regular | 15pt | 20pt | -0.24 |
| Footnote | Regular | 13pt | 18pt | -0.08 |
| Caption 1 | Regular | 12pt | 16pt | 0 |
| Caption 2 | Regular | 11pt | 13pt | 0.07 |

### Dynamic Type Support
- ทุก text style ต้องรองรับ Dynamic Type (scalable)
- Test ที่ accessibility size xLarge ขึ้นไป
- ใช้ system font (SF Pro) ไว้ก่อนไม่มีเหตุผลด้าน branding

---

## Color System

### System Colors (iOS 17+)
| Color | Light | Dark | Usage |
|-------|-------|------|-------|
| systemBlue | #007AFF | #0A84FF | Links, tappable text |
| systemGreen | #34C759 | #30D158 | Success, positive |
| systemRed | #FF3B30 | #FF453A | Destructive, errors |
| systemOrange | #FF9500 | #FF9F0A | Warnings |
| systemYellow | #FFCC00 | #FFD60A | Caution |
| systemPurple | #AF52DE | #BF5AF2 | — |
| systemPink | #FF2D55 | #FF375F | — |
| systemTeal | #5AC8FA | #64D2FF | — |

### Background Colors
| Color | Light | Dark | Usage |
|-------|-------|------|-------|
| systemBackground | #FFFFFF | #000000 | Primary bg |
| secondarySystemBackground | #F2F2F7 | #1C1C1E | Grouped content bg |
| tertiarySystemBackground | #FFFFFF | #2C2C2E | Elevated grouped bg |
| systemGroupedBackground | #F2F2F7 | #000000 | Grouped table bg |

### Label Colors
| Color | Light | Dark | Usage |
|-------|-------|------|-------|
| label | #000000 | #FFFFFF | Primary text |
| secondaryLabel | #3C3C43 (60%) | #EBEBF5 (60%) | Secondary text |
| tertiaryLabel | #3C3C43 (30%) | #EBEBF5 (30%) | Tertiary text |
| quaternaryLabel | #3C3C43 (18%) | #EBEBF5 (18%) | Placeholders |

### Separator Colors
| Color | Light | Dark |
|-------|-------|------|
| separator | #3C3C43 (29%) | #545458 (60%) |
| opaqueSeparator | #C6C6C8 | #38383A |

---

## Layout & Spacing

### Safe Areas & Margins
| Device | Leading Margin | Content Width |
|--------|---------------|---------------|
| iPhone SE | 16pt | 343pt |
| iPhone 15 | 16pt | 361pt |
| iPhone 15 Pro Max | 16pt | 398pt |
| iPad Mini | 20pt | — |
| iPad Pro 11" | 20pt | — |
| iPad Pro 12.9" | 20pt | — |

### Standard Spacing
| Value | Usage |
|-------|-------|
| 4pt | Minimal (between related icons) |
| 8pt | Tight (related elements) |
| 12pt | Compact (list item internal) |
| 16pt | Standard (content margins, section gaps) |
| 20pt | Comfortable (iPad margins) |
| 24pt | Spacious (between major sections) |
| 32pt | Section breaks |

### Layout Grid
- Base unit: 8pt
- ใช้ Auto Layout ใน Figma เพื่อจำลอง iOS layout behavior
- ระยะห่างระหว่าง list items: 44pt (minimum tap height)

---

## Key Components

### Navigation Bar (UINavigationBar)
- Height: 44pt (compact), 96pt (large title)
- Large Title: 34pt, Bold, left-aligned
- Back button: chevron + previous title
- Bar buttons: SF Symbols (28pt), max 2 trailing

### Tab Bar (UITabBar)
- Height: 49pt (iPhone), 50pt (iPad)
- Items: 2-5
- Icon: 25pt x 25pt (SF Symbols)
- Label: Caption 2 (10pt)
- Active: tint color, Inactive: systemGray

### Buttons
| Type | Height | Corner | Usage |
|------|--------|--------|-------|
| Bordered Prominent | 50pt | 12pt | Primary CTA |
| Bordered | 50pt | 12pt | Secondary |
| Plain | 44pt tap target | None | Tertiary, text-style |
| Destructive | 50pt | 12pt | Delete, remove (red) |

### Lists / Tables
| Style | Usage |
|-------|-------|
| Inset Grouped | Default for settings, forms (rounded corners, inset from edges) |
| Grouped | Classic grouped (full width per section) |
| Plain | Simple list, continuous (contacts, messages) |

- Row height: 44pt minimum
- Cell padding: 16pt leading, 16pt trailing
- Disclosure indicator: chevron.right (for drill-down navigation)
- Swipe actions: leading (positive), trailing (destructive)

### Sheets
| Type | Usage |
|-------|-------|
| Sheet (.sheet) | Non-blocking, drag to dismiss |
| Full-screen cover | Blocking, needs explicit dismiss |
| Popover | iPad only, arrow points to source |

- Sheet corner radius: 10pt
- Grabber: 36pt x 5pt, centered

### Alerts
- Title: Headline (17pt, Semibold)
- Message: Footnote (13pt, Regular)
- Buttons: 1-2 preferred, max 3
- Destructive button: Red, on the left
- Default/Cancel: Bold

### Text Fields
- Height: 36pt
- Corner radius: 10pt
- Background: tertiarySystemFill
- Placeholder: tertiaryLabel color
- Clear button on trailing edge when editing

### Search Bar
- Height: 36pt
- Corner radius: 10pt
- Magnifying glass icon on leading
- Cancel button appears on focus

---

## Navigation Patterns

### iPhone
1. **Tab Bar + Navigation Stack** — most common
   - Tab bar: top-level destinations (3-5)
   - Navigation stack: drill-down within each tab
2. **Modal Sheets** — for focused tasks
   - Present modally for creation/editing flows
   - Swipe down to dismiss (non-blocking)

### iPad
1. **Split View** — master-detail
   - Sidebar: 320pt width
   - Content: fills remaining
2. **Tab Bar** (compact) — **Sidebar** (regular)
   - Adaptive navigation

### Transitions
| Type | Usage | Direction |
|------|-------|-----------|
| Push | Navigate deeper | Left to right (LTR) |
| Pop | Navigate back | Right to left |
| Modal present | Show sheet/fullscreen | Bottom to top |
| Modal dismiss | Close sheet | Top to bottom / swipe down |

---

## Motion & Animation

### Duration Guidelines
| Type | Duration | Usage |
|------|----------|-------|
| Quick feedback | 100ms | Toggle, selection |
| Standard | 250ms | Sheet present, nav push |
| Complex | 350-500ms | Full-screen transitions |

### Spring Animation (preferred)
- iOS prefers spring-based animation over easing curves
- Default spring: `response: 0.3, dampingFraction: 0.8`
- Bouncy: `response: 0.4, dampingFraction: 0.6`

### Haptic Feedback
| Type | Usage |
|------|-------|
| Impact (light) | Button tap, toggle |
| Impact (medium) | Snap to position |
| Impact (heavy) | Significant action complete |
| Notification (success) | Task complete |
| Notification (warning) | Caution action |
| Notification (error) | Error occurred |
| Selection | Scrolling through picker |

ระบุ haptic feedback ใน spec สำหรับ iOS apps

---

## Accessibility

### Minimum Sizes
- Touch target: 44pt x 44pt minimum
- Spacing between targets: >= 8pt
- Text: ระบุ Dynamic Type support

### VoiceOver
- ทุก interactive element ต้องมี accessibility label
- Images: accessibilityLabel สำหรับ meaningful images
- Decorative images: isAccessibilityElement = false
- Group related elements ด้วย accessibilityElement container

### Color Contrast
- Text: 4.5:1 minimum (AA)
- Large text (>= 18pt): 3:1
- ใช้ system colors ซึ่งรองรับ accessibility แล้ว
- Support Increase Contrast mode

### Reduce Motion
- ต้องรองรับ Reduce Motion preference
- แทนที่ animation ด้วย cross-dissolve เมื่อ Reduce Motion เปิดอยู่

---

## Platform Differences

### iOS vs Android — สิ่งที่ต้องระวังใน Spec

| Feature | iOS (HIG) | Android (Material) |
|---------|-----------|-------------------|
| Primary nav | Tab Bar (bottom) | Bottom Nav / Nav Rail |
| Back | Swipe from left edge | System back button/gesture |
| Action placement | Top-right in nav bar | FAB or top app bar |
| Destructive | Leading swipe (red) | Trailing swipe or dialog |
| Sheet | Drag handle, swipe dismiss | Bottom sheet with handle |
| Font | SF Pro (system) | Roboto (system) |
| Units | pt (points) | dp (density-independent pixels) |
| Min touch | 44pt x 44pt | 48dp x 48dp |
| Alert buttons | Stacked or side-by-side | Always side-by-side |
