---
name: conversion-ux-review
description: "ตรวจ UX เพื่อ Conversion — วิเคราะห์ checkout flow, form optimization, CTA effectiveness, trust signals, cart abandonment prevention, landing page, onboarding funnel ตาม CRO best practices จากหนังสือ 16 เล่มด้าน Marketing & Conversion + 33 Design Crimes ใช้ skill นี้เมื่อผู้ใช้ต้องการ: ตรวจ conversion, เพิ่ม conversion rate, วิเคราะห์ funnel, ตรวจ checkout, ตรวจ form, landing page review, CTA review, หรือเมื่อพิมพ์ 'conversion', 'CRO', 'checkout', 'funnel', 'landing page', 'cart abandonment', 'form optimization', 'ตรวจ conversion', 'เพิ่ม conversion'"
---

# Conversion UX Review Skill

วิเคราะห์ UX ด้าน Business Conversion — ตรวจว่า design กระตุ้นให้ user ทำ action ที่ต้องการไหม (สมัคร, ซื้อ, กรอกฟอร์ม) โดยอิงจาก CRO best practices

---

## Pipeline Position

```
UI Design → Design Critique → ★ Conversion UX Review ★ → QA Gate → Handoff
```

---

## Overall Flow

```
1. รับ Design ──▶ 2. ระบุ Conversion Goal ──▶ 3. Audit 7 มิติ ──▶ 4. Score ──▶ 5. Report
```

---

## Step 1: รับ Design

ถามผู้ใช้ (ถ้ายังไม่ได้ระบุ):

- **Source**: Figma URL, HTML preview, screenshot?
- **Page Type**: Landing page, Checkout, Registration, Onboarding, Product page?
- **Platform**: Web, Mobile web, Native app?
- **Target Audience**: ใครคือ user? (อายุ, tech-savviness, ใช้ free หรือจ่ายเงิน?)

### อ่าน References ก่อน Audit:
```
references/ux-principles.md              → Laws of UX (Hick's, Fitts's, Von Restorff) (อ่านเสมอ)
references/ui-preview-quality-rules.md   → CTA rules, Form rules, Visual hierarchy (อ่านเสมอ)
```

### วิธีอ่าน Design:
เหมือน skills อื่น — Figma MCP หรืออ่าน HTML

---

## Step 2: ระบุ Conversion Goal

ก่อนวิเคราะห์ ต้องระบุ goal ให้ชัด:

| Page Type | Primary Conversion | Secondary Conversion |
|-----------|-------------------|---------------------|
| Landing page | Sign up / CTA click | Scroll to learn more |
| Registration | Complete sign up | Social login |
| Onboarding | Complete onboarding | Skip to app |
| Product page | Add to cart | Save to wishlist |
| Checkout | Complete purchase | Apply coupon |
| Pricing page | Select plan | Start free trial |
| Login | Successful login | Forgot password recovery |

ถามผู้ใช้:
> "Conversion goal หลักคืออะไรครับ? ต้องการให้ user ทำอะไร?"

---

## Step 3: Audit 7 มิติ

### Dimension 1: CTA (Call-to-Action) Effectiveness (20%)

**Primary CTA Checklist:**
| Check | Criteria | Why |
|-------|----------|-----|
| Visibility | CTA เห็นทันทีใน viewport แรก (above the fold)? | 80% ของ clicks เกิดที่ above the fold |
| Visual prominence | CTA เป็นสิ่งที่โดดเด่นที่สุดบนหน้า? | Von Restorff Effect — สิ่งที่ต่างจะถูกจำ |
| Color contrast | CTA สีต่างจาก background + surrounding elements? | ต้อง pop ออกมาจาก page |
| Button text | ใช้ action verb ที่เฉพาะเจาะจง? | "เริ่มทดลองฟรี" ดีกว่า "ส่ง" |
| Size | ใหญ่พอที่จะ tap ได้ง่าย (>= 48px height)? | Fitts's Law |
| Whitespace | มี whitespace รอบ CTA เพียงพอ? | ป้องกัน visual clutter |
| Position | อยู่ใน natural reading flow? (F/Z pattern) | Eye tracking research |
| Sticky CTA | มี sticky CTA เมื่อ scroll ลงยาว? | ให้ user convert ได้ทุกจุด |
| Single CTA | มี CTA เดียวที่โดดเด่นที่สุด ต่อ section? | Hick's Law — ลด choice paralysis |

**CTA Text Analysis:**
| Bad | Better | Best |
|-----|--------|------|
| ส่ง | สมัคร | เริ่มทดลองฟรี 14 วัน |
| ตกลง | ยืนยัน | ยืนยันการสั่งซื้อ |
| Click here | ดูเพิ่มเติม | ดูแพ็กเกจทั้งหมด |
| OK | บันทึก | บันทึกที่อยู่จัดส่ง |

