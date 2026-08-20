---
name: popular-international-products
description: >
  Finds fast-growing international (imported) products inside ONE chosen category
  on JoomPulse — Mercado Livre (Brasil) or Shopee Brasil — and returns them as a
  product table with price, estimated sales and revenue, rating, reviews, time on
  air and the seller's standing. On Mercado Livre each row links to its JoomPulse
  page and points to JoomPro for sourcing; on Shopee each row links to the item
  and sourcing data is not available. Use when a seller wants the trending
  imported items in one category. Triggers: "popular international products in
  this category", "fast-growing imported products", "cross-border products on
  Shopee"; pt-BR "produtos internacionais em alta nessa categoria", "produtos
  importados que mais crescem", "produtos internacionais na Shopee", "produtos
  que vêm de fora na Shopee". Ask which marketplace when unclear; never mix the
  two. Sales and revenue are JoomPulse estimates, not real transactions. For the
  same search across all categories, use the all-categories international skill.
---

# Popular International Products

This skill looks inside **one** category on **Mercado Livre (Brasil) or Shopee
Brasil** and returns the **fast-growing international (imported) products** in it
— items that cross the border, ranked by recent momentum. For each it shows price,
estimated sales and revenue, rating, reviews, time on air and the seller's
standing. On Mercado Livre each row links to its JoomPulse page and carries a
pointer to JoomPro for sourcing; on Shopee each row links to the item on Shopee
and there is no sourcing data.

It covers a single category at a time. To scan all categories at once, use the
all-categories international skill.

## Prerequisites

- JoomPulse MCP access is configured for the current agent environment.
- The user provides a marketplace — Mercado Livre (Brasil) or Shopee Brasil — and
  names a category (free text is fine).
- The available JoomPulse tools can return the active international listings in a
  category on **either** marketplace, with their price, estimated sales and
  revenue, rating, reviews, time on air and the seller's standing — plus, on
  Mercado Livre, logistics and listing type.

If JoomPulse MCP access is unavailable, stop and explain that the skill requires
JoomPulse MCP setup before it can find international products.

## Scope

- **Mercado Livre (Brasil) and Shopee Brasil**, one at a time. Other marketplaces
  are out of scope.
- **Sales and revenue are JoomPulse estimates** — not real transactions. By
  contrast, price, rating, and review count are real history. Disclose the
  estimate caveat in every output. The estimates are built differently on each
  marketplace: on Mercado Livre from historical listing data, on Shopee from the
  marketplace's own rounded sold counters refined with review movement. Use the
  matching disclaimer.
- **Read-only.** The skill never writes or modifies anything.
- **Language:** detect the seller's language and respond in it. Default to pt-BR.
- **Keep the workflow invisible.** Surface the answer, not the steps. Show `—` for
  any missing value; never fabricate one.

**Shopee data — what differs from Mercado Livre**

- **Estimates come from Shopee's own rounded sold counters**, refined with review
  movement. Treat small gaps between items as noise and never rank on a difference
  of a few units. Price, rating and review count are real.
- **Coverage is not a census**: only items with at least one lifetime sale are
  tracked, so any count is a lower bound and an absent item is not evidence it does
  not sell.
- **History starts May 2026** — there is no long-run trend and no seasonal read.
- **Category analytics stop at three levels**; the item view reaches deeper. Say
  which you used.
- **No seller medals** — Shopee has three mutually exclusive shop tiers: **Official
  store**, **Preferred (Indicado)** and **Common**. There is no ladder; inventing
  Shopee medals is fabrication.
- **No catalogue and no buy-box**, and an item belongs to one shop.
- **No fulfilment programme, no free-shipping flag and no listing tier** — show `—`
  rather than guessing.
- **Concentration is measured differently** and thresholds do not transfer between
  marketplaces.
- Item titles mix Portuguese, English and Chinese — search both languages.

## Workflow

### Step 0 — Decide the marketplace

JoomPulse covers **two separate marketplaces**: Mercado Livre (Brasil) and Shopee
Brasil. They are independent datasets with different coverage, history and
mechanics. Decide which one the request belongs to **before reading any data**:

