---
name: seller-overview-tracker
description: >
  Snapshot tracker for one seller on JoomPulse — Mercado Livre (Brasil) or Shopee
  Brasil. Pulls store name, estimated monthly revenue and sales, listing count,
  sales trend, categories, location, and the seller's reputation or buyer rating;
  medal, cancellation rate and 60/365-day sales are Mercado Livre only. Each run
  builds today's snapshot table and offers it for download; to see what changed,
  the user sends the seller's table from a previous period and the skill shows the
  difference per metric. The baseline is whatever table the user supplies — no
  hidden session memory. Triggers: "track this seller", "monitor this store",
  "what changed for this seller"; pt-BR "monitorar este vendedor", "acompanhar
  esta loja", "o que mudou nesse vendedor", "monitorar esta loja na Shopee",
  "acompanhar este vendedor da Shopee". Ask which marketplace when unclear; never
  mix the two. Sales and revenue are JoomPulse estimates, not real transactions.
  To rank many sellers in a category, use the top-sellers-in-category skill.
---

# Seller Overview Tracker

This skill tracks **one seller over time** on **Mercado Livre (Brasil) or Shopee
Brasil** — its estimated monthly revenue and sales, listing count, sales trend,
average ticket and average price, the categories it covers, its location, and how
buyers rate it. On Mercado Livre it also carries the seller medal, the cancellation
rate and the rolling 60-day and 365-day sales; **none of those three last fields
exist on Shopee**, where the shop tier stands in for the medal.

Each run builds **today's snapshot table** for the seller and offers it as a
**downloadable table**. To see what changed, the user **supplies the seller's table
from a previous period** (the one this skill produced before); the skill compares
the two and shows the difference per metric. **The baseline is whatever table the
user provides — there is no hidden session memory and nothing is stored
server-side.** The seller is identified by a store link or a seller identifier on
either marketplace.

It is different from ranking work: to rank many sellers in a category and track how
that ranking moves, use the top-sellers-in-category skill; to analyze one product, use
the single-product analysis skill. This skill follows **one** seller.

## Prerequisites

- JoomPulse MCP access is configured for the current agent environment.
- The user provides a marketplace — Mercado Livre (Brasil) or Shopee Brasil —
  and one seller as a store link or a seller identifier on that marketplace.
- For a period comparison, the user supplies a previous table that this skill
  produced for the same seller **on the same marketplace** (pasted or uploaded).
  Without it, the skill produces a standalone snapshot.
- The available JoomPulse tools can look up that seller's current market snapshot on
  **either** marketplace. On Shopee the shop's estimated revenue and sales are not
  published as one store-level figure — the tools report them per item, so the skill
  builds the shop total up from its items.

If JoomPulse MCP access is unavailable, stop and explain that the skill requires
JoomPulse MCP setup before it can monitor a seller.

## Scope

- **Mercado Livre (Brasil) and Shopee Brasil**, one at a time. Other marketplaces
  are out of scope.
- **Sales and revenue are JoomPulse estimates** — estimated monthly revenue,
  estimated monthly sales, average ticket, and average price are not real
  transactions. Disclose this in every output.
  - **On Mercado Livre**, by contrast, the rolling 60-day and 365-day sales counts,
    the sales trend, and the cancellation rate are real Mercado Livre data.
  - **On Shopee every sales figure is an estimate** — there is no real-data
    counterpart, so the Mercado Livre sentence above must never appear in a Shopee
    output. Only price, the buyer rating and the review count are real.
- **Read-only.** The skill never signs in as the seller or modifies a listing; it
  does not store the snapshot — the user keeps the downloadable table and brings it
  back next period.
- **Language:** respond in pt-BR by default; mirror another language only if the
  user clearly uses it.
- **The baseline is user-supplied.** Never claim a change without a previous table
  to compare against, and never infer or fabricate one from memory. The previous
  table must be for the **same seller on the same marketplace**.
- **Keep the workflow invisible.** The user wants the answer, not a play-by-play.
  If one approach does not return data, retry quietly; only if it still fails do
  you say one short, friendly sentence.

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

### Step 1 — Resolve the seller and pull today's snapshot

1. Resolve the seller from the store link or seller identifier the user provided,
   **on the marketplace settled in Step 0**. If given a store link, resolve it to
   the seller once.
2. Use JoomPulse to pull the current snapshot for that one seller.
   - **Mercado Livre:** store name, estimated monthly revenue, estimated monthly
     sales, sales trend, cancellation rate, listing count, rolling 60-day and
     365-day sales, the categories covered, seller medal, reputation, average
     ticket and average price, and location.
   - **Shopee:** shop name, the categories the shop covers, its location, its
     buyer rating and review count, average ticket and average price, and the
     shop's item count. **Build the shop's estimated revenue and sales up from
     its items** — there is no store-level figure to read, and the result is an
     estimate, so label it one. For the sales trend, count how many of the shop's
     items are growing, stable and falling. **Cancellation rate and the rolling
     60-day and 365-day sales counts do not exist on Shopee** — do not look for a
     substitute and do not derive one.
3. If the seller is not found, check the other marketplace before saying so; if it
   is on neither, say so plainly and stop — invent nothing.

