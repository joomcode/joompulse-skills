---
name: product-change-monitor
description: >
  Monitors how one or a few products changed over a period — by default week
  over week — on JoomPulse: Mercado Livre (Brasil) or Shopee Brasil. Use when a
  seller tracks a named product over time, given a marketplace or JoomPulse
  link, or a listing, item or catalog identifier. Returns a change table: per
  product the current value plus the difference versus about a week ago for
  price, rating and review count, plus current estimated sales and revenue, time
  on air and the marketplace's own seller and logistics attributes. Triggers:
  "monitor this product", "track price changes", "what changed this week", "did
  the price drop"; pt-BR "monitorar este produto", "o preço caiu", "variação de
  avaliações", "monitorar este produto na Shopee", "acompanhar este item da
  Shopee". Ask which marketplace when unclear; never mix the two. Sales and
  revenue are JoomPulse estimates, not real transactions; price, rating and
  reviews are real. For a point-in-time product and competitor read, use the
  single-product analysis skill.
---

# Product Change Monitor

This skill shows how **one** product — or a few of them — **changed over a
period**, by default the last week, on **Mercado Livre (Brasil) or Shopee
Brasil**, using JoomPulse market data. Given a product by a marketplace link, a
JoomPulse link, or a listing, item or catalog product identifier, it reports for
each product the current value **and the change versus about a week ago** for the
metrics that have real history (price, rating, review count), plus the current
snapshot for estimated sales and revenue, how long the listing has been on air,
and the seller and logistics attributes that marketplace actually has. The result
is a change table plus a downloadable spreadsheet; on Mercado Livre each row links
to its JoomPulse page, on Shopee each row links to the item on Shopee.

This is different from a single point-in-time analysis. To size up a product and
find the products that compete with it, use the single-product analysis skill. To
decide which new products to add across a whole catalog, use the gap-analysis
skill. This skill answers "how did this product move over time?" for a product
the user names.

## Prerequisites

- JoomPulse MCP access is configured for the current agent environment.
- The user provides a marketplace — Mercado Livre (Brasil) or Shopee Brasil — and
  one product (or a small set) as a marketplace link, a JoomPulse link, or a
  listing, item or catalog product identifier.
- The available JoomPulse tools can look up a product's current market data and
  its price and reviews history on **either** marketplace. The shape of that
  history differs: on Mercado Livre it is a daily series, on Shopee a record per
  change (see Step 2).

If JoomPulse MCP access is unavailable, stop and explain that the skill requires
JoomPulse MCP setup before it can monitor a product's changes.

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

### Step 1 — Identify the product(s)

Resolve the input to one or more listings on the marketplace chosen in Step 0.

**Mercado Livre:**

1. From a Mercado Livre link, a JoomPulse link, or a pasted identifier, determine
   whether you have an individual **listing** or a **catalog product**.
2. For a catalog product, expand it to the competing listings for that product,
   pick the representative one (the strongest seller / buy-box winner) for the
   row, and note the buy-box competition (how many sellers compete).
3. Confirm the listing is active. If there is no market data for it, see Notes &
   Guardrails.

**Shopee:**

1. From a Shopee item link or a pasted item identifier, resolve the **item**
   directly. Shopee is item-grain with **no catalogue and no buy-box**, so there
   is nothing to expand, no representative listing to pick and no buy-box
   competition to report — do not carry those steps over.
2. There is no listing-status filter on Shopee — how recently the item was last
   seen is what tells you whether it is still live, so check it and never monitor
   a stale item as if it were live. If the item is not tracked, see Notes &
   Guardrails.

On both marketplaces: a JoomPulse store link is a whole store, not one product —
ask for a specific product link or identifier (whole-store work belongs to the
gap-analysis skill). A link from any other marketplace cannot be resolved
directly — ask for a Mercado Livre, Shopee or JoomPulse link or identifier.

### Step 2 — Collect current state and history, then compare

1. **Current snapshot** (from JoomPulse):
   - **Mercado Livre:** product name, category, seller, listing type, seller
     medal, logistics (Mercado Envios Full / free shipping), how long the listing
     has been on air, and the estimated **weekly** sales and revenue.
   - **Shopee:** item name, category, shop, shop tier (Official store /
     Preferred (Indicado) / Common), how long the item has been on air — computed
     from the date the item was created — and the estimated sales and revenue.
     Shopee also reports **estimated sales week by week per item** (weeks start
     on Monday): use it, it is the cleanest weekly read this marketplace offers
     and a genuine Shopee strength for this skill.
2. **Real price and reviews history** (from JoomPulse): price, rating and review
   count. The shape of that history is fundamentally different on the two
   marketplaces:
   - **Mercado Livre:** a **daily series** — pull roughly the last month, so a
     baseline a week back is reachable.
   - **Shopee:** a **step function, not daily rows** — a value is recorded only
     when it **changes**, and it holds until the next record. History starts
     **May 2026**, so the lookback window is shorter than a year; do not ask for
     a year of trend.
