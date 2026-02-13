---
name: html-presentation-slide
description: "สร้าง HTML Presentation Slide (16:9) แบบ self-contained พร้อม Navigation ครบชุด ใช้สำหรับ Weekly Update, Sprint Review, Project Demo หรือ Presentation ใดๆ ใช้ skill นี้เมื่อผู้ใช้ต้องการ: สร้าง slide, ทำ presentation, weekly update slide, sprint review deck, สร้าง deck, project presentation, หรือเมื่อพิมพ์ 'slide', 'presentation', 'deck', 'weekly update', 'sprint review', 'present'"
---

# HTML Presentation Slide Skill

สร้างไฟล์ `.html` self-contained เปิดใน browser ได้ทันที เป็น Presentation Slide 16:9 พร้อม Navigation ครบชุด

---

## Overall Flow

```
1. Requirements → 2. Read Design Tokens → 3. สร้าง HTML Slide → 4. Iterate → 5. Push to GitHub
```

1. **Requirements**: ถามเนื้อหา, จำนวนหน้า, theme
2. **Design Tokens**: อ่าน references/design-tokens.md สำหรับ color/typography
3. **สร้าง HTML**: สร้างไฟล์ .html ที่เปิดได้ใน browser ทันที
4. **Iterate**: User เปิดดู → บอก Claude แก้ → refresh
5. **Push**: commit และ push ขึ้น GitHub

---

## Step 1: รวบรวม Requirements

ถามข้อมูลเหล่านี้ (ถ้ายังไม่ระบุ):

- **หัวข้อ Presentation**: เช่น Weekly Update — Week 1
- **จำนวน Slide โดยประมาณ**: ปกติ 10-20 หน้า
- **เนื้อหาแต่ละหน้า**: Agenda, Planning, Outcome, Demo, Nextstep ฯลฯ
- **รูปภาพ**: มี path ของรูปที่ต้องใส่ไหม?
- **Theme**: ใช้ Design Token ของโปรเจกต์ หรือ custom?
- **Project Logo**: มี SVG logo ไหม?

---

## Step 2: อ่าน Design Tokens

```
references/design-tokens.md → อ่านเสมอ สำหรับ color, typography, spacing, radius
```

---

## Step 3: สร้าง HTML Slide

### Architecture: Single HTML File

ไฟล์ `.html` เดียว self-contained ทั้ง CSS + JS ไม่ต้องพึ่ง external library ใดๆ (ยกเว้น Google Fonts)

### 3.1 Design Tokens (CSS Variables)

**ต้องมีเสมอ** — ใส่ใน `:root` ของ `<style>`:

```css
:root {
  /* Primary */
  --primary-fg-high: #EC599D;
  --primary-bg-lowest: #FDEFF5;
  --primary-bg-mid: #EC599D;
  --primary-border-mid: #F7BDD8;

  /* Secondary */
  --secondary-fg-high: #7279FB;
  --secondary-bg-lowest: #F1F2FF;
  --secondary-bg-mid: #7279FB;
  --secondary-border-mid: #C7C9FD;

  /* Gray Neutral */
  --gray-fg-high: #1B1D22;
  --gray-fg-mid-on-white: #6A6E83;
  --gray-fg-low-on-white: #9A9DAD;
  --gray-bg-white: #FFFFFF;
  --gray-bg-lightgray: #F8F8F9;
  --gray-bg-midgray: #EBECEF;
  --gray-bg-black: #1B1D22;

  /* Spacing */
  --spacing-1: 4px;  --spacing-2: 8px;  --spacing-3: 12px;
  --spacing-4: 16px; --spacing-5: 20px; --spacing-6: 24px;
  --spacing-8: 32px; --spacing-10: 40px; --spacing-12: 48px;

  /* Radius */
  --radius-sm: 4px;  --radius-md: 8px;  --radius-lg: 12px;
  --radius-xl: 16px; --radius-2xl: 24px; --radius-full: 9999px;

  /* Shadow */
  --shadow-sm: 0 1px 3px rgba(0,0,0,0.1);
  --shadow-md: 0 4px 6px rgba(0,0,0,0.1);
  --shadow-lg: 0 10px 15px rgba(0,0,0,0.1);

  /* Motion */
  --duration-fast: 200ms;
  --duration-normal: 300ms;
  --duration-slow: 500ms;
  --easing-default: ease-in-out;
  --easing-spring: cubic-bezier(0.34, 1.56, 0.64, 1);
}
```

