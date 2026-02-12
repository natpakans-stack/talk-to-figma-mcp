---
name: figma-user-flow
description: "ออกแบบ User Flow, Information Architecture, Task Flow, Screen Map สำหรับ app/web ทั้งระบบ สร้าง flow diagram ใน FigJam หรือ Figma ได้ ใช้ skill นี้เมื่อผู้ใช้ต้องการ: ออกแบบ flow, สร้าง user journey, วาง IA, task flow, screen map, navigation structure, sitemap, wireflow, หรือเมื่อพิมพ์ 'user flow', 'flow', 'IA', 'information architecture', 'journey', 'sitemap', 'screen map', 'navigation', 'task flow'"
---

# User Flow / Information Architecture Skill

ออกแบบ User Flow และ Information Architecture สำหรับ app/web ทั้งระบบ — ไม่ใช่แค่หน้าจอเดียว แต่มองภาพรวมทั้ง journey

## Overall Flow

```
1. Requirements → 2. Read Principles → 3. Map IA → 4. Design Flows → 5. Generate Diagrams → 6. Build in Figma (Optional)
```

1. **Requirements**: เข้าใจ product, users, features
2. **Read Principles**: อ่าน UX + navigation patterns
3. **Map IA**: วาง Information Architecture
4. **Design Flows**: สร้าง user flows สำหรับ key tasks
5. **Generate Diagrams**: สร้าง diagram ใน FigJam/Figma
6. **Build in Figma**: สร้าง screen map ใน Figma (optional)

> **ส่งต่อ**: เมื่อ flow เสร็จแล้ว สามารถส่งต่อไป **figma-ui-design-spec** skill เพื่อสร้าง HTML preview สำหรับแต่ละ screen ได้เลย

---

## Step 1: รวบรวม Requirements

ถามข้อมูลเหล่านี้ (ถ้ายังไม่ได้ระบุ):

- **Product**: แอป/เว็บอะไร? ทำหน้าที่อะไร?
- **Target Users**: กลุ่มผู้ใช้หลัก (1-3 personas)
- **Platform**: Mobile (iOS/Android), Web, Desktop, Cross-platform?
- **Key Features**: features หลักที่ต้องมี (list ออกมา)
- **User Goals**: ผู้ใช้ต้องการทำอะไรสำเร็จ? (top 3-5 goals)
- **Scope**: ออกแบบทั้ง app หรือเฉพาะบาง module?
- **Reference**: มี app ที่คล้ายกันอยากให้ดูเป็น reference ไหม?
- **Existing Design**: มี Figma URL ของ design ที่มีอยู่แล้วไหม?

---

## Step 2: อ่าน Design Principles

อ่าน reference files:

```
references/ux-principles.md        → อ่านเสมอ (โดยเฉพาะ Hick's Law, Miller's Law, Jakob's Law)
references/material-design.md      → Navigation patterns สำหรับ Android/Web
references/hig.md                  → Navigation patterns สำหรับ iOS
```

### Navigation Patterns ที่ต้องรู้:

**iOS (HIG):**
- Tab Bar (3-5 items) + Navigation Stack — most common
- Sidebar (iPad) → Tab Bar (iPhone)
- Modal Sheets — focused tasks

**Android (Material):**
- Bottom Navigation (3-5 items) — compact
- Navigation Rail — medium screens
- Navigation Drawer — expanded screens

**Web:**
- Top Navigation Bar + Side Navigation
- Breadcrumbs for deep hierarchy
- Tab-based navigation for related content

---

## Step 3: Map Information Architecture

### 3.1 Feature Inventory

จัดกลุ่ม features เป็น categories:

```markdown
## Feature Inventory

| Category | Features | Priority |
|----------|----------|----------|
| Authentication | Login, Register, Forgot Password, Social Login | Must Have |
| Profile | View Profile, Edit Profile, Settings | Must Have |
| [Core Feature] | [list features] | Must Have |
| [Secondary] | [list features] | Should Have |
| [Nice-to-have] | [list features] | Could Have |
```

### 3.2 Content Model

กำหนด entities และ relationships:

