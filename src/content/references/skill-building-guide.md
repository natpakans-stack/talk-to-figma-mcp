---
name: skill-building-guide
description: >
  คู่มือครบวงจรสำหรับสร้าง Claude Skill ใหม่ตาม Anthropic Official Guide
  ครอบคลุมโครงสร้าง YAML frontmatter, progressive disclosure, 5 workflow patterns,
  testing, troubleshooting และ distribution
  Use when creating new Skills, designing Skill structure, writing SKILL.md,
  planning Skill architecture, choosing workflow patterns, writing frontmatter,
  troubleshooting Skill issues, or improving existing Skills.
  Triggers: "สร้าง skill", "create skill", "ออกแบบ skill", "skill ใหม่",
  "เขียน SKILL.md", "ปรับปรุง skill", "skill ไม่ทำงาน", "skill triggering issues"
metadata:
  author: custom
  version: 2.0.0
  source: The Complete Guide to Building Skills for Claude (Anthropic)
  compatibility: claude.ai, claude-code, api
---

# Skill Building Guide — คู่มือสร้าง Skill สำหรับ Claude

คู่มืออ้างอิงหลักทุกครั้งที่ต้องสร้างหรือปรับปรุง Claude Skill
อิงจาก Anthropic Official Guide + Best Practices จากประสบการณ์จริง

---

## ขั้นตอนสร้าง Skill (Overview)

1. **วิเคราะห์** — ระบุ use case 2-3 อัน, เลือกประเภท Skill, กำหนด success criteria
2. **ออกแบบ** — วาง folder structure, เขียน frontmatter, เลือก workflow pattern
3. **เขียน** — สร้าง SKILL.md + scripts/references/assets ตามจำเป็น
4. **ทดสอบ** — Triggering tests, Functional tests, Performance comparison
5. **ปรับปรุง** — Iterate จาก feedback (under/over-triggering, execution issues)
6. **แจกจ่าย** — Upload to Claude.ai / Claude Code / API

---

## 1. วิเคราะห์ก่อนเขียน

### เลือกประเภท Skill

| ประเภท | ใช้เมื่อ | ต้องการ Script? | ตัวอย่าง |
|--------|---------|----------------|----------|
| **Document/Asset Creation** | สร้างเอกสาร, design, code ที่มีรูปแบบคงที่ | ไม่จำเป็น | frontend-design, docx, pptx |
| **Workflow Automation** | กระบวนการหลายขั้นตอนที่ต้องทำซ้ำ | อาจจะ | skill-creator, research pipeline |
| **MCP Enhancement** | เสริม workflow ให้ MCP server | อาจจะ | sentry-code-review |
| **Knowledge-only** | ความรู้เฉพาะทาง, guidelines | ไม่ | brand guidelines, policies |

### คำถามวิเคราะห์

ถามตัวเองก่อนเขียน:
1. **Skill แก้ปัญหาอะไร?** — ระบุให้ชัด
2. **Claude ยังไม่รู้อะไร?** — เพิ่มเฉพาะ context ที่ขาด
3. **ต้องการ executable code ไหม?** — Skill จำนวนมากใช้แค่ instructions
4. **User จะพูดว่าอะไรเพื่อ trigger?** — คิด trigger phrases
5. **Output ที่คาดหวังคืออะไร?** — document, code, analysis, etc.

### กำหนด Use Case (ตัวอย่าง)

```
Use Case: Project Sprint Planning
Trigger: "help me plan this sprint", "create sprint tasks"
Steps:
  1. Fetch current project status
  2. Analyze team velocity
  3. Suggest task prioritization
  4. Create tasks with labels and estimates
Result: Fully planned sprint with tasks created
```

### Success Criteria

**เชิงปริมาณ:**
- Skill triggers ถูกต้อง ≥90% ของ relevant queries
- Workflow จบใน X tool calls
- 0 failed API calls ต่อ workflow

**เชิงคุณภาพ:**
- User ไม่ต้อง prompt เพิ่มเกี่ยวกับ next steps
- ผลลัพธ์สม่ำเสมอข้าม sessions
- User ใหม่ทำสำเร็จตั้งแต่ครั้งแรก

---

## 2. โครงสร้าง Folder

```
your-skill-name/
├── SKILL.md              # ✅ REQUIRED — ไฟล์หลัก
├── scripts/              # ⚪ Optional — executable code
│   ├── process_data.py
│   └── validate.sh
├── references/           # ⚪ Optional — เอกสารเพิ่มเติม
│   ├── api-guide.md
│   └── examples/
└── assets/               # ⚪ Optional — templates, fonts, icons
    └── report-template.md
```

