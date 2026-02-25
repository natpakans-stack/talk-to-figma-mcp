---
name: mobile-ux-audit
description: "ตรวจสอบ Mobile UX อย่างเจาะลึก — ครอบคลุม thumb zones, gestures, bottom navigation, card patterns, pull-to-refresh, push notifications, mobile forms, one-handed use, performance perception เฉพาะ mobile ที่ responsive audit ไม่ครอบคลุม ใช้ skill นี้เมื่อผู้ใช้ต้องการ: ตรวจ mobile UX, audit mobile app, ตรวจ thumb zone, เช็ค gesture, mobile usability, ตรวจแอป, หรือเมื่อพิมพ์ 'mobile ux', 'mobile audit', 'thumb zone', 'mobile usability', 'ตรวจ mobile', 'mobile patterns', 'app ux', 'ตรวจแอป'"
---

# Mobile UX Audit Skill

ตรวจ Mobile UX เชิงลึก — เน้นสิ่งที่เฉพาะ mobile เท่านั้น: thumb zones, gestures, native patterns, performance perception, one-handed use ที่ responsive design skill ไม่ได้ครอบคลุม

---

## Pipeline Position

```
UI Design → Responsive → ★ Mobile UX Audit ★ → Accessibility Audit → QA Gate
```

---

## Overall Flow

```
1. รับ Design ──▶ 2. อ่าน Guidelines ──▶ 3. Audit 8 หมวด ──▶ 4. Score ──▶ 5. Report
```

---

## Step 1: รับ Design

ถามผู้ใช้ (ถ้ายังไม่ได้ระบุ):

- **Source**: Figma URL, HTML preview, screenshot?
- **Platform**: iOS หรือ Android? (guidelines ต่างกัน)
- **App Type**: Native, Hybrid, PWA?
- **Target Device**: iPhone 15 (393px), Android (360px), Tablet?
- **Context**: flow นี้ทำอะไร? user ใช้ตอนไหน? (เดินอยู่, นั่งอยู่, มือเดียว?)

### วิธีอ่าน Design:

**จาก Figma (Remote/Local MCP)** — เหมือน skills อื่น
**จาก HTML Preview** — อ่านไฟล์ + ตรวจ viewport, touch targets, mobile patterns

---

## Step 2: อ่าน Guidelines

```
references/ux-principles.md              → Fitts's Law, Hick's Law, Thumb Zone (อ่านเสมอ)
references/ui-preview-quality-rules.md   → Form rules, Button rules, Component patterns (อ่านเสมอ)
references/hig.md                        → iOS-specific (ถ้า iOS)
references/material-design.md            → Android-specific (ถ้า Android)
references/visual-design-principles.md   → Mobile visual patterns
```

---

## Step 3: Audit 8 หมวด

### Category 1: Thumb Zone & Reachability (20%)

**Thumb Zone Map (iPhone 15 / 393x852):**
```
┌─────────────────────────┐
│     HARD TO REACH       │  ← Status bar, top nav
│   ┌─────────────────┐   │
│   │                 │   │
│   │  MODERATE       │   │  ← Content area
│   │                 │   │
│   │  ┌───────────┐  │   │
│   │  │           │  │   │
│   │  │  EASY     │  │   │  ← Bottom half
│   │  │  REACH    │  │   │
│   │  │           │  │   │
│   │  └───────────┘  │   │
│   └─────────────────┘   │
│     NATURAL THUMB ARC   │  ← Bottom nav, FAB
└─────────────────────────┘
```

**ตรวจ:**
| Check | Criteria | Weight |
|-------|----------|--------|
| Primary CTA position | อยู่ใน easy reach zone (ล่าง)? | Critical |
| Navigation | Bottom nav / tab bar (ไม่ใช่ hamburger menu ด้านบน)? | Critical |
| Frequent actions | อยู่ล่างหรือกลาง? | Major |
| Destructive actions | อยู่ห่างจาก easy reach (ป้องกัน accidental tap)? | Major |
| Search | เข้าถึงง่ายไหม? (bottom bar หรือ pull-down) | Minor |

### Category 2: Touch Interaction (15%)

**Touch Target Rules:**
| Platform | Minimum | Recommended | Spacing |
|----------|---------|-------------|---------|
| iOS | 44 x 44pt | 56pt (primary CTA) | >= 8pt |
| Android | 48 x 48dp | 56dp (primary CTA) | >= 8dp |

