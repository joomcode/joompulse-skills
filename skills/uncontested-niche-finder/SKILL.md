---
name: uncontested-niche-finder
description: >
  Finds low-competition niche products in the deep sub-categories of one category
  on JoomPulse — Mercado Livre (Brasil) or Shopee Brasil. Keeps only the deep
  niches with no dominant incumbent: no platinum seller on Mercado Livre, no
  Official store (Shopee Mall) seller on Shopee. Returns one table of niche
  products, each with a competition signal (how many sellers). Use when a seller
  wants uncontested niches or where to enter without fighting an incumbent.
  Triggers: "uncontested niche", "low-competition products", "find a niche to
  enter"; pt-BR "nicho sem concorrência", "produtos sem vendedor platinum",
  "nicho pouco disputado na Shopee", "nicho sem loja oficial na Shopee". Ask which
  marketplace when unclear; never mix the two. Sales and revenue are JoomPulse
  estimates, not real transactions; price, rating and reviews are real. For one
  product and its competitors use the ml-product-analysis skill; for fast-growing
  deep categories, the growing-leaf-category-tracker skill.
---

# Uncontested Niche Finder

This skill finds products in **deep sub-categories** of a chosen category — on
**Mercado Livre (Brasil) or Shopee Brasil** — where the whole deep sub-category
has **no dominant incumbent** among its listings. On Mercado Livre the incumbent
test is **no platinum seller at all**; on Shopee, which has no seller medals, it
is **no Official store (Shopee Mall) seller at all**. Given a marketplace and a
category by name or identifier, it surfaces the active listings in those deep
niches, and ranks them by estimated traction so the strongest uncontested
opportunities surface first. On Mercado Livre each row links to its JoomPulse
page; on Shopee each row links to the item on Shopee.

A truly uncontested niche is a **whole deep sub-category with zero incumbents of
that kind** — not merely the listings without one inside a sub-category that
still has them elsewhere. Dropping individual incumbent-held listings is not
enough: if any platinum seller (Mercado Livre) or any Official store (Shopee) is
active in the sub-category, that niche is contested, so the skill keeps only the
deep sub-categories with none present. If keeping only those would leave too few
results, the skill may also show the non-incumbent listings from sub-categories
that still have one — but it labels those plainly as **non-platinum listings
(platinum sellers still present in the category)** on Mercado Livre, or
**listings outside an Official store (Official stores still present in the
category)** on Shopee, and does not call them uncontested.

This is different from broad assortment work. To size up one product and the
products that compete with it, use the ml-product-analysis skill. To find the
fast-growing deep **categories** under a category (rather than the products inside
them), use the growing-leaf-category-tracker skill. This skill answers "where can
I enter without facing a dominant incumbent?" for a category the seller names, on
the marketplace they choose.

## Prerequisites

- JoomPulse MCP access is configured for the current agent environment.
- The user provides a marketplace — Mercado Livre (Brasil) or Shopee Brasil — and
  one category, as a name or a category identifier.
- The available JoomPulse tools can resolve a category on **either** marketplace,
  reach the levels below it, and list the active product listings within them,
  with the standing of the seller behind each listing — the seller medal on
  Mercado Livre, the shop tier on Shopee.
- On Shopee, category analytics stop at three levels, so the deep set is built
  from the deeper category path the items themselves carry; the competition signal
  for a deep niche comes from the view of the sellers in a category, pinned to one
  category at a time.

If JoomPulse MCP access is unavailable, stop and explain that the skill requires
JoomPulse MCP setup before it can find uncontested niches.

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
- **Keep the workflow invisible.** The seller wants the niches, not a play-by-
  play. If one approach does not return data, switch to another quietly; only if
  every approach fails do you say one short, friendly sentence. Never fill gaps
  from general knowledge.

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

### Step 1 — Resolve the category and find its deep sub-levels

1. **Ask the user for a category** (a name or a category identifier). If given a
   name, use JoomPulse to resolve it to a category **on the chosen marketplace**,
   matching on the category name. If several categories match, briefly list the
   candidates (name and level) and ask which one is meant.
2. **Build the set of levels deeper than the third** under the chosen category.
   - **Mercado Livre:** use JoomPulse to walk down the category tree from the
     chosen branch and collect the descendant categories below the third level.
     Keep that set of deep category identifiers for the next step.
   - **Shopee:** deep niches do exist, but only through the item view — Shopee's
     category analytics stop at three levels, while the items themselves carry a
     category path several levels deeper, and populated fourth-level leaves are
     real. So build the deep set from **the items' own deeper category path**
     rather than the category tree, and always say which level you worked at.