### Step 2 — Present today's snapshot and offer it for download

Lay out the snapshot fields as a table, headed with the store name, the
**marketplace** and the date. This table is the deliverable — and **offer it as a
downloadable file (`.csv` / `.xlsx`)** so the user can save it and bring it back
next period as the baseline. If any field comes back empty, show `—`; never
substitute a guess. On Mercado Livre add the JoomPulse seller dashboard link; on
Shopee link the shop on Shopee instead — **there is no JoomPulse dashboard link
for Shopee**, so never invent one. On a standalone snapshot there is **no change
column and no color-dot legend** — just field and current value.

### Step 3 — Offer comparison, and compare if a previous table is supplied

Invite the user to send a previous table for the same seller to compare periods.
**If they provide one**, check it is for the same seller **on the same
marketplace**, then parse its values, align by field to today's snapshot, and
render a comparison table with the difference per field. A difference **requires
both an old and a new value** for the same field — if a field is missing or
unreadable in the supplied table, show `—`, never a fabricated trend. On Shopee,
remember the three fields that do not exist there stay `—` on both sides and can
never yield a change. If no previous table is supplied, the snapshot stands on its
own and the user is told to save it for next time.

## Output

Respond in pt-BR by default. Present the result with no commentary about how it was
produced. Lead with a short line naming the **marketplace** and the store.

**Snapshot (always):** a markdown table `| Campo | Valor atual |` for the rows
below, plus a downloadable `.csv` / `.xlsx` of the same data.

**Snapshot / comparison rows (Mercado Livre)** — pt-BR labels:

- Nome da loja
- Receita média mensal (estimada)
- Vendas médias mensais (estimadas)
- Tendência de vendas
- Taxa de cancelamento
- Anúncios
- Vendas (60 dias)
- Vendas (365 dias)
- Categorias
- Medalha (platina / ouro / prata / sem medalha)
- Reputação (5 verde, a melhor … 1 vermelho, a pior)
- Ticket médio / preço médio
- Localização (cidade, estado, país)
- Link JoomPulse do vendedor

**Snapshot / comparison rows (Shopee)** — same shape, with the marketplace's own
fields:

- Nome da loja
- Receita média mensal (estimada) — **built up from the shop's items**, never
  read as one store-level figure; always label it an estimate
- Vendas médias mensais (estimadas) — same build-up, same label
- Tendência de vendas — how many of the shop's items are **growing, stable or
  falling** (for example `12 em alta · 30 estáveis · 8 em queda`). It is a mix,
  not a single percentage — never compress it into one figure
- Taxa de cancelamento — **`—`: no Shopee equivalent exists**
- Anúncios — counts only items with **at least one lifetime sale**, so it
  under-counts the shop's listings; say so
- Vendas (60 dias) — **`—`: no Shopee equivalent exists**
- Vendas (365 dias) — **`—`: no Shopee equivalent exists**
- Categorias — the categories the shop covers
- Nível da loja (Official store / Preferred (Indicado) / Common) — three **mutually
  exclusive tiers, not a ladder**. Never map a tier onto a seller medal
- Avaliação dos compradores (0–5 estrelas), com o número de avaliações — this is
  **not** the Mercado Livre reputation thermometer; it is a star rating, not a
  colour ladder. Say so explicitly rather than presenting them as the same field
- Ticket médio / preço médio
- Localização
- Link da loja na Shopee — **there is no JoomPulse dashboard link for Shopee**, so
  never invent one

For the three rows with **no Shopee equivalent at all** — cancellation rate, sales
over the last 60 days and sales over the last 365 days — show `—` and state plainly
that the data does not exist for Shopee. **Never imply zero, and never present an
estimate in their place.**

**Comparison (only when a previous table is supplied):** a markdown table
`| Campo | Era | Agora |`. Put the change (figure, percentage, or percentage point)
inside the **Agora** cell, prefixed with a semantic color dot:

- 🟢 **good:** revenue up, sales up, listings up, medal improved, reputation or buyer
  rating improved, cancellation rate **down**.
- 🔴 **bad:** revenue down, sales down, listings down, medal worse, reputation or
  buyer rating worse, cancellation rate **up**.
- The **cancellation rate is inverted** — down = 🟢, up = 🔴.
- **Categorias** moving is neutral context — show the change with **no color dot**.
- **On Shopee the shop tier is not a rung** — the three tiers are mutually
  exclusive, so a tier that changed is neutral context with no dot, and "moved up a
  tier" or "moved up a medal" phrasing must not be used. The Shopee sales trend is a
  mix of growing, stable and falling items, so report how that mix shifted rather
  than colouring one number.

Column headers are words (`Campo | Era | Agora`), never a bare "Δ" symbol. Show the
color-dot legend (🟢/🔴) **only** in the comparison table, where the dots actually
appear — never on a plain snapshot.

Close with a short **Principais insights** section: with a comparison, interpret
what moved; on a standalone snapshot, frame it as the starting picture with no trend
claims. On Shopee, note that history starts May 2026, so there is no long-run trend
and no seasonal read.