**ตรวจ:**
| Check | Criteria |
|-------|----------|
| All tappable elements | >= minimum size? |
| Icon-only buttons | มี adequate tap area (padding around icon)? |
| Close/dismiss buttons | ไม่เล็กเกินไป? (X button ต้อง >= 44pt) |
| Adjacent tap targets | มี spacing >= 8pt? ไม่ overlap? |
| List item tap area | Full-width row ไม่ใช่แค่ text? |
| Swipe areas | ไม่ conflict กับ system gestures? (edge swipe = back) |

### Category 3: Mobile Navigation Patterns (15%)

**ตรวจตาม Platform:**

**iOS (HIG):**
| Pattern | ถูกต้อง | ผิด |
|---------|---------|-----|
| Tab Bar | ล่าง, 5 items max, icon + label | Hamburger ด้านบน |
| Back | Edge swipe + back button ซ้ายบน | Custom back position |
| Modal | Sheet from bottom | Full-screen unnecessary modal |
| Search | Pull down หรือ search bar | Hidden search |

**Android (Material):**
| Pattern | ถูกต้อง | ผิด |
|---------|---------|-----|
| Navigation | Bottom nav / Nav drawer | Top-only nav |
| Back | System back gesture + app back | No back affordance |
| FAB | Bottom right, single primary action | Multiple FABs |
| Snackbar | Bottom, auto-dismiss, one action | Sticky toast blocking content |

**ตรวจ:**
| Check | Criteria |
|-------|----------|
| Primary nav | ใช้ bottom navigation? |
| Depth indicator | ผู้ใช้รู้ว่าอยู่ตรงไหนของ app ไหม? |
| Back behavior | กด back แล้วไปถูกหน้าไหม? |
| Navigation consistency | Nav bar consistent ทุกหน้า? |
| Deep link support | เข้าจาก notification/link แล้ว navigate ต่อได้ไหม? |

### Category 4: Mobile Form Design (15%)

**ตรวจ:**
| Check | Criteria |
|-------|----------|
| Keyboard type | ตรงกับ input type? (email → @, phone → numpad, URL → .com) |
| Auto-complete | ใช้ autocomplete attributes? (name, email, address, cc-number) |
| Input positioning | Input ไม่ถูก keyboard บังไหม? (scroll into view) |
| Label visibility | Label ยังเห็นเมื่อ focused? (floating label recommended) |
| Error display | Inline error ใกล้ input? ไม่ใช่ top-of-page alert? |
| Multi-step form | มี progress indicator? ไม่ยาวเกิน 1 scroll? |
| Required fields | ระบุชัดเจน? (* หรือ "required" badge) |
| Submit button | ใกล้ keyboard? หรือ sticky bottom? |
| Paste support | ยอมให้ paste ได้? (OTP, password) |
| Biometric | รองรับ Face ID / fingerprint สำหรับ login? |

### Category 5: Content Patterns (10%)

**Mobile Card Design:**
| Check | Criteria |
|-------|----------|
| Card size | เห็นอย่างน้อย 1.5 cards ใน viewport? (hint ว่า scroll ได้) |
| Card tap area | ทั้ง card tappable? หรือแค่บาง element? |
| Image loading | มี placeholder/skeleton ก่อน image load? |
| Text truncation | Long text ตัดเหมาะสม? (ellipsis, "Read more") |
| Card actions | Actions ไม่ conflict กับ card tap? |

**Mobile List Design:**
| Check | Criteria |
|-------|----------|
| Row height | >= 44pt (iOS) / 48dp (Android)? |
| Swipe actions | มี swipe-to-action? (delete, archive, favorite) |
| Pull to refresh | รองรับ pull-to-refresh? |
| Infinite scroll | มี loading indicator ที่ bottom? |
| Empty state | แสดง illustration + CTA เมื่อ list ว่าง? |

### Category 6: Performance Perception (10%)

ไม่ได้ตรวจ actual performance แต่ตรวจว่า design รองรับ perceived performance:

| Check | Criteria |
|-------|----------|
| Skeleton screens | มี skeleton UI ก่อน content load? |
| Optimistic updates | UI update ทันทีก่อน server confirm? (เช่น like) |
| Progressive loading | Critical content load ก่อน? |
| Splash screen | ไม่นานเกิน 2 วินาที? transition เข้า app smooth? |
| Image loading | Progressive JPEG / blur-up / placeholder? |
| Offline state | แสดง cached content + offline indicator? |
| Background task | แจ้ง status ใน notification / app badge? |

### Category 7: Push Notification Design (5%)