3. If the chosen category is itself at or above the third level and has nothing
   deeper beneath it, tell the user there are no deep sub-levels for it and offer
   to run on a broader category.

### Step 2 — Keep only the uncontested deep sub-categories

1. Use JoomPulse to list the **active product listings** in those deep
   sub-categories.
   - **Mercado Livre:** for each listing collect name, category, seller, listing
     type, seller medal, logistics (frete grátis), price, estimated **weekly**
     sales and revenue, rating, review count, time on air, and — where available
     — how many sellers compete on the listing.
   - **Shopee:** collect name, the deeper category path the item itself carries,
     shop, shop tier (Official store / Preferred (Indicado) / Common), price,
     estimated sales and revenue **over the last 30 days**, rating, review count,
     the date the item was created — this is what time on air is computed from —
     and the date it was last seen. There is no listing-status filter on Shopee,
     so how recently an item was last seen is what tells you whether it is still
     live; check it and never present a stale row as a live opportunity. Free
     shipping and listing tier have no Shopee equivalent. The competition signal
     — how many sellers are in the niche — comes from the view of the sellers in
     a category, pinned to one deep category at a time.
2. **Decide which deep sub-categories are genuinely uncontested.** Group the
   listings by their deep sub-category and check each group for the incumbent that
   matters on that marketplace:
   - **Mercado Livre:** a deep sub-category is uncontested only when it has **no
     platinum seller at all** among its listings. **Keep only the sub-categories
     with zero platinum sellers.**
   - **Shopee:** there are no medals and no ladder, so the platinum wording does
     not carry across. A deep niche is uncontested only when it has **no Official
     store (Shopee Mall) seller at all** — the three shop tiers are mutually
     exclusive (Official store / Preferred (Indicado) / Common). **Keep only the
     niches with zero Official stores.**

   Do not merely drop the incumbent-held listings from a sub-category that still
   has one — that sub-category is contested and its other listings are not
   uncontested.
3. From the uncontested sub-categories, keep the listings that are real, funded
   niches — those with estimated sales above zero — and rank them so the
   strongest uncontested opportunities lead: by estimated **weekly** revenue on
   Mercado Livre, by estimated **30-day** revenue on Shopee. If nothing has
   estimated sales, fall back to listing the active listings in those
   sub-categories and say so. These are the **uncontested niches.**
4. **If keeping only the uncontested sub-categories leaves too few results**, you
   may additionally include the non-incumbent listings from sub-categories that
   still have one — but present them in a clearly separate, labelled group,
   **"non-platinum listings (platinum sellers still present in the category)"** on
   Mercado Livre or **"listings outside an Official store (Official stores still
   present in the category)"** on Shopee, and do **not** call them uncontested.
   Always lead with the genuinely uncontested niches.
5. If every deep sub-category has at least one incumbent, report that the deep
   sub-categories are already contested — by platinum sellers on Mercado Livre, by
   Official stores on Shopee — suggest a sibling category, and — if helpful —
   offer the non-incumbent listings under the labelled non-uncontested group
   described above.

## Output

Respond in the seller's language. Present the result with no commentary about how
it was produced. The product table always renders as markdown so it reads
cleanly in any client.

Lead with a short intro line naming the **marketplace** and the category — and on
Shopee, the category level you actually worked at.

**Niche table (Mercado Livre)** — one row per uncontested niche product (from the
platinum-free deep sub-categories), with these columns:

- Product / listing identifier (rendered as a JoomPulse link for the product)
- Name
- Category
- Seller
- Price
- Estimated sales (weekly)
- Estimated revenue (weekly)
- **Number of sellers** — the competition signal, so "uncontested" is legible
  (show `—` when it is not available)
- Rating
- Reviews
- Time on air
- Free shipping (frete grátis)
- Listing type
- Seller medal — gold, silver, or no medal (never platinum; uncontested rows
  come only from platinum-free sub-categories per Step 2)
- A JoomPulse link for the product

**Niche table (Shopee)** — the same shape, with the marketplace's own columns:

- Item identifier, linked to the item on Shopee — **there is no JoomPulse
  dashboard link for Shopee rows**, so never invent one
- Name
- Category — the deeper path the item itself carries; say which level it is
- Shop
- Price
- Estimated sales (30 days)
- Estimated revenue (30 days)
- **Number of sellers** in the niche — the competition signal (show `—` when it
  is not available)