### 3.2 Slide Viewport (16:9)

**ต้องมีเสมอ** — Container หลักรักษา aspect ratio 16:9:

```css
body {
  font-family: 'LINE Seed Sans TH', sans-serif;
  background: #0e0e12;
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: 100vh;
  overflow: hidden;
}

.slide-viewport {
  position: relative;
  width: 100vw;
  height: 56.25vw;       /* 16:9 */
  max-height: 100vh;
  max-width: 177.78vh;   /* 16:9 inverse */
  overflow: hidden;
  background: var(--gray-bg-white);
  box-shadow: 0 0 60px rgba(0,0,0,0.3);
}
```

### 3.3 Slide Structure

แต่ละ slide เป็น `<div class="slide" data-slide="N">` อยู่ใน `.slide-viewport`:

```html
<div class="slide-viewport">
  <!-- Slide 1 -->
  <div class="slide bg-gradient-pastel active" data-slide="0">
    <!-- content -->
  </div>
  <!-- Slide 2 -->
  <div class="slide bg-gradient-violet" data-slide="1">
    <!-- content -->
  </div>
  <!-- ... more slides ... -->

  <!-- TOP BAR (อยู่นอก slide, ใน viewport) -->
  <!-- NAV BAR (อยู่นอก slide, ใน viewport) -->
</div>
```

### 3.4 Slide Transition CSS

**ต้องมีเสมอ** — Smooth slide-left/slide-right animation:

```css
.slide {
  position: absolute;
  inset: 0;
  display: flex;
  flex-direction: column;
  opacity: 0;
  visibility: hidden;
  transform: translateX(80px);
  transition: opacity var(--duration-slow) var(--easing-default),
              transform var(--duration-slow) var(--easing-default),
              visibility 0s linear var(--duration-slow);
  pointer-events: none;
  overflow: hidden;
  z-index: 0;
}

.slide.active {
  opacity: 1;
  visibility: visible;
  transform: translateX(0);
  pointer-events: auto;
  z-index: 2;
  transition: opacity var(--duration-slow) var(--easing-default),
              transform var(--duration-slow) var(--easing-default),
              visibility 0s linear 0s;
}

.slide.exit-left  { opacity:0; visibility:hidden; transform:translateX(-80px); z-index:1; }
.slide.exit-right { opacity:0; visibility:hidden; transform:translateX(80px);  z-index:1; }
.slide.enter-from-left  { transform: translateX(-80px); }
.slide.enter-from-right { transform: translateX(80px);  }
```

### 3.5 Background Gradient Presets

สลับ gradient แต่ละ slide เพื่อ visual variety:

```css
.bg-gradient-pastel { background: linear-gradient(135deg, #f3e8ff 0%, #fce7f3 25%, #e0e7ff 50%, #f0f9ff 75%, #fdf2f8 100%); }
.bg-gradient-dark   { background: linear-gradient(135deg, #1B1D22 0%, #282160 50%, #1B1D22 100%); }
.bg-gradient-violet { background: linear-gradient(135deg, #F1F2FF 0%, #FDEFF5 50%, #E6F6FC 100%); }
.bg-gradient-warm   { background: linear-gradient(135deg, #FDEFF5 0%, #FEF9EB 50%, #F1F2FF 100%); }
.bg-gradient-cool   { background: linear-gradient(135deg, #E6F6FC 0%, #F1F2FF 50%, #FDEFF5 100%); }
```

Dark slide: เพิ่ม class `dark-slide` เพื่อให้ nav ปรับเป็น dark mode อัตโนมัติ

### 3.6 Decorative Elements

เพิ่มความสวยด้วย circle blur + dot pattern:

