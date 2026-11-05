#!/usr/bin/env node
// Ao iniciar a sessão: instala o medidor de contexto em ~/.claude e injeta as regras de uso automático.
const fs = require("fs"), path = require("path"), os = require("os");
const root = path.resolve(__dirname, "..");
try {
  const dir = path.join(os.homedir(), ".claude");
  fs.mkdirSync(dir, { recursive: true });
  fs.copyFileSync(path.join(root, "scripts", "statusline.js"), path.join(dir, "claudemonstro-statusline.js"));
} catch {}
try { process.stdout.write(fs.readFileSync(path.join(root, "RULES.md"), "utf8")); } catch {}
