---
name: interaction-design-spec
description: "สร้าง Interaction Design Specification — ครอบคลุม micro-interactions, animations, transitions, gestures, state changes, feedback patterns ตาม 5 Dimensions of Interaction Design (Words, Visuals, Space, Time, Behavior) ใช้ skill นี้เมื่อผู้ใช้ต้องการ: ออกแบบ interaction, กำหนด animation, micro-interaction, transition spec, gesture design, motion design, ระบุ behavior ของ UI, หรือเมื่อพิมพ์ 'interaction', 'animation', 'transition', 'micro-interaction', 'gesture', 'motion', 'behavior', 'ออกแบบ interaction', 'กำหนด animation', 'motion spec'"
---

# Interaction Design Specification Skill

สร้าง Interaction Design Spec อย่างเป็นระบบ — กำหนดว่า UI ตอบสนองอย่างไรเมื่อผู้ใช้ interact ครอบคลุม animations, transitions, gestures, micro-interactions, feedback patterns

---

## Pipeline Position

```
Jira BA → IA/Flow → UI Design → ★ Interaction Spec ★ → QA Gate → Handoff
```

---

## Overall Flow

```
1. รับ Design ──▶ 2. อ่าน Principles ──▶ 3. วิเคราะห์ 5 Dimensions ──▶ 4. สร้าง Spec ──▶ 5. Output
```

---

## Step 1: รับ Design

ถามผู้ใช้ (ถ้ายังไม่ได้ระบุ):

- **Source**: Figma URL, HTML preview, หรือจะเลือกใน Figma?
- **Scope**: ทั้งหน้า หรือเฉพาะบาง component/flow?
- **Platform**: Mobile (iOS/Android), Web, Desktop?
- **Context**: หน้าจอนี้ใช้ทำอะไร? มี flow ต่อเนื่องไหม?

### วิธีอ่าน Design:

**จาก Figma URL (Remote MCP):**
- get_screenshot → ดู visual
- get_design_context → อ่าน design details
- get_metadata → ดู structure + component list

**จาก Figma Selection (TalkToFigma MCP):**
- read_my_design → อ่าน design ที่เลือก
- scan_nodes_by_types → scan interactive elements

**จาก HTML Preview:**
- อ่านไฟล์ .html ด้วย Read tool
- ดู interactive elements, transitions, states

---

## Step 2: อ่าน Design Principles

อ่าน reference files:

- `references/ux-principles.md` → Fitts's Law, Hick's Law, Doherty Threshold **(อ่านเสมอ)**
- `references/ui-preview-quality-rules.md` → Animation rules, Loading states, Component patterns **(อ่านเสมอ)**
- `references/hig.md` → ถ้า iOS — Motion, Gestures, Haptics
- `references/material-design.md` → ถ้า Android/Web — Motion, Transitions
- `references/visual-design-principles.md` → Visual feedback, animation principles

---

## Step 3: วิเคราะห์ 5 Dimensions of Interaction Design

### Dimension 1: Words (1D) — ข้อความที่สื่อสาร interaction

- Button labels ใช้ verb ที่ชัดเจนไหม? (เช่น "บันทึก" ไม่ใช่ "ตกลง")
- Placeholder text บอก format ที่คาดหวังไหม?
- Loading text บอก status ไหม? ("กำลังบันทึก..." ไม่ใช่แค่ spinner)
- Error messages บอกปัญหา + วิธีแก้ไหม?
- Confirmation dialogs ชัดเจนไหม? (ระบุ action ที่จะเกิดขึ้น)
- Empty state text กระตุ้น action ไหม?

### Dimension 2: Visual Representations (2D) — สิ่งที่ผู้ใช้เห็น

- Interactive elements มี visual affordance ชัดเจนไหม?
- Active/selected states แตกต่างจาก default ชัดเจนไหม?
- Disabled states สื่อว่า "ใช้ไม่ได้" ไหม?
- Focus indicators เห็นชัดไหม? (contrast >= 3:1)
- Progress indicators แสดง status ไหม? (determinate vs indeterminate)
- Visual feedback ตอบสนองทันทีเมื่อ interact ไหม?

