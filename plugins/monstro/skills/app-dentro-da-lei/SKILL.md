---
name: app-dentro-da-lei
description: Checklist legal brasileiro de 24 itens (LGPD, CDC, direitos autorais, marcas e acessibilidade) para revisar e corrigir um app, site ou SaaS antes de lançar. Use AUTOMATICAMENTE antes de publicar/lançar/fazer deploy de produção de um app com usuários, e sempre que criar ou mexer em cadastro/login, coleta de dados pessoais, cookies/analytics/pixel, e-mail de marketing, checkout/pagamento/assinatura, página de vendas/landing page, depoimentos, rodapé, termos de uso ou política de privacidade. Também quando a pessoa pedir "deixa o app dentro da lei", "LGPD", "CDC", "termos de uso", "política de privacidade".
---

# App dentro da lei

Checklist de 24 itens para conferir antes de lançar um app feito com IA, com a base legal de cada um e o que implementar. Fonte: material "Seu app dentro da lei" de Pedro Zanatta (@pedrozanatta1). **Não é consultoria jurídica:** para produto com pagamento, dados sensíveis ou público infantil, diga à pessoa que passe por um advogado.

## Como rodar

1. Leia o projeto e descubra o que ele realmente faz: que dados coleta, se tem cadastro, cookies/rastreadores, e-mail de marketing, venda, assinatura, página de vendas, logos de terceiros, conteúdo gerado por IA, se menores podem usar.
2. Para **cada item** abaixo, marque **OK**, **Parcial**, **Faltando** ou **Não se aplica** (com o motivo em uma linha).
3. **Implemente o que faltar sem quebrar nada**, na ordem: 1º Dados (01–13), 2º Consumidor (14–21), 3º o resto (22–24 e bônus). Siga o "O que fazer" de cada item. Textos legais (termos, política) são baseados no que o app **realmente** coleta e faz, nunca genéricos.
4. O que depende de informação ou decisão da pessoa (CNPJ, endereço, e-mail de contato, prazos de guarda, contratos com fornecedores, autorização de logos/depoimentos): **não invente**. Deixe um marcador claro (`[PREENCHER: CNPJ]`) e liste no fim.
5. Entregue a **lista final**: os 24 itens com o status antes → depois, o que mudou (arquivos) e uma seção **"O que você precisa decidir/fornecer"**.
6. Com o app pronto, rode o checklist de novo e liste o que não foi possível cumprir, por quê e o que a pessoa precisa decidir.

## Bloco 1 · Dados (LGPD)

| # | Item | Base legal | O que fazer |
|---|---|---|---|
| 01 | Política de privacidade e termos de uso visíveis | LGPD art. 9º · CDC art. 46 | Criar /privacidade e /termos com base no que o app realmente coleta e faz; link no rodapé de todas as páginas e na tela de cadastro. |
| 02 | Checkbox de aceite dos termos, com registro | LGPD art. 8º · CDC art. 46 | No cadastro, checkbox **desmarcado** "Li e aceito os termos e a política de privacidade". Salvar no banco data, hora e versão aceita. |
| 03 | Banner de cookies com botão de recusar | Guia de cookies da ANPD (2022) | Banner com Aceitar, Recusar e Configurar, **todos com o mesmo destaque** (nada de só "OK"); salvar a escolha. |
| 04 | Nenhum rastreador antes do consentimento | Guia de cookies da ANPD (2022) | Google Analytics, pixel da Meta e qualquer script de rastreio só carregam depois do aceite. |
| 05 | Consentimento separado para marketing | LGPD art. 8º, §4º | Checkbox próprio, desmarcado e opcional para e-mails/mensagens de marketing; o cadastro funciona sem ele. |
| 06 | Link de descadastro em todo e-mail de marketing | LGPD art. 8º, §5º | Link de descadastro de um clique em todo e-mail de marketing; marcar o usuário como descadastrado no banco. |
| 07 | Coletar só o dado necessário | LGPD art. 6º, III (necessidade) | Listar todos os dados coletados e para que serve cada um; remover campos sem uso (CPF, nascimento, endereço que não são usados). |
| 08 | Prazo de guarda para cada dado e exclusão no fim | LGPD arts. 15 e 16 | Tabela com cada dado e por quanto tempo fica guardado + job que apaga ou anonimiza o que passou do prazo. |
| 09 | Acesso, correção e exclusão pelo próprio usuário | LGPD art. 18 | Tela "Meus dados": baixar os dados, corrigir e pedir exclusão da conta. |
| 10 | Encarregado de dados ou, no mínimo, um canal de contato | LGPD art. 41 · Res. CD/ANPD 2/2022 | Canal de contato sobre dados pessoais (e-mail e formulário) na política e no rodapé. Pequeno porte pode ficar só com o canal. |
| 11 | Plano para vazamento de dados | Res. CD/ANPD 15/2024 · Res. CD/ANPD 2/2022 | Documento: como detectar, quem decide, modelo de aviso aos usuários e passo a passo para comunicar a ANPD. Risco relevante: avisar ANPD e usuários em até 3 dias úteis (pequeno porte: prazo dobra). |
| 12 | Dado de criança só com consentimento de um dos pais | LGPD art. 14, §1º | Se menores de 12 anos podem usar, só liberar o cadastro após consentimento específico de um dos pais/responsável. Criança ou adolescente pode usar? Vale também o ECA Digital (Lei 15.211/2025), em vigor desde 17/03/2026, fiscalizado pela ANPD. |
| 13 | Contrato com quem processa dados por você | LGPD art. 39 | Listar serviços externos que recebem dados (hospedagem, banco, e-mail, analytics, pagamento) e o link do contrato/DPA de cada um. |

