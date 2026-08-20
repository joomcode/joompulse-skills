---
name: category-monitor
description: >
  Monitors one category's aggregate health on JoomPulse — Mercado Livre
  (Brasil) or Shopee Brasil: estimated sales, product count, seller count,
  the seller-tier mix and market concentration. Each run builds today's
  snapshot table and offers it for download; send a table from a previous
  period and the skill shows the metric-by-metric difference. The baseline is
  whatever table the user supplies — no hidden session memory. Triggers:
  "monitor this category", "what changed in this category", "track category
  sales and sellers", "monitor a Shopee category"; pt-BR "monitorar esta
  categoria", "o que mudou na categoria", "comparar a categoria com o período
  anterior", "monitorar categoria na Shopee", "o que mudou na categoria da
  Shopee". Ask which marketplace when unclear; never mix the two. Sales and
  revenue are JoomPulse estimates, not real transactions. To track one named
  product over time use the product-change-monitor skill; for a one-shot
  opportunity snapshot use the category-opportunity-index skill.
---

# Category Monitor

This skill tracks **one category's aggregate health over time** on **Mercado
Livre (Brasil) or Shopee Brasil** — its estimated sales, how many products and
sellers it holds, how those sellers split across tiers, and how concentrated
the market is.

Each run builds **today's snapshot table** for the category and offers it as a
**downloadable table**. To see what changed, the user **supplies the table from
a previous period** (the one this skill produced before); the skill compares the
two and shows the difference per metric. **The baseline is whatever table the
user provides — there is no hidden session memory and nothing is stored
server-side.** The default view is the whole category; on Mercado Livre the user
may instead point it at a single listing or a catalog product (a catalog product
rolls up its competing listings). **Shopee has no catalogue at all**, so that
input mode does not exist there.

To track one named product over time, use the product-change-monitor skill. For
a one-shot opportunity / market-size snapshot, use the
category-opportunity-index skill.

## Prerequisites

- JoomPulse MCP access is configured for the current agent environment.
- The user provides a marketplace — Mercado Livre (Brasil) or Shopee Brasil —
  and names a category (on Mercado Livre, optionally a single listing or a
  catalog product instead).
- For a period comparison, the user supplies a previous table that this skill
  produced for the **same category on the same marketplace** (pasted or
  uploaded). Without it, the skill produces a standalone snapshot.
- The available JoomPulse tools can resolve a category name to its identifier
  and return that category's monthly aggregate metrics and its seller-tier
  breakdown on **either** marketplace.

If JoomPulse MCP access is unavailable, stop and explain that the skill requires
JoomPulse MCP setup before it can monitor a category.

## Scope

- **Mercado Livre (Brasil) and Shopee Brasil**, one at a time. Other
  marketplaces are out of scope.
- **Sales and revenue are JoomPulse estimates** — not real transactions.
  Disclose this in every output. The estimates are built differently on each
  marketplace: on Mercado Livre from historical listing data, on Shopee from the
  marketplace's own rounded sold counters refined with review movement. Use the
  matching disclaimer.
- **Read-only.** The skill never writes or modifies anything; it does not store
  the snapshot — the user keeps the downloadable table and brings it back next
  period.
- **Language:** detect the seller's language and respond in it. Default to
  pt-BR.
- **The baseline is user-supplied.** Never claim a change without a previous
  table to compare against, and never infer or fabricate one from memory.

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

### Step 1 — Resolve what to monitor

Ask for a category if none was given, then use JoomPulse to match the free text
to a category **on the chosen marketplace** (disambiguate with the user when
several plausible matches return, listing the candidates with their level). On
Mercado Livre the user may instead point the skill at a single listing or a
catalog product. On Shopee, **category analytics stop at three levels and there
is no catalogue** — if the seller names a deeper niche, answer at its level-3
ancestor and say out loud which category the snapshot actually describes; a
catalog product is not an available input there.

### Step 2 — Collect today's aggregates

Use JoomPulse to collect, for the target:

- **Mercado Livre:** estimated sales, number of products, number of catalog
  products, number of active sellers, the seller-medal distribution, and the
  monopolization level.
- **Shopee:** estimated sales, number of products, number of sellers, the split
  across the three shop tiers (Official store / Preferred (Indicado) / Common),
  and the concentration measure. **Omit the catalog-products metric entirely** —
  Shopee has no catalogue, so drop that row rather than leaving it blank. There
  are no medals and no ladder either: report the three-tier breakdown, never a
  four-tier medal one.

Two Shopee-specific cautions:

- **The flag that marks a month as the latest is unreliable.** Resolve the most
  recent available month explicitly instead of trusting it, and state in the
  output which month the snapshot describes.
- **Concentration is a different measurement on the two marketplaces.** On
  Mercado Livre it is the leading seller's share (monopolization); on Shopee it
  is an index computed across all sellers. Label it with the term that belongs
  to the marketplace you queried, and never compare the two marketplaces'
  values.

### Step 3 — Present today's snapshot and offer it for download

Render the snapshot table for **today**, headed with the marketplace, the
category name and the date — and, on Shopee, the month the aggregates cover.
This table is the deliverable — and **offer it as a downloadable file (`.csv` /
`.xlsx`)** so the user can save it and bring it back next period as the
baseline. On a standalone snapshot there is **no change column and no color-dot
legend** — just metric and current value.

### Step 4 — Offer comparison, and compare if a previous table is supplied

