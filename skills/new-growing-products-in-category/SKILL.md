---
name: new-growing-products-in-category
description: >
  Finds new, already-selling listings in one category on JoomPulse — Mercado
  Livre (Brasil) or Shopee Brasil. Keeps listings that are recent (default: under
  about 30 days on air), well rated (above 3) and have real traction (about 30+
  estimated monthly sales); all thresholds overridable. Returns a product table.
  Use when a seller wants fresh, promising entrants in a niche. Triggers: "new
  products in category", "what's launching and already selling", "recent
  best-sellers in my category", "new products on Shopee"; pt-BR "produtos novos
  na categoria", "novos anúncios que já vendem", "lançamentos em alta na minha
  categoria", "produtos novos na Shopee", "novidades na Shopee que já vendem".
  Ask which marketplace when unclear; never mix the two. Sales and revenue are
  JoomPulse estimates, not real transactions; price, rating and reviews are real.
  For well-selling but weak-rated products, use the high-demand low-quality
  skill; for one product over time, the change-monitor skill.
---

# New & Growing Products in a Category

This skill surfaces **newly launched listings that are already selling well**
inside one category, on **Mercado Livre (Brasil) or Shopee Brasil**, using
JoomPulse market data. The seller picks a marketplace and a category; the skill
returns the recent, well-rated, traction-having listings as a product table. On
Mercado Livre each row links to its JoomPulse page so the seller can dig deeper;
on Shopee each row links to the item on Shopee.

This is a discovery snapshot, not a tracker and not a whole-catalog audit. For
products that sell well but are poorly rated — gaps you can enter with a better
offer — use the high-demand low-quality skill. To follow how one product
moves over time, use the product change-monitor skill. This skill answers "which
fresh entrants in this niche are already getting traction right now?"

## Prerequisites

- JoomPulse MCP access is configured for the current agent environment.
- The user provides a marketplace — Mercado Livre (Brasil) or Shopee Brasil — and
  a category, either by name or by its category identifier.
- The available JoomPulse tools can look up the listings in a category and resolve
  a category name to its identifier on **either** marketplace, and can report,
  per listing, the price, rating, review count, estimated sales and revenue, and
  the date the listing was created.

If JoomPulse MCP access is unavailable, stop and explain that the skill requires
JoomPulse MCP setup before it can find new growing products in a category.

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

### Step 1 — Capture the category and confirm the thresholds

1. Ask the user for the **category** — a name or a category identifier.
2. The skill keeps three filters, each with a **default the user may override**.
   All three work on both marketplaces:
   - **recently listed** — under about 30 days on air;
   - **well rated** — rating above 3;
   - **real traction** — more than about 30 estimated sales in the last month.
3. Echo back what you captured (the marketplace, the category and the three
   thresholds in use) so the user can adjust before you run, then remember those
   inputs for the rest of the run.
4. If the user gave a category **name**, resolve it to its identifier first with
   JoomPulse, matching the current category list **for the chosen marketplace**.
   If the name is ambiguous, list the candidate categories with their level and
   ask which one. If the user already gave an identifier, skip resolution. On
   Shopee, category analytics stop at three levels — if the seller names a deeper
   niche, work it through the item view instead and say which you used.

### Step 2 — Find the new, already-selling listings

1. Use JoomPulse to retrieve the listings in that category, with the fields each
   row needs. Pull a generous set so the filters have room to work.
   - **Mercado Livre:** the **active listings**, with name, seller, listing type,
     seller medal, free shipping and Mercado Envios Full flags, price, estimated
     weekly sales and revenue, estimated monthly sales, rating, review count, and
     how long the listing has been on air.
   - **Shopee:** name, shop, shop tier (Official store / Preferred (Indicado) /
     Common), price, **estimated sales and revenue over the last 30 days**, rating,
     review count, the date the item was created, and the date it was last seen.
     There is no listing-status filter on Shopee — how recently an item was last
     seen is what tells you whether it is still live, so check it and never
     present a stale row as a live opportunity.
2. **Work out how long each listing has been on air.** On Shopee this is computed
   from the item's creation date.
3. **Apply the three filters** to the retrieved listings: keep only those that
   are recently listed (under the day-on-air threshold), well rated (above the
   rating threshold), and have real traction (above the monthly-sales threshold).
   On Shopee, **also require at least one review** — rating is absent for items
   nobody has reviewed, and without this guard unreviewed items slip through the
   rating gate unchecked.
4. **Sort the survivors strongest-first** by estimated monthly sales, breaking
   ties by estimated revenue over the same window, so the most promising fresh
   entrants are on top.

## Output

Respond in the seller's language. Present the result with no commentary about how
it was produced. Use plain markdown so it renders cleanly in any client.

