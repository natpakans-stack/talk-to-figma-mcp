import { readFileSync, writeFileSync, mkdirSync, existsSync } from 'fs';
import { join, dirname } from 'path';
import { fileURLToPath } from 'url';
import { marked } from 'marked';

const __dirname = dirname(fileURLToPath(import.meta.url));
const src = (...p) => join(__dirname, 'src', ...p);
const dist = (...p) => join(__dirname, 'dist', ...p);

// ── Helpers ──────────────────────────────────────────────

function read(path) {
  return readFileSync(path, 'utf-8');
}

function escapeHtml(str) {
  return str
    .replace(/&/g, '&amp;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;')
    .replace(/"/g, '&quot;');
}

/** Strip YAML frontmatter (--- ... ---) from .md content */
function stripFrontmatter(md) {
  return md.replace(/^---[\s\S]*?---\n*/, '');
}

/** Build a badge span if config has one */
function badgeHtml(item) {
  if (!item.badge) return '';
  const bg = item.badgeColor || '#888';
  return ` <span style="background:${bg};color:#fff;padding:2px 8px;border-radius:4px;font-size:11px;font-weight:700;margin-left:8px;">${item.badge}</span>`;
}

// ── Build reference card (markdown → HTML) ───────────────

function buildReferenceCard(item) {
  const mdPath = src('content', 'references', item.filename);
  const raw = read(mdPath);
  const body = stripFrontmatter(raw);
  const html = marked.parse(body);

  return `
  <!-- ─── ${item.filename} ─── -->
  <details>
    <summary><span style="color:${item.color};">${item.icon}</span> ${item.filename} — ${item.title}${badgeHtml(item)}</summary>
    <div class="details-body">
      <div class="file-badge"><span class="dot ref"></span> ${item.installPath}</div>
      ${html}
    </div>
  </details>
`;
}

// ── Build skill card (raw .md in <pre><code>) ────────────

function buildSkillCard(item) {
  const mdPath = src('content', 'skills', item.filename);
  const raw = read(mdPath);
  const escaped = escapeHtml(raw);

  return `
  <!-- ─── ${item.filename} ─── -->
  <details>
    <summary><span style="color:${item.color};">${item.icon}</span> ${item.filename} — ${item.title}${badgeHtml(item)}</summary>
    <div class="details-body">
      <div class="file-badge"><span class="dot skill"></span> ${item.installPath}</div>
      <div class="info-box warn">
        <span class="icon">\ud83d\udccb</span>
        <div>Copy \u0e40\u0e19\u0e37\u0e49\u0e2d\u0e2b\u0e32\u0e14\u0e49\u0e32\u0e19\u0e25\u0e48\u0e32\u0e07\u0e17\u0e31\u0e49\u0e07\u0e2b\u0e21\u0e14 \u0e41\u0e25\u0e49\u0e27 save \u0e40\u0e1b\u0e47\u0e19\u0e44\u0e1f\u0e25\u0e4c <code>${item.installPath}</code></div>
      </div>
      <pre><code>${escaped}</code></pre>
    </div>
  </details>
`;
}

// ── Section 8 (Reference Files) builder ──────────────────

function buildSection8(config) {
  const intro = read(src('sections', '08-references-intro.html'));
  const refCards = config.references.map(buildReferenceCard).join('\n');
  const skillCards = config.skills.map(buildSkillCard).join('\n');

  // intro already has <section> open tag, we close it here
  return `${intro}
${refCards}

${skillCards}

</section>
`;
}

// ── Main build ───────────────────────────────────────────

function build() {
  const t0 = Date.now();

  // Read config
  const config = JSON.parse(read(src('skill-config.json')));

  // Read template parts
  const head = read(src('template', 'head.html'));
  const hero = read(src('template', 'hero.html'));
  const footer = read(src('template', 'footer.html'));

  // Read static section partials (order matters)
  // v3.0.0: Restructured for 2 user journeys
  //   Journey 2 (existing users): sec1-4 → Quick Start, Skills, Usage, Cheat Sheet
  //   Journey 1 (new members): sec5-7 → Overview, Installation, Troubleshooting
  const sectionFiles = [
    '01-quick-start.html',
    '02-skill-catalog.html',
    '03-real-usage.html',
    '04-cheatsheet-tips.html',
    '05-overview-architecture.html',
    '06-installation.html',
    '07-troubleshooting.html',
  ];

  const sections = sectionFiles.map(f => read(src('sections', f)));

  // Build section 8 (Reference Files) from .md files
  const section8 = buildSection8(config);

  // Glossary
  const glossary = read(src('sections', 'glossary.html'));

  // Assemble
  const html = [
    head,
    '',
    hero,
    '',
    ...sections.map(s => s + '\n'),
    section8,
    glossary,
    '',
    footer,
  ].join('\n');

  // Write output
  mkdirSync(dist(), { recursive: true });
  writeFileSync(dist('index.html'), html, 'utf-8');

  const ms = Date.now() - t0;
  const kb = (Buffer.byteLength(html) / 1024).toFixed(1);
  console.log(`\u2705 Built dist/index.html (${kb} KB) in ${ms}ms`);
}

build();