```css
.deco-circle {
  position: absolute;
  border-radius: 50%;
  opacity: 0.15;
  pointer-events: none;
}

.deco-dots {
  position: absolute;
  width: 120px; height: 120px;
  opacity: 0.08;
  background-image: radial-gradient(circle, var(--secondary-fg-high) 2px, transparent 2px);
  background-size: 16px 16px;
  pointer-events: none;
}
```

### 3.7 Slide Content Layouts

```css
/* Header bar (logo + section label) */
.slide-header {
  display: flex;
  align-items: center;
  gap: var(--spacing-3);
  padding: 2.5% 4%;
  flex-shrink: 0;
}

/* Content area */
.slide-content {
  flex: 1;
  display: flex;
  padding: 0 5% 3%;
  gap: 4%;
  min-height: 0;
}

/* Layout variants */
.slide-content.centered   { justify-content:center; align-items:center; text-align:center; }
.slide-content.two-col    { flex-direction:row; align-items:center; }
```

### 3.8 Typography (clamp responsive)

ใช้ `clamp()` เสมอเพื่อให้ scale กับ viewport:

```css
.title-xl  { font-size: clamp(32px, 3.5vw, 56px); font-weight: 800; line-height: 1.15; }
.title-lg  { font-size: clamp(22px, 2.5vw, 40px); font-weight: 700; line-height: 1.2; }
.title-md  { font-size: clamp(18px, 2vw, 32px);   font-weight: 700; line-height: 1.25; }
.body-lg   { font-size: clamp(14px, 1.4vw, 22px);  font-weight: 400; line-height: 1.5; }
.body-md   { font-size: clamp(12px, 1.2vw, 19px);  font-weight: 400; line-height: 1.5; }
.body-sm   { font-size: clamp(10px, 1vw, 16px);    font-weight: 400; line-height: 1.5; }

.gradient-text {
  background: linear-gradient(135deg, var(--primary-fg-high), var(--secondary-fg-high));
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}
```

---

## Step 4: Navigation Components

### ต้องมีทั้ง 3 ส่วน:

### 4.1 Top Bar (Position: absolute top-right ใน viewport)

ประกอบด้วย 2 component:

#### A) Present Button — แสดงเฉพาะ Slide แรก (Cover) เมื่อไม่ได้ fullscreen

```html
<div style="position:absolute;top:1.5%;right:4%;z-index:200;display:flex;align-items:center;gap:var(--spacing-2);" id="topBar">
  <button class="present-btn" id="presentBtn" onclick="enterPresent()" title="เข้าโหมด Present (F)">
    <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="15 3 21 3 21 9"/><polyline points="9 21 3 21 3 15"/><line x1="21" y1="3" x2="14" y2="10"/><line x1="3" y1="21" x2="10" y2="14"/></svg>
    <span>Present</span>
  </button>
  <!-- Pages Dropdown อยู่ถัดไป -->
</div>
```

CSS:

```css
.present-btn {
  display: flex;
  align-items: center;
  gap: var(--spacing-2);
  padding: var(--spacing-2) var(--spacing-4);
  border-radius: var(--radius-md);
  border: none;
  background: var(--secondary-fg-high);
  cursor: pointer;
  font-family: 'LINE Seed Sans TH', sans-serif;
  font-size: clamp(11px, 1vw, 14px);
  font-weight: 700;
  color: #fff;
  transition: all var(--duration-fast) var(--easing-default);
  box-shadow: var(--shadow-md);
}
.present-btn:hover { background: #5a60e8; box-shadow: var(--shadow-lg); transform: translateY(-1px); }
.present-btn:active { transform: scale(0.97); }
.present-btn svg { width: clamp(14px, 1.1vw, 18px); height: clamp(14px, 1.1vw, 18px); }
```

#### B) Pages Dropdown — แสดงทุกหน้ายกเว้น Slide แรก (ยกเว้นตอน fullscreen จะแสดงทุกหน้า)

**ปุ่ม Dropdown**: บาง จาง opacity 0.45 → hover แล้วชัดขึ้น

