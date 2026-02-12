# Jira Requirement Analysis Skill

วิเคราะห์ Requirements จาก Jira Card ของ BA เพื่อเตรียม UI Design Scope

---

## Trigger

ใช้ skill นี้เมื่อ:
- ผู้ใช้บอก Jira issue key (เช่น PROJ-123)
- ผู้ใช้พิมพ์ "jira", "analyse req", "วิเคราะห์ requirement", "card analysis", "BA req", "jira card"
- ผู้ใช้ paste requirement text จาก BA/PM

---

## Step 1: รับ Jira Card

### ถ้ามี Jira MCP (ตรวจจาก tools ที่ available)

ถาม issue key แล้วดึงข้อมูล:

```
jira_get(
  path: "/rest/api/3/issue/{issueKey}",
  jq: "{key: key, summary: fields.summary, description: fields.description, status: fields.status.name, priority: fields.priority.name, labels: fields.labels, issueType: fields.issuetype.name}"
)
```

ดึง comments ด้วย:
```
jira_get(
  path: "/rest/api/3/issue/{issueKey}/comment",
  jq: "comments[*].{author: author.displayName, body: body, created: created}",
  queryParams: { maxResults: "10" }
)
```

ถ้ามี subtasks:
```
jira_get(
  path: "/rest/api/3/search/jql",
  queryParams: { jql: "parent={issueKey}", maxResults: "20" },
  jq: "issues[*].{key: key, summary: fields.summary, status: fields.status.name}"
)
```

### ถ้าไม่มี Jira MCP

ถามผู้ใช้:
> "กรุณา paste เนื้อหา requirement จาก Jira card มาเลยครับ (summary, description, acceptance criteria)"

---

## Step 2: วิเคราะห์ Requirements

จาก Jira card ให้แยกวิเคราะห์เป็น:

### 2.1 User Stories

แยก requirement ออกเป็น User Stories format:
```
As a [user type], I want to [action], so that [benefit]
```

### 2.2 Acceptance Criteria

ดึง acceptance criteria (AC) ออกมาเป็น checklist:
- AC ที่เขียนไว้ใน card
- AC ที่ implied จาก description
- AC ที่ขาดหายไป (แนะนำเพิ่ม)

### 2.3 Business Rules

สรุปกฎเฉพาะ:
- Validation rules (format, length, required fields)
- Permission/role ที่เกี่ยวข้อง
- Limits/quotas
- Dependencies กับระบบอื่น

### 2.4 Edge Cases

ระบุ edge cases ที่ต้องออกแบบ:
| Case | Description | ต้องมี UI สำหรับ? |
|------|-------------|-------------------|
| Empty State | ยังไม่มีข้อมูล | ใช่ |
| Error State | API fail, validation error | ใช่ |
| Loading State | กำลังโหลดข้อมูล | ใช่ |
| Success State | ทำสำเร็จแล้ว | ใช่ |
| Permission Denied | ไม่มีสิทธิ์ | ตรวจสอบ |
| Offline | ไม่มี internet | ตรวจสอบ |
| Long Text | ข้อความยาวเกิน | ใช่ |
| Max Items | ข้อมูลเยอะมาก | ตรวจสอบ |
| First Time User | ใช้ครั้งแรก | ตรวจสอบ |

### 2.5 Dependencies

- Feature/screen อื่นที่เกี่ยวข้อง
- API endpoints ที่ต้องใช้
- Data models

---

## Step 3: สรุป UI Scope

Output เป็น structured summary:

### Screen List

| # | Screen Name | Description | Priority |
|---|-------------|-------------|----------|
| 1 | ... | ... | Must have |
| 2 | ... | ... | Must have |
| 3 | ... | ... | Nice to have |

### State Matrix

| Screen | Default | Filled | Error | Loading | Success | Empty |
|--------|---------|--------|-------|---------|---------|-------|
| Screen 1 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| Screen 2 | ✅ | ✅ | ✅ | - | ✅ | - |

### Component List

รายการ component ที่ต้องออกแบบ:
- Navigation: tabs, back button, etc.
- Forms: input fields, dropdowns, etc.
- Actions: buttons, links, etc.
- Feedback: toast, alerts, etc.
- Content: cards, lists, etc.

### User Flow Summary

**Happy Path**:
1. User เข้า screen → ...
2. User กรอกข้อมูล → ...
3. User กดยืนยัน → ...
4. แสดง success → ...

**Error Paths**:
- Validation error → แสดง inline error
- API error → แสดง error dialog
- ...

---

## Step 4: แนะนำ Design Approach

### Platform Pattern

อ้างอิง platform guidelines:
- **iOS**: อ่าน `references/hig.md` — navigation, modals, forms
- **Android**: อ่าน `references/material-design.md` — components, layout
- **Web**: อ่านทั้งสอง + responsive patterns

### UX Principles ที่เกี่ยวข้อง

อ่าน `references/ux-principles.md` แล้วแนะนำ:
- **H1 (Visibility)**: ผู้ใช้ต้องเห็น status ตลอด
- **H3 (User Control)**: มี undo/back ทุกจุด
- **H5 (Error Prevention)**: validate ก่อน submit
- **H9 (Error Recovery)**: error message ชัดเจน + วิธีแก้
- **Hick's Law**: ลด choices ต่อ screen
- **Miller's Law**: จัดกลุ่มข้อมูล 5-9 items
- (แนะนำตาม context ของ requirement)

### Design Tokens ที่เกี่ยวข้อง

อ่าน `references/design-tokens.md` แล้วระบุ:
- Color tokens ที่ใช้ (primary, error, success, etc.)
- Typography ที่เหมาะสม (heading, label, caption)
- Spacing pattern
- Component patterns

### Similar App/Pattern References

แนะนำ app ที่มี pattern คล้ายกัน เพื่อเป็น reference

---

## Step 5: ส่งต่อไป Design

เมื่อ user review สรุปแล้ว ถาม:

> "พร้อมเริ่มออกแบบ UI ไหมครับ? ผมจะสร้าง HTML preview ให้ดูได้เลย"

เมื่อ user ตอบพร้อม:
- ใช้ข้อมูลจาก Step 1-4 เป็น input สำหรับ **figma-ui-design-spec** skill
- ส่ง: Screen list, State matrix, Component list, User flow, Design approach ไปเป็น requirements

---

## Output Format

### UI Requirements Summary

```markdown
# UI Requirements Summary

## Source
- Jira: {ISSUE_KEY} — {Summary}
- Status: {Status}
- Priority: {Priority}

## User Stories
1. As a {user}, I want to {action}, so that {benefit}
2. ...

## Screens to Design
| # | Screen | States | Components |
|---|--------|--------|------------|
| 1 | ... | default, filled, error, loading, success | ... |
| 2 | ... | ... | ... |

## User Flow
{Happy path + error paths}

## Edge Cases
{Edge case list}

## Design Approach
- Platform: {iOS/Android/Web}
- Key UX Principles: {H1, H5, H9, ...}
- Design Tokens: {primary, error, ...}
- References: {similar apps}

## Acceptance Criteria Checklist
- [ ] AC 1
- [ ] AC 2
- ...
```
