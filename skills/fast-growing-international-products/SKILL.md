---
name: fast-growing-international-products
description: >
  Finds fast-growing international (imported) products ACROSS ALL categories on
  JoomPulse — Mercado Livre (Brasil) or Shopee Brasil — as one product table
  that includes each item's category, plus price, estimated sales and revenue,
  rating, time on air and each marketplace's own logistics, tier and link
  columns. Use when a seller wants rising imported products marketwide, not in
  one niche. Triggers: "fast-growing international products", "imported products
  that are taking off", "cross-border winners across all categories",
  "international products on Shopee"; pt-BR "produtos internacionais em alta",
  "produtos importados crescendo rápido", "produtos internacionais que mais
  crescem em todas as categorias", "produtos importados na Shopee". Ask which
  marketplace when unclear; never mix the two. Sales and revenue are JoomPulse
  estimates, not real transactions; price, rating and reviews are real. For one
  category only, use the single-category international skill.
---

# Fast-Growing International Products

This skill returns the **fast-growing international (imported) products across all
categories** on **Mercado Livre (Brasil) or Shopee Brasil** — a marketwide
shortlist of cross-border items with recent momentum, each shown with the
category it sits in. It is the all-categories sibling of the single-category
international skill.

For imported products inside one specific category, use the single-category
international skill.

## Prerequisites

- JoomPulse MCP access is configured for the current agent environment.
- The user provides a marketplace — Mercado Livre (Brasil) or Shopee Brasil.
- The available JoomPulse tools can return active international listings across
  categories on **either** marketplace, each carrying its own category path,
  price, estimated sales and revenue, rating and review count.
- Per marketplace, the tools can also report: on Mercado Livre, how long the
  listing has been on air, its logistics flags, listing type and seller medal; on
  Shopee, the shop tier, whether the item ships cross-border, the seller's
  location, the item's creation date, and a growth direction flag comparing the
  item's current monthly rate against its own lifetime average.

If JoomPulse MCP access is unavailable, stop and explain that the skill requires
JoomPulse MCP setup before it can find international products.

## Scope

- **Mercado Livre (Brasil) and Shopee Brasil**, one at a time. Other
  marketplaces are out of scope.
- **Sales and revenue are JoomPulse estimates** — not real transactions. Price,
  rating, and reviews are real history. The estimates are built differently on
  each marketplace: on Mercado Livre from historical listing data, on Shopee from
  the marketplace's own rounded sold counters refined with review movement. Use
  the matching disclaimer, and disclose the estimate caveat in every output.
- **Read-only.** The skill never writes or modifies anything.
- **Language:** detect the seller's language and respond in it. Default to pt-BR.
- **Keep the workflow invisible.** Show `—` for any missing value; never fabricate.

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

### Step 1 — Optional narrowing

This skill is marketwide by default, on both marketplaces: a scan with no
category filter works, and every item carries its own category path, so the
Category column is fillable either way. The seller may optionally narrow it to a
broad area; if they do and the term is ambiguous, disambiguate before continuing.

### Step 2 — Find fast-growing international products marketwide

Use JoomPulse to get active **international (imported)** listings across
categories on the chosen marketplace. There is no single "fast growth" flag, so
it must be defined from a real momentum proxy — **revenue alone is not growth**,
and ranking by it surfaces old, high-ticket slow movers rather than rising items.

**What "international" means, per marketplace.** On Mercado Livre it is the
imported/cross-border listing signal. On Shopee it means the item **ships
cross-border**; a probe showed such items can also carry a specific foreign
country as the seller location, so the two signals are **not** equivalent — pick
one, say which one you used, and do not present them as the same thing.

**Fast-growth rule on Mercado Livre (always apply and disclose):** an item is
"fast-growing" only when it is **recently listed (low time on air)** *and* has
**strong estimated weekly sales (and/or estimated weekly revenue)** — that is, it
gained real traction in a short time. Rank the shortlist by that momentum
(estimated weekly sales/revenue relative to how recently it was listed), not by
revenue on its own. **State this rule in the output.**

**Fast-growth rule on Shopee (different — do not reuse the Mercado Livre rule):**
each item carries a growth direction flag comparing its current monthly rate
against its own lifetime average, so define fast-growing as **direction is
growing AND recent estimated sales above zero**. **Drop the "recently listed"
gate entirely** — Shopee's strongest cross-border items are often years old, and
the gate empties the list. **Never sort descending without first excluding the
zero-sales rows**, or the top of the list fills with items that sell nothing.
State the rule you applied.

Keep a clearly stated **top-N** (for example top 30) and say it is a top-N.

