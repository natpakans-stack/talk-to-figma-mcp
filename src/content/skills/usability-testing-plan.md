---
name: usability-testing-plan
description: "สร้างแผน Usability Testing อย่างเป็นระบบ — ครอบคลุม test objectives, participant recruitment, task scenarios, test script, metrics, analysis framework รองรับทั้ง moderated/unmoderated, remote/in-person ใช้ skill นี้เมื่อผู้ใช้ต้องการ: วางแผน usability test, สร้าง test plan, เขียน task scenario, ทดสอบ usability, user testing, UX research, หรือเมื่อพิมพ์ 'usability test', 'user test', 'test plan', 'ux research', 'ทดสอบ', 'สร้าง test plan', 'test scenario', 'ux testing'"
---

# Usability Testing Plan Skill

สร้างแผน Usability Testing ที่พร้อมใช้งาน — ตั้งแต่กำหนด objectives ถึง analysis framework

---

## Pipeline Position

```
UI Design → Prototype → ★ Usability Testing Plan ★ → Conduct Test → Iterate → QA Gate
```

---

## Overall Flow

```
1. รับ Context ──▶ 2. เลือกวิธี ──▶ 3. สร้าง Plan ──▶ 4. เขียน Script ──▶ 5. กำหนด Metrics ──▶ 6. Output
```

---

## Step 1: รับ Context

ถามผู้ใช้:

- **Product**: ทดสอบอะไร? (app, website, feature, prototype)
- **Stage**: อยู่ขั้นไหน? (concept, wireframe, prototype, live product)
- **Goal**: ต้องการรู้อะไร? (usability, learnability, findability, preference)
- **Scope**: ทดสอบทั้ง app หรือเฉพาะ flow?
- **Budget**: มีงบเท่าไหร่? มีเวลากี่วัน?
- **Existing Data**: มี analytics, support tickets, หรือ feedback อยู่แล้วไหม?

---

## Step 2: เลือกวิธีทดสอบ

### Testing Method Matrix

| Method | Cost | Speed | Depth | Best for |
|--------|------|-------|-------|----------|
| **Moderated Remote** | Medium | Fast | Deep | Complex flows, think-aloud, follow-up questions |
| **Unmoderated Remote** | Low | Very fast | Medium | Large sample, simple tasks, quantitative data |
| **Moderated In-Person** | High | Slow | Very deep | Physical products, sensitive topics, observation |
| **Guerrilla Testing** | Very low | Very fast | Low | Quick validation, public spaces, informal |
| **A/B Testing** | Low | Varies | Specific | Design decisions, CTA comparison, layout |
| **Card Sorting** | Low | Fast | Medium | IA, navigation, categorization |
| **First Click Testing** | Low | Fast | Medium | Navigation, findability, layout |
| **5-Second Test** | Very low | Very fast | Low | First impression, clarity, value proposition |

### แนะนำตาม Stage:

| Stage | Recommended Method | Participants |
|-------|-------------------|--------------|
| Concept / Wireframe | Moderated (remote/in-person), 5-Second test | 5-8 |
| Lo-fi Prototype | Moderated remote, Card sorting | 5-8 |
| Hi-fi Prototype | Moderated remote, Unmoderated remote | 5-15 |
| Live Product | Unmoderated remote, A/B testing, Analytics | 10-50+ |
| Quick Validation | Guerrilla, 5-Second test, First Click | 5-10 |

---

## Step 3: สร้าง Test Plan

### 3.1 Test Objectives

เขียน 3-5 objectives ที่ measurable:

```
Format: "ตรวจสอบว่าผู้ใช้สามารถ [action] โดย [criteria] ได้หรือไม่"
```

ตัวอย่าง:
1. "ตรวจสอบว่าผู้ใช้ใหม่สามารถลงทะเบียนสำเร็จใน < 2 นาทีได้หรือไม่"
2. "ตรวจสอบว่าผู้ใช้หา feature X ได้ใน < 3 clicks หรือไม่"
3. "ตรวจสอบว่าผู้ใช้เข้าใจ value proposition ภายใน 5 วินาทีหรือไม่"

### 3.2 Participant Profile