Lead with a short intro line naming the **marketplace**, the category and the
three thresholds actually applied, and state that the listings are **ranked by
estimated monthly sales** (ties broken by estimated revenue over the same
window).

**Product table (Mercado Livre)** — one row per surviving listing, ranked by
estimated monthly sales, in this order:

- Listing identifier (the Mercado Livre code), linked to its JoomPulse page
- Name
- Seller
- Price
- Estimated sales (monthly) — the ranking metric and the figure behind the
  monthly-sales traction filter
- Estimated sales (weekly)
- Estimated revenue (weekly)
- Rating
- Reviews
- Time on air (days)
- Free shipping (Sim/Não)
- Mercado Envios Full (Sim/Não)
- Listing type
- Seller medal

**Product table (Shopee)** — same shape, with the marketplace's own columns:

- Item identifier, linked to the item on Shopee — **there is no JoomPulse
  dashboard link for Shopee rows**, so never invent one
- Name
- Shop
- Price
- Estimated sales (30 days) — the ranking metric and the figure behind the
  traction filter
- Estimated revenue (30 days)
- Rating
- Reviews
- Time on air (days) — computed from the date the item was created
- Shop tier — Official store / Preferred (Indicado) / Common
- Free shipping, Mercado Envios Full and listing type have **no Shopee
  equivalent**: either drop these columns or show `—` in them. Never map a shop
  tier onto a seller medal.

Note that the two sales columns are **not** the same window on the two
marketplaces: Mercado Livre reports weekly and monthly figures, Shopee reports
30-day figures only — label the Shopee columns as 30 days and never present a
30-day figure under a weekly heading.

Empty field → `—`; never guess or fabricate. Below the table, list the item codes
explicitly so they are easy to copy — as clickable JoomPulse links on Mercado
Livre, as Shopee item links on Shopee. You may translate the column headers into
the seller's language.

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

When the client can render inline visuals, present metric cards and, when the
data supports it, a bar chart above the markdown table; otherwise present a
short markdown cards block (or a tiny two-column Métrica | Valor table) plus
text. **The product table always renders as markdown**, never inside a widget —
it is the main deliverable.

- **Summary cards** over the surviving listings:
  - **Produtos novos encontrados** — how many listings survived the filters.
  - **Vendas/mês (mediana est.)** — median of the estimated monthly sales.
  - **Ticket médio** — average price across the survivors.
  - **Idade média (dias no ar)** — average time on air.
- **Top-N bar (optional)** — the strongest new products by estimated monthly
  sales. Label each bar with a short product name (truncate long ones) plus its
  item code — the Mercado Livre code, or the Shopee item identifier. **Render
  this chart only when the data supports it** — skip it when fewer than four
  listings survive; the cards and table are enough.

This is a discovery list, not a week-over-week tracker, so it has **no change or
"Variação" column and no 🟢/🔴/🆕 legend** — those belong only to trackers that
compare runs. Use a neutral color ramp for the bar (no semantic coloring). If you
ever show seller medals as colored chips, use the standard palette: platina =
purple, ouro = amber, prata = blue, sem medalha = white with a thin border. On
Shopee there are no medals — write the shop tier as plain text and never colour
it as if it were a rung on a ladder.

**Formatting (both surfaces):** round numbers and use pt-BR formatting — prices
and revenue as `R$` with `.` thousands and `,` decimals (e.g. `R$ 1.234,50`);
counts as integers with `.` thousands; rating to one decimal (e.g. `4,6`); time
on air as whole days. Empty field → `—`. The estimate disclaimer is mandatory on
every output.

## Notes & Guardrails

The seller should never see a system or stack error — only a friendly next step.

- **No listings survive the filters:** say that no new listings currently match
  these thresholds in this category, and offer to relax them (for example, a
  larger day-on-air window or a lower monthly-sales floor). Keep it in pt-BR.
  On Shopee, add that the list is a lower bound — only items with at least one
  lifetime sale are tracked — so an empty result is not proof the niche is quiet.
- **Category not found or ambiguous name:** list the candidate categories (name
  and level) and ask the user to pick one. If nothing matches, check the other
  marketplace before saying the category does not exist.
- **Empty fields:** show `—` for any value that is missing; never assume "no" for
  an unknown logistics flag and never fabricate a number. On Shopee, free
  shipping, the fulfilment programme and the listing tier are always `—` — that
  is an absent attribute, not a missing value, and never a "Não".
- **Market data temporarily unavailable:** retry once quietly; if it is still
  down, say market data is temporarily unavailable and to try again shortly.
  Never paste internal error text, HTTP codes, or field names to the seller.