Invite the user to send a previous table for the same category **on the same
marketplace** to compare periods. **If they provide one**, parse its metric
values, align by metric to today's snapshot, and render a comparison table with
the difference per metric. A difference **requires both an old and a new value**
for the same metric — if a metric is missing or unreadable in the supplied
table, show `—`, never a fabricated trend. If no previous table is supplied, the
snapshot stands on its own and the user is told to save it for next time.

On Shopee the comparison is also limited by the data itself: **history starts
May 2026** and partial months are excluded, so a prior period may simply not
exist yet. Say that plainly instead of inventing a baseline or comparing against
an incomplete month.

## Output

Respond in the seller's language (default pt-BR). Name the marketplace the
figures came from.

**Snapshot (always):** a markdown table `| Métrica | Valor atual |`, plus a
downloadable `.csv` / `.xlsx` of the same data.

- **Mercado Livre** rows: **Vendas (estimadas), Produtos, Produtos de catálogo,
  Vendedores, Distribuição de medalhas, Monopolização**.
- **Shopee** rows: **Vendas (estimadas), Produtos, Vendedores, Distribuição por
  tipo de loja, Concentração** — there is **no Produtos de catálogo row**; omit
  it rather than showing it empty.

**Comparison (only when a previous table is supplied):** a markdown table `|
Métrica | Anterior | Atual |`. Put the change (figure or percentage point)
inside the **Atual** cell, prefixed with a semantic color dot:

- **Vendas ↑ = 🟢**; Vendas ↓ = 🔴.
- **Monopolização (Mercado Livre) and Concentração (Shopee) are inverted** (like
  cancellation rate): **down = 🟢** (easier to enter), **up = 🔴**. The
  direction rule holds on both marketplaces even though the measurements differ.
- **Produtos / Vendedores** moving is neutral context — show the change without
  a strong good/bad dot.
- **Distribuição de medalhas** (Mercado Livre) — show the tiers that moved (for
  example `platina 4 → 5`). On Shopee the same line is the **shop-tier
  breakdown**: show which of the three tiers moved (for example `Indicado 12 →
  15`), and never phrase it as a medal or a rung.

Column headers are words (`Métrica | Anterior | Atual`), never a bare "Δ"
symbol. Show the color-dot legend (🟢/🔴) **only** in the comparison table,
where the dots actually appear — never on a plain snapshot.

Close with a short **Principais insights** section: with a comparison, interpret
what moved; on a standalone snapshot, frame it as the starting picture with no
trend claims.

**Disclaimer (every report) — use the variant for the marketplace you queried.**

Mercado Livre:

> ⚠️ Vendas, vendedores, produtos e monopolização são estimativas do JoomPulse
> com base no histórico de anúncios — não são transações reais. / Sales,
> sellers, products, and monopolization are JoomPulse estimates based on
> historical listing data — not actual transactions.

Shopee:

> ⚠️ Vendas são estimativas do JoomPulse a partir dos contadores arredondados da
> própria Shopee — não são transações reais. Só itens com pelo menos uma venda
> no histórico são rastreados, então as contagens são um piso, e a concentração
> é medida de forma diferente da do Mercado Livre. / Sales are JoomPulse
> estimates built from Shopee's own rounded sold counters — not actual
> transactions. Only items with at least one lifetime sale are tracked, so the
> counts are a lower bound, and concentration is measured differently than on
> Mercado Livre.

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

- **Cards:** estimated sales, number of products and number of active sellers,
  plus the concentration figure as a value or small bar — labelled
  Monopolização on Mercado Livre, Concentração on Shopee. On Mercado Livre add a
  **number of catalog products** card; on Shopee there is **no such card** —
  drop it. With a comparison, you may annotate each card with its `anterior →
  atual` change.
- **A distribution bar:** on Mercado Livre, sellers (or listings) split across
  medal tiers using the medal palette — platina = purple, ouro = amber, prata =
  blue, sem medalha = white with a thin border (white needs the border to stay
  visible on a light background). On Shopee, a **three-tier** bar — Official
  store / Preferred (Indicado) / Common — with plain labels and a neutral
  palette: no medal colours, no four-tier phrasing, and never a shop tier mapped
  onto a medal. With a previous table, note the shift.
- **No synthesized trend line** from a single run (there is no server-side
  history). Only if the user supplies several past-period tables may you plot a
  simple line across those periods.

Presentation rules: column headers are words, never a bare "Δ" symbol; show the
color-dot legend only when those dots appear (the comparison table); and the
downloadable file mirrors what is shown.

## Notes & Guardrails

The seller should never see a system or stack error — only a friendly next step.

- **No previous table supplied:** render today's snapshot only (no change
  column, no legend) and invite the user to save it for next time.
- **Supplied table is for a different category, a different marketplace,
  malformed, or unreadable:** say so plainly and fall back to the snapshot only;
  do not force a misaligned comparison, and never align a Shopee table against
  a Mercado Livre one.
- **No prior period available on Shopee:** history starts May 2026 and partial
  months are excluded — say the comparison has no baseline yet instead of
  producing one.
- **Category deeper than Shopee's third level:** answer at its level-3 ancestor
  and state which category the numbers actually describe.
- **Empty or failed data:** say the data is temporarily unavailable and to try
  again. Never paste internal error text, HTTP codes, or field names to the
  seller.
- **Catalog product input (Mercado Livre only):** when monitoring a catalog
  product, note the buy-box competition (how many sellers compete) rather than
  implying a single listing. Shopee has neither a catalogue nor a buy-box, so
  this mode does not apply there.