3. **Compare current versus about a week ago.** The **current point** is the
   latest value in force on or before today; the **baseline** is the value in
   force about seven days earlier. How you reach that baseline differs:
   - **Mercado Livre:** the baseline is the observation about seven days back. If
     there is no observation exactly seven days back, use the **nearest earlier
     observation within tolerance** (roughly up to two weeks back in total) and
     **state which date was actually used** — never silently substitute it. If no
     comparable earlier observation exists within tolerance, show the current
     value only and say the period comparison is not available for that metric.
     Do not invent a baseline.
   - **Shopee:** **carry forward** the most recent record dated on or before the
     target day — that is the value that was in force then. Look back **as far as
     needed**; there is no two-week tolerance and no giving up, because an absent
     record means the value **did not change**, so the difference is **0**, never
     "unavailable". Silence is information here, so never report a Shopee metric
     as uncomparable just because no record sits near the target day.
4. Estimated sales and revenue are **current-window** figures — weekly on Mercado
   Livre, and on Shopee the current week of the week-by-week series — so present
   them as the current value; they carry no period-over-period difference.

## Output

Respond in the seller's language. Present the result with no commentary about how
it was produced. Use plain markdown so it renders cleanly in any client.

Lead with a short line naming the **marketplace** that was monitored.

**Change table (Mercado Livre)** — one row per monitored product, with these
columns:

- Product / listing identifier
- Name
- Category
- Seller
- Price (current value, with the change folded into the cell — for example the
  percentage change versus the baseline)
- Estimated sales (weekly)
- Estimated revenue (weekly)
- Rating (current value, with the **real numeric difference** versus the baseline
  in the cell — for example `+0.2`, `-0.3`, or `0` when unchanged)
- Reviews (current count, with the absolute growth versus the baseline in the
  cell — for example `+832`)
- Time on air
- Free shipping
- Mercado Envios Full
- Listing type
- Seller medal
- A JoomPulse link for the product

**Change table (Shopee)** — same shape, with the marketplace's own columns:

- Item identifier, linked to the item on Shopee — **there is no JoomPulse
  dashboard link for Shopee rows**, so never invent one
- Name
- Category
- Shop
- Price, Rating and Reviews — current value with the change in the cell, exactly
  as above. A metric with no record in the period changed by `0`; never show it
  as unavailable
- Estimated sales (current week, weeks starting Monday)
- Estimated revenue — label the window you actually show
- Time on air — computed from the date the item was created
- Shop tier — Official store / Preferred (Indicado) / Common
- Free shipping, Mercado Envios Full and listing type have **no Shopee
  equivalent**: either drop these columns or show `—` in them. Never map a shop
  tier onto a seller medal

Do **not** put a delta symbol or "(Δ)" in any column header — it confuses sellers;
the change belongs inside the cell. Below the table, state the period actually
compared (for example "today versus seven days ago"). On Mercado Livre also
surface any baseline date that was not exactly the target, so the comparison is
transparent; on Shopee, when the carried-forward record is older than the target
day, give its date and say the value simply had not changed since. You may
translate the column headers into the seller's language.

**Disclaimer (every report) — use the variant for the marketplace you queried.**

Mercado Livre:

> ⚠️ Sales and revenue are JoomPulse **estimates** based on historical listing
> data — they are **not** actual transactions. Price, rating, and reviews are
> real Mercado Livre history. / Vendas e receita são **estimativas** do JoomPulse
> com base no histórico de anúncios — **não são transações reais**. Preço,
> classificação e avaliações são histórico real do Mercado Livre.

Shopee:

> ⚠️ Sales and revenue are JoomPulse **estimates** built from Shopee's own
> rounded sold counters — they are **not** actual transactions, and small
> movements are noise. Price, rating, and reviews are real Shopee history, and
> that history starts in May 2026. / Vendas e receita são **estimativas** do
> JoomPulse a partir dos contadores arredondados da própria Shopee — **não são
> transações reais**, e variações pequenas são ruído. Preço, classificação e
> avaliações são histórico real da Shopee, e esse histórico começa em maio de
> 2026.

**Download** — offer a downloadable spreadsheet (`.xlsx` plus `.csv`) of the
change table.

## Notes & Guardrails

The seller should never see a system or stack error — only a friendly next step.

- **Product not tracked in JoomPulse / no sales:** JoomPulse tracks products that
  have sales, so a product may not be tracked. Say so and offer to try a different
  link or identifier; you cannot build a history for an untracked product. On
  Shopee only items with at least one lifetime sale are tracked, so an untracked
  item is not proof it does not exist. If an identifier is not found, check the
  other marketplace before telling the seller it does not exist.
- **New listing or too little history:** if there is less than about a week of
  data, show the current snapshot and explain that the period comparison is not
  available yet; suggest re-running in a few days to start a trend. On Shopee,
  first make sure you are not mistaking a step function for missing data — no
  record simply means no change — and remember the history itself only starts in
  May 2026, so an older baseline may be unreachable for that reason alone.
- **Catalog product (Mercado Livre only):** the daily history is per listing, so
  resolve a catalog product to its listing(s) first; if several sellers compete,
  monitor the representative listing and mention the buy-box competition. Shopee
  has no catalogue and no buy-box, so none of this applies there.
- **Unknown flags:** when a logistics flag (such as Mercado Envios Full) is
  unknown, show it as unknown — do not assume "no". On Shopee free shipping, the
  fulfilment programme and the listing tier are always `—`: that is an absent
  attribute, not a missing value, and never a "Não".
- **Market data temporarily unavailable:** retry once quietly; if it is still
  down, say market data is temporarily unavailable. Never paste internal error
  text, HTTP codes, or field names to the seller.
- **Never silently limit coverage** — if you monitor only some of several
  listings, say so.