### กฎเหล็กที่ต้องปฏิบัติ

| กฎ | ถูก ✅ | ผิด ❌ |
|----|-------|--------|
| ชื่อไฟล์ | `SKILL.md` (exact case) | `skill.md`, `SKILL.MD` |
| ชื่อ folder | `my-cool-skill` (kebab-case) | `My Cool Skill`, `my_cool_skill` |
| README | ห้ามใส่ README.md ใน skill folder | มี README.md ข้างใน |
| Frontmatter | ต้องมี `---` เปิดปิด | ไม่มี delimiters |
| Name field | kebab-case, ไม่มี spaces/capitals | `My Cool Skill` |
| Security | ห้าม XML brackets `< >` | มี `<tag>` ใน frontmatter |
| Reserved names | ห้ามใช้ "claude" หรือ "anthropic" ในชื่อ | `claude-helper` |

---

## 3. เขียน YAML Frontmatter

### Minimal (ใช้ได้เลย)

```yaml
---
name: your-skill-name
description: What it does. Use when user asks to [specific phrases].
---
```

### Full Options

```yaml
---
name: your-skill-name
description: >
  [สิ่งที่ทำ] + [เมื่อไหร่ใช้] + [ความสามารถหลัก]
  Use when user says "phrase1", "phrase2", or mentions "keyword".
  Do NOT use for [negative triggers].
license: MIT
compatibility: claude.ai, claude-code
metadata:
  author: Your Name
  version: 1.0.0
  mcp-server: server-name
  category: productivity
  tags: [project-management, automation]
---
```

### Field Requirements

| Field | Required? | ข้อจำกัด |
|-------|-----------|---------|
| `name` | ✅ Yes | kebab-case, ≤64 chars, letters/numbers/hyphens |
| `description` | ✅ Yes | ≤1024 chars, ต้องมี WHAT + WHEN, ห้าม XML tags |
| `license` | Optional | e.g. MIT, Apache-2.0 |
| `compatibility` | Optional | 1-500 chars, ระบุ environment requirements |
| `metadata` | Optional | key-value pairs อะไรก็ได้ |

### ตัวอย่าง Description ที่ดี vs ไม่ดี

**ดี:**
```yaml
description: >
  Analyzes Figma design files and generates developer handoff documentation.
  Use when user uploads .fig files, asks for "design specs",
  "component documentation", or "design-to-code handoff".
```

**ดี (มี negative triggers):**
```yaml
description: >
  Advanced data analysis for CSV files. Use for statistical modeling,
  regression, clustering. Do NOT use for simple data exploration
  (use data-viz skill instead).
```

**ไม่ดี:**
```yaml
description: Helps with projects.  # เกินไปกว้าง
description: Creates sophisticated multi-page documentation systems.  # ไม่มี triggers
description: Implements the Project entity model with hierarchical relationships.  # technical เกินไป
```

---

## 4. Progressive Disclosure (3 ระดับ)

Skill ใช้ระบบ 3 ระดับเพื่อประหยัด tokens:

| ระดับ | อะไร | โหลดเมื่อไหร่ |
|-------|------|-------------|
| **Level 1** | YAML frontmatter | เสมอ (อยู่ใน system prompt) |
| **Level 2** | SKILL.md body | เมื่อ Claude คิดว่า skill เกี่ยวข้อง |
| **Level 3** | Linked files (references/, scripts/) | เมื่อ Claude ต้องการข้อมูลเพิ่ม |

**แนวปฏิบัติ:**
- SKILL.md body ≤500 บรรทัด (ควร ≤5,000 words)
- ถ้าเกิน → ย้ายรายละเอียดไป `references/`
- Link ชัดเจน: `See references/api-patterns.md for rate limiting guidance`
- ใช้ progressive disclosure เมื่อ SKILL.md เกิน ~300 บรรทัดเท่านั้น

---

## 5. เขียน Instructions

### Template โครงสร้างหลัก

```markdown
---
name: your-skill
description: [description with triggers]
---

# Your Skill Name

## Instructions

### Step 1: [First Major Step]
Clear explanation of what happens.

Example:
  python scripts/fetch_data.py --project-id PROJECT_ID
  Expected output: [describe what success looks like]

### Step 2: [Next Step]
...

## Examples

### Example 1: [common scenario]
User says: "Set up a new marketing campaign"
Actions:
  1. Fetch existing campaigns
  2. Create new campaign with parameters
Result: Campaign created with confirmation link

## Troubleshooting

### Error: [Common error message]
Cause: [Why it happens]
Solution: [How to fix]
```

