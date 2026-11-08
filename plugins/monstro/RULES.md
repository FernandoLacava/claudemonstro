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
| Começar um projeto ou funcionalidade nova: escrever o que vai ser feito antes de programar | `agent-skills` (spec → plan → build → test → review → ship; comece por spec-driven-development) |
| Usar qualquer biblioteca/framework (Next.js, React, Remotion, Supabase etc.): conferir a documentação atual e da versão certa | MCP `context7` (consulte antes de escrever código com a API da biblioteca) |
| Projeto grande ou desconhecido, muitas perguntas sobre como o código se liga | `graphify` (se já existir `graphify-out/`, consulte o grafo primeiro; para uma busca pontual, use grep) |
| Criar tela, botão, card, tabela de preço, gráfico ou buscar logo de marca em SVG | `21st` (skill `21st-ui` e MCP do 21st) |
| Mapa no app: estilo Waze, rotas e navegação passo a passo, trânsito, busca de endereço, localização, marcadores, mapa de calor, loja mais próxima | skills `mapbox-*` (comece por `mapbox-web-integration-patterns` para web; `mapbox-navigation-patterns` para rotas/trânsito/navegação; `mapbox-search-integration` para busca; `mapbox-token-security` sempre que mexer no token). Precisa de um token grátis da Mapbox (account.mapbox.com) |
| Pentest / caçar falhas de segurança de verdade no app **da própria pessoa** | `penetration-testing-with-strix`, `find-security-vulnerabilities-in-code`, depois `fix-security-vulnerabilities-with-strix`. Só em código/sistemas da pessoa ou com autorização escrita do dono. Gasta tokens da chave de IA dela: avise antes de rodar |
| **Antes de lançar/publicar em produção um app com usuários**, e ao criar ou mexer em cadastro, dados pessoais, cookies/analytics, e-mail de marketing, checkout/assinatura, página de vendas, depoimentos, rodapé, termos ou política de privacidade | `app-dentro-da-lei` (checklist LGPD/CDC de 24 itens; implementa o que faltar e lista o que a pessoa precisa decidir; lembre que não é consultoria jurídica) |
| Auditoria de segurança completa do código (sem atacar o app rodando) | `security-audit` (Cloudflare; quem confirma a falha nunca é o mesmo agente que achou). Para atacar o app rodando, use o Strix |
| Projeto novo ou "configura o Claude Code neste projeto": que hooks, skills, MCP ou agentes valem a pena | `claude-automation-recommender` (plugin claude-code-setup) |
| Tarefa longa e bem definida que dá para verificar sozinho (testes passando, build verde) e a pessoa quer que eu vá até o fim sem parar | `/ralph-loop "pedido" --max-iterations 20 --completion-promise "PRONTO"`: **sempre** com limite de iterações; avise antes porque gasta bastante uso |
| **Antes de todo commit, push ou deploy de código alterado na sessão** | `banca` (obrigatório; se REPROVADO, corrija os itens CRÍTICO/ALTO e rode a banca de novo antes de subir) |

Regras:
- Não use skill para pergunta simples que se responde direto.
- O plugin `security-guidance` dá avisos automáticos de segurança ao editar e revisa sozinho ao commitar: trate os avisos dele como itens da banca.
- O plugin `context-mode` filtra saídas grandes de ferramentas para economizar contexto; se ele bloquear ou redirecionar um comando, use as ferramentas `ctx_*` que ele indicar.
- Skills que gastam créditos ou dinheiro (Higgsfield, HeyGen, renders na nuvem): informe o custo antes, quando a skill disser como saber.
- Skills que precisam de login ou chave (Higgsfield, HeyGen, 21st `API_KEY_21ST`, Strix `STRIX_LLM` + `LLM_API_KEY`, Mapbox token): se faltar, peça para a pessoa fazer o login/cadastrar a chave e continue o resto.

## Instalar coisas novas

Tudo que a pessoa mandar instalar (skills, regras, hooks, ferramentas) vai para o repositório GitHub **FernandoLacava/claudemonstro**, nunca para o projeto em que se está trabalhando:
- Skills: `plugins/monstro/skills/<nome>/SKILL.md`. Regras de uso automático: atualize a tabela em `plugins/monstro/RULES.md`. Hooks: `plugins/monstro/hooks/hooks.json`.
- Skills novas entram sozinhas no `bootstrap.sh` (ele copia tudo de `plugins/monstro/skills/`); dependências de outros repositórios precisam ser adicionadas no `bootstrap.sh` e no `dependencies` do plugin.json.
- Revise o conteúdo antes por segurança, suba a `version` em `plugins/monstro/.claude-plugin/plugin.json`, rode `claude plugin validate`, faça commit e push na `main`.
- Se o repositório não estiver na sessão, adicione-o (add_repo FernandoLacava/claudemonstro com push) e clone.

## Onde o Claude monstro está instalado

- **Nuvem (claude.ai/code, app, celular): em todas as sessões, de qualquer projeto.** O Setup script do ambiente pessoal "Padrão" instala o plugin antes de cada sessão começar, e a rede dele libera mcp.context7.com, 21st.dev e strix.ai. Se a pessoa criar outro ambiente, coloque nele o mesmo script (`setup.sh` deste repositório) com update_environment/create_environment.
- **Claude Code no computador da pessoa:** uma vez só, no terminal: `claude plugin marketplace add FernandoLacava/claudemonstro` e `claude plugin install monstro@claudemonstro --scope user`. Vale para todos os projetos daquele computador.
- **Claude normal (claude.ai no chat):** não usa plugins do Claude Code; skills ali são enviadas em Configurações → Capacidades → Skills, uma por uma (arquivo .zip).

## Ligar o claudemonstro num projeto novo

Quando a pessoa pedir ("liga o claudemonstro aqui"), ou ao começar a trabalhar num projeto que não tem isso, crie/mescle estes dois arquivos no projeto, faça commit e push. O hook SessionStart baixa este repositório e roda `bootstrap.sh`, que copia todas as skills para `~/.claude/skills` (carregam na hora, também na nuvem) e imprime estas regras. No computador, com o plugin instalado, o bootstrap não faz nada e o plugin assume.

`.claude/settings.json`:
```json
{
  "hooks": {
    "SessionStart": [
      {
        "hooks": [
          {
            "type": "command",
            "command": "D=\"$HOME/.claude/claudemonstro-src\"; if [ -d \"$D/.git\" ]; then timeout 60 git -C \"$D\" pull -q --ff-only; else timeout 90 git clone -q --depth 1 https://github.com/FernandoLacava/claudemonstro \"$D\"; fi >/dev/null 2>&1; if [ -f \"$D/bootstrap.sh\" ]; then bash \"$D/bootstrap.sh\"; else echo \"AVISO PARA O CLAUDE: nao foi possivel baixar o Claude monstro (github.com/FernandoLacava/claudemonstro). Avise a pessoa na primeira resposta.\"; fi",
            "timeout": 240
          }
        ]
      }
    ]
  },
  "enableAllProjectMcpServers": true,
  "statusLine": {
    "type": "command",
    "command": "node ~/.claude/claudemonstro-statusline.js",
    "padding": 0
  },
  "extraKnownMarketplaces": {
    "claudemonstro": {
      "source": {
        "source": "github",
        "repo": "FernandoLacava/claudemonstro"
      }
    }
  },
  "enabledPlugins": {
    "monstro@claudemonstro": true
  }
}
```

`.mcp.json`:
```json
{
  "mcpServers": {
    "context7": {
      "type": "http",
      "url": "https://mcp.context7.com/mcp?client=claude-code-plugin"
    }
  }
}
```
