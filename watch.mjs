import { watch } from 'fs';
import { execSync } from 'child_process';
import { dirname } from 'path';
import { fileURLToPath } from 'url';

const __dirname = dirname(fileURLToPath(import.meta.url));

let timer = null;

function rebuild() {
  try {
    execSync('node build.mjs', { cwd: __dirname, stdio: 'inherit' });
  } catch {
    console.error('\u274c Build failed');
  }
}

// Initial build
rebuild();

// Watch src/ recursively (macOS native recursive support)
watch(`${__dirname}/src`, { recursive: true }, (_event, filename) => {
  if (!filename) return;
  // Debounce 200ms
  clearTimeout(timer);
  timer = setTimeout(() => {
    console.log(`\n\ud83d\udd04 Changed: src/${filename}`);
    rebuild();
  }, 200);
});

console.log('\n\ud83d\udc40 Watching src/ for changes... (Ctrl+C to stop)\n');