### Dimension 3: Physical Objects / Space (3D) — พื้นที่ interaction

- Touch targets >= 44pt (iOS) / 48dp (Android)?
- Thumb zone awareness — ปุ่มสำคัญอยู่ล่าง (reachable zone)?
- Gesture areas ไม่ conflict กันไหม? (swipe vs scroll)
- Modal/sheet ใช้พื้นที่เหมาะสมไหม?
- Content ต้อง scroll ไหม? ถ้าต้อง — มี scroll indicator?

### Dimension 4: Time (4D) — เวลาและจังหวะ

**Animation Duration:**
| Type | Duration | Easing | ใช้เมื่อ |
|------|----------|--------|---------|
| Micro-feedback | 100-150ms | ease-out | Button press, toggle, checkbox |
| Simple transition | 200-300ms | ease-in-out | Page transition, expand/collapse |
| Complex animation | 300-500ms | custom bezier | Modal open, slide-in panel |
| Emphasis/Attention | 500-1000ms | ease-in-out | Onboarding spotlight, celebration |

**Timing Rules:**
- Response < 100ms = feels instant (Doherty Threshold)
- Feedback < 400ms = feels connected
- Animation > 500ms = feels slow — ใช้เท่าที่จำเป็น
- Loading > 1s = ต้องมี progress indicator
- Loading > 3s = ต้องมี skeleton / text explanation

**Easing Functions:**
| Easing | CSS | ใช้เมื่อ |
|--------|-----|---------|
| ease-out | cubic-bezier(0, 0, 0.2, 1) | Element entering (appear, slide-in) |
| ease-in | cubic-bezier(0.4, 0, 1, 1) | Element leaving (disappear, slide-out) |
| ease-in-out | cubic-bezier(0.4, 0, 0.2, 1) | Element moving within view |
| spring | custom | Bounce, pull-to-refresh, snap |

### Dimension 5: Behavior (5D) — พฤติกรรมที่เกิดขึ้น

**Micro-interaction Framework:**
ทุก interaction ต้องมี 4 ส่วน:

```
Trigger → Rules → Feedback → Loops & Modes
```

1. **Trigger**: อะไรเริ่มต้น interaction? (tap, swipe, scroll, timer, system event)
2. **Rules**: กฎคืออะไร? (validation, conditions, boundaries)
3. **Feedback**: ผู้ใช้เห็น/รู้สึกอะไร? (visual, haptic, audio)
4. **Loops & Modes**: ทำซ้ำไหม? มี mode เปลี่ยนไหม?

---

## Step 4: สร้าง Interaction Spec

### 4.1 Interaction Inventory

สำรวจทุก interactive element แล้วจัดกลุ่ม:

| # | Element | Type | Trigger | States | Animation | Duration |
|---|---------|------|---------|--------|-----------|----------|
| 1 | CTA Button | Button | Tap | default→pressed→loading→success | scale(0.95)→spinner→checkmark | 150ms→∞→300ms |
| 2 | Card | Tappable | Tap | default→pressed→navigate | scale(0.98)→page transition | 100ms→300ms |
| 3 | Pull to refresh | Gesture | Pull down | idle→pulling→refreshing→done | translate-y→spinner→fade | gesture→∞→200ms |

### 4.2 State Transitions

สำหรับแต่ละ component กำหนด state machine:

```
                    ┌──── tap ────┐
                    ▼             │
    Default ──▶ Pressed ──▶ Loading ──▶ Success
       ▲                       │          │
       │                       ▼          │
       │                     Error ───────┘
       │                       │     (retry)
       └───────────────────────┘
              (dismiss)
```

### 4.3 Gesture Spec (Mobile)

| Gesture | Action | Element | Behavior | Fallback |
|---------|--------|---------|----------|----------|
| Tap | Select | Card, Button, List item | Highlight → navigate/toggle | — |
| Long press | Context menu | Card, Message | Haptic → show menu | Tap → open |
| Swipe left | Delete / Archive | List item | Reveal action → snap | Tap menu |
| Swipe down | Dismiss / Refresh | Sheet, List | Rubber band → dismiss/refresh | Close button |
| Pinch | Zoom | Image, Map | Scale with gesture | Zoom controls |
| Double tap | Quick action | Image, Text | Zoom / Like | Tap → zoom |