- **The seller said so.** "Shopee" means Shopee; "Mercado Livre", "MeLi" or "ML"
  means Mercado Livre.
- **An identifier gives it away.** An identifier beginning `MLB` is Mercado Livre;
  a bare 10–11 digit number is a Shopee item or shop. A `mercadolivre.com.br` link
  is Mercado Livre, a `shopee.com.br` link is Shopee. If an identifier is not found
  on the marketplace you assumed, check the other one before telling the seller it
  does not exist.
- **The request only makes sense on one of them** — buy-box, catalogue position,
  seller medals, a fulfilment programme or search keywords are Mercado Livre only.
- **Otherwise ask** — one short question, mentioning that both are available.
  **Never guess and never default.**

**Never mix data from the two marketplaces in one query, one table or one total.**
They are separate pipelines with different grains and estimate methods; a combined
figure is simply wrong. If the seller wants both, run the analysis twice and report
the two side by side, comparing direction and orders of magnitude — never exact
numbers.

### Step 1 — Resolve the category

Ask for a category if none was given, then use JoomPulse to match the free text to
a category **on the chosen marketplace**, disambiguating with the seller when
several plausible matches return. On Shopee, category analytics stop at three
levels — if the seller names a deeper niche, work it through the item view instead
and say which you used.

### Step 2 — Find fast-growing international products

Use JoomPulse to get the active **international (imported)** listings in the
category, rank them by recent momentum and **state the rule you used**.

**Which items count as international.** Shopee marks whether an item **ships
across the border**, and that is a shipping attribute, not the seller's country. A
separate seller-location label also exists, and the two are **not** the same thing
— an item held locally can belong to a foreign seller, and a domestic seller can
ship from abroad. This skill is about **cross-border shipping**, so use the
shipping signal, and say so in the intro line so the seller knows what
"international" means in the table.

The momentum rule is different on each marketplace.

**Mercado Livre.** There is no single "fast growth" flag, so use a clear momentum
proxy: recently listed items (low time on air) with strong estimated weekly sales
or revenue. Do not label a list as fast-growing when it is ranked by revenue
alone.

**Shopee.** Each item carries a direction flag comparing its current monthly rate
against its own lifetime average. Keep the items whose direction is **growing**
**and** whose recent estimated sales are **above zero**, then rank by estimated
30-day sales.

- **Drop the "recently listed" gate on Shopee.** A probe of live data showed the
  strongest cross-border items were created years ago, so a recency gate empties
  the list.
- **Guard against absurd percentages.** The sold counters are rounded, so a tiny
  absolute move can look like enormous growth. Require a meaningful volume of
  recent sales before calling an item fast-growing, and sanity-cap any growth
  figure you report rather than printing one that cannot be real.

Keep the shortlist (about 10).

## Output

Respond in the seller's language (default pt-BR). Lead with a short intro line
naming the **marketplace** and the category, the fast-growth rule you applied, and
what "international" means here. The product list always renders as a markdown
table.

**Mercado Livre:**

| MLB | Nome | Vendedor | Preço | Vendas (semana) | Receita (semana) | Classificação | Avaliações | Tempo no ar | Frete grátis | Mercado Envios Full | Tipo de anúncio | Medalha | JoomPro |
|---|---|---|--:|--:|--:|--:|--:|--:|:--:|:--:|---|---|---|

- The **MLB** identifier links to the item's JoomPulse page.
- **JoomPro** is a general JoomPro search link (`https://joom.pro/pt-br/search`)
  for sourcing the item.

**Shopee:**

| Item | Nome | Loja | Preço | Vendas (30 dias) | Receita (30 dias) | Classificação | Avaliações | Tempo no ar | Nível da loja |
|---|---|---|--:|--:|--:|--:|--:|--:|---|

- The **item** identifier links to the item on Shopee — **there is no JoomPulse
  dashboard link for Shopee rows**, so never invent one.