| Criteria | Specification |
|----------|--------------|
| จำนวน | 5-8 คน (หา 85% ของปัญหา — Nielsen's 5-user rule) |
| Demographics | อายุ, เพศ, อาชีพ, ที่ตั้ง |
| Tech proficiency | Novice / Intermediate / Expert |
| Domain knowledge | คุ้นเคยกับ domain ไหม? |
| Product experience | เคยใช้ product นี้ไหม? (new vs returning) |
| Device | iPhone / Android / Desktop / Tablet |
| Exclusion criteria | ใครที่ห้ามเข้าร่วม? (เช่น designer, developer) |

### Recruitment Screener Questions

สร้าง 5-7 คำถาม screening:

```markdown
1. คุณใช้สมาร์ทโฟนยี่ห้ออะไร?
   □ iPhone  □ Android  □ อื่นๆ → [DISQUALIFY if not target platform]

2. คุณเคยใช้แอป [category] หรือไม่?
   □ ใช่ → ถามต่อ  □ ไม่เคย → [QUALIFY/DISQUALIFY depending on goal]

3. คุณใช้แอป [category] บ่อยแค่ไหน?
   □ ทุกวัน  □ สัปดาห์ละ  □ เดือนละ  □ ไม่เคย

4. อาชีพของคุณคืออะไร?
   [Open text] → [DISQUALIFY if UX/UI designer or developer]

5. คุณสะดวกเข้าร่วมทดสอบ [date/time] ไหม?
   □ สะดวก  □ ไม่สะดวก
```

### 3.3 Task Scenarios

**Task Writing Rules:**
- ใช้ **scenario-based** ไม่ใช่ **instruction-based**
- เขียนเป็น "เรื่องเล่า" ไม่ใช่ขั้นตอน
- ห้ามใช้คำที่อยู่บน UI (clue words)
- ให้ realistic context

**Bad vs Good Tasks:**

| Bad (Instruction) | Good (Scenario) |
|-------------------|-----------------|
| "กดปุ่ม Register" | "คุณเพิ่งรู้จักแอปนี้จากเพื่อน อยากลองใช้ดู ลองเริ่มต้นใช้งาน" |
| "หาหน้า Settings" | "คุณอยากเปลี่ยนรูปโปรไฟล์ ลองทำดู" |
| "กรอกฟอร์มที่อยู่" | "คุณสั่งของออนไลน์ ต้องกรอกที่อยู่สำหรับจัดส่ง ลองดำเนินการ" |
| "ค้นหาร้านอาหาร" | "คุณหิวข้าว อยากหาร้านอาหารไทยใกล้ๆ ลองหาดู" |

**Task Template:**

```markdown
### Task [N]: [Task Name]

**Scenario:**
[Realistic context — 2-3 sentences]

**Starting Point:**
[Where the user starts — specific screen]

**Success Criteria:**
- [ ] [Measurable outcome 1]
- [ ] [Measurable outcome 2]

**Expected Path:**
[Screen A] → [Screen B] → [Screen C] → [Success]

**Data Points to Collect:**
- Task completion: Yes/No
- Time on task: ___
- Number of errors: ___
- Number of clicks/taps: ___
- Satisfaction (1-5): ___
```

สร้าง 5-8 tasks ต่อ session (ไม่เกิน 60 นาที total)

### 3.4 Test Environment

| Setting | Specification |
|---------|--------------|
| Location | Remote (Zoom/Teams) / In-person / Unmoderated (UserTesting) |
| Device | Participant's own device / Provided device |
| Prototype | Figma prototype URL / Live product URL |
| Recording | Screen + face + audio (ต้องขอ consent) |
| Tools | Screen sharing, think-aloud, eye-tracking (optional) |
| Duration | 30-60 min per session |
| Compensation | [Amount] per participant |

---

## Step 4: เขียน Test Script

### Moderator Script Template:

```markdown
## ก่อนเริ่ม (5 min)

### แนะนำตัว
"สวัสดีครับ/ค่ะ ขอบคุณที่มาช่วยทดสอบวันนี้
ผม/ดิฉัน [ชื่อ] จาก [ทีม]
วันนี้เราจะลองทดสอบ [product] กัน ใช้เวลาประมาณ [X] นาที"

### อธิบาย Process
"ขอเล่าให้ฟังก่อนนะครับ:
- เราทดสอบ **product** ไม่ใช่ทดสอบคุณ
- ไม่มีคำตอบถูกหรือผิด
- ถ้าอะไรยากหรือสับสน นั่นคือปัญหาของ design ไม่ใช่ของคุณ
- อยากให้ **คิดออกเสียง** — พูดสิ่งที่คิดขณะใช้งาน
- คุณสามารถหยุดได้ทุกเมื่อ
- ผมจะบันทึกหน้าจอและเสียง เพื่อนำไปปรับปรุง — ยินยอมไหมครับ?"

### Warm-up Questions
"ก่อนเริ่ม ขอถามสั้นๆ:
- ปกติใช้แอปแบบนี้บ้างไหม? ใช้อะไรบ้าง?
- ใช้บ่อยแค่ไหน?
- ชอบ/ไม่ชอบอะไรเกี่ยวกับแอปพวกนั้น?"

---

## ช่วงทดสอบ (40-50 min)

### Task 1: [Task Name]
"ลองจินตนาการว่า... [scenario]"

*เงียบ รอให้ user ทำเอง*

**ถ้า user ติด (> 30 วินาทีไม่มี action):**
- ระดับ 1: "ตอนนี้คิดอะไรอยู่ครับ?"
- ระดับ 2: "ปกติจะทำยังไง?"
- ระดับ 3: "ลองดูตรง [area] สิครับ" (เฉพาะกรณีจำเป็นมาก)

**Note:**
- เวลาเริ่ม: ___
- เวลาจบ: ___
- สำเร็จ: □ Yes □ No □ Partial
- จำนวน errors: ___
- สังเกต: ___

### [Tasks 2-N ตาม pattern เดียวกัน]

---

## ช่วงสรุป (5-10 min)

### Post-Task Questions
"ขอบคุณมากครับ ขอถามอีกนิดหน่อย:

1. โดยรวมรู้สึกยังไงบ้างกับการใช้ [product]?
2. มีจุดไหนที่ยากหรือสับสนเป็นพิเศษไหม?
3. มีอะไรที่ชอบเป็นพิเศษไหม?
4. ถ้าเปลี่ยนได้ 1 อย่าง จะเปลี่ยนอะไร?
5. คะแนน 1-10 ความง่ายในการใช้งานให้เท่าไหร่?"

### SUS Questionnaire (Optional)
System Usability Scale — 10 questions, 1-5 scale

### ปิด
"ขอบคุณมากครับ สิ่งที่คุณแชร์จะเป็นประโยชน์มากในการปรับปรุง"
```

---

## Step 5: กำหนด Metrics

### Quantitative Metrics

| Metric | Formula | Benchmark |
|--------|---------|-----------|
| Task completion rate | สำเร็จ / ทั้งหมด × 100% | >= 78% (industry avg) |
| Time on task | เวลาเฉลี่ย per task | เทียบกับ expected time |
| Error rate | จำนวน errors / ทั้งหมด | < 10% |
| Click/tap count | จำนวน clicks vs optimal path | <= optimal + 2 |
| SUS Score | System Usability Scale | >= 68 (above avg) |
| NPS | Promoters - Detractors | >= 30 (good) |

### Qualitative Metrics

| Metric | How to capture |
|--------|---------------|
| Pain points | สิ่งที่ user พูดว่ายาก/สับสน |
| Mental model mismatch | สิ่งที่ user คาดหวังแต่ไม่ตรง |
| Delight moments | สิ่งที่ user ชอบ/ประทับใจ |
| Workarounds | วิธีที่ user แก้ปัญหาเอง |
| Quotes | คำพูดสำคัญจาก user (verbatim) |

### Analysis Framework

**Severity Rating:**
| Rating | Label | Description | Action |
|--------|-------|-------------|--------|
| 4 | Catastrophic | User ไม่สามารถทำ task สำเร็จ | แก้ทันที |
| 3 | Major | User ทำสำเร็จแต่ยากมาก / ใช้เวลานาน | แก้ใน sprint นี้ |
| 2 | Minor | User สับสนเล็กน้อยแต่แก้ได้เอง | แก้ใน sprint ถัดไป |
| 1 | Cosmetic | สังเกตได้แต่ไม่กระทบ task | backlog |

**Finding Template:**
```markdown
### Finding [N]: [Title]

**Severity:** [4/3/2/1]
**Task:** [Which task]
**Frequency:** [X out of Y participants]
**Description:** [What happened]
**User Quote:** "[exact words]"
**Root Cause:** [Why — UX principle violated]
**Recommendation:** [How to fix]
**Evidence:** [Screenshot / recording timestamp]
```

---

## Step 6: Output

### Output Format: HTML Usability Test Plan

สร้างไฟล์ `usability-test-plan.html` ที่แสดง:

1. **Test Overview** — goals, method, timeline, participants
2. **Participant Profile** — demographics + screener questions
3. **Task Scenarios** — ทุก task พร้อม scenario + success criteria
4. **Moderator Script** — script ที่พิมพ์ได้
5. **Data Collection Sheet** — ตาราง record data per participant
6. **Analysis Framework** — severity scale + finding template
7. **Timeline** — recruitment → testing → analysis → report
8. **Printable Consent Form** — form ขอ consent บันทึก

### Alternative Output: Markdown
ถ้าผู้ใช้ต้องการ ส่งเป็น markdown สำหรับ Notion/Confluence

---

## หลักการสำคัญ

1. **5 Users Enough**: 5 คนหาปัญหาได้ 85% (Nielsen)
2. **Test Early, Test Often**: ทดสอบ lo-fi ดีกว่าไม่ทดสอบเลย
3. **Observe, Don't Lead**: ห้ามบอกใบ้ ห้ามช่วย (ยกเว้นจำเป็นจริงๆ)
4. **Think Aloud**: ให้ user พูดสิ่งที่คิด — data ที่ดีที่สุด
5. **Behavior > Opinion**: สังเกตสิ่งที่ user ทำ สำคัญกว่าสิ่งที่ user พูด
6. **No Bias**: ห้ามถาม leading questions ("คุณชอบปุ่มนี้ไหม?")
7. **Iterate Fast**: test → find → fix → test again ก่อน launch
