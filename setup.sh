# Claude monstro: instala skills, regras, Context7 e medidor em toda sessao, em qualquer projeto
claude plugin marketplace add FernandoLacava/claudemonstro || true
claude plugin marketplace update claudemonstro || true
claude plugin install monstro@claudemonstro --scope user || true
claude plugin update monstro@claudemonstro --scope user || true
node -e '
const fs = require("fs"), f = require("os").homedir() + "/.claude/settings.json";
let s = {}; try { s = JSON.parse(fs.readFileSync(f)); } catch {}
s.statusLine = { type: "command", command: "node ~/.claude/claudemonstro-statusline.js", padding: 0 };
fs.writeFileSync(f, JSON.stringify(s, null, 2));
' || true
