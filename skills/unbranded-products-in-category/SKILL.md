---
name: unbranded-products-in-category
description: >
  Finds products with no brand (unbranded / no-name / generic) in one category on
  JoomPulse — Mercado Livre (Brasil) or Shopee Brasil: an opening for your own brand
  / private label, where buyers aren't brand-anchored. Asks for a marketplace and a
  category, ranks the no-brand listings by estimated demand, and returns a product
  table. Triggers: "unbranded products", "products without a
  brand", "private-label opportunities", "unbranded products on Shopee"; pt-BR
  "produtos sem marca", "genéricos que vendem", "oportunidade de marca própria",
  "produtos sem marca na Shopee". Ask which marketplace when unclear; never mix the
  two. Sales and revenue are JoomPulse estimates, not real transactions; price,
  rating and reviews are real. On Shopee the unbranded set is a lower bound. NOT for
  ranking brands (use top-brand-position-tracker), new listings (use
  new-growing-products-in-category), high-demand low-rated products (use
  high-demand-low-quality-finder), or niches without platinum sellers (use
  uncontested-niche-finder).
---

# Unbranded Products In Category

This skill surfaces the **products that have no brand** (unbranded / no-name /
generic) in one category on **Mercado Livre (Brasil) or Shopee Brasil** — the
listings where no brand is attached. These are spots where a seller can enter with
their **own brand / private label**, because buyers there aren't anchored to a
brand name. For each it shows price, estimated sales and revenue, rating, reviews,
time on air, and the seller's or shop's standing. On Mercado Livre each row links
to its JoomPulse page; on Shopee each row links to the item on Shopee.

It is the opposite of ranking a category's brands (for that, use the
top-brand-position-tracker skill). For fresh listings use the
new-growing-products-in-category skill; for low-rated, well-selling products use
the high-demand-low-quality-finder skill; for deep niches without platinum sellers
use the uncontested-niche-finder skill.

## Prerequisites

- JoomPulse MCP access is configured for the current agent environment.
- The user provides a marketplace — Mercado Livre (Brasil) or Shopee Brasil — and
  names a category (free text is fine).
- The available JoomPulse tools can return the listings in a category and resolve a
  category name on **either** marketplace, tell which listings have no brand
  attached, and provide each listing's price, estimated sales and revenue, rating,
  reviews, and time on air. On Mercado Livre they also report listing status,
  logistics, listing type and the seller medal; on Shopee, the shop tier, the date
  the item was created and the date it was last seen.

If JoomPulse MCP access is unavailable, stop and explain that the skill requires
JoomPulse MCP setup before it can find unbranded products.

## Scope

- **Mercado Livre (Brasil) and Shopee Brasil**, one at a time. Other marketplaces
  are out of scope.
- **Sales and revenue are JoomPulse estimates** — not real transactions. By
  contrast, price, rating, and review count are real history. Disclose the estimate
  caveat in every output. The estimates are built differently on each marketplace:
  on Mercado Livre from historical listing data, on Shopee from the marketplace's
  own rounded sold counters refined with review movement. Use the matching
  disclaimer.
- **Read-only.** The skill never writes or modifies anything, and does not render
  product images.
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

### Step 1 — Resolve the category

Ask for a category if none was given, then use JoomPulse to match the free text to
a category **on the chosen marketplace**. If several plausible matches come back,
list the top candidates (name and depth level) and let the user choose — do not
guess between unrelated categories. On Shopee, category analytics stop at three
levels — if the seller names a deeper niche, work it through the item view instead
and say which you used.

### Step 2 — Find the unbranded products

Use JoomPulse to get the category's listings that have **no brand attached** (brand
empty / unbranded), rank them by estimated demand, highest first, and keep the
strongest ~20–30.

- **Mercado Livre:** take the **active** listings and rank by estimated weekly
  demand (estimated weekly revenue, or weekly sales).
- **Shopee:** items carry an explicit "has a brand attached" signal, so the no-brand
  filter ports over directly. There is no listing-status filter here — how recently
  an item was last seen is what tells you whether it is still live, so check it and
  never present a stale row as a live opportunity. Estimated sales and revenue cover
  the **last 30 days**, not a week, so rank by estimated 30-day revenue and label
  those columns as 30 days.
- **On Shopee the unbranded set is a lower bound.** Brand information exists only
  for items that are tracked at all, and only items with at least one lifetime sale
  are tracked. Never quote the count or the share of unbranded items as complete,
  and never claim that some percentage of the category has no brand.

## Output

Respond in the seller's language (default pt-BR). Lead with a one-line summary (the
**marketplace**, the category and how many unbranded products were found), sort by
estimated demand, and end with the disclaimer. The product list always renders as a
markdown table.

