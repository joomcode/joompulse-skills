---
name: high-demand-low-quality-finder
description: >
  Finds products in one category on JoomPulse — Mercado Livre (Brasil) or Shopee
  Brasil — that have high demand but a low rating: listings that sell well yet
  score at or below a rating threshold the user chooses, an opening to enter with
  a better offer. Use it when a seller wants well-selling products to beat. Asks
  for a marketplace, a category and a rating threshold, then returns the matching
  listings ranked by demand. Triggers: "high demand low rating products", "low
  quality opportunities", "products I can beat", "badly rated products on
  Shopee"; pt-BR "produtos com muita demanda e nota baixa",
  "oportunidades de baixa qualidade", "produtos mal avaliados que vendem",
  "produtos mal avaliados na Shopee". Ask which marketplace when unclear; never
  mix the two. Sales and revenue are JoomPulse estimates, not real transactions;
  price, rating and reviews are real. For brand-new listings use the
  new-growing-products-in-category skill; for one product and its competitors,
  the ml-product-analysis skill.
---

# High-Demand, Low-Quality Finder

This skill surfaces products in one category that **sell well but are poorly
rated** — listings with strong demand whose rating sits at or below a threshold
the seller chooses — on **Mercado Livre (Brasil) or Shopee Brasil**, using
JoomPulse market data. These are the products a seller has the best chance of
beating: the demand is already proven, and a better offer can win on quality.
The result is a ranked product table, ordered by estimated demand. On Mercado
Livre each row links to its JoomPulse page; on Shopee each row links to the item
on Shopee.

This is different from finding fresh entrants or empty niches. To find brand-new
listings that are already selling in a category, use the new-and-growing-products
skill. To find niches with no strong incumbents, use the uncontested-niche skill.
To size up a single product and the products that compete with it, use the
single-product analysis skill. This skill answers "which proven sellers in this
category are weak on quality, so I can enter with a better offer?"

## Prerequisites

- JoomPulse MCP access is configured for the current agent environment.
- The user provides a **marketplace** — Mercado Livre (Brasil) or Shopee Brasil —
  plus the **category** (a name or a category identifier) **and** a **rating
  threshold** (for example `4.0`). All three are required.
- The available JoomPulse tools can resolve a category and list the items in it
  on **either** marketplace, and can report, per item, the demand, rating, review
  count, price, and the date the item was created.

If JoomPulse MCP access is unavailable, stop and explain that the skill requires
JoomPulse MCP setup before it can find opportunities.

## Scope

- **Mercado Livre (Brasil) and Shopee Brasil**, one at a time. Other marketplaces
  are out of scope.
- **Sales and revenue are JoomPulse estimates** — not real transactions. Disclose
  this in every output. By contrast, **price, rating, and review count are real
  history** from the marketplace — say so, it is a strength of the report. The
  estimates are built differently on each marketplace: on Mercado Livre from
  historical listing data, on Shopee from the marketplace's own rounded sold
  counters refined with review movement. Use the matching disclaimer.
- **Read-only.** The skill does not sign in as the seller or modify any listing.
- **Language:** detect the seller's language and respond in it. Default to pt-BR.
- **Keep the workflow invisible.** The seller wants the answer, not a play-by-
  play. If one approach does not return data, switch to another quietly; only if
  every approach fails do you say one short, friendly sentence.

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

### Step 1 — Collect the inputs

1. Ask the user for both the **category** and the **rating threshold**. Both are
   required, on top of the marketplace from Step 0, before you proceed.
2. Resolve the user's category text to a category identifier, matching the current
   category list **for the chosen marketplace**. If they gave a name, look it up in
   JoomPulse and confirm the match if it is ambiguous; if they gave an identifier,
   use it directly. On Shopee, category analytics stop at three levels — if the
   seller names a deeper niche, work it through the item view instead and say which
   you used.
3. The rating threshold becomes the upper bound: keep only products whose rating
   is **at or below** the chosen value.

### Step 2 — Pull the category's items

Use JoomPulse to obtain the items in the chosen category, with the fields each row
needs. Pull a generous set so the filters have room to work.

- **Mercado Livre:** the **active listings** whose rating is at or below the
  threshold, with name, seller, price, estimated weekly sales and revenue,
  estimated monthly demand, rating, review count, time on air, free shipping,
  Mercado Envios Full, listing type, and seller medal.
- **Shopee:** name, shop, shop tier (Official store / Preferred (Indicado) /
  Common), price, **estimated sales and revenue over the last 30 days**, rating,
  review count, the date the item was created, and the date it was last seen.
  Time on air is computed from the creation date. There is no listing-status
  filter on Shopee — how recently an item was last seen is what tells you whether
  it is still live, so check it and never present a stale row as a live
  opportunity.

### Step 3 — Filter and rank

- **On Shopee, require at least one review before applying the rating threshold.**
  An item nobody has reviewed reports a rating of **zero**, not a blank, so a plain
  "rating at or below the threshold" filter sweeps every unreviewed item into the
  shortlist and labels proven-nothing items as low-quality. The review floor is
  what makes the result mean "poorly rated" instead of "never rated".
- Defensively drop any row whose rating is above the threshold, and ignore rows
  with no rating at all unless the user asks to include them.
- **Rank by estimated demand**, highest first, so the high-demand, low-quality
  products surface at the top: estimated monthly demand on Mercado Livre (weekly
  revenue as a tiebreaker), estimated 30-day sales on Shopee (30-day revenue as a
  tiebreaker). The ranking figure must appear as its own column in the table —
  never rank on a number the table does not show.
- Keep roughly the top 20–30 rows for the table.

