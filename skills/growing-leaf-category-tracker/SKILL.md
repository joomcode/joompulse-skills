---
name: growing-leaf-category-tracker
description: >
  Finds the fastest-growing sub-categories under a chosen category on JoomPulse —
  Mercado Livre (Brasil) or Shopee Brasil — ranked by month-over-month revenue
  growth. On Mercado Livre it reaches the deep leaf niches below the third level;
  on Shopee, category analytics stop at the third level, so it ranks there and says
  plainly that deeper niches are folded into their level-3 ancestor. Use when a
  seller picks a category and wants the niches inside it growing fastest now.
  Triggers: "fast-growing subcategories", "which niches are growing in this
  category", "growing categories on Shopee"; pt-BR "subcategorias em crescimento",
  "nichos que mais crescem nesta categoria", "categorias em alta na Shopee". Ask
  which marketplace when unclear; never mix the two. Sales and revenue are
  JoomPulse estimates, not real transactions. For one category's opportunity index
  use the category-opportunity-index skill; for new products inside a category, the
  new-growing-products-in-category skill.
---

# Growing Leaf Category Tracker

This skill takes one category on **Mercado Livre (Brasil) or Shopee Brasil** and
surfaces the **sub-categories inside it that are growing fastest** — the niches
with the strongest month-over-month growth in estimated revenue. It helps a seller
who already knows a broad area decide which specific niche to move into next.

**How deep it can go differs by marketplace.** On Mercado Livre the answer is the
deep leaf niches below the third level of the category tree. On Shopee, category
analytics exist only down to the third level, so the ranking runs at the deepest
level available — the third — and anything deeper is folded into its level-3
ancestor and cannot be separated. Say so in the output; never pass level-3 rows
off as deep leaves.

This is a niche-discovery snapshot, not a tracker over time. For a single
category's opportunity index and market size, use the category-opportunity-index
skill. To compare a category's aggregate numbers against a user-supplied previous
snapshot, use the category-monitor skill. To find specific new products inside a
category, use the new-growing-products-in-category skill.

## Prerequisites

- JoomPulse MCP access is configured for the current agent environment.
- The user provides a marketplace — Mercado Livre (Brasil) or Shopee Brasil — and
  names a parent category (free text is fine).
- The available JoomPulse tools can resolve a category on **either** marketplace,
  walk its sub-categories, and return each one's current monthly market stats
  (estimated revenue and sales, number of active sellers, number of products) and
  the month-over-month movement in estimated revenue.

If JoomPulse MCP access is unavailable, stop and explain that the skill requires
JoomPulse MCP setup before it can find growing niches.

## Scope

- **Mercado Livre (Brasil) and Shopee Brasil**, one at a time. Other marketplaces
  are out of scope.
- **Depth differs by marketplace:** deep leaf niches below the third level on
  Mercado Livre; the third level only on Shopee, where deeper niches are folded
  into their level-3 ancestor.
- **Sales and revenue are JoomPulse estimates** — not real transactions. Disclose
  this in every output. The estimates are built differently on each marketplace:
  on Mercado Livre from historical listing data, on Shopee from the marketplace's
  own rounded sold counters refined with review movement. Use the matching
  disclaimer.
- **Read-only.** The skill never writes or modifies anything.
- **Language:** detect the seller's language and respond in it. Default to pt-BR.
- **Keep the workflow invisible.** Surface the answer, not the steps. Never fill
  gaps from general knowledge; show `—` for any missing value.

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

### Step 1 — Resolve the parent category

Ask the seller for a category if none was given, then use JoomPulse to match the
free text to a category **on the chosen marketplace**. If several plausible
matches come back, list the top candidates (name and depth level) and let the
seller choose.

### Step 2 — Collect the sub-categories at the deepest level available

Use JoomPulse to list the descendant categories below the chosen one, keeping the
deepest level the marketplace actually supports:

- **Mercado Livre:** the **deep ones — leaf niches deeper than the third level**.
- **Shopee:** the **third level**, which is as deep as category analytics go.
  Anything deeper comes back empty, so do not chase it. If the seller specifically
  wants deep niches on Shopee, name the limitation — deeper niches are folded into
  their level-3 ancestor and cannot be separated — and point them at the item-level
  view instead, where items carry their own deeper category path; that is a
  different skill's territory, so hand it over rather than faking depth here.

