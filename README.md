# claudemonstro

O "Claude monstro" do Fernando: um plugin do Claude Code com todas as skills instaladas, as regras de quando usar cada uma sozinho e o medidor de contexto.

## Ligar num projeto

No `.claude/settings.json` do projeto:

```json
{
  "extraKnownMarketplaces": {
    "claudemonstro": { "source": { "source": "github", "repo": "FernandoLacava/claudemonstro" } }
  },
  "enabledPlugins": { "monstro@claudemonstro": true },
  "statusLine": { "type": "command", "command": "node ~/.claude/claudemonstro-statusline.js", "padding": 0 }
}
```

Ou no terminal: `/plugin marketplace add FernandoLacava/claudemonstro` e `/plugin install monstro@claudemonstro`.

## O que tem

- `plugins/monstro/skills/`: as skills (vídeo, código, produtividade).
- `plugins/monstro/RULES.md`: quando cada skill é usada automaticamente (injetado no início de toda sessão).
- `plugins/monstro/scripts/statusline.js`: medidor de contexto (verde/amarelo/vermelho + COMPACTA).

Origem das skills: heygen-com/hyperframes, remotion-dev/skills, higgsfield-ai/skills, mattpocock/skills, vercel-labs/agent-skills; `banca` é própria.