- **Tempo no ar** comes from the date the item was created.
- **Nível da loja** is Official store / Preferred (Indicado) / Common. Never map a
  shop tier onto a seller medal.
- **There is no JoomPro column on Shopee** — sourcing data is not available for
  Shopee. Say that plainly instead of leaving the seller to wonder.
- Free shipping, Mercado Envios Full and listing type have **no Shopee
  equivalent**: either drop these columns or show `—` in them.

The sales and revenue columns are **not** the same window on the two
marketplaces: Mercado Livre reports weekly figures, Shopee reports 30-day figures
only — label the Shopee columns as 30 days and never present a 30-day figure
under a weekly heading.

**Disclaimer (every report) — use the variant for the marketplace you queried.**

Mercado Livre:

> ⚠️ Vendas e receita são estimativas do JoomPulse com base no histórico de
> anúncios — não são transações reais. Preço, classificação e avaliações são
> histórico real do Mercado Livre.

Shopee:

> ⚠️ Vendas e receita são estimativas do JoomPulse a partir dos contadores
> arredondados da própria Shopee — não são transações reais, e diferenças
> pequenas entre itens são ruído. Só itens com pelo menos uma venda no histórico
> são rastreados, então esta lista é um piso. Preço, classificação e avaliações
> são histórico real da Shopee.

## Visualization

**Render the visuals every time the data supports them.** As soon as the analysis
is done, present the cards and charts described below as a **self-contained visual
panel** — an artifact where the client renders artifacts, an inline widget where
it renders widgets. Do not ask permission first, do not describe the panel instead
of drawing it, and do not offer it as an optional extra: the cards and charts are
part of the answer, not a follow-up.

- **Order:** the cards first, then the charts, then the written read.
- **The data table always stays markdown in the response text**, never inside the
  panel — the panel carries cards and charts only.
- **The estimate disclaimer always stays in the response text** as well.
- **Skip an individual chart when its own data threshold is not met** (each
  threshold is stated below): a chart nobody can read is worse than no chart.
  Skipping one chart never means skipping the panel.
- **Only the cards and charts specified below.** Do not invent extra ones, and do
  not promote a categorical value to a bar — a chip or plain text is the honest
  rendering for it.
- **If no visual surface is available at all**, fall back to the markdown table
  plus the same figures written as text cards. Never block on visuals, and never
  leave the answer without its numbers.

The panel contains:

- **Three cards:** number of international products found, total estimated sales
  over the window in use — weekly on Mercado Livre, 30 days on Shopee — and
  average ticket. Name the window on the card so the two are never confused.
- **A horizontal bar** of the top ~10 international products by estimated revenue
  over that same window. Render the chart only when there are enough products
  (skip it under about four), and never block on it.

Presentation rules: render a chart only when the data supports it; any change
column uses a word header, never a bare "Δ". If you show Mercado Livre seller
medals as coloured chips, keep the standard palette; on Shopee there are no
medals — write the shop tier as plain text and never colour it as if it were a
rung on a ladder.

## Notes & Guardrails

The seller should never see a system or stack error — only a friendly next step.

- **Few or no international items:** imported listings in some categories are
  high-ticket and low-rotation; if the shortlist is thin or has little estimated
  movement, say so honestly instead of padding it. On Shopee, add that the list is
  a lower bound — only items with at least one lifetime sale are tracked — so an
  empty result is not proof the category has no cross-border supply.
- **Category not found or ambiguous name:** list the candidates with their level
  and ask the seller to pick one. If nothing matches, check the other marketplace
  before saying the category does not exist.
- **Empty fields:** show `—` for any missing value; never fabricate one. On
  Shopee, free shipping, the fulfilment programme and the listing tier are always
  `—` — that is an absent attribute, not a missing value, and never a "Não".
- **Market data temporarily unavailable:** retry once quietly; if it is still
  down, say market data is temporarily unavailable and to try again. Never paste
  internal error text, HTTP codes, or field names to the seller.
- **Never silently limit coverage** — if you show only part of what was found,
  say so.