```css
.page-dropdown-btn {
  display: flex;
  align-items: center;
  gap: var(--spacing-2);
  padding: var(--spacing-1) var(--spacing-3);
  border-radius: var(--radius-full);
  border: 1px solid transparent;
  background: transparent;
  cursor: pointer;
  font-family: 'LINE Seed Sans TH', sans-serif;
  font-size: clamp(10px, 0.9vw, 13px);
  font-weight: 600;
  color: var(--gray-fg-low-on-white);
  opacity: 0.45;
  transition: all var(--duration-fast) var(--easing-default);
}
.page-dropdown-btn:hover {
  opacity: 1;
  background: rgba(0,0,0,0.04);
  border-color: var(--gray-bg-midgray);
  color: var(--gray-fg-high);
}
.page-dropdown-wrap.open .page-dropdown-btn {
  opacity: 1;
  background: var(--gray-bg-white);
  border-color: var(--gray-bg-midgray);
  color: var(--gray-fg-high);
  box-shadow: var(--shadow-sm);
}
```

**Dropdown Menu**: สร้างด้วย JS — แสดงรายการ slide เป็น `หน้า {N} : {Title}`:

```javascript
const slideTitles = [
  'Cover',
  'Agenda',
  // ... ชื่อ slide ทั้งหมด
];

function buildDropdownMenu() {
  const menu = document.getElementById('pageDropdownMenu');
  menu.innerHTML = '';
  slideTitles.forEach((title, i) => {
    const item = document.createElement('button');
    item.className = 'page-dropdown-item' + (i === currentSlide ? ' active-page' : '');
    item.innerHTML = `<span class="slide-num">${i + 1}</span> ${title}`;
    item.onclick = () => { goToSlide(i); document.getElementById('pageDropdown').classList.remove('open'); };
    menu.appendChild(item);
  });
}
```

**Dropdown item styling**:

```css
.page-dropdown-item {
  display: flex;
  align-items: center;
  gap: var(--spacing-2);
  width: 100%;
  padding: var(--spacing-2) var(--spacing-3);
  border: none;
  background: none;
  cursor: pointer;
  font-family: 'LINE Seed Sans TH', sans-serif;
  font-size: clamp(10px, 0.9vw, 13px);
  font-weight: 500;
  color: var(--gray-fg-mid-on-white);
  text-align: left;
  white-space: nowrap;
}
.page-dropdown-item:hover { background: var(--gray-bg-lightgray); color: var(--gray-fg-high); }
.page-dropdown-item.active-page { color: var(--secondary-fg-high); font-weight: 700; background: var(--secondary-bg-lowest); }

.page-dropdown-item .slide-num {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-width: clamp(18px, 1.6vw, 22px);
  height: clamp(18px, 1.6vw, 22px);
  border-radius: var(--radius-sm);
  background: var(--gray-bg-lightgray);
  font-size: clamp(9px, 0.75vw, 11px);
  font-weight: 700;
}
```

### 4.2 Bottom Nav Bar (Position: absolute bottom ใน viewport)

```html
<div class="nav-bar" id="navBar">
  <button class="nav-home-btn" onclick="goToSlide(0)" title="Go to first slide">
    <!-- House SVG icon -->
  </button>
  <div class="nav-buttons">
    <button class="nav-btn" onclick="prevSlide()"><!-- Left chevron --></button>
    <span class="nav-counter" id="navCounter">1/16</span>
    <button class="nav-btn" onclick="nextSlide()"><!-- Right chevron --></button>
  </div>
</div>
```

CSS:

```css
.nav-bar {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  display: flex;
  align-items: center;
  justify-content: flex-end;
  padding: 1.5% 4%;
  z-index: 100;
}

.nav-btn, .nav-home-btn {
  display: flex;
  align-items: center;
  justify-content: center;
  width: clamp(32px, 3vw, 44px);
  height: clamp(32px, 3vw, 44px);
  border-radius: var(--radius-md);
  border: 1px solid var(--gray-bg-midgray);
  background: var(--gray-bg-white);
  cursor: pointer;
  color: var(--gray-fg-mid-on-white);
  transition: all var(--duration-fast) var(--easing-default);
}

.nav-btn:hover, .nav-home-btn:hover {
  background: var(--gray-bg-lightgray);
  color: var(--gray-fg-high);
}

.nav-counter {
  font-size: clamp(11px, 1vw, 14px);
  color: var(--gray-fg-mid-on-white);
  font-weight: 700;
  min-width: 50px;
  text-align: center;
  font-variant-numeric: tabular-nums;
}

/* Dark variant (for dark-slide backgrounds) */
.nav-bar.dark-nav .nav-btn,
.nav-bar.dark-nav .nav-home-btn {
  background: rgba(255,255,255,0.1);
  border-color: rgba(255,255,255,0.15);
  color: rgba(255,255,255,0.7);
}
```

### 4.3 Present Hint Text — เฉพาะ Cover Slide

ข้อความเล็กๆ บอก shortcut:

```html
<!-- Inside cover slide -->
<div class="present-hint" id="presentHint">
  กดปุ่ม <kbd>F</kbd> เพื่อเข้าโหมด Present
</div>
```

```css
.present-hint {
  position: absolute;
  bottom: 12%;
  left: 50%;
  transform: translateX(-50%);
  font-size: clamp(10px, 0.85vw, 13px);
  color: var(--gray-fg-low-on-white);
  opacity: 0.7;
  pointer-events: none;
}
.present-hint kbd {
  padding: 1px 6px;
  font-weight: 700;
  background: var(--gray-bg-white);
  border: 1px solid var(--gray-bg-midgray);
  border-radius: var(--radius-sm);
  box-shadow: 0 1px 0 var(--gray-bg-midgray);
}
```

---

## Step 5: JavaScript (Navigation Engine)

**ต้องมีเสมอ** — ใส่ก่อน `</body>`:

```javascript
const slides = document.querySelectorAll('.slide');
const totalSlides = slides.length;
let currentSlide = 0;
let isAnimating = false;

// === Update Nav Bar State ===
function updateNavBar() {
  document.getElementById('navCounter').textContent = `${currentSlide + 1}/${totalSlides}`;

  // Dark nav for dark slides
  const navBar = document.getElementById('navBar');
  const isDark = slides[currentSlide].classList.contains('dark-slide');
  navBar.classList.toggle('dark-nav', isDark);

  const pageDropdown = document.getElementById('pageDropdown');
  pageDropdown.classList.toggle('dark-dropdown', isDark);

  // First slide (not fullscreen): show Present, hide dropdown
  const isFS = !!document.fullscreenElement;
  const showPresent = currentSlide === 0 && !isFS;
  document.getElementById('presentBtn').style.display = showPresent ? '' : 'none';
  pageDropdown.style.display = showPresent ? 'none' : '';

  // Rebuild dropdown
  if (typeof buildDropdownMenu === 'function') buildDropdownMenu();
}

// === Slide Navigation ===
function goToSlide(index) {
  if (index === currentSlide || index < 0 || index >= totalSlides || isAnimating) return;
  isAnimating = true;

  const goingForward = index > currentSlide;
  const oldSlide = slides[currentSlide];
  const newSlide = slides[index];

  oldSlide.classList.remove('active');
  oldSlide.classList.add(goingForward ? 'exit-left' : 'exit-right');

  newSlide.style.transition = 'none';
  newSlide.classList.remove('exit-left', 'exit-right');
  newSlide.classList.add(goingForward ? 'enter-from-right' : 'enter-from-left');

  newSlide.offsetHeight; // force reflow
  newSlide.style.transition = '';
  newSlide.classList.remove('enter-from-right', 'enter-from-left');
  newSlide.classList.add('active');

  currentSlide = index;
  updateNavBar();

  setTimeout(() => {
    oldSlide.classList.remove('exit-left', 'exit-right');
    isAnimating = false;
  }, 500);
}

function nextSlide() { if (currentSlide < totalSlides - 1) goToSlide(currentSlide + 1); }
function prevSlide() { if (currentSlide > 0) goToSlide(currentSlide - 1); }

// === Keyboard Navigation ===
document.addEventListener('keydown', (e) => {
  switch(e.key) {
    case 'ArrowRight': case 'ArrowDown': case ' ':
      e.preventDefault(); nextSlide(); break;
    case 'ArrowLeft': case 'ArrowUp':
      e.preventDefault(); prevSlide(); break;
    case 'Home': e.preventDefault(); goToSlide(0); break;
    case 'End':  e.preventDefault(); goToSlide(totalSlides - 1); break;
    case 'f': case 'F': e.preventDefault(); enterPresent(); break;
  }
});

// === Touch Support ===
let touchStartX = 0;
document.addEventListener('touchstart', (e) => { touchStartX = e.touches[0].clientX; });
document.addEventListener('touchend', (e) => {
  const diff = touchStartX - e.changedTouches[0].clientX;
  if (Math.abs(diff) > 50) { diff > 0 ? nextSlide() : prevSlide(); }
});

// === Fullscreen / Present Mode ===
function enterPresent() {
  const el = document.querySelector('.slide-viewport');
  if (!document.fullscreenElement) {
    (el.requestFullscreen || el.webkitRequestFullscreen || el.msRequestFullscreen).call(el);
  } else {
    (document.exitFullscreen || document.webkitExitFullscreen || document.msExitFullscreen).call(document);
  }
}

document.addEventListener('fullscreenchange', () => { updateNavBar(); });

// === Pages Dropdown ===
const slideTitles = [/* fill per project */];

function buildDropdownMenu() { /* ... */ }
function togglePageDropdown() { /* ... */ }

document.addEventListener('click', (e) => {
  const dropdown = document.getElementById('pageDropdown');
  if (!dropdown.contains(e.target)) dropdown.classList.remove('open');
});

// === Init ===
buildDropdownMenu();
updateNavBar();
```