## Output

Respond in the seller's language. Present the result with no commentary about how
it was produced. The product table always renders as markdown so it displays
cleanly in any client.

Lead with a short intro line naming the **marketplace**, the category and the
rating threshold actually applied.

**Product table (Mercado Livre)** — one row per listing, with these columns (pt-BR
labels by default):

- product / listing identifier, linked to its JoomPulse page
- Nome (name)
- Categoria (category)
- Vendedor (seller)
- Preço (price)
- Demanda estimada (mês) — estimated monthly demand (**this is the ranking
  metric**; rows are sorted by this column, highest first)
- Vendas estimadas (semana) — estimated weekly sales
- Receita estimada (semana) — estimated weekly revenue
- Classificação (rating)
- Avaliações (review count)
- Tempo do anúncio no ar (time on air)
- Frete grátis (free shipping)
- Mercado Envios Full
- Tipo de anúncio (listing type)
- Medalha do vendedor (seller medal)

**Product table (Shopee)** — same shape, with the marketplace's own columns:

- item identifier, linked to the item on Shopee — **there is no JoomPulse
  dashboard link for Shopee rows**, so never invent one
- Nome (name)
- Categoria (category)
- Loja (shop)
- Preço (price)
- Vendas estimadas (30 dias) — estimated 30-day sales (**this is the ranking
  metric** on Shopee)
- Receita estimada (30 dias) — estimated 30-day revenue
- Classificação (rating)
- Avaliações (review count) — at least one, by construction
- Tempo do anúncio no ar (time on air) — computed from the item's creation date
- Nível da loja (shop tier) — Official store / Preferred (Indicado) / Common
- Free shipping, Mercado Envios Full and listing type have **no Shopee
  equivalent**: either drop these columns or show `—` in them. Never map a shop
  tier onto a seller medal.

The demand columns are **not** the same window on the two marketplaces: Mercado
Livre reports weekly and monthly figures, Shopee reports 30-day figures only —
label the Shopee columns as 30 days and never present a 30-day figure under a
weekly heading.

Below the table, state the inputs used (the marketplace, the category and the
rating threshold) and which column the rows are ranked by. When a cell has no
value, show `—`; never guess or fabricate.

**Disclaimer (every report) — use the variant for the marketplace you queried.**

Mercado Livre:

> ⚠️ Sales and revenue are JoomPulse **estimates** based on historical listing
> data — they are **not** actual transactions. Price, rating, and reviews are
> real Mercado Livre history. / Vendas e receita são **estimativas** do JoomPulse
> com base no histórico de anúncios — **não são transações reais**. Preço,
> classificação e número de avaliações são histórico real do Mercado Livre.

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

**Metric cards (three):**

- **Oportunidades encontradas** — the count of products kept (rows in the table).
- **Demanda total** — the estimated demand summed across the kept rows, over the
  window the marketplace reports (monthly on Mercado Livre, 30 days on Shopee).
- **Nota média** — the average rating across the kept rows. It will be low by
  construction; label it as the low-quality signal.

**Demand × rating chart:** one point per product — demand on the horizontal axis,
rating on the vertical axis, and bubble size by estimated revenue over the same
window as the demand axis (weekly revenue on Mercado Livre, 30-day revenue on
Shopee). Highlight the sweet spot (high demand, low rating — the bottom-right) by
drawing those points in **coral**, with all other points muted/grey: these are
exactly the products worth beating. **Skip the chart when there are fewer than
five points** — show the table only; no graph for the sake of a graph.

Presentation rules:

- Round numbers and format them in **pt-BR** (for example `R$ 1.234`,
  `1.234 vendas/mês`, rating `3,8`).
- The medal palette is **Mercado Livre only**: platina = purple, ouro = amber,
  prata = blue, sem medalha = white with a thin border. On Shopee there are no
  medals — write the shop tier as plain text and never colour it as if it were a
  rung on a ladder.
- Keep the ⚠️ estimate disclaimer on every output that shows estimated sales or
  revenue.

## Notes & Guardrails

The seller should never see a system or stack error — only a friendly next step.

- **No products at or below the threshold:** say the category has few or no
  low-rated-but-selling products at the chosen threshold — this is a valid result,
  not an error, so keep it friendly. Make the next-step suggestion **relative to
  the threshold they picked**, never a blanket "lower the rating":
  - If the threshold is **low** (a strict bound, e.g. `≤ 3.0` or `≤ 3.5`), few
    products are rated that poorly — suggest **raising** the threshold (e.g. to
    `4.0`) to widen the search to more weak-but-selling listings.
  - If the threshold is already **high** (a loose bound, e.g. `≥ 4.5`), most
    listings already qualify, so an empty result more likely means little demand
    in this category — suggest **lowering** the threshold to focus on the truly
    weak-rated products, or trying a different category.
  Always frame it as adjusting the threshold in the sensible direction for the
  value they gave. On Shopee, add that the list is a lower bound — only items with
  at least one lifetime sale are tracked, and unreviewed items are excluded on
  purpose — so an empty result is not proof the niche is all well-rated.
- **Category not found or ambiguous:** ask the user to confirm the exact category
  or to provide its category identifier. If nothing matches, check the other
  marketplace before saying the category does not exist.
- **Market data temporarily unavailable:** retry once quietly; if it is still
  down, say market data is temporarily unavailable and offer to retry. Never paste
  internal error text, HTTP codes, or field names to the seller.
- **Empty cells:** show `—`; never guess or fabricate. On Shopee, free shipping,
  the fulfilment programme and the listing tier are always `—` — that is an absent
  attribute, not a missing value, and never a "Não".