```markdown
## Content Model

| Entity | Key Attributes | Relationships |
|--------|---------------|---------------|
| User | name, email, avatar, role | has many Posts, has many Orders |
| Product | title, price, image, category | belongs to Category, has many Reviews |
| Order | items, total, status, date | belongs to User, has many Products |
```

### 3.3 Site Map / Screen Map

จัด hierarchy ของ screens:

```markdown
## Screen Map

### Level 0: Entry
- Splash / Onboarding

### Level 1: Main Navigation (Tab Bar / Bottom Nav)
- Home (Tab 1)
- Search (Tab 2)
- [Core Feature] (Tab 3)
- Profile (Tab 4)

### Level 2: Sub-screens
- Home → Product Detail
- Home → Category List → Product List
- Search → Search Results → Product Detail
- Profile → Settings → Edit Profile
- Profile → Order History → Order Detail

### Level 3: Modals / Overlays
- Cart Sheet
- Filter Sheet
- Login Modal
```

### 3.4 Navigation Matrix

```markdown
## Navigation Matrix

| From \ To | Home | Search | Detail | Cart | Profile |
|-----------|------|--------|--------|------|---------|
| Home | — | Tab | Push | Sheet | Tab |
| Search | Tab | — | Push | Sheet | Tab |
| Detail | Back | — | — | Sheet | — |
| Cart | Dismiss | — | Push | — | — |
| Profile | Tab | Tab | — | — | — |

Transition types: Tab (tab switch), Push (nav push), Sheet (modal), Back (pop), Dismiss (close modal)
```

---

## Step 4: Design User Flows

### 4.1 Identify Key Flows

เลือก top 3-5 flows ที่สำคัญที่สุด:

```markdown
## Key User Flows

| # | Flow Name | User Goal | Priority | Complexity |
|---|-----------|-----------|----------|------------|
| 1 | Onboarding | สมัครและเริ่มใช้งาน | Critical | Medium |
| 2 | [Core Task] | [goal] | Critical | High |
| 3 | Purchase | ซื้อสินค้าสำเร็จ | Critical | High |
| 4 | Search & Filter | หาสิ่งที่ต้องการ | High | Medium |
| 5 | Account Management | จัดการบัญชี | Medium | Low |
```

### 4.2 Flow Diagram Format

แต่ละ flow ใช้ format นี้:

```markdown
### Flow: [Flow Name]

**User Goal**: [ผู้ใช้ต้องการทำอะไร]
**Entry Point**: [เข้ามาจากไหน]
**Success State**: [สำเร็จแล้วเห็นอะไร]
**Happy Path Steps**: [จำนวน steps]

#### Happy Path:
1. [Screen A] → User action: [action] →
2. [Screen B] → User action: [action] →
3. [Screen C] → Success ✓

#### Error/Alternative Paths:
- Step 2 error: [validation fail] → Show inline error → Retry
- Step 2 alternative: [ผู้ใช้กด back] → Return to Screen A
- Step 3 timeout: [network error] → Error state → Retry button

#### Decision Points:
- [Screen B]: if logged in → skip to Step 3; if not → show login modal
- [Screen C]: if first time → show tutorial; if returning → skip

#### Edge Cases:
- No network → Offline state with cached data
- Session expired → Re-auth modal
- Deep link entry → Skip to Step 2 with prefilled data
```

### 4.3 Flow Principles

ตรวจสอบทุก flow ด้วยหลักการ:

- **Hick's Law**: แต่ละ step มีตัวเลือกไม่เกิน 5-7
- **Miller's Law**: ข้อมูลต่อหน้าจอไม่เกิน 7±2 chunks
- **Doherty Threshold**: แต่ละ transition ต้อง < 400ms (perceived)
- **H1 - Visibility**: ผู้ใช้รู้ว่าอยู่ step ไหนของ flow
- **H3 - User Control**: ทุก step มีทางกลับ/undo
- **H5 - Error Prevention**: ป้องกัน error ก่อน submit

---

## Step 5: Generate Diagrams

### 5.1 สร้าง Flow Diagram (ใช้ Figma Remote MCP)

ใช้ `generate_diagram` สร้าง Mermaid.js diagram:

```
generate_diagram({
  name: "User Registration Flow",
  mermaidSyntax: 'flowchart LR\n  A["Splash Screen"] -->|"Tap Get Started"| B["Sign Up Form"]\n  B -->|"Fill & Submit"| C{"Valid?"}\n  C -->|"Yes"| D["Verify Email"]\n  C -->|"No"| B\n  D -->|"Code Entered"| E["Welcome Screen"]\n  E -->|"Continue"| F["Home"]',
  userIntent: "Registration user flow diagram"
})
```

### Diagram Types ที่ใช้ได้:

| Type | Mermaid Syntax | Use Case |
|------|---------------|----------|
| Flowchart | `flowchart LR` | User flows, task flows |
| Sequence | `sequenceDiagram` | API interactions, system flows |
| State Diagram | `stateDiagram-v2` | Screen states, component states |
| Gantt | `gantt` | Project timeline, feature roadmap |

### 5.2 Flow Diagram Best Practices

- ใช้ `flowchart LR` (left-to-right) สำหรับ user flows
- ใช้ `flowchart TD` (top-down) สำหรับ decision trees
- ทุก node ต้องมี label ในเครื่องหมายคำพูด
- Decision points ใช้ rhombus `{"Decision?"}`
- Color coding: green=success, red=error, blue=action
- ไม่ใช้ emoji ใน Mermaid syntax

### 5.3 Screen Map ใน Figma (Optional — ใช้ TalkToFigma MCP)

ถ้าต้องการสร้าง visual screen map ใน Figma:

```
1. สร้าง frame สำหรับแต่ละ screen (create_frame with name)
2. ใส่ชื่อ screen (create_text)
3. ใช้ create_connections เชื่อม screens
4. จัด layout ตาม hierarchy
```

---

## Step 6: Build Screen Map in Figma (Optional)

ถ้าผู้ใช้ต้องการ screen map ใน Figma:

### 6.1 Screen Card Template

สร้าง card สำหรับแต่ละ screen:
```
create_frame({
  name: "Screen: Home",
  x, y, width: 200, height: 120,
  fillColor: { r: 0.95, g: 0.95, b: 1 },
  layoutMode: "VERTICAL",
  itemSpacing: 8,
  paddingTop: 12, paddingBottom: 12, paddingLeft: 16, paddingRight: 16
})
```

### 6.2 Connect Screens

ใช้ `create_connections` เชื่อม:
```
create_connections({
  connections: [
    { startNodeId: "home-id", endNodeId: "detail-id", text: "Tap Product" },
    { startNodeId: "home-id", endNodeId: "search-id", text: "Tab Switch" }
  ]
})
```

### 6.3 Annotate

ใส่ annotations อธิบาย flow logic:
```
set_multiple_annotations({
  nodeId: "flow-frame-id",
  annotations: [
    { nodeId: "decision-id", labelMarkdown: "**Decision**\nIf logged in → skip auth" }
  ]
})
```

---

## Output Formats

| Output | Format | เมื่อไหร่ |
|--------|--------|----------|
| Feature Inventory | Markdown table | เสมอ |
| Screen Map | Markdown hierarchy | เสมอ |
| Navigation Matrix | Markdown table | เสมอ |
| User Flows (text) | Markdown steps | เสมอ |
| Flow Diagrams | FigJam (via generate_diagram) | เมื่อผู้ใช้ต้องการ visual |
| Screen Map (visual) | Figma frames + connections | เมื่อผู้ใช้ต้องการใน Figma |

---

## หลักการสำคัญ

1. **Goal-Oriented**: เริ่มจาก user goal ไม่ใช่ feature list
2. **Happy Path First**: ออกแบบ happy path ก่อน แล้วค่อยคิด edge cases
3. **Minimal Steps**: ลด steps ให้น้อยที่สุด (3-click rule เป็น guideline)
4. **Clear Wayfinding**: ผู้ใช้ต้องรู้เสมอว่าอยู่ตรงไหน ไปไหนได้
5. **Consistent Navigation**: ใช้ pattern เดียวกันทั้ง app
6. **Error Recovery**: ทุก flow ต้องมีทางกลับและ error handling
7. **Platform Conventions**: ใช้ navigation patterns ตาม platform