### Best Practices สำหรับ Instructions

**เฉพาะเจาะจง ไม่คลุมเครือ:**
```markdown
# ✅ ดี
Run `python scripts/validate.py --input {filename}` to check data format.
If validation fails:
- Missing required fields → add them to the CSV
- Invalid date formats → use YYYY-MM-DD

# ❌ ไม่ดี
Validate the data before proceeding.
```

**ใส่ error handling:**
```markdown
# MCP Connection Failed
If you see "Connection refused":
1. Verify MCP server is running: Check Settings > Extensions
2. Confirm API key is valid
3. Try reconnecting: Settings > Extensions > [Your Service] > Reconnect
```

**อ้างอิง bundled resources ชัดเจน:**
```markdown
Before writing queries, consult `references/api-patterns.md` for:
- Rate limiting guidance
- Pagination patterns
- Error codes and handling
```

**กำหนด degrees of freedom:**

| ระดับ | ใช้เมื่อ | ตัวอย่าง |
|-------|---------|----------|
| **สูง** (text instructions) | หลายวิธีเป็นไปได้ | Code review guidelines |
| **กลาง** (scripts + params) | มี pattern ที่ดี แต่ยืดหยุ่นได้ | Report generator |
| **ต่ำ** (specific scripts) | ต้องแม่นยำ, fragile operations | Database migration |

**สำหรับ validations สำคัญ:** ใช้ script แทน language instructions เมื่อเป็นไปได้
— code กำหนดผลลัพธ์แน่นอน, ภาษาตีความได้หลายแบบ

---

## 6. Workflow Patterns (5 แบบ)

### Pattern 1: Sequential Workflow Orchestration
**ใช้เมื่อ:** กระบวนการหลายขั้นตอนตามลำดับ

```markdown
# Step 1: Create Account → create_customer(name, email)
# Step 2: Setup Payment → setup_payment_method() → wait for verification
# Step 3: Create Subscription → create_subscription(plan_id, customer_id from Step 1)
# Step 4: Send Welcome Email → send_email(template: welcome)
```
เทคนิค: explicit ordering, dependencies ระหว่าง steps, validation ทุกขั้น, rollback instructions

### Pattern 2: Multi-MCP Coordination
**ใช้เมื่อ:** Workflow ข้ามหลาย services

```markdown
# Phase 1: Design Export (Figma MCP)
# Phase 2: Asset Storage (Drive MCP)
# Phase 3: Task Creation (Linear MCP)
# Phase 4: Notification (Slack MCP)
```
เทคนิค: แยก phase ชัดเจน, data passing ระหว่าง MCPs, validate ก่อนไป phase ถัดไป

### Pattern 3: Iterative Refinement
**ใช้เมื่อ:** คุณภาพ output ดีขึ้นเมื่อ iterate

```markdown
# Initial Draft → Quality Check (scripts/check_report.py)
# → Refinement Loop (fix issues, re-validate)
# → Repeat until quality threshold met → Finalization
```
เทคนิค: explicit quality criteria, validation scripts, รู้ว่าเมื่อไหร่ควรหยุด iterate

### Pattern 4: Context-Aware Tool Selection
**ใช้เมื่อ:** ผลลัพธ์เดียวกัน แต่ใช้ tools ต่างกันตาม context

```markdown
# Decision Tree:
# Large files (>10MB) → cloud storage MCP
# Collaborative docs → Notion/Docs MCP
# Code files → GitHub MCP
# Temporary files → local storage
```
เทคนิค: decision criteria ชัดเจน, fallback options, บอก user ว่าเลือกทำไม

### Pattern 5: Domain-Specific Intelligence
**ใช้เมื่อ:** Skill เพิ่มความรู้เฉพาะทางนอกเหนือจาก tool access

```markdown
# Before Processing: compliance check (sanctions, jurisdiction, risk)
# IF passed → process transaction with fraud checks
# ELSE → flag for review, create compliance case
# Always: audit trail logging
```
เทคนิค: domain expertise ฝังใน logic, compliance ก่อน action, audit trail

---

## 7. Testing

### 7.1 Triggering Tests
```
Should trigger:
- "Help me set up a new ProjectHub workspace"
- "I need to create a project in ProjectHub"
- "Initialize a ProjectHub project for Q4 planning"

Should NOT trigger:
- "What's the weather?"
- "Help me write Python code"
- "Create a spreadsheet"
```
**Debug:** ถาม Claude: "When would you use the [skill name] skill?" — Claude จะ quote description กลับมา

