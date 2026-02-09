# FontAwesome Icons Reference for Figma MCP

เนื่องจาก MCP ไม่สามารถสร้าง vector icon ได้โดยตรง ให้ใช้ **text placeholder** แทน
แล้ว dev จะแปลงเป็น FontAwesome component ตอน implement จริง

---

## วิธีใช้ Icon ใน Figma MCP

### Pattern: Icon Placeholder
```
create_text({
  text: "⬜",           // placeholder character
  name: "icon/fa-home", // ใช้ชื่อ layer เป็น FA icon name
  fontSize: 20,
  fontColor: {r, g, b},
  parentId: "container-id"
})
```

### ข้อตกลง Naming Convention
- Layer name: `icon/fa-{icon-name}`
- ตัวอย่าง: `icon/fa-calendar`, `icon/fa-user`, `icon/fa-bell`
- Dev จะ map ชื่อ layer → `<FontAwesomeIcon icon="fa-{name}" />`

---

## Icon Categories & Common Icons

### Navigation
| Icon Name | Placeholder | Usage |
|-----------|------------|-------|
| `fa-home` | `⌂` | Home/หน้าแรก |
| `fa-arrow-left` | `←` | Back/ย้อนกลับ |
| `fa-arrow-right` | `→` | Forward/ไปต่อ |
| `fa-bars` | `☰` | Menu/เมนู |
| `fa-xmark` | `✕` | Close/ปิด |
| `fa-chevron-down` | `▾` | Dropdown |
| `fa-chevron-right` | `▸` | Expand/ขยาย |
| `fa-ellipsis` | `⋯` | More options |
| `fa-ellipsis-vertical` | `⋮` | More options (vertical) |

### Actions
| Icon Name | Placeholder | Usage |
|-----------|------------|-------|
| `fa-plus` | `+` | Add/เพิ่ม |
| `fa-minus` | `−` | Remove/ลบ |
| `fa-pen` | `✎` | Edit/แก้ไข |
| `fa-trash` | `🗑` | Delete/ลบ |
| `fa-magnifying-glass` | `⌕` | Search/ค้นหา |
| `fa-filter` | `▿` | Filter/กรอง |
| `fa-sort` | `⇅` | Sort/เรียง |
| `fa-share` | `↗` | Share/แชร์ |
| `fa-download` | `↓` | Download |
| `fa-upload` | `↑` | Upload |
| `fa-copy` | `⧉` | Copy/คัดลอก |
| `fa-check` | `✓` | Confirm/ยืนยัน |

### User & Account
| Icon Name | Placeholder | Usage |
|-----------|------------|-------|
| `fa-user` | `👤` | User/ผู้ใช้ |
| `fa-user-plus` | `👤+` | Add user |
| `fa-users` | `👥` | Group/กลุ่ม |
| `fa-circle-user` | `◉` | Avatar/รูปโปรไฟล์ |
| `fa-gear` | `⚙` | Settings/ตั้งค่า |
| `fa-right-from-bracket` | `⎋` | Logout/ออกจากระบบ |
| `fa-lock` | `🔒` | Password/รหัสผ่าน |
| `fa-key` | `🔑` | Authentication |

### Communication
| Icon Name | Placeholder | Usage |
|-----------|------------|-------|
| `fa-bell` | `🔔` | Notification/แจ้งเตือน |
| `fa-envelope` | `✉` | Email/อีเมล |
| `fa-comment` | `💬` | Chat/แชท |
| `fa-phone` | `📞` | Call/โทร |
| `fa-paper-plane` | `➤` | Send/ส่ง |

### Content & Media
| Icon Name | Placeholder | Usage |
|-----------|------------|-------|
| `fa-image` | `🖼` | Image/รูปภาพ |
| `fa-camera` | `📷` | Camera/กล้อง |
| `fa-file` | `📄` | File/ไฟล์ |
| `fa-folder` | `📁` | Folder/โฟลเดอร์ |
| `fa-link` | `🔗` | Link/ลิงก์ |
| `fa-video` | `🎥` | Video/วิดีโอ |

### Calendar & Time
| Icon Name | Placeholder | Usage |
|-----------|------------|-------|
| `fa-calendar` | `📅` | Calendar/ปฏิทิน |
| `fa-calendar-days` | `📆` | Calendar view |
| `fa-clock` | `🕐` | Time/เวลา |
| `fa-stopwatch` | `⏱` | Timer/จับเวลา |

### Status & Feedback
| Icon Name | Placeholder | Usage |
|-----------|------------|-------|
| `fa-circle-check` | `✅` | Success/สำเร็จ |
| `fa-circle-xmark` | `❌` | Error/ผิดพลาด |
| `fa-circle-exclamation` | `⚠` | Warning/เตือน |
| `fa-circle-info` | `ℹ` | Info/ข้อมูล |
| `fa-spinner` | `◌` | Loading |
| `fa-star` | `★` | Favorite/ชอบ |
| `fa-heart` | `♥` | Like/ถูกใจ |
| `fa-thumbs-up` | `👍` | Approve |

### E-Commerce
| Icon Name | Placeholder | Usage |
|-----------|------------|-------|
| `fa-cart-shopping` | `🛒` | Cart/ตะกร้า |
| `fa-bag-shopping` | `🛍` | Shopping bag |
| `fa-credit-card` | `💳` | Payment/ชำระเงิน |
| `fa-receipt` | `🧾` | Receipt/ใบเสร็จ |
| `fa-tag` | `🏷` | Tag/ป้าย |
| `fa-percent` | `%` | Discount/ส่วนลด |

### Map & Location
| Icon Name | Placeholder | Usage |
|-----------|------------|-------|
| `fa-location-dot` | `📍` | Location/ตำแหน่ง |
| `fa-map` | `🗺` | Map/แผนที่ |
| `fa-compass` | `🧭` | Direction/ทิศทาง |
| `fa-route` | `🛣` | Route/เส้นทาง |

### Social
| Icon Name | Placeholder | Usage |
|-----------|------------|-------|
| `fa-brands fa-facebook` | `f` | Facebook |
| `fa-brands fa-google` | `G` | Google |
| `fa-brands fa-apple` | `` | Apple |
| `fa-brands fa-line` | `L` | LINE |
| `fa-brands fa-github` | `⌥` | GitHub |

---

## Size Mapping

| Token | Size | FA class |
|-------|------|----------|
| `icon.xs` | 12px | `fa-xs` |
| `icon.sm` | 16px | `fa-sm` |
| `icon.md` | 20px | — (default) |
| `icon.lg` | 24px | `fa-lg` |
| `icon.xl` | 32px | `fa-xl` |
| `icon.2xl` | 48px | `fa-2xl` |

---

## Install FontAwesome (for Dev)

### React
```bash
npm install @fortawesome/fontawesome-svg-core @fortawesome/free-solid-svg-icons @fortawesome/react-fontawesome
```

### CDN
```html
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" />
```

### Usage in React
```jsx
import { FontAwesomeIcon } from '@fortawesome/react-fontawesome'
import { faCalendar, faUser, faBell } from '@fortawesome/free-solid-svg-icons'

<FontAwesomeIcon icon={faCalendar} size="lg" color="#7C5CFC" />
```