**Disclaimer (every report) — use the variant for the marketplace you queried.**

Mercado Livre:

> ⚠️ Receita e vendas são estimativas do JoomPulse com base no histórico de
> anúncios — não são transações reais. / Revenue and sales are JoomPulse estimates
> based on historical listing data — not actual transactions.

Shopee:

> ⚠️ **Todos** os números de vendas e receita são estimativas do JoomPulse, a partir
> dos contadores arredondados da própria Shopee — não são transações reais, e
> diferenças pequenas são ruído. Só itens com pelo menos uma venda no histórico são
> rastreados, então a contagem de anúncios é um piso. Preço, avaliação e número de
> avaliações são reais. / **Every** sales and revenue figure is a JoomPulse estimate
> built from Shopee's own rounded sold counters — not actual transactions, and small
> gaps are noise. Only items with at least one lifetime sale are tracked, so the
> listing count is a lower bound. Price, rating, and reviews are real.

Keep it concise — no methodology, no internal jargon, and do not explain these rules
to the user.

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

- **Metric cards** for the key current metrics — on Mercado Livre, for example
  estimated monthly revenue, estimated monthly sales, listings, cancellation rate,
  and medal / reputation; on Shopee, estimated monthly revenue and sales (built up
  from items), listings, buyer rating, and shop tier. With a comparison, you may
  annotate each card with its `era → agora` change. **Never show a card for a
  field that does not exist on the marketplace** — no cancellation-rate or
  60/365-day card on Shopee.
- **Round all displayed numbers** and use **pt-BR number and currency formatting**
  (for example `R$ 1,38 mi`, `7.900`, `+1,3 p.p.`) everywhere — cards and table.
- On Mercado Livre, use a consistent medal palette: platina = purple, ouro = amber,
  prata = blue, sem medalha = white with a thin border (white needs the border to
  stay visible on a light background). **On Shopee there are no medals** — write the
  shop tier as plain text and never colour it as if it were a rung on a ladder.
- The Shopee sales trend is a **mix** of growing, stable and falling items; if you
  chart it, chart the three counts side by side, never a single percentage.
- **No synthesized trend line from a single snapshot** (there is no server-side
  history). Only if the user supplies several past-period tables may you plot a
  simple line across those periods — and on Shopee no such line can reach back
  before May 2026, where the history starts.

Example comparison table, **Mercado Livre** (only with a previous table):

| Campo | Era | Agora |
|---|---|---|
| Receita mensal (est.) | R$ 1,20 mi | 🟢 R$ 1,38 mi · ↑ +15% |
| Vendas/mês (est.) | 8.400 | 🔴 7.900 · ↓ −6% |
| Medalha | Ouro | 🟢 Platina · ↑ |
| Reputação | 4 verde-claro | 🟢 5 verde · ↑ |
| Taxa de cancelamento | 2,1% | 🔴 3,4% · ↑ +1,3 p.p. |
| Categorias | 12 | 14 · +2 |

Example comparison table, **Shopee** (same shape, marketplace's own fields):

| Campo | Era | Agora |
|---|---|---|
| Receita mensal (est.) | R$ 180 mil | 🟢 R$ 214 mil · ↑ +19% |
| Vendas/mês (est.) | 3.100 | 🔴 2.850 · ↓ −8% |
| Tendência de vendas | 10 alta · 34 est. · 6 queda | 14 alta · 28 est. · 8 queda |
| Nível da loja | Common | Preferred (Indicado) |
| Avaliação dos compradores | 4,6 (1.204 aval.) | 🟢 4,8 (1.410 aval.) · ↑ |
| Taxa de cancelamento | — | — (não existe na Shopee) |
| Vendas (60 dias) | — | — (não existe na Shopee) |

Presentation rules: column headers are words, never a bare "Δ" symbol; show the
color-dot legend only when those dots appear (the comparison table); render a chart
only when the data supports it.

## Notes & Guardrails

The user should never see a system or stack error — only a friendly next step.
Translate any failure into one short, friendly sentence, and retry once quietly on a
transient hiccup.

- **Marketplace unclear:** ask one short question naming both before reading any
  data. Never guess and never default.
- **Seller not found:** check the other marketplace first; if it is on neither,
  state it plainly, stop, and invent nothing.
- **No previous table supplied:** render today's snapshot only (no change column, no
  legend) and invite the user to save it for next time.
- **Supplied table is for a different seller, a different marketplace, malformed, or
  unreadable:** say so plainly and fall back to the snapshot only; do not force a
  misaligned comparison, and never compare a Shopee table against a Mercado Livre
  one.
- **Empty or failed pull:** say the data is temporarily unavailable and to try
  again. Never paste internal error text, HTTP codes, or field names to the user.
- **A single field empty but the seller is found:** show `—` for that field and keep
  the rest.
- **Fields that do not exist on Shopee:** cancellation rate and sales over the last
  60 and 365 days are absent attributes, not missing values. Show `—`, say the data
  does not exist for Shopee, and never fill the gap with a zero or an estimate.
- **Shopee listing count:** it covers only items with at least one lifetime sale, so
  it under-counts the shop's listings — say so rather than presenting it as
  complete.
