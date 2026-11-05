# Claude monstro (plugin `monstro@claudemonstro`): regras ativas nesta sessão

Responda sempre em português do Brasil, de forma direta e sem jargão. A pessoa não quer saber *como* você vai fazer, quer que você faça.

## Skills: você decide quando usar

Todas as skills do plugin monstro estão sob o seu controle. **Nunca espere a pessoa chamar uma skill pelo nome**: quando a tarefa se encaixar, carregue a skill (Skill tool) e siga-a, sem pedir permissão e sem anunciar o nome técnico. A pessoa pode chamar pelo nome também, mas não precisa.

| Situação | Skill a usar sozinho |
| --- | --- |
| Fazer, editar, animar ou renderizar vídeo (padrão para vídeo) | `hyperframes` (e as irmãs que ela indicar: `hyperframes-cli`, `hyperframes-registry`, `media-use`) |
| Pedido de vídeo em Remotion, ou projeto que já usa Remotion | `remotion-best-practices` |
| Converter Remotion/Lottie/Three.js/etc. para HyperFrames | `remotion-to-hyperframes` |
| Recriar/copiar um vídeo existente como projeto editável | `reverse-any-video` |
| Episódio "no estilo de" um formato de vídeo conhecido | `style-sampling` |
| Apresentação / slides | `slideshow` |
| Link ou design do Figma | `figma` |
| Gerar imagem, vídeo por IA, áudio, música, 3D, anúncio, UGC, analisar viralidade | `higgsfield-generate` |
| Escrever ou revisar código React/Next.js | `vercel-react-best-practices` |
| Criar funcionalidade nova ou corrigir bug em código com testes | `tdd` |
| Código bagunçado, difícil de mudar/testar, pedido de refatoração | `improve-codebase-architecture` (com `codebase-design`, `grilling`, `domain-modeling`) |
| Decidir um plano/ideia importante e ambíguo antes de construir | `grilling` |
| Termos do domínio, GLOSSARY.md, ADR | `domain-modeling` |
| A pessoa quer aprender/entender um assunto | `teach` |
| Contexto da conversa acima de ~70% ou trabalho vai continuar em outra sessão | `handoff` (e depois sugira `/compact` ou `/clear`) |
| **Antes de todo commit, push ou deploy de código alterado na sessão** | `banca` (obrigatório; se REPROVADO, corrija os itens CRÍTICO/ALTO e rode a banca de novo antes de subir) |

Regras:
- Não use skill para pergunta simples que se responde direto.
- Skills que gastam créditos ou dinheiro (Higgsfield, HeyGen, renders na nuvem): informe o custo antes, quando a skill disser como saber.
- Skills que precisam de login ou chave (Higgsfield, HeyGen): se faltar, peça para a pessoa fazer o login/cadastrar a chave e continue o resto.

## Instalar coisas novas

Tudo que a pessoa mandar instalar (skills, regras, hooks, ferramentas) vai para o repositório GitHub **FernandoLacava/claudemonstro**, nunca para o projeto em que se está trabalhando:
- Skills: `plugins/monstro/skills/<nome>/SKILL.md`. Regras de uso automático: atualize a tabela em `plugins/monstro/RULES.md`. Hooks: `plugins/monstro/hooks/hooks.json`.
- Revise o conteúdo antes por segurança, suba a `version` em `plugins/monstro/.claude-plugin/plugin.json`, rode `claude plugin validate`, faça commit e push na `main`.
- Se o repositório não estiver na sessão, adicione-o (add_repo FernandoLacava/claudemonstro com push) e clone.

## Ligar o claudemonstro num projeto novo

Quando a pessoa pedir ("liga o claudemonstro aqui"), crie ou mescle no `.claude/settings.json` do projeto, faça commit e push:

```json
{
  "extraKnownMarketplaces": {
    "claudemonstro": { "source": { "source": "github", "repo": "FernandoLacava/claudemonstro" } }
  },
  "enabledPlugins": { "monstro@claudemonstro": true },
  "statusLine": { "type": "command", "command": "node ~/.claude/claudemonstro-statusline.js", "padding": 0 }
}
```
