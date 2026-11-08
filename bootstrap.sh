#!/bin/bash
# Claude monstro: instalação no início da sessão (usado pelo hook SessionStart dos projetos).
# Copia as skills para ~/.claude/skills (carregam na hora), instala o medidor e imprime as regras.
# Se o plugin monstro já estiver instalado (ex.: Claude Code no computador), não faz nada.
[ -d "$HOME/.claude/plugins/cache/claudemonstro/monstro" ] && exit 0

SRC="$(cd "$(dirname "$0")" && pwd)"
C="$HOME/.claude"; DEPS="$C/claudemonstro-deps"; SK="$C/skills"; CMD="$C/commands"
mkdir -p "$DEPS" "$SK" "$CMD"

fetch() { # repo destino
  if [ -d "$2/.git" ]; then timeout 60 git -C "$2" pull -q --ff-only >/dev/null 2>&1
  else timeout 90 git clone -q --depth 1 "https://github.com/$1" "$2" >/dev/null 2>&1; fi
}
fetch addyosmani/agent-skills "$DEPS/agent-skills"
fetch 21st-dev/magic-mcp "$DEPS/21st"
fetch mapbox/mapbox-agent-skills "$DEPS/mapbox"

ok=0
for d in "$SRC/plugins/monstro/skills"/*/ "$DEPS/agent-skills/skills"/*/ "$DEPS/21st/skills"/*/ "$DEPS/mapbox/skills"/*/; do
  [ -f "$d/SKILL.md" ] || continue
  n=$(basename "$d"); rm -rf "$SK/$n"; cp -r "$d" "$SK/$n"; ok=$((ok+1))
done
# Sem plugin não há prefixo "agent-skills:" nos nomes
grep -rl "agent-skills:" "$SK" 2>/dev/null | xargs -r sed -i 's/agent-skills:\([a-z]\)/\1/g'
# Atalhos /spec /plan /build /test /ship ... (o /review do Addy vira /agent-review)
if [ -d "$DEPS/agent-skills/.claude/commands" ]; then
  for f in "$DEPS/agent-skills/.claude/commands"/*.md; do
    n=$(basename "$f"); [ "$n" = review.md ] && n=agent-review.md
    sed 's/agent-skills:\([a-z]\)/\1/g' "$f" > "$CMD/$n"
  done
fi
cp "$SRC/plugins/monstro/scripts/statusline.js" "$C/claudemonstro-statusline.js" 2>/dev/null

cat "$SRC/plugins/monstro/RULES.md"
echo
echo "_(Claude monstro instalado nesta sessão pelo bootstrap: $ok skills em ~/.claude/skills.)_"
[ "$ok" -lt 60 ] && echo "AVISO PARA O CLAUDE: o Claude monstro carregou só $ok skills (esperado 73). Avise a pessoa."
exit 0
