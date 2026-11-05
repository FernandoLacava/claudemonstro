# claudemonstro

O "Claude monstro" do Fernando: um plugin do Claude Code com todas as skills instaladas, as regras de quando usar cada uma sozinho e o medidor de contexto.

## Ligar num projeto

Coloque no projeto o `.claude/settings.json` e o `.mcp.json` descritos em [`plugins/monstro/RULES.md`](plugins/monstro/RULES.md) (seção "Ligar o claudemonstro num projeto novo"). Ao abrir uma sessão (computador ou nuvem), o hook roda [`bootstrap.sh`](bootstrap.sh), que instala todas as skills e as regras na hora. Nada para configurar no ambiente.

Alternativa para o ambiente na nuvem: colar [`setup.sh`](setup.sh) em Setup script (instala como plugin antes da sessão).

## O que tem

- `plugins/monstro/skills/`: as skills (vídeo, código, produtividade).
- `plugins/monstro/RULES.md`: quando cada skill é usada automaticamente (injetado no início de toda sessão).
- `plugins/monstro/scripts/statusline.js`: medidor de contexto (verde/amarelo/vermelho + COMPACTA).

Origem das skills: heygen-com/hyperframes, remotion-dev/skills, higgsfield-ai/skills, mattpocock/skills, vercel-labs/agent-skills; `banca` é própria.