### 4.4 Transition Spec (Between Screens)

| From | To | Transition | Duration | Easing | Direction |
|------|----|-----------|----------|--------|-----------|
| Home | Detail | Push right | 300ms | ease-in-out | → |
| List | Detail | Shared element | 300ms | ease-out | expand |
| Any | Modal | Slide up + dim | 300ms | ease-out | ↑ |
| Modal | Dismiss | Slide down + fade | 250ms | ease-in | ↓ |
| Any | Alert | Fade + scale | 200ms | ease-out | center |

### 4.5 Feedback Pattern Spec

| Event | Visual | Haptic (Mobile) | Audio | Duration |
|-------|--------|-----------------|-------|----------|
| Button tap | Ripple / scale | Light impact | — | 150ms |
| Toggle on | Slide + color change | Light impact | — | 200ms |
| Success | Checkmark animation | Success pattern | Optional ding | 500ms |
| Error | Shake + red flash | Error pattern | — | 300ms |
| Pull to refresh | Spinner appear | — | — | gesture |
| Swipe action | Reveal background | Medium impact | — | gesture |

### 4.6 Loading States

| Scenario | Pattern | When to use | Duration hint |
|----------|---------|------------|---------------|
| Skeleton | Gray placeholder shapes | Content loading < 5s | Pulse animation |
| Spinner | Circular indicator | Action processing < 3s | Indeterminate |
| Progress bar | Linear fill | Upload/download, known % | Determinate |
| Shimmer | Gradient sweep | Image/card loading | Pulse 1.5s loop |
| Inline text | "กำลังบันทึก..." | Button/form submission | Replace button text |

### 4.7 Reduced Motion Alternative

ทุก animation ต้องมี alternative เมื่อ `prefers-reduced-motion: reduce`:

| Normal | Reduced Motion |
|--------|---------------|
| Slide transition | Instant cut / cross-fade |
| Bounce animation | Simple scale |
| Parallax scroll | Static position |
| Auto-play animation | Static frame + play button |
| Loading spinner | Text "กำลังโหลด..." |

---

## Step 5: Output

### Output Format: HTML Interaction Spec (Preferred)

สร้างไฟล์ `interaction-spec.html` ที่แสดง:

1. **Interaction Inventory Table** — รายการทุก interaction
2. **State Machine Diagrams** — แต่ละ component (ใช้ CSS/SVG diagram)
3. **Animation Preview** — ตัวอย่าง animation จริง (ใช้ CSS @keyframes)
4. **Gesture Guide** — gesture ที่ใช้พร้อมภาพประกอบ
5. **Transition Map** — screen-to-screen transitions
6. **Timing Table** — duration + easing ทุก animation
7. **Reduced Motion Table** — alternative ทุก animation

### Styling Guidelines
- ใช้ Design Tokens ของระบบเป็น CSS variables
- แต่ละ interaction มี **live preview** (CSS animation ที่เล่นได้)
- ใช้สีตาม severity: ต้องมี = สีแดง, แนะนำ = สีเหลือง, nice-to-have = สีม่วง

---

## หลักการสำคัญ

1. **Purpose-Driven**: ทุก animation ต้องมีเหตุผล — guide attention, show connection, provide feedback
2. **Performance First**: animation ไม่ควรทำให้ UI ช้า (ใช้ transform/opacity เท่านั้น)
3. **Consistent Timing**: ใช้ duration/easing system ที่สม่ำเสมอทั้ง app
4. **Accessible**: ทุก animation ต้องมี reduced-motion alternative
5. **Natural Feel**: easing ต้องรู้สึกธรรมชาติ ไม่ linear (ยกเว้น progress bar)
6. **Micro > Macro**: micro-interaction feedback สำคัญกว่า flashy animation
7. **Doherty Threshold**: response < 400ms = ผู้ใช้รู้สึก "connected"