### Dimension 2: Form Optimization (20%)

**Form Friction Checklist:**
| Check | Criteria | Impact |
|-------|----------|--------|
| Field count | น้อยที่สุดเท่าที่จำเป็น? (ทุก field ที่เพิ่ม = -7% conversion) | Critical |
| Required only | ขอเฉพาะข้อมูลที่จำเป็นจริงๆ? | Critical |
| Smart defaults | มี default values ที่เหมาะสม? (ประเทศ, เมือง auto) | Major |
| Auto-fill | รองรับ browser autofill? (name, email, address) | Major |
| Input types | ใช้ keyboard type ถูกต้อง? (email, tel, number) | Major |
| Real-time validation | validate ทันที ไม่ใช่รอกด submit? | Major |
| Inline errors | error แสดงใกล้ field ที่ผิด? | Major |
| Password rules | แสดง requirements ก่อนกรอก? (ไม่ใช่หลัง submit) | Major |
| Progress indicator | form หลาย step มี progress bar? | Minor |
| Social login | มีทางลัด (Google, Apple, LINE)? | Minor |
| Guest checkout | ซื้อได้โดยไม่ต้องสมัคร? | Critical (e-commerce) |

**Form Layout Best Practices:**
- Single column layout (ไม่ใช่ multi-column)
- Label above input (ไม่ใช่ข้าง — saves vertical space บน mobile)
- Group related fields (ชื่อ-นามสกุล, ที่อยู่)
- CTA ท้ายฟอร์ม ไม่ใช่ต้น form
- "ย้อนกลับ" link — ไม่ใช่ button (ลด visual weight)

### Dimension 3: Trust & Credibility (15%)

| Check | Criteria | Where |
|-------|----------|-------|
| Social proof | มี reviews, ratings, testimonials? | Near CTA / product info |
| Numbers | แสดงจำนวนผู้ใช้, downloads, reviews? | Hero section / near CTA |
| Security badges | มี SSL, payment badges, guarantees? | Checkout / payment form |
| Brand trust | มี logo ที่จำได้ + consistent branding? | Header / throughout |
| Contact info | มีช่องทางติดต่อ (chat, phone, email)? | Footer / help section |
| Privacy policy | มี link ไป privacy policy ใกล้ form? | Registration / checkout |
| Money-back guarantee | มีการรับประกัน? | Pricing / checkout |
| Real photos | ใช้รูปจริง ไม่ใช่ stock photos? | Throughout |
| Third-party logos | มี "trusted by" / partner logos? | Below hero / social proof |

### Dimension 4: Visual Hierarchy for Conversion (15%)

| Check | Criteria |
|-------|----------|
| Value proposition | เห็นทันทีใน 5 วินาที ว่าหน้านี้ offer อะไร? |
| F-pattern / Z-pattern | Content เรียงตาม reading pattern? |
| Eye flow to CTA | สายตาถูก guide ไปยัง CTA อย่างธรรมชาติ? |
| Distraction-free | ไม่มี element ที่แย่ง attention จาก CTA? |
| Above the fold | ข้อมูลสำคัญที่สุดอยู่ใน viewport แรก? |
| Content priority | Important content อยู่บน, details อยู่ล่าง? |
| Negative space | ใช้ white space guide attention ไป CTA? |
| One clear message | แต่ละ section มี message เดียว? |

### Dimension 5: Friction & Abandonment Prevention (15%)

**Friction Points Checklist:**
| Check | Impact | Fix |
|-------|--------|-----|
| Surprise costs | ราคาเปลี่ยนที่ checkout? | แสดงราคาสุดท้ายก่อน checkout |
| Account required | ต้องสมัครก่อนซื้อ/ใช้? | Guest checkout / lazy registration |
| Too many steps | Checkout > 3 steps? | ลดเหลือ 1-3 steps |
| Unclear next step | ไม่รู้ต้องทำอะไรต่อ? | CTA ชัดเจน + progress indicator |
| External redirect | ออกจาก site ไปจ่ายเงิน? | Inline payment / embedded form |
| Slow loading | > 3 วินาที load time? | Skeleton + lazy loading |
| Captcha | ต้องไขปริศนา? | Invisible captcha / hCaptcha |
| Forced registration | popup สมัครก่อนเห็น content? | ให้เห็น value ก่อน |

**Exit Intent Recovery:**
| Trigger | Recovery Pattern |
|---------|-----------------|
| Mouse to close tab (web) | Exit-intent popup + offer |
| Back button (mobile) | Confirmation dialog "ยังไม่ได้บันทึก" |
| Cart abandonment | Email / notification reminder |
| Form abandonment | Auto-save draft + "ดำเนินการต่อ" |
| Long idle time | "ยังอยู่ไหม?" prompt |

### Dimension 6: Onboarding & First Experience (10%)