For each kept category, get the current monthly estimated revenue and sales, the
number of active sellers, the number of products, and the month-over-month revenue
growth. All five reported columns exist on both marketplaces.

On Shopee, **work out the most recent month explicitly** instead of trusting a
latest-month indicator — that indicator is unreliable there — and state which month
the figures describe.

### Step 3 — Keep the fast-growing ones

From those sub-categories, **keep only the ones that are growing fast** (strong
month-over-month revenue growth), then order the kept niches by growth, fastest
first. Use the always-positive monthly totals for size (revenue, sales,
products); growth is the filter that selects the niches — never present a change
figure as a total or as a table column.

Month-over-month revenue growth works on both marketplaces, and the growth ranking
survives on each. On Shopee only about three months of history exist, so compare
the most recent month with the one before it and read nothing longer-run into it.

## Output

Respond in the seller's language (default pt-BR), with no commentary about how the
result was produced. Lead with a short line naming the **marketplace**, the parent
category, the **level the ranking is at**, and the month the figures describe. On
Shopee that line also says plainly that niches deeper than the third level are
folded into their level-3 ancestor and cannot be separated here.

The ranking always renders as a markdown table:

| Categoria | Qtd. vendedores | Receita (mês est.) | Vendas (mês est.) | Produtos |
|---|--:|--:|--:|--:|

- Exactly these five columns on both marketplaces — fast growth is the filter that
  selects the niches, not a displayed column.
- On Mercado Livre each category links to its JoomPulse category dashboard page.
  **There is no JoomPulse category dashboard link for Shopee rows** — leave the
  name as plain text and never invent a link.

**Disclaimer (every report) — use the variant for the marketplace you queried.**

Mercado Livre:

> ⚠️ Receita e vendas são estimativas do JoomPulse com base no histórico de
> anúncios — não são transações reais. / Revenue and sales are JoomPulse
> estimates based on historical listing data — not actual transactions.

Shopee:

> ⚠️ Receita e vendas são estimativas do JoomPulse a partir dos contadores
> arredondados da própria Shopee — não são transações reais, e diferenças
> pequenas entre categorias são ruído. / Revenue and sales are JoomPulse
> estimates built from Shopee's own rounded sold counters — not actual
> transactions, and small gaps between categories are noise.

## Visualization

When the client can render inline visuals, present metric cards and a chart;
otherwise fall back to the markdown table plus text cards. Never block on visuals.
The ranking table always renders as markdown in the response text, on every
surface, and the ⚠️ disclaimer always stays in the text.

When inline visuals are available:

- **Three cards:** number of growing niches found, the single fastest-growing
  niche (name + growth %), and the average growth across the shortlist.
- **A size-versus-growth bubble chart:** each niche placed by market size
  (estimated monthly revenue) against its growth %, with bubble size showing the
  number of sellers — the upper-right area is the large-and-fast-growing sweet
  spot. Render this chart only when the data supports it (a few niches); fall back
  to a simple bar of the top niches by growth, and skip the chart entirely when
  there are too few niches.

Presentation rules: any change or difference column uses a word as its header
("Variação" / "Crescimento"), never a bare "Δ" symbol; render a chart only when
the underlying data supports it. On Shopee, label the visuals with the level the
ranking is at (the third) so nobody reads them as deep leaf niches.

## Notes & Guardrails

The seller should never see a system or stack error — only a friendly next step.

- **Flat parent category:** if the chosen category has nothing below it at the
  level this skill ranks — deeper than the third level on Mercado Livre, the third
  level on Shopee — say so plainly and offer to look at a broader parent category
  instead of returning an empty table.
- **Deeper niches on Shopee:** never fabricate a level below the third and never
  present a level-3 row as a deep leaf. Say the platform folds deeper niches into
  their level-3 ancestor and offer the item-level route instead.
- **Not enough history:** with only about three months of Shopee history, there
  will often be too little to judge growth. Say that honestly rather than lowering
  the bar on what counts as fast growth.
- **Negative or odd growth:** some niches may be shrinking; surface that honestly
  rather than hiding it, and never invent a positive trend.
- **Market data temporarily unavailable:** retry once quietly; if it is still
  down, say market data is temporarily unavailable and to try again. Never paste
  internal error text, HTTP codes, or field names to the seller.
- **Never silently limit coverage** — if you rank only some of the niches, say so.