---

## Visibility Rules Summary

| Component | Cover Slide (ไม่ fullscreen) | Cover Slide (fullscreen) | หน้าอื่นๆ |
|-----------|-----|-----|-----|
| Present Button | แสดง | ซ่อน | ซ่อน |
| Pages Dropdown | ซ่อน | แสดง | แสดง |
| Nav Bar (Home + Prev/Next) | แสดง | แสดง | แสดง |
| Present Hint Text | แสดง (อยู่ใน cover slide) | แสดง | ไม่มี |

---

## Slide Type Templates

### Cover Slide
- gradient background + decorative circles
- โลโก้โปรเจกต์ (SVG)
- วันที่ + ชื่อ Presentation + subtitle
- tags (project name, topic)
- character image (ถ้ามี)
- present hint text

### Content Slide (Two Column)
- slide-header (logo + section label)
- `.slide-content.two-col` → `.col-text` + `.col-visual`

### Content Slide (Full Width)
- slide-header
- `.slide-content` → เนื้อหา full width (timeline, calendar, grid, etc.)

### Image Gallery Slide
- slide-header
- grid ของรูปภาพ (CSS Grid)

### Thank You Slide
- gradient background + decorative circles
- "Thank you!" title + "Questions & Discussion"

---

## Checklist ก่อนส่งมอบ

- [ ] ทุก slide มี `data-slide` attribute เรียงลำดับ 0, 1, 2, ...
- [ ] Slide แรกมี class `active`
- [ ] `slideTitles` array ตรงกับจำนวนและลำดับ slide
- [ ] Background gradient สลับกันทุก slide (ไม่ซ้ำติดกัน)
- [ ] Dark slide มี class `dark-slide` เพื่อ toggle nav theme
- [ ] Navigation ครบ: Home btn, Prev/Next, Counter, Pages dropdown, Present btn
- [ ] Keyboard shortcuts ทำงาน: Arrow keys, Space, Home, End, F
- [ ] Touch swipe ทำงาน
- [ ] Fullscreen mode ทำงาน + nav ยังแสดง
- [ ] Typography ใช้ `clamp()` ทั้งหมด
- [ ] รูปภาพมี `object-fit: contain` หรือ `cover` ตามเหมาะสม