| Check | Criteria |
|-------|----------|
| Time to value | User เห็น core value ใน < 60 วินาที? |
| Progressive disclosure | ไม่ show ทุก feature ทีเดียว? |
| Skip option | สามารถ skip onboarding ได้? |
| Contextual guidance | สอนตอนใช้จริง ไม่ใช่ tutorial ก่อนเริ่ม? |
| Minimal setup | ขอข้อมูลน้อยที่สุดก่อนเริ่มใช้? |
| Welcome state | หน้าแรกหลัง onboarding มี guidance ไหม? |
| Empty state as CTA | Empty state กระตุ้น action แรก? |
| Achievement feeling | มี micro-celebration เมื่อทำสำเร็จ? |

### Dimension 7: Pricing & Value Communication (5%)

| Check | Criteria |
|-------|----------|
| Price anchoring | แสดง plan ที่แพงที่สุดก่อน? (anchor effect) |
| Recommended plan | Highlight plan ที่ต้องการขาย? (visual prominence) |
| Feature comparison | เปรียบเทียบ features ชัดเจน? |
| Free trial | มี risk-free option? |
| Annual discount | แสดง savings ของ annual plan? |
| Currency/tax | แสดง currency + inclusive/exclusive tax? |
| Refund policy | แสดงชัดเจน? |

---

## Step 4: Score

### Scoring Matrix

| Dimension | Weight | Score (1-10) | Revenue Impact | Notes |
|-----------|--------|-------------|----------------|-------|
| CTA Effectiveness | 20% | — | — | — |
| Form Optimization | 20% | — | — | — |
| Trust & Credibility | 15% | — | — | — |
| Visual Hierarchy | 15% | — | — | — |
| Friction Prevention | 15% | — | — | — |
| Onboarding | 10% | — | — | — |
| Pricing Communication | 5% | — | — | — |
| **Weighted Total** | **100%** | **—/10** | — | — |

### Rating Scale
- **9-10**: Conversion machine — UX ไม่มี friction
- **7-8**: ดี — มี minor optimizations
- **5-6**: Average — conversion rate ต่ำกว่าที่ควร
- **3-4**: Leaky funnel — สูญเสีย user หลายจุด
- **1-2**: Broken — user ไม่สามารถ/ไม่อยาก convert

---

## Step 5: Report

### Output Format: HTML Conversion UX Report

สร้างไฟล์ `conversion-ux-report.html` ที่แสดง:

1. **Score Overview** — คะแนนรวม + conversion funnel diagram
2. **Funnel Analysis** — แต่ละ step ของ funnel + predicted drop-off points
3. **Issue Cards** แยกตาม severity:
   - WHAT: ปัญหาคืออะไร
   - WHY: ทำไมกระทบ conversion (อ้าง research/principle)
   - IMPACT: estimated impact (high/medium/low)
   - FIX: วิธีแก้ + before/after mockup
4. **CTA Audit** — วิเคราะห์ CTA ทุกตัว (text, color, position, size)
5. **Form Audit** — วิเคราะห์ form fields ทุกตัว
6. **Trust Signal Map** — แสดงว่า trust signals อยู่ตรงไหน (หรือขาดตรงไหน)
7. **Quick Wins** — 3-5 สิ่งที่แก้ง่ายแต่ impact สูง
8. **Checklist** — สรุปทุก issue เรียงตาม priority

### โทน Designer-Friendly:
- ใช้ "เพิ่ม conversion ได้ด้วย..." แทน "ปัญหาคือ..."
- ให้ before/after comparison ทุก issue
- อ้าง research data เมื่อมี (เช่น "ลด 1 field = +7% conversion")

---

## หลักการสำคัญ (33 Design Crimes to Avoid)

จาก "33 Website Design Crimes to Avoid":

1. **No clear value proposition** — user ไม่รู้ว่าจะได้อะไร
2. **Too many CTAs** — ไม่รู้จะกดอะไร (Hick's Law)
3. **Weak CTA text** — "Submit" ไม่บอกว่า submit อะไร
4. **No social proof** — ทำไมต้องเชื่อ?
5. **Hidden pricing** — ราคาเท่าไหร่?
6. **Surprise costs** — ทำไมราคาเปลี่ยน?
7. **Forced registration** — ต้องสมัครก่อน?
8. **Long forms** — กรอกเยอะจัง
9. **No error prevention** — กดผิดแล้วเริ่มใหม่
10. **Slow performance** — รอนาน ไม่รอแล้ว
11. **No mobile optimization** — ใช้ mobile ไม่ได้
12. **Confusing navigation** — หาไม่เจอ
13. **Auto-play video/audio** — น่ารำคาญ
14. **Popup overload** — popup ทับ popup
15. **No search** — หาสิ่งที่ต้องการไม่ได้