### 7.2 Functional Tests
```
Test: Create project with 5 tasks
Given: Project name "Q4 Planning", 5 task descriptions
When: Skill executes workflow
Then:
  - Project created
  - 5 tasks with correct properties
  - All tasks linked
  - No API errors
```

### 7.3 Performance Comparison
```
Without skill: 15 messages, 3 failed API calls, 12,000 tokens
With skill: 2 clarifying questions, 0 failures, 6,000 tokens
```

### วิธี iterate

| สัญญาณ | ปัญหา | แก้ไข |
|---------|-------|-------|
| Skill ไม่โหลดเมื่อควรโหลด | Under-triggering | เพิ่ม trigger phrases ใน description |
| Skill โหลดตอนไม่เกี่ยว | Over-triggering | เพิ่ม negative triggers, เจาะจงมากขึ้น |
| ผลลัพธ์ไม่สม่ำเสมอ | Execution issues | ปรับ instructions, เพิ่ม error handling |
| Claude ไม่ทำตาม instructions | Instructions ไม่ชัด | ใส่ CRITICAL header, ใช้ numbered lists |

---

## 8. Troubleshooting

### Skill ไม่ยอม Upload

| Error | สาเหตุ | แก้ |
|-------|--------|-----|
| "Could not find SKILL.md" | ชื่อไฟล์ผิด | ตั้งชื่อเป็น `SKILL.md` (case-sensitive) |
| "Invalid frontmatter" | YAML format ผิด | ตรวจ `---` delimiters, ปิด quotes |
| "Invalid skill name" | มี spaces/capitals | ใช้ kebab-case: `my-cool-skill` |

### Claude ไม่ทำตาม Instructions

1. **Instructions ยาวเกินไป** → ตัดให้กระชับ, ย้ายไป references/
2. **Instructions อยู่ลึก** → ย้าย critical instructions ขึ้นบนสุด, ใช้ `## CRITICAL` header
3. **ภาษาคลุมเครือ** → เปลี่ยนจาก "validate things properly" เป็น checklist ชัดเจน
4. **Model laziness** → เพิ่มใน user prompt: "Take your time, quality over speed"

### Context ใหญ่เกินไป

- SKILL.md ≤5,000 words, ย้ายรายละเอียดไป references/
- ลด skills ที่ enable พร้อมกัน (อย่าเกิน 20-50)
- ใช้ progressive disclosure ให้เต็มที่

---

## 9. Distribution

### Upload to Claude.ai
1. Zip skill folder
2. Settings > Capabilities > Skills > Upload
3. Toggle on

### Claude Code
วาง skill folder ในตำแหน่งที่ Claude Code อ่านได้

### API
- `/v1/skills` endpoint สำหรับ manage skills
- `container.skills` parameter ใน Messages API
- ต้องเปิด Code Execution Tool beta

### GitHub (แนะนำ)
- Public repo + clear README (ข้างนอก skill folder)
- Example usage + screenshots
- Link จาก MCP docs ถ้ามี

---

## 10. Checklist สุดท้าย

### ก่อนเริ่ม
- [ ] ระบุ 2-3 use cases แล้ว
- [ ] เลือก tools ที่ต้องใช้แล้ว (built-in or MCP)
- [ ] วาง folder structure แล้ว

### ระหว่างพัฒนา
- [ ] Folder ชื่อ kebab-case
- [ ] `SKILL.md` มีอยู่ (exact spelling)
- [ ] YAML frontmatter มี `---` เปิดปิด
- [ ] `name`: kebab-case, ไม่มี spaces/capitals
- [ ] `description`: มีทั้ง WHAT และ WHEN
- [ ] ไม่มี XML tags `< >` ที่ไหนเลย
- [ ] Instructions ชัดเจน actionable
- [ ] มี error handling
- [ ] มี examples
- [ ] References link ชัดเจน

### ก่อน Upload
- [ ] ทดสอบ triggering กับ obvious tasks
- [ ] ทดสอบ triggering กับ paraphrased requests
- [ ] ยืนยันว่าไม่ trigger กับ unrelated topics
- [ ] Functional tests ผ่าน
- [ ] Zip folder แล้ว

### หลัง Upload
- [ ] ทดสอบใน conversation จริง
- [ ] Monitor under/over-triggering
- [ ] เก็บ feedback จาก users
- [ ] Iterate description + instructions
