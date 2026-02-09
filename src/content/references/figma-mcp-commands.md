# Figma MCP Commands Reference

คู่มือ commands ทั้งหมดที่ใช้ได้จริงสำหรับทำงานกับ Figma ผ่าน MCP Servers 2 ตัว

---

## MCP Servers ที่ใช้

| Server | ประเภท | หน้าที่หลัก |
|--------|--------|------------|
| **TalkToFigma** (stdio) | Local Plugin | สร้าง/แก้ไข/ลบ elements ใน Figma โดยตรง |
| **figma** (remote) | Figma API | อ่าน design, screenshot, generate code, diagrams |

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

### Patterns
14. [Common Patterns](#14-common-patterns)
15. [Color Conversion](#15-color-conversion)

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

## 14. Common Patterns

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

## 15. Color Conversion

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

## 16. Smart Frame Positioning (ป้องกัน Frame ทับกัน)

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

## 17. Icon Placeholder Pattern (ใช้ FontAwesome)

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
