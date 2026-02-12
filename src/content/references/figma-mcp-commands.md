# Figma MCP Commands Reference

คู่มือ commands ทั้งหมดที่ใช้ได้จริงสำหรับทำงานกับ Figma ผ่าน MCP Servers 3 ตัว

---

## MCP Servers ที่ใช้

| Server | ประเภท | หน้าที่หลัก |
|--------|--------|------------|
| **TalkToFigma** (stdio) | Local Plugin | สร้าง/แก้ไข/ลบ elements ใน Figma โดยตรง |
| **figma** (remote) | Figma API | อ่าน design, screenshot, generate code, diagrams |
| **html-to-design** (remote) | html.to.design Plugin | ส่ง HTML ไปสร้างเป็น Figma layers อัตโนมัติ |

---

## Table of Contents

### TalkToFigma (Local Plugin)
1. [Connection](#1-connection)
2. [Document & Selection](#2-document--selection)
3. [Creation Tools](#3-creation-tools)
4. [Modification Tools](#4-modification-tools)
5. [Auto Layout Tools](#5-auto-layout-tools)
6. [Text Tools](#6-text-tools)
7. [Component Tools](#7-component-tools)
8. [Annotation Tools](#8-annotation-tools)
9. [Connector Tools](#9-connector-tools)
10. [Selection & Focus](#10-selection--focus)

### Figma Remote MCP
11. [Screenshot & Design Context](#11-screenshot--design-context)
12. [Diagrams](#12-diagrams)
13. [Code Connect](#13-code-connect)

### html-to-design MCP (HTML → Figma)
14. [Import HTML to Figma](#14-import-html-to-figma)

### Patterns
15. [Common Patterns](#15-common-patterns)
16. [Color Conversion](#16-color-conversion)
17. [Smart Frame Positioning](#17-smart-frame-positioning)
18. [Icon Placeholder Pattern](#18-icon-placeholder-pattern)
19. [Exact Color Conversion](#19-exact-color-conversion)
20. [CSS-to-Figma Mapping Table](#20-css-to-figma-mapping-table)
21. [Post-Creation Verification Pattern](#21-post-creation-verification-pattern)
22. [Font Handling](#22-font-handling)
23. [HTML to Figma Best Practices](#23-html-to-figma--best-practices)

---

## 1. Connection

ก่อนใช้ TalkToFigma commands ต้อง join channel ก่อน:

```
join_channel(channel)
```

- ผู้ใช้ต้องเปิด Figma → รัน Plugin "Talk to Figma" → copy channel ID
- ถ้ายังไม่ได้ connect ให้ถาม: "กรุณาเปิด Talk to Figma Plugin ใน Figma แล้วบอก channel ID ให้หน่อยครับ"

---

## 2. Document & Selection

| Command | Parameters | Description |
|---------|-----------|-------------|
| `get_document_info` | — | ดูข้อมูล document ทั้งหมด (pages, frames) |
| `get_selection` | — | ดู elements ที่ถูกเลือกอยู่ (basic info) |
| `read_my_design` | — | ดูรายละเอียดทั้งหมดของ selection (all node details) |
| `get_node_info` | `nodeId` | ดูรายละเอียด element ตาม ID |
| `get_nodes_info` | `nodeIds[]` | ดูหลาย elements พร้อมกัน |
| `scan_text_nodes` | `nodeId` | หา text nodes ทั้งหมดใน node ที่ระบุ |
| `scan_nodes_by_types` | `nodeId, types[]` | หา child nodes ตาม type เช่น `['COMPONENT', 'FRAME']` |
| `get_styles` | — | ดู styles ที่มีใน document |
| `export_node_as_image` | `nodeId, format?, scale?` | Export เป็น PNG/JPG/SVG/PDF |

---

## 3. Creation Tools

### Frames & Containers

```
create_frame({
  x, y, width, height,        // required
  name?,                       // ชื่อ layer
  parentId?,                   // ใส่เข้า parent ได้เลย (ไม่ต้อง insert_child แยก)
  fillColor?: {r, g, b, a?},  // สีพื้น (0-1)
  strokeColor?: {r, g, b, a?}, strokeWeight?,
  // Auto Layout (ตั้งพร้อมสร้างได้เลย)
  layoutMode?: "NONE" | "HORIZONTAL" | "VERTICAL",
  layoutSizingHorizontal?: "FIXED" | "HUG" | "FILL",
  layoutSizingVertical?: "FIXED" | "HUG" | "FILL",
  primaryAxisAlignItems?: "MIN" | "MAX" | "CENTER" | "SPACE_BETWEEN",
  counterAxisAlignItems?: "MIN" | "MAX" | "CENTER" | "BASELINE",
  itemSpacing?,
  paddingTop?, paddingRight?, paddingBottom?, paddingLeft?,
  layoutWrap?: "NO_WRAP" | "WRAP"
})
```

**สำคัญ**: `create_frame` รองรับตั้ง auto layout + สี + parentId ในคำสั่งเดียว ไม่ต้องเรียกแยกหลายคำสั่ง

### Shapes

| Command | Parameters | Description |
|---------|-----------|-------------|
| `create_rectangle` | `x, y, width, height, name?, parentId?` | สร้างสี่เหลี่ยม |

> **หมายเหตุ**: มีเฉพาะ rectangle เท่านั้น ไม่มี ellipse, polygon, star

### Text

```
create_text({
  x, y, text,            // required
  name?,                  // ชื่อ layer
  parentId?,              // ใส่เข้า parent ได้เลย
  fontSize?: 14,          // default 14
  fontWeight?: 400 | 700, // 400=Regular, 700=Bold
  fontColor?: {r, g, b, a?}
})
```

### Duplication & Deletion

| Command | Parameters | Description |
|---------|-----------|-------------|
| `clone_node` | `nodeId, x?, y?` | สำเนา element (ตั้งตำแหน่งใหม่ได้) |
| `delete_node` | `nodeId` | ลบ element |
| `delete_multiple_nodes` | `nodeIds[]` | ลบหลาย elements พร้อมกัน |

---

## 4. Modification Tools

### Position & Size

| Command | Parameters | Description |
|---------|-----------|-------------|
| `move_node` | `nodeId, x, y` | ย้าย element |
| `resize_node` | `nodeId, width, height` | ปรับขนาด (ค่าต้อง > 0) |

### Styling

| Command | Parameters | Description |
|---------|-----------|-------------|
| `set_fill_color` | `nodeId, r, g, b, a?` | ตั้งสีพื้น (**RGBA 0-1**) ใช้ได้กับ Text และ Frame |
| `set_stroke_color` | `nodeId, r, g, b, a?, weight?` | ตั้งสีเส้นขอบ + ความหนา |
| `set_corner_radius` | `nodeId, radius, corners?` | ตั้ง corner radius, corners = `[topLeft, topRight, bottomRight, bottomLeft]` booleans |

> **ไม่มี**: `set_effects`, `set_effect_style_id`, `rename_node` — ถ้าต้องการ effects ต้องทำใน Figma โดยตรง

---

## 5. Auto Layout Tools

**สำคัญ**: ไม่มีคำสั่ง `set_auto_layout` รวมเดียว ต้องใช้แยกเป็น 5 คำสั่ง:

| Command | Parameters | Description |
|---------|-----------|-------------|
| `set_layout_mode` | `nodeId, layoutMode, layoutWrap?` | ตั้ง layout direction: NONE/HORIZONTAL/VERTICAL |
| `set_padding` | `nodeId, paddingTop?, paddingRight?, paddingBottom?, paddingLeft?` | ตั้ง padding |
| `set_axis_align` | `nodeId, primaryAxisAlignItems?, counterAxisAlignItems?` | ตั้ง alignment |
| `set_layout_sizing` | `nodeId, layoutSizingHorizontal?, layoutSizingVertical?` | ตั้ง sizing mode: FIXED/HUG/FILL |
| `set_item_spacing` | `nodeId, itemSpacing?, counterAxisSpacing?` | ตั้ง spacing ระหว่าง children |

### ทางลัด: ตั้ง Auto Layout ตอนสร้าง Frame

ใช้ `create_frame` พร้อม params ทั้งหมดได้เลย:

```
create_frame({
  name: "Card",
  x: 0, y: 0, width: 361, height: 200,
  layoutMode: "VERTICAL",
  itemSpacing: 12,
  paddingTop: 16, paddingRight: 16, paddingBottom: 16, paddingLeft: 16,
  primaryAxisAlignItems: "MIN",
  counterAxisAlignItems: "MIN",
  layoutSizingHorizontal: "FIXED",
  layoutSizingVertical: "HUG",
  fillColor: {r: 1, g: 1, b: 1}
})
```

### Alignment Values Reference

| Value | primaryAxisAlignItems | counterAxisAlignItems |
|-------|----------------------|----------------------|
| MIN | ชิดซ้าย (H) / ชิดบน (V) | ชิดบน (H) / ชิดซ้าย (V) |
| CENTER | กลาง | กลาง |
| MAX | ชิดขวา (H) / ชิดล่าง (V) | ชิดล่าง (H) / ชิดขวา (V) |
| SPACE_BETWEEN | กระจายเท่ากัน (ignores itemSpacing) | — |
| BASELINE | — | เฉพาะ counter axis, จัด baseline text |

---

## 6. Text Tools

| Command | Parameters | Description |
|---------|-----------|-------------|
| `set_text_content` | `nodeId, text` | เปลี่ยน text content |
| `set_multiple_text_contents` | `nodeId (parent), text[]` | เปลี่ยน text หลายตัวพร้อมกัน |

### set_multiple_text_contents format

```
set_multiple_text_contents({
  nodeId: "parent-id",
  text: [
    { nodeId: "text-1-id", text: "New text 1" },
    { nodeId: "text-2-id", text: "New text 2" }
  ]
})
```

> **ไม่มี**: `set_font_name`, `set_font_size`, `set_font_weight`, `set_letter_spacing`, `set_line_height`, `set_text_case`, `set_text_decoration`, `load_font_async` — ตั้งค่า font ได้ตอน `create_text` เท่านั้น (fontSize, fontWeight, fontColor) หรือแก้ใน Figma โดยตรง

---

## 7. Component Tools

| Command | Parameters | Description |
|---------|-----------|-------------|
| `get_local_components` | — | ดู components ใน file |
| `create_component_instance` | `componentKey, x, y` | สร้าง instance จาก component |
| `get_instance_overrides` | `nodeId?` | ดู overrides ของ instance (ถ้าไม่ระบุ nodeId ใช้ selection) |
| `set_instance_overrides` | `sourceInstanceId, targetNodeIds[]` | Copy overrides จาก source ไปยัง targets |

> **ไม่มี**: `get_remote_components` — ใช้ได้เฉพาะ local components

---

## 8. Annotation Tools

| Command | Parameters | Description |
|---------|-----------|-------------|
| `get_annotations` | `nodeId, includeCategories?` | ดู annotations ของ node |
| `set_annotation` | `nodeId, labelMarkdown, categoryId?, annotationId?` | สร้าง/อัปเดต annotation |
| `set_multiple_annotations` | `nodeId, annotations[]` | สร้างหลาย annotations พร้อมกัน |

### set_multiple_annotations format

```
set_multiple_annotations({
  nodeId: "parent-id",
  annotations: [
    { nodeId: "child-1", labelMarkdown: "**Button**: Primary CTA" },
    { nodeId: "child-2", labelMarkdown: "**Input**: Email field", categoryId: "form" }
  ]
})
```

---

## 9. Connector Tools

ใช้สำหรับสร้างเส้นเชื่อม (flow diagrams, prototyping visualization)

| Command | Parameters | Description |
|---------|-----------|-------------|
| `get_reactions` | `nodeIds[]` | ดู prototyping reactions ของ nodes |
| `set_default_connector` | `connectorId?` | ตั้ง connector style ที่จะใช้ |
| `create_connections` | `connections[]` | สร้างเส้นเชื่อมระหว่าง nodes |

### create_connections format

```
create_connections({
  connections: [
    { startNodeId: "btn-1", endNodeId: "screen-2", text: "On Click" },
    { startNodeId: "screen-2", endNodeId: "screen-3" }
  ]
})
```

---

## 10. Selection & Focus

| Command | Parameters | Description |
|---------|-----------|-------------|
| `set_focus` | `nodeId` | เลือก node + scroll viewport ไปหา |
| `set_selections` | `nodeIds[]` | เลือกหลาย nodes + scroll ไปแสดง |

---

## 11. Screenshot & Design Context (Figma Remote MCP)

ใช้ server `figma` (remote) — ต้องมี fileKey และ nodeId จาก URL

### แยก fileKey และ nodeId จาก URL

```
URL: https://figma.com/design/ABC123/MyFile?node-id=1-2
→ fileKey = "ABC123"
→ nodeId = "1:2"  (เปลี่ยน - เป็น :)
```

| Command | Parameters | Description |
|---------|-----------|-------------|
| `get_screenshot` | `fileKey, nodeId` | ถ่ายภาพหน้าจอของ node |
| `get_design_context` | `fileKey, nodeId` | อ่าน design + generate UI code |
| `get_metadata` | `fileKey, nodeId` | ดู structure ในรูปแบบ XML (node IDs, types, positions) |
| `get_variable_defs` | `fileKey, nodeId` | ดู design variables ที่ใช้ใน node |
| `whoami` | — | ดูข้อมูลผู้ใช้ที่ login อยู่ |

### Use Cases

- **get_screenshot**: ดู preview ของ design ที่สร้างแล้ว หรือ reference design
- **get_design_context**: อ่าน design เพื่อ generate code หรือทำความเข้าใจ design
- **get_metadata**: ดู structure ของ file เพื่อหา node IDs

---

## 12. Diagrams (Figma Remote MCP)

| Command | Parameters | Description |
|---------|-----------|-------------|
| `generate_diagram` | `name, mermaidSyntax, userIntent?` | สร้าง diagram ใน FigJam จาก Mermaid.js |

รองรับ: flowchart, sequenceDiagram, stateDiagram, gantt

---

## 13. Code Connect (Figma Remote MCP)

| Command | Parameters | Description |
|---------|-----------|-------------|
| `get_code_connect_map` | `fileKey, nodeId` | ดู mapping ระหว่าง Figma node กับ code component |
| `get_code_connect_suggestions` | `fileKey, nodeId` | ดูคำแนะนำ mapping |
| `add_code_connect_map` | `fileKey, nodeId, source, componentName, label` | เพิ่ม mapping |
| `send_code_connect_mappings` | `fileKey, nodeId, mappings[]` | ส่ง mappings หลายตัว |
| `create_design_system_rules` | — | สร้าง design system rules สำหรับ repo |

---

## 14. Import HTML to Figma (html-to-design MCP)

ใช้ server `html-to-design` (remote) — ส่ง HTML ไปสร้างเป็น Figma layers ได้โดยตรงจาก Claude

### Prerequisites

1. ติดตั้ง plugin **html.to.design** (by divRIOTS) ใน Figma
2. เปิด plugin → tab **MCP** → เปิด toggle **"Enable MCP endpoint"**
3. ตรวจว่า **STATUS: connected** (จุดเขียว) ใน plugin

### Available Tools

| Command | Parameters | Description |
|---------|-----------|-------------|
| `import_html` | `html, css?, js?, name?` | ส่ง HTML code ไปสร้างเป็น Figma layers |
| `import_url` | `url, name?` | ส่ง URL ไป import ทั้งหน้าเว็บเป็น Figma layers |

### import_html — ส่ง HTML Code

```
import_html({
  html: "<div class='card'>...</div>",
  css: ".card { display: flex; ... }",
  name: "Login Screen"
})
```

- ส่ง HTML + CSS ไปตรง → plugin แปลงเป็น Figma layers ทันที
- **ไม่ต้อง** serve file ผ่าน URL
- **ไม่ต้อง** manual copy/paste ใน plugin
- Class names จะกลายเป็น Figma layer names

### import_url — ส่ง URL

```
import_url({
  url: "http://localhost:3000/login-preview.html",
  name: "Login Screen"
})
```

- ส่ง URL ของหน้าเว็บ → plugin import ทั้งหน้า
- ต้อง serve file ก่อน (Live Server, `npx serve .`)
- เหมาะกับ HTML preview ที่ซับซ้อน (multi-page, external assets)

### Workflow: Claude → HTML → Figma

```
1. Claude สร้าง HTML preview (Step 3 ใน UI Design Spec)
2. User review ใน browser + iterate จนพอใจ
3. Claude ส่ง HTML ไป Figma ผ่าน import_html หรือ import_url
4. Plugin แปลง HTML → Figma layers อัตโนมัติ
5. User fine-tune ใน Figma (font, sizing, components)
```

### Tips

- ใช้ `import_html` เมื่อ HTML ไม่ซับซ้อนมาก (single component, single screen)
- ใช้ `import_url` เมื่อ HTML มี external assets (fonts, images) หรือหลายหน้า
- บอก "send to Figma" หรือ "send to html.to.design" ใน prompt เพื่อ trigger import
- ตรวจว่า plugin เปิด MCP endpoint อยู่ก่อน import

---

## 15. Common Patterns

### Pattern 1: สร้าง Mobile Screen (iPhone 15 Pro)

```
// สร้าง main frame พร้อม auto layout + สี ในคำสั่งเดียว
create_frame({
  name: "Login Screen",
  x: 0, y: 0, width: 393, height: 852,
  fillColor: {r: 1, g: 1, b: 1},
  layoutMode: "VERTICAL",
  paddingTop: 0, paddingRight: 16, paddingBottom: 0, paddingLeft: 16,
  primaryAxisAlignItems: "MIN",
  counterAxisAlignItems: "MIN",
  layoutSizingHorizontal: "FIXED",
  layoutSizingVertical: "FIXED",
  itemSpacing: 0
})
set_corner_radius(nodeId, 47)
```

### Pattern 2: สร้าง Text Field

```
// 1. สร้าง container พร้อม auto layout + parentId
create_frame({
  name: "Email Field",
  parentId: "screen-id",          // ใส่เข้า parent เลย
  x: 0, y: 0, width: 361, height: 50,
  fillColor: {r: 0.46, g: 0.46, b: 0.5, a: 0.12},
  layoutMode: "HORIZONTAL",
  itemSpacing: 10,
  paddingLeft: 12, paddingRight: 12, paddingTop: 0, paddingBottom: 0,
  counterAxisAlignItems: "CENTER"
})
set_corner_radius(container_id, 10)

// 2. สร้าง text ใส่เข้า container เลย
create_text({
  text: "Email address",
  x: 0, y: 0,
  fontSize: 17,
  fontColor: {r: 0.24, g: 0.24, b: 0.26, a: 0.6},
  parentId: "container-id"       // ใส่เข้า container
})
```

### Pattern 3: สร้าง Button

```
create_frame({
  name: "Log In Button",
  parentId: "screen-id",
  x: 0, y: 0, width: 361, height: 50,
  fillColor: {r: 0, g: 0.48, b: 1},
  layoutMode: "HORIZONTAL",
  primaryAxisAlignItems: "CENTER",
  counterAxisAlignItems: "CENTER"
})
set_corner_radius(button_id, 12)

create_text({
  text: "Log In",
  x: 0, y: 0,
  fontSize: 17, fontWeight: 700,
  fontColor: {r: 1, g: 1, b: 1},
  parentId: "button-id"
})
```

### Pattern 4: สร้าง Card

```
create_frame({
  name: "Notification Card",
  parentId: "screen-id",
  x: 0, y: 0, width: 361, height: 120,
  fillColor: {r: 1, g: 1, b: 1},
  strokeColor: {r: 0.89, g: 0.89, b: 0.91},
  strokeWeight: 1,
  layoutMode: "VERTICAL",
  itemSpacing: 8,
  paddingTop: 16, paddingRight: 16, paddingBottom: 16, paddingLeft: 16,
  layoutSizingVertical: "HUG"
})
set_corner_radius(card_id, 12)
```

### Pattern 5: Batch Text Update

```
// หา text nodes ก่อน
scan_text_nodes(parentNodeId)

// แก้ทีเดียวหลายตัว
set_multiple_text_contents({
  nodeId: "parent-id",
  text: [
    { nodeId: "title-id", text: "New Title" },
    { nodeId: "subtitle-id", text: "New Subtitle" },
    { nodeId: "body-id", text: "New body text here" }
  ]
})
```

### Pattern 6: Clone & Modify (สร้าง Variants)

```
// Clone element
clone_node(nodeId: "original-card", x: 420, y: 0)

// แก้ไข clone
set_fill_color(clone_id, r: 0.95, g: 0.95, b: 0.97)
scan_text_nodes(clone_id)
set_text_content(text_id, "Variant B")
```

### Pattern 7: Read Existing Design

```
// ดูว่ามีอะไรอยู่แล้ว
get_document_info()

// อ่าน design ที่เลือก
read_my_design()

// หรืออ่านจาก Figma Remote (ต้องมี fileKey + nodeId)
get_screenshot(fileKey, nodeId)
get_design_context(fileKey, nodeId)
```

---

## 16. Color Conversion

Figma MCP ใช้ค่าสี RGBA แบบ **0-1** (ไม่ใช้ 0-255)

### Hex to Figma RGBA Formula

```
r = parseInt(hex.slice(1,3), 16) / 255
g = parseInt(hex.slice(3,5), 16) / 255
b = parseInt(hex.slice(5,7), 16) / 255
```

### Common Colors

| Color | Hex | Figma RGBA |
|-------|-----|------------|
| systemBlue (light) | #007AFF | r=0, g=0.478, b=1 |
| systemRed (light) | #FF3B30 | r=1, g=0.231, b=0.188 |
| systemGreen (light) | #34C759 | r=0.204, g=0.78, b=0.349 |
| Black | #000000 | r=0, g=0, b=0 |
| White | #FFFFFF | r=1, g=1, b=1 |
| M3 Primary | #6750A4 | r=0.404, g=0.314, b=0.643 |
| M3 Surface | #FFFBFE | r=1, g=0.984, b=0.996 |
| Gray 100 | #F5F5F5 | r=0.961, g=0.961, b=0.961 |
| Gray 300 | #E0E0E0 | r=0.878, g=0.878, b=0.878 |
| Gray 600 | #757575 | r=0.459, g=0.459, b=0.459 |
| Gray 900 | #212121 | r=0.129, g=0.129, b=0.129 |

---

## 17. Smart Frame Positioning (ป้องกัน Frame ทับกัน)

**สำคัญ**: ก่อนสร้าง frame ใหม่ ต้องสแกนตำแหน่ง frame เดิมก่อนเสมอ

### Pattern: Scan Before Create

```
// ขั้นตอนที่ 1: สแกน document เพื่อดู frame ที่มีอยู่แล้ว
get_document_info()

// ขั้นตอนที่ 2: ดูรายละเอียด position/size ของ frame ที่อยู่ใน page
get_nodes_info(nodeIds: ["frame-1-id", "frame-2-id", ...])

// ขั้นตอนที่ 3: คำนวณตำแหน่งใหม่ที่ไม่ทับ
// - หา maxX = max(frame.x + frame.width) ของทุก frame
// - วาง frame ใหม่ที่ x = maxX + GAP
```

### การคำนวณตำแหน่งว่าง

```
GAP = 100  // ระยะห่างระหว่าง frames (px)

// หา bounding box ของทุก frame ที่มีอยู่
existingFrames = get_document_info().children.filter(type == "FRAME" | "SECTION")
nodesInfo = get_nodes_info(existingFrames.map(id))

// คำนวณตำแหน่งถัดไป (วางทางขวา)
maxX = 0
for each frame in nodesInfo:
  rightEdge = frame.x + frame.width
  if rightEdge > maxX:
    maxX = rightEdge

newFrameX = maxX + GAP
newFrameY = 0  // เริ่มที่ y=0 เสมอ (หรือ align กับ frame แรก)
```

### ตัวอย่างการใช้งานจริง

```
// 1. สแกนก่อน
docInfo = get_document_info()
// → เจอ Frame A ที่ x=0, w=393 / Frame B ที่ x=493, w=393

// 2. ดู details
nodesInfo = get_nodes_info(["frame-a-id", "frame-b-id"])
// → Frame A: x=0, y=0, w=393, h=852
// → Frame B: x=493, y=0, w=393, h=852

// 3. คำนวณ
// maxX = 493 + 393 = 886
// newX = 886 + 100 = 986

// 4. สร้าง frame ใหม่ที่ไม่ทับ
create_frame({ x: 986, y: 0, width: 393, height: 852, ... })
```

### Layout Strategies

| Strategy | เมื่อไหร่ใช้ | วิธีคำนวณ |
|----------|------------|----------|
| **วางขวา** | Default - เรียงแนวนอน | `x = maxX + GAP` |
| **วางล่าง** | เรียงแนวตั้ง | `y = maxY + GAP` |
| **Grid** | หลาย frame (เช่น responsive) | ทุก 3 frame ขึ้นแถวใหม่ |

### Grid Layout สำหรับ Responsive Design

```
COLS = 3          // จำนวน columns
GAP = 100         // ระยะห่าง
FRAME_WIDTH = 393 // ความกว้าง frame

for i in range(totalFrames):
  col = i % COLS
  row = i // COLS  (integer division)
  x = startX + col * (FRAME_WIDTH + GAP)
  y = startY + row * (FRAME_HEIGHT + GAP)
```

---

## 18. Icon Placeholder Pattern (ใช้ FontAwesome)

เนื่องจาก MCP ไม่สามารถสร้าง vector icon ได้ ให้ใช้ text placeholder แทน

### วิธีใช้

```
// ใช้ Unicode placeholder + ตั้งชื่อ layer เป็น FA icon name
create_text({
  text: "📅",              // placeholder emoji/symbol
  name: "icon/fa-calendar", // ชื่อ layer = FA icon name
  fontSize: 20,
  fontColor: {r: 0.42, g: 0.447, b: 0.502},
  parentId: "container-id"
})
```

### Naming Convention
- Format: `icon/fa-{icon-name}`
- Dev จะ map → `<FontAwesomeIcon icon="fa-{name}" />`
- ดูรายละเอียด icon ทั้งหมดที่ `references/fontawesome-icons.md`

---

## 19. Exact Color Conversion (Hex → Figma RGBA)

**กฎสำคัญ**: ใช้ทศนิยม **อย่างน้อย 3 ตำแหน่ง** เสมอ — ห้ามปัดเศษเหลือ 2 ตำแหน่ง

### สูตร Exact

```
r = Math.round((parseInt(hex.slice(1,3), 16) / 255) * 1000) / 1000
g = Math.round((parseInt(hex.slice(3,5), 16) / 255) * 1000) / 1000
b = Math.round((parseInt(hex.slice(5,7), 16) / 255) * 1000) / 1000
```

### Pre-computed Design Token Colors (Exact)

#### Primary & Secondary
| Token | Hex | r | g | b |
|-------|-----|---|---|---|
| semantic/primary/fg/high | #EC599D | 0.925 | 0.349 | 0.616 |
| semantic/primary/fg/low | #F3E2EA | 0.953 | 0.886 | 0.918 |
| semantic/primary/bg/lowest | #FDEFF5 | 0.992 | 0.937 | 0.961 |
| semantic/primary/bg/mid | #EC599D | 0.925 | 0.349 | 0.616 |
| semantic/primary/border/mid | #F7BDD8 | 0.969 | 0.741 | 0.847 |
| semantic/secondary/fg/high | #7279FB | 0.447 | 0.475 | 0.984 |
| semantic/secondary/bg/mid | #7279FB | 0.447 | 0.475 | 0.984 |
| semantic/secondary/border/mid | #C7C9FD | 0.780 | 0.788 | 0.992 |

#### Gray-Neutral
| Token | Hex | r | g | b |
|-------|-----|---|---|---|
| semantic/gray-neutral/fg/high | #1B1D22 | 0.106 | 0.114 | 0.133 |
| semantic/gray-neutral/fg/mid-on-gray | #3F414E | 0.247 | 0.255 | 0.306 |
| semantic/gray-neutral/fg/mid-on-white | #6A6E83 | 0.416 | 0.431 | 0.514 |
| semantic/gray-neutral/fg/low-on-white | #9A9DAD | 0.604 | 0.616 | 0.678 |
| semantic/gray-neutral/bg/lightgray | #F8F8F9 | 0.973 | 0.973 | 0.976 |
| semantic/gray-neutral/bg/midgray | #EBECEF | 0.922 | 0.925 | 0.937 |
| semantic/gray-neutral/bg/darkgray | #CFD1D9 | 0.812 | 0.820 | 0.851 |

#### Semantic Status
| Token | Hex | r | g | b |
|-------|-----|---|---|---|
| semantic/error/fg/high | #EA244F | 0.918 | 0.141 | 0.310 |
| semantic/error/bg/high | #BB1D3F | 0.733 | 0.114 | 0.247 |
| semantic/warning/fg/high | #C69A2A | 0.776 | 0.604 | 0.165 |
| semantic/warning/bg/high | #F8C135 | 0.973 | 0.757 | 0.208 |
| semantic/success/fg/high | #559652 | 0.333 | 0.588 | 0.322 |
| semantic/success/bg/high | #559652 | 0.333 | 0.588 | 0.322 |
| semantic/info/fg/high | #026486 | 0.008 | 0.392 | 0.525 |
| semantic/info/bg/high | #0386B3 | 0.012 | 0.525 | 0.702 |

#### System Colors (iOS)
| Color | Hex | r | g | b |
|-------|-----|---|---|---|
| systemBlue | #007AFF | 0.000 | 0.478 | 1.000 |
| systemRed | #FF3B30 | 1.000 | 0.231 | 0.188 |
| systemGreen | #34C759 | 0.204 | 0.780 | 0.349 |
| systemOrange | #FF9500 | 1.000 | 0.584 | 0.000 |
| systemYellow | #FFCC00 | 1.000 | 0.800 | 0.000 |
| systemIndigo | #5856D6 | 0.345 | 0.337 | 0.839 |
| systemTeal | #5AC8FA | 0.353 | 0.784 | 0.980 |
| label | #000000 | 0.000 | 0.000 | 0.000 |
| secondaryLabel | #3C3C43 | 0.235 | 0.235 | 0.263 |
| tertiaryLabel | #3C3C43 | 0.235 | 0.235 | 0.263 |
| quaternaryLabel | #3C3C43 | 0.235 | 0.235 | 0.263 |
| placeholderText | #3C3C43 | 0.235 | 0.235 | 0.263 |
| separator | #3C3C43 | 0.235 | 0.235 | 0.263 |
| systemGray | #8E8E93 | 0.557 | 0.557 | 0.576 |
| systemGray2 | #AEAEB2 | 0.682 | 0.682 | 0.698 |
| systemGray3 | #C7C7CC | 0.780 | 0.780 | 0.800 |
| systemGray4 | #D1D1D6 | 0.820 | 0.820 | 0.839 |
| systemGray5 | #E5E5EA | 0.898 | 0.898 | 0.918 |
| systemGray6 | #F2F2F7 | 0.949 | 0.949 | 0.969 |

#### Material Design 3
| Color | Hex | r | g | b |
|-------|-----|---|---|---|
| M3 Primary | #6750A4 | 0.404 | 0.314 | 0.643 |
| M3 OnPrimary | #FFFFFF | 1.000 | 1.000 | 1.000 |
| M3 PrimaryContainer | #EADDFF | 0.918 | 0.867 | 1.000 |
| M3 Secondary | #625B71 | 0.384 | 0.357 | 0.443 |
| M3 Surface | #FFFBFE | 1.000 | 0.984 | 0.996 |
| M3 SurfaceVariant | #E7E0EC | 0.906 | 0.878 | 0.925 |
| M3 Error | #B3261E | 0.702 | 0.149 | 0.118 |

#### Common Grays
| Color | Hex | r | g | b |
|-------|-----|---|---|---|
| Gray 50 | #FAFAFA | 0.980 | 0.980 | 0.980 |
| Gray 100 | #F5F5F5 | 0.961 | 0.961 | 0.961 |
| Gray 200 | #EEEEEE | 0.933 | 0.933 | 0.933 |
| Gray 300 | #E0E0E0 | 0.878 | 0.878 | 0.878 |
| Gray 400 | #BDBDBD | 0.741 | 0.741 | 0.741 |
| Gray 500 | #9E9E9E | 0.620 | 0.620 | 0.620 |
| Gray 600 | #757575 | 0.459 | 0.459 | 0.459 |
| Gray 700 | #616161 | 0.380 | 0.380 | 0.380 |
| Gray 800 | #424242 | 0.259 | 0.259 | 0.259 |
| Gray 900 | #212121 | 0.129 | 0.129 | 0.129 |

> **สำคัญ**: ถ้าสีที่ต้องการไม่อยู่ใน table นี้ ให้คำนวณจากสูตรด้านบน — **ห้ามประมาณค่าเอง**

### ตัวอย่างสีที่คำนวณผิดบ่อย

| ❌ ค่าปัดเศษ (ผิด) | ✅ ค่า Exact (ถูก) | ผลต่าง |
|---------------------|--------------------|---------|
| `#007AFF → g=0.48` | `g=0.478` | สีเขียวเพี้ยน |
| `#EC599D → r=0.93` | `r=0.925` | สี Primary เพี้ยน |
| `#7279FB → g=0.48` | `g=0.475` | สี Secondary เพี้ยน |
| `#6A6E83 → g=0.43` | `g=0.431` | สีเทาเพี้ยน |

### Alpha Handling

- `opacity: 0.6` ใน CSS → ใช้ `a: 0.6` ใน Figma RGBA
- iOS `tertiaryLabel` มี opacity 30% → `fontColor: {r: 0.235, g: 0.235, b: 0.263, a: 0.3}`
- `rgba(60,60,67,0.6)` → `{r: 0.235, g: 0.235, b: 0.263, a: 0.6}`

---

## 20. CSS-to-Figma Mapping Table

เมื่อแปลง React preview (.jsx) เป็น Figma MCP commands ใช้ตารางนี้:

### Layout Direction

| CSS | Figma Parameter |
|-----|----------------|
| `display: flex; flex-direction: row` | `layoutMode: "HORIZONTAL"` |
| `display: flex; flex-direction: column` | `layoutMode: "VERTICAL"` |
| `display: block` (default) | `layoutMode: "NONE"` |

### Spacing

| CSS | Figma Parameter |
|-----|----------------|
| `gap: 12px` | `itemSpacing: 12` |
| `row-gap` + `column-gap` (wrap) | `itemSpacing` + `counterAxisSpacing` |
| `padding: 16px` | `paddingTop: 16, paddingRight: 16, paddingBottom: 16, paddingLeft: 16` |
| `padding: 12px 16px` | `paddingTop: 12, paddingRight: 16, paddingBottom: 12, paddingLeft: 16` |
| `padding: 8px 16px 12px 16px` | `paddingTop: 8, paddingRight: 16, paddingBottom: 12, paddingLeft: 16` |

### Sizing

| CSS | Figma Parameter | หมายเหตุ |
|-----|----------------|----------|
| `width: 393px` | `width: 393, layoutSizingHorizontal: "FIXED"` | ขนาดคงที่ |
| `height: 852px` | `height: 852, layoutSizingVertical: "FIXED"` | ขนาดคงที่ |
| `width: 100%` | `layoutSizingHorizontal: "FILL"` | ยืดเต็ม parent (ใช้ได้เฉพาะ child ของ auto-layout) |
| `height: auto` / `height: fit-content` | `layoutSizingVertical: "HUG"` | ขนาดตาม content |
| `width: fit-content` | `layoutSizingHorizontal: "HUG"` | ขนาดตาม content |
| `flex: 1` | `layoutSizingHorizontal: "FILL"` หรือ `layoutSizingVertical: "FILL"` | ขยายเต็มพื้นที่ว่าง |

### Alignment

| CSS | Figma primaryAxisAlignItems | ทิศทาง |
|-----|---------------------------|--------|
| `justify-content: flex-start` | `"MIN"` | ชิดซ้าย (H) / ชิดบน (V) |
| `justify-content: center` | `"CENTER"` | กลาง |
| `justify-content: flex-end` | `"MAX"` | ชิดขวา (H) / ชิดล่าง (V) |
| `justify-content: space-between` | `"SPACE_BETWEEN"` | กระจายเท่ากัน |

| CSS | Figma counterAxisAlignItems | ทิศทาง |
|-----|---------------------------|--------|
| `align-items: flex-start` | `"MIN"` | ชิดบน (H) / ชิดซ้าย (V) |
| `align-items: center` | `"CENTER"` | กลาง |
| `align-items: flex-end` | `"MAX"` | ชิดล่าง (H) / ชิดขวา (V) |
| `align-items: baseline` | `"BASELINE"` | baseline ของ text |

### Wrap

| CSS | Figma Parameter |
|-----|----------------|
| `flex-wrap: nowrap` | `layoutWrap: "NO_WRAP"` |
| `flex-wrap: wrap` | `layoutWrap: "WRAP"` |

### Gotchas: CSS ≠ Figma

| CSS Behavior | Figma Behavior | วิธีแก้ |
|-------------|----------------|---------|
| `margin` สร้าง space รอบ element | ไม่มี margin — ใช้ `itemSpacing` ของ parent | ตั้ง `itemSpacing` ที่ parent frame |
| `margin: auto` จัดกลาง | ไม่มี — ใช้ alignment | ตั้ง `primaryAxisAlignItems: "CENTER"` |
| Margin collapse (vertical) | ไม่มี concept นี้ | spacing จะรวมกันไม่ collapse |
| `box-sizing: border-box` | Figma ทำ border-box เสมอ | ไม่ต้องทำอะไร |
| `overflow: hidden` | Figma clip content อยู่แล้ว | ไม่ต้องทำอะไร |
| `position: absolute` | ใช้ `layoutMode: "NONE"` + กำหนด x, y ตรงๆ | วาง element ใน frame ที่ไม่มี auto-layout |
| `border: 1px solid #ccc` | `strokeColor + strokeWeight` | ใช้ `strokeColor` + `strokeWeight` |
| `border-radius: 12px` | `set_corner_radius(nodeId, 12)` | เรียกหลัง create |
| `background-color: #F5F5F5` | `fillColor: {r: 0.961, g: 0.961, b: 0.961}` | ใส่ตอน create_frame |
| `color: #333` (text color) | `fontColor: {r: 0.2, g: 0.2, b: 0.2}` | ใส่ตอน create_text |
| Text `font-size: 17px` | `fontSize: 17` | ใส่ตอน create_text |
| Text `font-weight: bold` / `700` | `fontWeight: 700` | ใส่ตอน create_text |

---

## 21. Post-Creation Verification Pattern

หลังสร้าง UI ใน Figma ทุกครั้ง **ต้อง verify** ว่าผลลัพธ์ตรงกับ spec

### Pattern: Verify Main Frame

```
// หลังสร้าง main screen frame
frameInfo = get_node_info(mainFrameId)

// ตรวจ dimensions
if frameInfo.width != expectedWidth || frameInfo.height != expectedHeight:
  resize_node(mainFrameId, expectedWidth, expectedHeight)

// ตรวจ fill color (เทียบค่า RGBA)
if frameInfo.fills[0].color != expectedColor:
  set_fill_color(mainFrameId, r, g, b)
```

### Pattern: Verify Children

```
// หลังสร้าง children ทั้งหมด
childIds = [child1Id, child2Id, ...]
childrenInfo = get_nodes_info(childIds)

for each child in childrenInfo:
  // ตรวจ size
  if |child.width - expectedWidth| > 2:
    resize_node(child.id, expectedWidth, expectedHeight)

  // ตรวจ color
  if child.fills && child.fills[0].color != expectedColor:
    set_fill_color(child.id, r, g, b)
```

### Tolerance

- **Dimensions**: ±1px (auto-layout อาจปัดเศษ sub-pixel)
- **Colors**: ค่า RGBA ต้องตรงกัน (ใช้ exact conversion จาก Section 18)
- **Spacing**: ตรวจ itemSpacing ผ่าน parent frame info

### When to Verify

| จังหวะ | ทำอะไร |
|--------|--------|
| หลังสร้าง main frame | `get_node_info()` → ตรวจ w, h, fill |
| หลังสร้าง children ทั้งหมด | `get_nodes_info()` → ตรวจ w, h ของแต่ละ child |
| หลังตั้ง auto-layout | `get_node_info()` → ตรวจว่า frame ไม่ resize ผิด |
| สุดท้ายก่อนบอกผู้ใช้ | `get_node_info(mainFrame)` → snapshot สุดท้าย |

---

## 22. Font Handling (ข้อจำกัดและวิธีรับมือ)

### MCP ทำได้เฉพาะตอน `create_text`

| Parameter | ทำได้ | ตัวอย่าง |
|-----------|-------|---------|
| `fontSize` | ✅ ตั้งตอนสร้าง | `fontSize: 17` |
| `fontWeight` | ✅ ตั้งตอนสร้าง | `fontWeight: 700` (รองรับ 400, 700) |
| `fontColor` | ✅ ตั้งตอนสร้าง | `fontColor: {r: 0, g: 0, b: 0}` |
| `fontFamily` | ❌ ไม่มี | Figma ใช้ default font (มักเป็น Inter) |
| `lineHeight` | ❌ ไม่มี | ต้องแก้ใน Figma |
| `letterSpacing` | ❌ ไม่มี | ต้องแก้ใน Figma |
| `textDecoration` | ❌ ไม่มี | ต้องแก้ใน Figma |
| `textCase` | ❌ ไม่มี | ต้องแก้ใน Figma |

### แก้ไขหลังสร้าง

| Parameter | แก้ไขได้ | วิธี |
|-----------|---------|------|
| text content | ✅ | `set_text_content(nodeId, text)` |
| fill color (text bg) | ✅ | `set_fill_color(nodeId, r, g, b)` |
| fontSize | ❌ หลังสร้าง | ต้องลบแล้วสร้างใหม่ หรือแก้ใน Figma |
| fontWeight | ❌ หลังสร้าง | ต้องลบแล้วสร้างใหม่ หรือแก้ใน Figma |
| fontColor | ❌ หลังสร้าง | ต้องลบแล้วสร้างใหม่ หรือแก้ใน Figma |

### CSS fontWeight → Figma Mapping

MCP รองรับเฉพาะ `400` (Regular) และ `700` (Bold):

| CSS font-weight | ค่า | Figma fontWeight | หมายเหตุ |
|----------------|-----|-----------------|----------|
| `100` (Thin) | 100 | `400` | ปัดเป็น Regular |
| `200` (ExtraLight) | 200 | `400` | ปัดเป็น Regular |
| `300` (Light) | 300 | `400` | ปัดเป็น Regular |
| `normal` / `400` (Regular) | 400 | `400` | ตรง |
| `500` (Medium) | 500 | `400` | ปัดเป็น Regular (ใกล้กว่า) |
| `600` (SemiBold) | 600 | `700` | ปัดเป็น Bold |
| `bold` / `700` (Bold) | 700 | `700` | ตรง |
| `800` (ExtraBold) | 800 | `700` | ปัดเป็น Bold |
| `900` (Black) | 900 | `700` | ปัดเป็น Bold |

### ขั้นตอนหลังสร้าง text ทั้งหมดเสร็จ

บอกผู้ใช้:
> "Text ถูกสร้างด้วย fontSize และ fontWeight ที่ถูกต้องแล้ว แต่ **font family** อาจไม่ตรงกับ preview (Figma ใช้ default font)
> หากต้องการเปลี่ยน font family:
> 1. เลือก text ทั้งหมดใน Figma (Cmd+A ภายใน frame)
> 2. เปลี่ยน font ใน Properties panel ทางขวา
> 3. สำหรับ iOS → ใช้ SF Pro
> 4. สำหรับ Android → ใช้ Roboto
> 5. สำหรับ Custom → ใช้ font ตาม brand guidelines"

---

## สิ่งที่ไม่มีใน MCP (ต้องทำใน Figma โดยตรง)

- สร้าง Ellipse, Polygon, Star
- สร้าง/ลบ/เปลี่ยนชื่อ Page
- Group/Ungroup nodes
- เปลี่ยน font family/style หลังสร้าง text แล้ว
- ตั้ง effects (shadow, blur)
- ตั้ง text decoration (underline, strikethrough)
- ตั้ง line height, letter spacing, paragraph spacing
- Rename node
- Get remote components (team library)

---

## 23. HTML to Figma — Best Practices

ส่ง HTML ไป Figma ผ่าน **html-to-design MCP** (ดู Section 14) หรือ manual import ผ่าน plugin

### Plugin: html.to.design (by divRIOTS)

- **MCP (แนะนำ)**: เชื่อม html-to-design MCP → ใช้ `import_html` / `import_url` ส่งตรงจาก Claude (ดู Section 14)
- **Manual**: Figma → Plugins → html.to.design → ใส่ URL ของ HTML page → Import
- ถ้าใช้ manual ต้องเปิด HTML ผ่าน URL (Live Server หรือ `npx serve .`)

### HTML Best Practices สำหรับ Import

เพื่อให้ผลลัพธ์ใน Figma ดีที่สุด ให้เขียน HTML/CSS ตามกฎเหล่านี้:

#### CSS → Figma Mapping

| HTML/CSS | Figma Result | หมายเหตุ |
|----------|-------------|----------|
| `display: flex` | Auto Layout | — |
| `flex-direction: column` | Vertical Auto Layout | — |
| `flex-direction: row` | Horizontal Auto Layout | — |
| `gap: 16px` | Item Spacing = 16 | — |
| `padding: 16px` | Padding = 16 (all sides) | — |
| `padding: 12px 16px` | paddingTop/Bottom = 12, Left/Right = 16 | — |
| `border-radius: 12px` | Corner Radius = 12 | — |
| `width: 100%` (flex child) | layoutSizingHorizontal = FILL | เฉพาะ child ของ flex |
| `width: 200px` | Fixed Width = 200 | — |
| `background-color: #EC599D` | Fill Color | — |
| `color: #1B1D22` | Text Color | — |
| `font-size: 16px` | Font Size = 16 | — |
| `font-weight: 700` | Font Weight = Bold | — |
| `box-shadow` | Effect > Drop Shadow | บาง plugin รองรับ |

#### Class Names → Layer Names

Plugin จะใช้ class name เป็น layer name ใน Figma:

```html
<!-- ✅ ดี — layer name มีความหมาย -->
<div class="login-form">
  <input class="email-field" />
  <button class="login-button">เข้าสู่ระบบ</button>
</div>

<!-- ❌ ไม่ดี — layer name ไม่มีความหมาย -->
<div class="flex-col p-4">
  <input class="w-full" />
  <button class="bg-pink-500">เข้าสู่ระบบ</button>
</div>
```

#### สิ่งที่ควรทำ

- ใช้ **flexbox/grid** (ไม่ใช้ absolute position) → Auto Layout
- ใช้ **CSS Variables** สำหรับ colors → ง่ายต่อการปรับ
- ตั้ง **class names** ให้มีความหมาย → Figma layer names ที่อ่านได้
- ใช้ **semantic HTML** (`<header>`, `<main>`, `<section>`) → clean hierarchy
- ใช้ **Google Fonts** → font จะถูก map (อาจต้องปรับใน Figma)
- ใช้ **inline SVG** สำหรับ icons → จะกลายเป็น vector ใน Figma

#### สิ่งที่ควรหลีกเลี่ยง

- **absolute/fixed position** → จะไม่ได้ Auto Layout
- **Tailwind/Bootstrap class names** → layer names ไม่มีความหมาย
- **Complex CSS animations** → ไม่รองรับใน Figma
- **External images via URL** → อาจโหลดไม่ได้ ใช้ inline SVG หรือ base64 แทน
- **Nested flex ลึกเกินไป** → Figma layer hierarchy จะซับซ้อน

### หลัง Import — สิ่งที่ต้องปรับใน Figma

1. **Font**: อาจต้องเปลี่ยนเป็น font ที่ต้องการ (LINE Seed Sans TH, SF Pro, Roboto)
2. **Sizing mode**: ตรวจ FILL/HUG/FIXED ให้ถูกต้อง
3. **Layer names**: ปรับ rename ถ้าต้องการ
4. **Components**: แปลง repeated elements เป็น Figma components
5. **Styles**: สร้าง color styles / text styles จาก imported values
