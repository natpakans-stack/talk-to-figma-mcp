# Material Design 3 (M3) Reference

อ้างอิงจาก Material Design 3 guidelines สำหรับ Android และ Web applications

---

## Table of Contents
1. [Design Tokens](#design-tokens)
2. [Typography](#typography)
3. [Color System](#color-system)
4. [Layout & Grid](#layout--grid)
5. [Elevation & Shadows](#elevation--shadows)
6. [Components](#key-components)
7. [Motion](#motion)
8. [Accessibility](#accessibility)

---

## Design Tokens

### Spacing (Base unit: 4dp)
| Token | Value | Usage |
|-------|-------|-------|
| spacing-xs | 4dp | Icon padding |
| spacing-sm | 8dp | Tight element spacing |
| spacing-md | 16dp | Default content padding |
| spacing-lg | 24dp | Section spacing |
| spacing-xl | 32dp | Large section spacing |
| spacing-2xl | 48dp | Page margins (compact) |

### Shape (Corner Radius)
| Shape | Radius | Usage |
|-------|--------|-------|
| None | 0dp | Full-width containers |
| Extra Small | 4dp | Small components (chips) |
| Small | 8dp | Buttons, text fields |
| Medium | 12dp | Cards, dialogs |
| Large | 16dp | FABs, large cards |
| Extra Large | 28dp | Bottom sheets |
| Full | 50% | Circular elements |

---

## Typography

### Type Scale (M3 Default: Roboto)
| Style | Font | Weight | Size | Line Height | Tracking |
|-------|------|--------|------|-------------|----------|
| Display Large | Roboto | 400 | 57sp | 64sp | -0.25 |
| Display Medium | Roboto | 400 | 45sp | 52sp | 0 |
| Display Small | Roboto | 400 | 36sp | 44sp | 0 |
| Headline Large | Roboto | 400 | 32sp | 40sp | 0 |
| Headline Medium | Roboto | 400 | 28sp | 36sp | 0 |
| Headline Small | Roboto | 400 | 24sp | 32sp | 0 |
| Title Large | Roboto | 400 | 22sp | 28sp | 0 |
| Title Medium | Roboto | 500 | 16sp | 24sp | 0.15 |
| Title Small | Roboto | 500 | 14sp | 20sp | 0.1 |
| Body Large | Roboto | 400 | 16sp | 24sp | 0.5 |
| Body Medium | Roboto | 400 | 14sp | 20sp | 0.25 |
| Body Small | Roboto | 400 | 12sp | 16sp | 0.4 |
| Label Large | Roboto | 500 | 14sp | 20sp | 0.1 |
| Label Medium | Roboto | 500 | 12sp | 16sp | 0.5 |
| Label Small | Roboto | 500 | 11sp | 16sp | 0.5 |

---

## Color System

### M3 Dynamic Color Roles
| Role | Light Theme | Dark Theme | Usage |
|------|-------------|------------|-------|
| Primary | seed color | lighter seed | Key actions, active states |
| On Primary | White | Dark | Text/icons on primary |
| Primary Container | Very light primary | Muted dark primary | Filled buttons bg, FABs |
| Secondary | Muted seed | Lighter muted | Supporting actions |
| Tertiary | Complementary | Lighter complementary | Accents, tags |
| Surface | #FFFBFE | #1C1B1F | Page backgrounds |
| Surface Variant | #E7E0EC | #49454F | Cards, elevated surfaces |
| On Surface | #1C1B1F | #E6E1E5 | Primary text |
| On Surface Variant | #49454F | #CAC4D0 | Secondary text |
| Outline | #79747E | #938F99 | Borders, dividers |
| Outline Variant | #CAC4D0 | #49454F | Subtle dividers |
| Error | #B3261E | #F2B8B5 | Error states |
| On Error | White | #601410 | Text on error |

### Spec Template
เมื่อกำหนดสี ให้ระบุทั้ง Light และ Dark theme:
```
Primary: #6750A4 (Light) / #D0BCFF (Dark)
On Primary: #FFFFFF / #381E72
```

---

## Layout & Grid

### Responsive Grid
| Window Class | Width | Columns | Margins | Gutter |
|-------------|-------|---------|---------|--------|
| Compact | < 600dp | 4 | 16dp | 8dp |
| Medium | 600-839dp | 8 | 24dp | 16dp |
| Expanded | 840-1199dp | 12 | 24dp | 24dp |
| Large | 1200-1599dp | 12 | 24dp | 24dp |
| Extra Large | >= 1600dp | 12 | 24dp | 24dp |

### Navigation Patterns by Window Class
| Window Class | Primary Nav | Secondary Nav |
|-------------|-------------|---------------|
| Compact | Bottom Navigation Bar (3-5 items) | Navigation Drawer (hamburger) |
| Medium | Navigation Rail (side) | Navigation Drawer |
| Expanded | Navigation Drawer (permanent) | Tabs |

---

## Elevation & Shadows

### Elevation Levels
| Level | Elevation | Shadow | Usage |
|-------|-----------|--------|-------|
| 0 | 0dp | None | Surface, backgrounds |
| 1 | 1dp | Subtle | Cards, App Bar |
| 2 | 3dp | Light | Snackbar, Nav Drawer |
| 3 | 6dp | Medium | FAB, Bottom Sheet |
| 4 | 8dp | Pronounced | Nav Drawer (modal) |
| 5 | 12dp | Strong | Dialog |

M3 ใช้ **tonal elevation** (surface tint color) แทน shadow ใน dark theme

---

## Key Components

### Buttons
| Type | Height | Min Width | Corner | Usage |
|------|--------|-----------|--------|-------|
| Filled | 40dp | 48dp | 20dp (full) | Primary CTA |
| Outlined | 40dp | 48dp | 20dp | Secondary actions |
| Text | 40dp | 48dp | 20dp | Low-emphasis |
| Elevated | 40dp | 48dp | 20dp | Medium emphasis with shadow |
| Tonal | 40dp | 48dp | 20dp | Medium emphasis, no shadow |
| FAB | 56dp | 56dp | 16dp | Primary floating action |
| Extended FAB | 56dp | - | 16dp | FAB with label |

### Text Fields
| Type | Height | Usage |
|------|--------|-------|
| Filled | 56dp | Default, high density forms |
| Outlined | 56dp | Lower density, clearer boundaries |

States: Rest, Focused, Error, Disabled
- Label floats on focus
- Helper text below (12sp, Body Small)
- Error text replaces helper in error state (Error color)

### Cards
| Type | Elevation | Border | Usage |
|------|-----------|--------|-------|
| Elevated | Level 1 | None | Default |
| Filled | Level 0 | None | Secondary surface color |
| Outlined | Level 0 | 1dp outline | Clear boundaries |

Padding: 16dp all sides (minimum)
Corner radius: 12dp (Medium)

### Dialogs
- Width: 280-560dp
- Corner radius: 28dp (Extra Large)
- Elevation: Level 5
- Title: Headline Small (24sp)
- Body: Body Medium (14sp)
- Actions: Text buttons, right-aligned

### Bottom Sheets
- Corner radius: 28dp (top corners only)
- Handle: 32dp x 4dp, centered, 22dp from top
- Standard: pushes content up
- Modal: overlay with scrim

### Navigation Bar (Bottom)
- Height: 80dp
- Items: 3-5
- Icon: 24dp
- Label: Label Medium (12sp)
- Active indicator: pill shape (64dp x 32dp)

---

## Motion

### Duration
| Category | Duration | Usage |
|----------|----------|-------|
| Short 1 | 50ms | Hover feedback |
| Short 2 | 100ms | Selection, toggle |
| Short 3 | 150ms | Icon animation |
| Short 4 | 200ms | Small expand/collapse |
| Medium 1 | 250ms | Menu open |
| Medium 2 | 300ms | Page transition |
| Medium 3 | 350ms | Complex transition |
| Medium 4 | 400ms | Full-screen transition |
| Long 1 | 450ms | Large complex animation |
| Long 2 | 500ms | Sheet, dialog entry |

### Easing
| Type | Curve | Usage |
|------|-------|-------|
| Emphasized | cubic-bezier(0.2, 0, 0, 1) | Most transitions |
| Emphasized Decelerate | cubic-bezier(0, 0, 0, 1) | Enter/appear |
| Emphasized Accelerate | cubic-bezier(0.3, 0, 0.8, 0.15) | Exit/disappear |
| Standard | cubic-bezier(0.2, 0, 0, 1) | Layout changes |

---

## Accessibility

### Touch Targets
- Minimum: 48dp x 48dp
- Recommended: 56dp x 56dp สำหรับ primary actions
- Spacing between targets: >= 8dp

### Color Contrast (WCAG 2.1)
- Normal text: 4.5:1 minimum (AA)
- Large text (>= 18sp regular, >= 14sp bold): 3:1 minimum
- Icons and UI components: 3:1 minimum

### Content Descriptions
- ทุก icon button ต้องมี contentDescription
- Decorative icons ใช้ `contentDescription = null`
- Images ที่ให้ข้อมูล ต้องมี alt text
