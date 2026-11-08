---
name: performance-app
description: Kit de performance de 31 itens para apps web (Next ou React/Vite/Lovable + Supabase, na Vercel ou VPS) - auditoria só leitura, top 10 por onde começar e correção de 1 item por vez com medida antes x depois. Use AUTOMATICAMENTE quando a pessoa disser que o app está lento, travando, demorando, pesado, com nota ruim no Lighthouse/PageSpeed/Core Web Vitals (LCP, INP, CLS), ou pedir para otimizar/acelerar; e antes de lançar um app web em produção. Também ao escrever listas, buscas, imagens, consultas ao Supabase ou chamadas de IA, para não criar os problemas da lista (N+1, select('*'), sem paginação, sem debounce, sem streaming).
---

# Performance do app (31 itens)

Fonte: "Kit de performance pro seu app" (Entrega #09). Metas "bom" do Google para Core Web Vitals, nos 75% de visitas mais rápidas (web.dev/vitals): **LCP ≤ 2,5 s** (conteúdo principal na tela), **INP ≤ 200 ms** (resposta ao toque), **CLS ≤ 0,1** (quanto a tela pula).

## Regras de ouro

- **Meça primeiro.** Chrome → F12 → Lighthouse → Mobile → Analyze. Guarde o "antes".
- **Um item por vez.** Mudar 5 juntos esconde o que ajudou e o que quebrou.
- **Não precisa dos 31.** Num app pequeno uns 10 resolvem quase tudo. Fila, Redis, várias instâncias e OpenTelemetry são para quando o app cresce.
- **Não prometa ganho em segundos ou %.** Cada mudança é medida antes e depois com números reais; se não melhorou, diga e proponha desfazer. Nunca invente número: sem medida, escreva "não medido".
- Nada roda no banco de produção sem a pessoa ver o SQL. Teste de carga só no app da própria pessoa.

## Fluxo

1. **Auditoria (só leitura)**: resumo do projeto em 5 linhas (framework, onde roda, banco, como o front busca dados, se chama IA/APIs externas) → tabela `| # | item | status | evidência | impacto | esforço |` com status OK / FALTA / NÃO SE APLICA (diga por quê) / NÃO CONSEGUI VER (diga onde a pessoa olha). Evidência = `arquivo:linha` ou medida feita. Seção de banco: liste as consultas (arquivo:linha), marque `select('*')`, consulta em loop e filtro/ordenação sem índice provável, e dê o `EXPLAIN ANALYZE` (só SELECT) de cada suspeita. Termine com os **5 FALTA de maior impacto e menor esforço** e pare para a pessoa escolher, a menos que ela já tenha pedido para corrigir.
2. **Correção, 1 item por vez**: (1) ANTES: medida repetível (tamanho da resposta na Network, nº de requisições, tempo da rota, EXPLAIN ANALYZE, Lighthouse mobile); meça você se der. (2) PLANO: arquivos e o que muda em cada um. (3) Aplique só esse item, sem refatorar fora dele nem trocar biblioteca sem perguntar. (4) Build, lint e testes. (5) DEPOIS: mesma medida, ANTES x DEPOIS com números reais. (6) O que testar à mão. Índice/migração: mostre o SQL e deixe a pessoa rodar (tabela grande em produção: `CREATE INDEX CONCURRENTLY`).

## Por onde começar (Next/React + Supabase, Vercel ou Lovable)

**Top 10, nesta ordem:** 31 medir no celular e rede lenta → 19 servidor na região do banco → 24 só as colunas → 08 N+1 → 17 índices → 02 e 15 imagens leves e lazy (menos o banner do topo) → 01 skeleton → 05 paginação → 13 streaming da IA → 04 debounce.
**Depois:** 03, 12, 16, 21, 22, 29, 14, 26, 30. **Só quando crescer:** 07, 10, 18, 23, 28. **Confira e passe:** 06, 09, 27 (Vercel/Netlify/Cloudflare já fazem) e 25 (só se conecta direto no Postgres).

## Os 31 itens

Formato: **o que é** · Vale / Não vale · **Conferir**.

### Frontend
- **01 Skeleton de carregamento (TOP 10).** Esqueleto no formato do conteúdo em vez de tela branca/spinner. Vale: toda tela que busca dados. Não vale: conteúdo que já vem no HTML. Conferir: Network em Slow 4G, recarregar; esqueleto do mesmo tamanho e nada pula. Fazer os 3 estados: carregando (skeleton), vazio (frase + botão de próximo passo), erro (mensagem em português + "tentar de novo"). Next App Router: `loading.tsx`/Suspense; Vite: estado de carregamento da busca. Comece pela tela mais usada.
- **02 Imagens WebP/AVIF no tamanho exibido (TOP 10).** Vale: quase sempre, ainda mais foto e upload do usuário. Não vale: ícone e logo (SVG). Conferir: Network → Img → Type webp/avif e nenhuma imagem de MB. Next: `next/image` com width/height (ou fill + sizes) e `images.formats: ['image/avif','image/webp']`. Vite: WebP/AVIF no tamanho certo com srcset/sizes. Upload no Supabase Storage: redimensionar no upload ou transformação de imagem do Supabase.
- **04 Debounce na busca/autocompletar (TOP 10).** Vale: busca, filtro, autocompletar, salvamento automático. Não vale: filtro local em lista pequena carregada. Conferir: digitar "notebook" = 1 requisição, não 8. Fazer: ~300 ms, cancelar a anterior com AbortController, mínimo 2 caracteres, hook pequeno sem biblioteca nova.
- **11 Remover dependências não usadas.** Vale: projeto com muita iteração. Não vale: caçar pacote que só roda no servidor/build. Conferir: `npx knip`; confira cada item antes de apagar.
- **14 UI otimista.** Like/check/edição aparece na hora, servidor confirma por trás, se falhar volta e avisa. Vale: ação simples que quase nunca falha. Não vale: pagamento, estoque. Conferir: rede lenta muda na hora; Offline volta ao estado anterior com aviso.
- **15 Lazy nas imagens fora da tela (TOP 10).** Vale: listas, feeds, páginas longas. Não vale: imagem principal do topo (essa carrega primeiro: Next 16 `preload`, antes `priority`, ou `fetchPriority="high"`; confira a versão). Conferir: Network → Img sem rolar mostra só a primeira tela. Toda imagem com width/height.
- **20 Renderizar no servidor ou no build.** Vale: landing, blog, produto, tudo público com SEO. Não vale: painel atrás de login; Lovable é Vite, migrar é grande, só para página pública com SEO. Conferir: Ctrl+U tem o texto; só `<div id="root">` vazio = renderizado no navegador.
- **21 Scripts de terceiros depois da página.** Pixel, chat, analytics, mapa. Não vale: o que precisa rodar antes (aviso de cookies obrigatório). Conferir: Waterfall, scripts de outros domínios depois da linha Load; Next `next/script` com `lazyOnload`/`afterInteractive`.
- **22 JavaScript dividido por página.** Componente pesado (editor, gráfico, mapa) sob demanda. Não vale: repartir componente pequeno (Next já divide por rota). Conferir: Ctrl+Shift+P → Show Coverage. Correção: `next/dynamic` ou `React.lazy`.
- **23 Virtualizar listas longas.** Vale: centenas de itens numa tela. Não vale: se já pagina de 20 em 20. Conferir: Elements com poucas dezenas de linhas. TanStack Virtual ou react-window.
- **26 Evitar re-render desnecessário.** Vale: tela trava ao digitar/rolar. Não vale: memo em tudo por precaução (React Compiler já faz onde ligado). Conferir: React DevTools → Profiler → "Highlight updates"; digitar só faz piscar o campo.
- **29 Fontes no próprio domínio e poucos pesos.** Next: `next/font`. Não vale: fonte do sistema. Conferir: Network → Font, 2–3 arquivos do seu domínio.

### Rede
- **06 Estáticos por CDN.** Vale: VPS própria. Não vale: Vercel/Netlify/Cloudflare já fazem. Conferir: headers `x-vercel-cache: HIT`, `cf-cache-status: HIT`.
- **09 Brotli/Gzip.** Vale: servidor próprio (Nginx, Node na VPS). Conferir: `content-encoding: br` ou `gzip`.
- **19 Servidor perto do banco (TOP 10).** Vercel roda funções em Washington (iad1) por padrão; muito Supabase brasileiro está em São Paulo. Vale: rotas de API/server actions que consultam o banco. Não vale: front falando direto com o Supabase sem servidor. Conferir: Supabase → Project Settings → General (região) e Vercel → Settings → Functions → Function Region: mesma região ou a mais próxima.
- **27 Cache dos estáticos no navegador.** Vale: imagens, fontes e JS com hash no nome. Não vale: HTML e dado que muda. Conferir: `cache-control: public, max-age=31536000, immutable` e "(memory/disk cache)" ao recarregar.

### API
- **03 Chamadas duplicadas.** Vale: sempre. TanStack Query/SWR ou buscar uma vez e passar aos componentes. Atenção: StrictMode em dev roda efeitos 2x de propósito, confira no build de produção. Conferir: Fetch/XHR ordenado por Name, mesma URL repetida.
- **05 Paginar (TOP 10).** Vale: lista que cresce com o uso. Não vale: lista de poucas dezenas. Conferir: contar itens na Response. Supabase: `.range(0, 19)`.
- **12 Timeout nas APIs externas.** Vale: toda chamada externa (ajuste: IA longa precisa mais que CEP). Conferir: `AbortSignal.timeout(` ou opção da SDK; testar com `https://httpbin.org/delay/30`, tela mostra erro e "tentar de novo".
- **13 Resposta da IA em streaming (TOP 10).** Vale: todo texto gerado por IA mostrado ao usuário. Não vale: JSON processado antes de mostrar. Fazer: servidor em stream (AI SDK `streamText`; SDKs OpenAI/Anthropic `stream: true`), front mostra conforme chega (`useChat`/`useCompletion`). Manter chave só no servidor, timeout, botão de parar, erro se cair no meio, salvar no banco só no fim. Conferir: primeiras palavras aparecem antes do fim.
- **16 Requisições independentes em paralelo.** Não vale: quando uma depende da outra. Conferir: Waterfall sem "escada". Código: `Promise.all`.

### Backend
- **07 Tarefas lentas numa fila.** PDF, vídeo, 500 e-mails. Vale: vários segundos ou estoura o limite da função. Não vale: app pequeno com tarefa de 1–2 s; antes tente `after()` do Next. Conferir: rota responde rápido e tarefa aparece no painel (Inngest, Trigger.dev, QStash).
- **10 Cache no Redis.** Vale: consulta pesada muito pedida e que muda pouco. Não vale: app pequeno; antes use cache do Next (revalidate) e arrume consultas (08, 17, 24). Conferir: logar hit/miss e comparar tempo.
- **28 Várias instâncias.** Vale: VPS com CPU no talo no pico. Não vale: Vercel/Netlify (já escalam) e app pequeno. Conferir: CPU/memória no pico; `npx autocannon -c 50 -d 20 https://seu-app/rota` só no app da pessoa.

### Banco de dados (no vibe coding com Supabase, quase sempre a maior lentidão)
- **08 Consultas N+1 (TOP 10).** 20 posts + 1 consulta por autor = 21. Vale: sempre. Correção: `.select('id, titulo, autor:profiles(nome)')`, `.in('id', ids)` ou JOIN. Procure consulta dentro de loop/map/forEach ou componente que busca o próprio dado por item; diga quantas consultas uma tela de 20 itens dispara. Conferir: Network filtro "rest/v1", uma requisição por item = N+1.
- **17 Índices nas consultas comuns (TOP 10).** Postgres não indexa chave estrangeira sozinho (`user_id`). Vale: colunas de filtro/ordenação em tabela que cresce. Não vale: tabela de poucas centenas de linhas nem índice "por garantia" (deixa escrita mais lenta). Conferir: `explain analyze select ...` no SQL Editor; Seq Scan em tabela grande = falta índice, depois deve virar Index Scan. Supabase tem Query Performance e Index Advisor.
- **24 Só as colunas necessárias (TOP 10).** Trocar `select('*')`/`select()` pela lista que a tela usa; texto longo, JSON, embedding, base64 só no detalhe. Manter tipos do TypeScript. Conferir: coluna Size da requisição antes e depois.
- **25 Pool de conexões.** Vale: servidor conecta direto no Postgres (Prisma, Drizzle, pg) em serverless; no Supabase use o pooler em modo transaction (`pooler.supabase.com:6543`). Não vale: só supabase-js (HTTP). Sinal: "too many connections" / "remaining connection slots".

### Medição
- **18 OpenTelemetry.** Vale: backend com várias etapas sem saber onde demora. Não vale: app pequeno (comece pelos logs da Vercel com tempo por rota). Next: `instrumentation.ts`. Ferramentas: Sentry, Honeycomb, Grafana, Jaeger.
- **30 Monitorar usuários reais.** Vercel Speed Insights ou biblioteca `web-vitals` para o analytics. Não vale: antes de ter tráfego. Comparar com 2,5 s, 200 ms e 0,1.
- **31 Testar no celular e rede lenta (TOP 10).** Sempre, antes e depois de cada mudança. F12 → Ctrl+Shift+M → Slow 4G; aba Performance com CPU throttling; melhor ainda, no celular no 4G sem wi-fi.

## Lovable

No Lovable, auditoria no modo chat/plano para não sair editando. Itens "NÃO CONSEGUI VER" a pessoa confere com o "Conferir" de cada item.