## Bloco 2 · Consumidor (CDC)

| # | Item | Base legal | O que fazer |
|---|---|---|---|
| 14 | CNPJ, endereço e contato no site | Decreto 7.962/2013, art. 2º | Rodapé de todas as páginas com nome da empresa, CNPJ, endereço e um contato (e-mail ou telefone). |
| 15 | 7 dias de arrependimento na venda online | CDC art. 49 · Decreto 7.962/2013, art. 5º | Botão "Desistir da compra" que funciona nos 7 dias após a compra e dispara reembolso total; explicar no checkout como pedir. |
| 16 | Cancelar fácil, pelo mesmo lugar onde assinou | CDC (boa prática) · Decreto 11.034/2022 nos serviços regulados | Botão "Cancelar assinatura" na área do cliente, no máximo 2 cliques, sem obrigar contato com atendimento. |
| 17 | Renovação automática avisada antes da compra | CDC art. 6º, III | Perto do botão de pagar: "Renova automaticamente em [data], por R$ [valor]. Dá pra cancelar quando quiser." |
| 18 | Nenhuma taxa escondida no checkout | CDC art. 31 | Preço final com todas as taxas antes do botão de pagar; nada somado depois. |
| 19 | Sem cronômetro falso de "última chance" | CDC art. 37 | Remover contador, estoque ou "últimas vagas" que não seja real; oferta que acaba usa a data verdadeira. |
| 20 | Sem avaliação falsa | CDC art. 37 | Só depoimentos reais, com autorização de quem escreveu; remover os de exemplo. |
| 21 | Sem promessa que você não cumpre | CDC arts. 30 e 37 | Revisar textos da página de vendas e listar toda promessa que o produto não cumpre hoje (resultado garantido, recurso que não existe). A oferta obriga. |

## Bloco 3 · Direitos e acessibilidade

| # | Item | Base legal | O que fazer |
|---|---|---|---|
| 22 | Licença de imagem, fonte e código | Lei 9.610/1998 · Lei 9.609/1998 (software) · licença de cada pacote | Listar imagens, fontes e bibliotecas com a licença de cada uma e apontar o que não pode ser usado em produto comercial. |
| 23 | Logo de cliente só com autorização | Lei 9.279/1996 (marcas) | Listar todos os logos de outras empresas no app para a pessoa confirmar a autorização de cada um. |
| 24 | Acessibilidade | Lei 13.146/2015 (LBI), art. 63 | Contraste das cores, texto alternativo em todas as imagens, navegação só pelo teclado e rótulos nos campos. Corrigir o que faltar. |

## Bônus · Avisar quando imagem ou texto foi feito com IA

Boa prática, ainda sem obrigação geral no Brasil (o marco legal da IA, PL 2338/2023, foi aprovado no Senado em dez/2024 e em nov/2026 aguardava parecer na comissão especial da Câmara; em propaganda eleitoral o TSE já exige). O que fazer: aviso discreto "feito com IA" nas imagens e textos gerados por IA dentro do app.

## Onde ler as leis

LGPD (Lei 13.709/2018) · CDC (Lei 8.078/1990) · Comércio eletrônico (Decreto 7.962/2013) · LBI (Lei 13.146/2015). Leis e resoluções mudam: se for citar prazo ou artigo como definitivo, confira a versão atual (planalto.gov.br, gov.br/anpd).