| Check | Criteria |
|-------|----------|
| Permission timing | ขอหลังจาก user เห็นคุณค่าแล้ว? (ไม่ใช่ first launch) |
| Permission explanation | อธิบายว่าจะส่งอะไร ก่อนขอ permission? |
| Notification content | actionable + specific? (ไม่ใช่แค่ "มีข้อความใหม่") |
| Deep link | กดแล้วไปถูกหน้าในแอป? |
| Grouping | จัดกลุ่ม notification ที่เกี่ยวข้อง? |
| Frequency | ไม่ส่งถี่เกินไป? (ไม่เกิน 3-5 ต่อวัน) |

### Category 8: Platform Conventions (10%)

**ตรวจว่า design ตรงกับ platform expectations:**

**iOS-specific:**
| Check | iOS Convention |
|-------|---------------|
| Navigation bar | Title centered, back button ซ้าย |
| Tab bar | Icons + labels, max 5 tabs |
| Segmented control | ไม่ใช่ toggle ที่ดูเหมือน Android |
| Action sheets | Bottom sheet for destructive actions |
| Alert style | iOS-style alert dialog |
| Swipe back | Edge swipe to go back |

**Android-specific:**
| Check | Android Convention |
|-------|-------------------|
| Material components | ใช้ Material Design components? |
| System bars | Transparent/translucent status bar? |
| Back gesture | Predictive back animation? |
| Share sheet | ใช้ system share sheet? |
| FAB placement | Bottom right, not blocking content? |
| Bottom sheet | Rounded top corners, drag handle? |

---

## Step 4: Score

### Scoring Matrix

| Category | Weight | Score (1-10) | Critical Issues | Notes |
|----------|--------|-------------|-----------------|-------|
| Thumb Zone & Reachability | 20% | — | — | — |
| Touch Interaction | 15% | — | — | — |
| Mobile Navigation | 15% | — | — | — |
| Mobile Form Design | 15% | — | — | — |
| Content Patterns | 10% | — | — | — |
| Performance Perception | 10% | — | — | — |
| Push Notification | 5% | — | — | — |
| Platform Conventions | 10% | — | — | — |
| **Weighted Total** | **100%** | **—/10** | — | — |

### Rating Scale
- **9-10**: Native-quality UX — รู้สึกเหมือนแอป first-party
- **7-8**: ดี — มี minor adjustments
- **5-6**: ใช้ได้ — แต่รู้สึก "web-like" บน mobile
- **3-4**: ต้องปรับหนัก — ไม่ตรง platform conventions
- **1-2**: ต้อง rethink — ไม่ได้ออกแบบสำหรับ mobile

---

## Step 5: Report

### Output Format: HTML Mobile UX Report

สร้างไฟล์ `mobile-ux-report.html` ที่แสดง:

1. **Score Overview** — คะแนนรวม + breakdown ทุกหมวด
2. **Thumb Zone Heat Map** — overlay บนรูปจริง แสดง reachability zones
3. **Issue Cards** — ทุก issue แยกตาม severity (Critical/Major/Minor)
   - WHERE: จุดบนรูปจริง
   - WHAT: ปัญหาคืออะไร
   - WHY: ทำไมถึงเป็นปัญหา (อ้าง principle)
   - FIX: วิธีแก้สำหรับ Designer
4. **Platform Compliance** — เทียบกับ iOS/Android guidelines
5. **Checklist** — สรุปทุก issue เรียงตาม priority

### โทน Designer-Friendly:
- ใช้โทน "แนะนำ" ไม่ใช่ "ตรวจจับ"
- ให้ภาพเปรียบเทียบ (ก่อน/หลัง) ทุก issue
- อ้าง platform guidelines เสมอ

---

## หลักการสำคัญ

1. **Platform-Native Feel**: Design ต้อง "รู้สึกถูกที่" บน platform นั้น
2. **One-Handed Use**: 75% ของ mobile users ใช้มือเดียว — ออกแบบสำหรับนิ้วโป้ง
3. **Context-Aware**: Mobile ใช้ระหว่างเดิน, ข้างนอก, แสงจ้า — content ต้องชัด
4. **Gesture-First**: Native gestures (swipe, pull) รู้สึกดีกว่า button taps
5. **Forgiveness**: Mobile = typo + accidental tap — ต้องมี undo/redo ง่าย
6. **Performance = UX**: Perceived speed สำคัญเท่า actual speed
7. **Offline-Ready**: ผู้ใช้ mobile อาจหลุด connection — design สำหรับ graceful degradation