**Product table (Mercado Livre):**

| MLB | Nome | Vendedor | Preço | Vendas (semana) | Receita (semana) | Classificação | Avaliações | Tempo no ar | Frete grátis | Mercado Envios Full | Tipo de anúncio | Medalha do vendor |
|---|---|---|--:|--:|--:|--:|--:|--:|:--:|:--:|---|---|

- The **MLB** identifier links to the item's JoomPulse page.

**Product table (Shopee)** — same shape, with the marketplace's own columns:

| Item | Nome | Loja | Preço | Vendas (30 dias) | Receita (30 dias) | Classificação | Avaliações | Tempo no ar | Nível da loja |
|---|---|---|--:|--:|--:|--:|--:|--:|---|

- The item identifier links to the item on Shopee — **there is no JoomPulse
  dashboard link for Shopee rows**, so never invent one.
- **Tempo no ar** is computed from the date the item was created.
- **Nível da loja** is the shop tier — Official store / Preferred (Indicado) /
  Common. Never map a shop tier onto a seller medal.
- Free shipping, Mercado Envios Full and the listing tier have **no Shopee
  equivalent**: either drop those columns or show `—` in them, never a "Não".
- The sales window differs: weekly on Mercado Livre, 30 days on Shopee. Never
  present a 30-day figure under a weekly heading.
- Say in the text that the Shopee list is a **lower bound** — a brand is recorded
  only for tracked items, and only items with at least one lifetime sale are
  tracked — so it is not the complete set of unbranded items in the category, and no
  share of the category can be claimed from it.

**Disclaimer (every report) — use the variant for the marketplace you queried.**

Mercado Livre:

> ⚠️ Vendas e receita são estimativas do JoomPulse com base no histórico de
> anúncios — não são transações reais. Preço, classificação e avaliações são
> histórico real do Mercado Livre. / Sales and revenue are JoomPulse estimates
> based on historical listing data — not actual transactions. Price, rating, and
> reviews are real Mercado Livre history.

Shopee:

> ⚠️ Vendas e receita são estimativas do JoomPulse a partir dos contadores
> arredondados da própria Shopee — não são transações reais, e diferenças pequenas
> entre itens são ruído. Só itens com pelo menos uma venda no histórico são
> rastreados, e a marca só é conhecida para itens rastreados: esta lista de produtos
> sem marca é um piso, não a categoria inteira. Preço, classificação e avaliações
> são histórico real da Shopee. / Sales and revenue are JoomPulse estimates built
> from Shopee's own rounded sold counters — not actual transactions, and small gaps
> between items are noise. Only items with at least one lifetime sale are tracked,
> and a brand is known only for tracked items: this unbranded list is a lower bound,
> not the whole category. Price, rating, and reviews are real Shopee history.

## Visualization

When the client can render inline visuals, present metric cards and a chart;
otherwise fall back to the markdown table plus text cards. Never block on visuals.
The product table always renders as markdown in the response text, on every
surface, and the ⚠️ disclaimer always stays in the text. No product images.

When inline visuals are available:

- **Three cards:** number of unbranded products found — on Shopee label it as a
  lower bound — total estimated sales for the window in use, and average ticket.
- **A horizontal bar** of the top ~10 unbranded products by estimated revenue —
  weekly on Mercado Livre, 30-day on Shopee; name the window on the chart. Render
  the chart only when there are enough products (skip it under about four), and
  never block on it.

Presentation rules: render a chart only when the data supports it; any column with
movement uses a word header, never a bare "Δ". The medal palette (platina = purple,
ouro = amber, prata = blue, sem medalha = white with a thin border) is Mercado Livre
only — on Shopee write the shop tier as plain text and never colour it as if it were
a rung on a ladder.

## Notes & Guardrails

The seller should never see a system or stack error — only a friendly next step.

- **No unbranded products in the category:** the category may be brand-dominated —
  say so plainly and suggest a broader or adjacent category. Never fabricate rows.
  On Shopee, add that the list is a lower bound — a brand is recorded only for
  tracked items, and only items with at least one lifetime sale are tracked — so an
  empty result is not proof that the whole category is branded.
- **Ambiguous category name:** list the candidates and ask the user to choose. If
  nothing matches, check the other marketplace before saying it does not exist.
- **Market data temporarily unavailable:** retry once quietly; if it is still
  down, say market data is temporarily unavailable and to try again. Never paste
  internal error text, HTTP codes, or field names to the seller.
- **Never silently limit coverage** — if the category is larger than what you
  pulled, say the table covers the strongest unbranded products, not all of them.
  On Shopee say it twice over: the coverage itself is partial.