**Fallback (not "growth"):** if the momentum signal is unavailable, you may
instead show the **top international items by estimated revenue** — weekly on
Mercado Livre, over the last 30 days on Shopee, since Shopee has **no marketwide
weekly ranking**. Label it plainly as a *top-by-revenue fallback*, never call it
"fast-growing" or "growth", and say the momentum rule could not be applied.

## Output

Respond in the seller's language (default pt-BR). Lead with a short line naming
the **marketplace** you queried. The product list always renders as a markdown
table, and **includes a Category column** (the cross-category differentiator).

**Product table (Mercado Livre):**

| MLB | Nome | Vendedor | Categoria | Preço | Vendas (semana) | Receita (semana) | Classificação | Avaliações | Tempo no ar | Frete grátis | Mercado Envios Full | Tipo de anúncio | Medalha |
|---|---|---|---|--:|--:|--:|--:|--:|--:|:--:|:--:|---|---|

- The **MLB** identifier links to the item's JoomPulse page.

**Product table (Shopee)** — same shape, with the marketplace's own columns:

| Item | Nome | Loja | Categoria | Preço | Vendas (30 dias) | Receita (30 dias) | Classificação | Avaliações | Tempo no ar | Nível da loja |
|---|---|---|---|--:|--:|--:|--:|--:|--:|---|

- The item identifier links to the item **on Shopee** — there is **no JoomPulse
  dashboard link for Shopee rows**, so never invent one.
- **Nível da loja** is Official store / Preferred (Indicado) / Common. Never map
  a shop tier onto a seller medal.
- **Tempo no ar** comes from the item's creation date. Shopee history starts May
  2026, so an item can predate any measurable sales — a long time on air does not
  mean it has been selling all that time.
- Free shipping, the fulfilment programme and the listing type have **no Shopee
  equivalent**: either drop these columns or show `—` in them.

Sales and revenue are **not the same window** on the two marketplaces: Mercado
Livre reports weekly figures, Shopee reports 30-day figures only — label the
Shopee columns as 30 days and never present a 30-day figure under a weekly
heading.

State the fast-growth rule you actually applied — on Mercado Livre, recently
listed **and** strong estimated weekly sales/revenue, ranked by that momentum; on
Shopee, a growing direction with non-zero recent sales and **no recency gate** —
plus which cross-border signal you used and the top-N cap, in one short line. If
you used the top-by-revenue fallback instead, say so and do not call it growth.

**Disclaimer (every report) — use the variant for the marketplace you queried.**

Mercado Livre:

> ⚠️ Sales and revenue are JoomPulse **estimates** based on historical listing
> data — they are **not** actual transactions. Price, rating, and reviews are
> real Mercado Livre history. / Vendas e receita são **estimativas** do JoomPulse
> com base no histórico de anúncios — **não são transações reais**. Preço,
> classificação e avaliações são histórico real do Mercado Livre.

Shopee:

> ⚠️ Sales and revenue are JoomPulse **estimates** built from Shopee's own
> rounded sold counters — they are **not** actual transactions, and small gaps
> between items are noise. Only items with at least one lifetime sale are
> tracked, so this list is a lower bound. Price, rating, and reviews are real
> Shopee history. / Vendas e receita são **estimativas** do JoomPulse a partir
> dos contadores arredondados da própria Shopee — **não são transações reais**, e
> diferenças pequenas entre itens são ruído. Só itens com pelo menos uma venda no
> histórico são rastreados, então esta lista é um piso. Preço, classificação e
> avaliações são histórico real da Shopee.

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

- **Three cards:** number of products in the shortlist (top-N), number of distinct
  categories represented, and average ticket.
- **A horizontal bar** of the top products by estimated revenue — weekly on
  Mercado Livre, over the last 30 days on Shopee; label the axis with the window
  you used. Add an optional small companion bar of which categories contribute
  the most fast-growing international products. Render charts only when there are
  enough items (skip under about four).

Presentation rules: any change column uses a word header, never a bare "Δ". If
you show Mercado Livre seller medals as colored chips, use the standard palette.
On Shopee there are no medals — write the shop tier as plain text and never
colour it as a rung on a ladder.

## Notes & Guardrails

The seller should never see a system or stack error — only a friendly next step.

- **High-ticket, low-rotation skew:** marketwide imported items can skew toward
  expensive, slow-moving SKUs; surface that honestly rather than implying broad
  momentum that is not there.
- **On Shopee the skew is worse, and you must warn about it:** only items with at
  least one lifetime sale are tracked and very expensive items are excluded from
  coverage, which compounds the high-ticket, low-rotation bias. Say so plainly
  instead of presenting the shortlist as a broad read on the market.
- **Market data temporarily unavailable:** retry once quietly; if it is still
  down, say market data is temporarily unavailable and to try again. Never paste
  internal error text, HTTP codes, or field names to the seller.
- **Never silently limit coverage** — always state the top-N cap.