- Rating
- Reviews
- Time on air (days) — computed from the date the item was created
- Shop tier — Official store / Preferred (Indicado) / Common; uncontested rows
  carry only Preferred (Indicado) or Common, never Official store
- Free shipping and listing type have **no Shopee equivalent**: either drop these
  columns or show `—` in them. Never map a shop tier onto a seller medal.

The sales columns are **not** the same window on the two marketplaces: Mercado
Livre reports weekly figures, Shopee reports 30-day figures only — label the
Shopee columns as 30 days and never present a 30-day figure under a weekly
heading.

Put the marketplace link on the product identifier in each row. When a cell is
empty, show `—` rather than guessing. Below the table, briefly state what
"uncontested niche" means here: sub-categories deeper than the third level that
have **no platinum seller at all** among their listings on Mercado Livre, or **no
Official store (Shopee Mall) seller at all** on Shopee. You may translate the
column headers into the seller's language.

**On Shopee, state this next to the verdict itself, not only in the guardrails:**
only items with at least one lifetime sale are tracked, so an Official store
whose items have never sold is invisible in the data — an "uncontested" verdict
can therefore be false. Present it as the best available read, not as proof that
no Official store is in the niche.

**If you also include the fallback group** (listings without the incumbent, taken
from sub-categories that still have one, used only when the uncontested set is too
small), put it in a clearly separate, labelled section — titled **"non-platinum
listings (platinum sellers still present in the category)"** on Mercado Livre, or
**"listings outside an Official store (Official stores still present in the
category)"** on Shopee. Use the same columns, but do **not** call these rows
uncontested — be explicit that the incumbent is still active in those
sub-categories.

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

**Cards** — three summary cards:

- **Produtos encontrados** — the count of uncontested niche rows in the table
  (from the deep sub-categories with no incumbent).
- **Subnichos cobertos** — the count of distinct deep sub-categories actually
  represented in the results.
- **Ticket médio** — the average price across the listed rows, in pt-BR currency
  formatting (for example `R$ 1.234`).

**Chart** — a horizontal bar of the top niche products by estimated revenue —
weekly on Mercado Livre, 30-day on Shopee, and label the axis with the window you
used — strongest uncontested niches first, each bar labelled with a short product
name. **Skip the bar entirely when there are fewer than four products** — show
only the cards and the table.

Round numbers and use pt-BR formatting (for example `R$ 1.234`, `1.234 vendas`).
If you show Mercado Livre seller medals as coloured chips, keep the standard
palette; on Shopee there are no medals, so write the shop tier as plain text and
never colour it as a rung on a ladder.

## Notes & Guardrails

The seller should never see a system or stack error — only a friendly next step.

- **No deep sub-categories:** if the chosen category has nothing deeper than the
  third level, say so and offer to run on a broader category. On Shopee, reach
  the deeper levels through the item view before concluding there are none.
- **No uncontested sub-categories:** if every deep sub-category has at least one
  platinum seller (Mercado Livre) or one Official store (Shopee), report that the
  deep sub-categories are already contested and suggest a sibling category. You
  may still offer the non-incumbent listings, but only under the labelled
  fallback group — never as uncontested.
- **Shopee coverage limits the verdict:** only items with at least one lifetime
  sale are tracked, so an Official store whose items have not sold does not
  appear at all and an "uncontested" verdict can be false. Say this in the output
  itself, every time. Likewise, there is no listing-status filter — judge whether
  an item is still live by how recently it was last seen.
- **Too few uncontested niches:** if the genuinely uncontested sub-categories
  yield too few results, you may add the non-incumbent listings from sub-
  categories that still have one, in the separate labelled group above — always
  lead with the uncontested niches and never relabel the fallback group as
  uncontested.
- **No funded listings:** if no listing has estimated sales, list the active
  listings in the uncontested sub-categories instead and say the niche has
  little measured traction.
- **Unknown flags:** when a logistics flag such as frete grátis is unknown, show
  it as unknown — do not assume "no". On Shopee, free shipping and the listing
  tier are always `—`: an absent attribute, not a missing value, and never a
  "Não".
- **Many deep sub-categories:** when the deep category set is large, gather the
  listings in batches and merge the results before ranking. On Shopee the
  competition signal is pinned to one category at a time, so collect it per niche
  and merge.
- **Market data temporarily unavailable:** retry once quietly; if it is still
  down, say market data is temporarily unavailable. Never paste internal error
  text, HTTP codes, or field names to the seller.
- **Never silently limit coverage** — if you cover only some of the deep
  sub-categories, say so, and on Shopee say which category level you used.
