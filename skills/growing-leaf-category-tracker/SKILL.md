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
number of active sellers, the month-over-month growth of **both revenue and
units**, the concentration of orders on the leading seller, and revenue per
seller. Every reported column exists on both marketplaces, but concentration is
computed differently on each — never compare that figure across marketplaces.

On Shopee, **work out the most recent month explicitly** instead of trusting a
latest-month indicator — that indicator is unreliable there — and state which month
the figures describe.

### Step 3 — Keep the fast-growing ones

From those sub-categories, **keep only the ones that are growing fast** (strong
month-over-month revenue growth), then order the kept niches by revenue growth,
fastest first.

**Apply a size floor before ranking, and state it.** Month-over-month growth
explodes off a near-zero base: a niche going from R$ 200 to R$ 1.600 reads +700%
and leads the table over one that added hundreds of thousands. Set the floor
**relative to the parent the seller named** — at least **0,02% of that category's
estimated monthly revenue, and never below R$ 300 mil**. A fixed figure cannot
serve both marketplaces, because they rank different units: deep leaf niches on
Mercado Livre against whole level-3 categories on Shopee, which are far larger.
Say under the table which floor was used and how many niches it excluded. Without
a stated floor the same category returns a different leader from run to run.

**Read revenue growth and unit growth together.** A niche can grow revenue while
selling *fewer* units: the gain came from a higher average ticket, not from more
demand, and a seller who wants volume should not enter it — say so plainly. The
reverse, units growing faster than revenue, means the average price is falling:
easier to enter, margin under pressure. Flag both cases.

**Collapse a parent and its dominant child** — Mercado Livre only, since Shopee
has nothing below the level being ranked. A deep tree ranks a sub-category and its
own child separately, so a parent holding nearly all its revenue in one child
appears twice and reads as two opportunities. Where a child accounts for almost
all of its parent's revenue, keep one row, name the other beside it, and say they
are the same niche — twelve rows should mean twelve choices.

**Identify the surviving row by the same identifier every time.** Where a pair is
collapsed, keep the row under the **parent** and name the child beside it. The
identifier is the only way the seller can find the niche again, and the table is
meant to be saved and compared next period — the same niche appearing under two
different identifiers across runs defeats the purpose of showing one.

**Then say which of the ranked niches is actually enterable.** Growth alone is not
room:

- **Concentration.** Where one seller holds a large share of the category's
  orders, strong growth is not open space; name those niches and say the seller
  would be taking on a dominant incumbent.
- **Revenue per seller.** A large, fast-growing niche split across tens of
  thousands of sellers is worth less than a smaller one with few. Name the best
  and the worst rather than leaving the columns to be divided by hand.
- **Seasonality — Mercado Livre only.** Where the category is marked seasonal with
  a known peak month, say whether the growth is the start of the ramp (time to
  position) or the middle of the curve (entering behind it). **Shopee carries no
  seasonality data**: do not infer it there, and where the calendar suggests a
  season say that as timing, not as data.

Lead the written read with the most enterable niches — strong growth with low
concentration — not simply the fastest-growing.

Keep levels and changes distinct: use the always-positive monthly totals for size,
and never present a change figure as if it were a total.

Month-over-month revenue growth works on both marketplaces, and the growth ranking
survives on each. On Shopee only about three months of history exist, so compare
the most recent month with the one before it and read nothing longer-run into it —
which makes the floor matter more there, not less, because a short history makes a
percentage noisier.

## Output

Respond in the seller's language (default pt-BR), with no commentary about how the
result was produced. Lead with a short line naming the **marketplace**, the parent
category, the **level the ranking is at**, and the month the figures describe. On
Shopee that line also says plainly that niches deeper than the third level are
folded into their level-3 ancestor and cannot be separated here.

The ranking always renders as a markdown table:

| Categoria | Cresc. receita | Cresc. vendas | Qtd. vendedores | Receita (mês est.) | Vendas (mês est.) | Monopolização | Receita/vendedor |
|---|--:|--:|--:|--:|--:|:--|--:|

- **Exactly these eight columns on both marketplaces.** Concentration and revenue
  per seller are what turn a growth list into an entry decision, so they belong in
  every run rather than only the ones where they occur to you.
- **Show the growth the ranking is built on** — never rank on a number the table
  does not display. Both growth columns are month-over-month.
- **Monopolização** carries the tier and the raw value together, as `Baixa (0,180)`
  — the tier alone hides how close two niches are.
- **Full precision in the money columns on Mercado Livre** — `R$ 468.400,35`, never
  `R$ 468 mil`: this is a ranking, and rounding collapses the rows into each other.
  **Shopee is exempt.** Its figures are rebuilt from the platform's own rounded
  sold counters, so exact digits there would be false precision — round Shopee
  money to thousands and say once that the source is rounded.
- **Identify each row by its category ID beside the name.** Neither marketplace has
  a working per-category deep link: on Shopee there is none at all, and on Mercado
  Livre a URL carrying a category identifier resolves to the same general
  categories page. So give the seller the route in one line below the table and
  **never render a per-row URL as though it opened that niche** — the ID is what
  lets them find it, and a link that lands somewhere general while looking specific
  is worse than none.
- Under the table, state the size floor used, the period compared, and how many
  niches were read against how many the ranking shows. **Give those counts
  exactly, never rounded or hedged** — "about 900" cannot be checked against the
  data, and a coverage claim nobody can audit is worth little more than none.

**Disclaimer (every report) — use the variant for the marketplace you queried.**

Mercado Livre:

> ⚠️ Receita, vendas e crescimento da categoria são estimativas de mercado do
> JoomPulse — não são transações reais, e o crescimento mês a mês herda essa
> margem de erro. A base mensal de categorias pode ter até ~31 dias de defasagem.
> / Category revenue, sales, and growth are JoomPulse market estimates — not
> actual transactions, and the month-over-month growth inherits that margin of
> error. The monthly category data can lag by up to ~31 days.

Shopee:

> ⚠️ Receita e vendas são estimativas do JoomPulse a partir dos contadores
> arredondados da própria Shopee — não são transações reais, e diferenças
> pequenas entre categorias são ruído. / Revenue and sales are JoomPulse
> estimates built from Shopee's own rounded sold counters — not actual
> transactions, and small gaps between categories are noise.

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
- **Missing values.** Show `—` for any figure that is unavailable, and never print
  `0` for something that was simply not measured.
- **Market data temporarily unavailable:** retry once after a short pause rather
  than immediately; if it still fails, say the service is busy and to try again in
  a few minutes. Never paste internal error text, HTTP codes, or field names to
  the seller.
- **An empty result is not a failure.** A category with no niches above the floor
  is an answer — say that, and offer to lower the floor or widen the parent. Never
  report a genuine empty result as an outage.
- **Never silently limit coverage.** State how many niches were read against how
  many the ranking shows. Where the pull can be ordered by growth, one page is
  enough for a top-N and nothing unread grows faster — say so; otherwise page until
  a pull comes back short.
