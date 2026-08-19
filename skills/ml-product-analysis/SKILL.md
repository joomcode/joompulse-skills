---
name: ml-product-analysis
description: >
  Analyzes one product and its competitors on JoomPulse — Mercado Livre (Brasil)
  or Shopee Brasil. From a marketplace link, a JoomPulse link, a photo, or a row
  of data, it returns a card for the subject product plus a ranked table of
  comparable items, each with price, estimated monthly sales and revenue, rating
  and reviews; on Mercado Livre also logistics and catalog / buy-box status,
  which do not exist on Shopee. Triggers: "analyze this product", "how much does
  this sell", "find similar products", "find competing products"; pt-BR
  "analisar este produto", "quanto vende esse produto", "produtos parecidos",
  "produtos concorrentes", "análise por foto", "analisar este produto da
  Shopee", "quanto vende esse produto na Shopee", "concorrentes na Shopee". Ask
  which marketplace when unclear; never mix the two. Sales and revenue are
  JoomPulse estimates, not real transactions; price, rating and reviews are real.
  For which products to add across a whole catalog, use the gap-analysis skill.
---

# Single-Product Analysis

This skill analyzes **one** product and the products that compete with it, on
**Mercado Livre (Brasil) or Shopee Brasil**, using JoomPulse market data. Given a
single product — by a marketplace link, a JoomPulse link, a photo, or a row of
data — it identifies the product, finds comparable listings, and returns a
product card for the subject plus a ranked table of analogs. For each one it
shows price, estimated monthly sales and revenue, rating and reviews; on Mercado
Livre also logistics and catalog / buy-box status. Shopee has no catalogue and no
buy-box, so that part of the analysis is omitted there, not left blank.

This is different from whole-catalog assortment analysis. If the user wants to
know which new products to add to their store, hand off to the gap-analysis
skill. This skill works on a single product the seller already has in hand.

## Prerequisites

- JoomPulse MCP access is configured for the current agent environment.
- The user provides a marketplace — Mercado Livre (Brasil) or Shopee Brasil — and
  one product on it: a marketplace link, a JoomPulse link, a product photo, or a
  row of data (a `.csv` / `.xlsx` file, a pasted table, or typed fields).
- The available JoomPulse tools can look up product market data on **either**
  marketplace and find comparable listings. The ways of finding comparables
  differ: on Mercado Livre by image, by meaning, by category and by keyword; on
  Shopee only by category and by title text.

If JoomPulse MCP access is unavailable, stop and explain that the skill requires
JoomPulse MCP setup before it can analyze a product or find competitors.

## Scope

- **Mercado Livre (Brasil) and Shopee Brasil**, one at a time. Other marketplaces
  are out of scope.
- **Sales and revenue are JoomPulse estimates** — not real transactions. Disclose
  this in every output. By contrast, **price, rating, and review count are real
  history** from the marketplace — say so. The estimates are built differently on
  each marketplace: on Mercado Livre from historical listing data, on Shopee from
  the marketplace's own rounded sold counters refined with review movement. Use
  the matching disclaimer.
- **Prices are marketplace prices only.** Do not surface sourcing prices,
  margins, or profit figures.
- **Read-only.** The skill does not sign in as the seller or modify any listing.
- **Language:** detect the seller's language and respond in it. Default to
  pt-BR.
- **Keep the workflow invisible.** The seller wants the answer, not a play-by-
  play. Do the analysis quietly and present only the result. If one approach to
  finding the product or its competitors does not work, switch to another
  silently; only if every approach fails do you say one short, friendly sentence.

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

### Step 1 — Route the input to one subject product

Resolve the input to a single normalized subject product, then find analogs. The
first matching rule wins:

1. **A photo** → Photo route.
2. **A `.csv` / `.xlsx` file, a pasted table, or typed fields** → Tabular route.
3. **A Mercado Livre link** → MLB route.
4. **A Shopee item link** → Shopee route.
5. **A JoomPulse product link** → JoomPulse route. These exist for Mercado Livre
   only; Shopee items have no JoomPulse product page.
6. **A JoomPulse store link** → this is a whole store, not one product. Ask for a
   specific product link or a product title; whole-store analysis belongs to the
   gap-analysis skill.
7. **Any other link** (a different marketplace, a generic web page) → do not
   scrape it. Explain that only Mercado Livre, Shopee and JoomPulse links can be
   resolved directly, and ask the seller to paste the product name or upload a
   photo → Keyword route.
8. **Plain text** (a product name or keywords) → Keyword route.

Every route converges on one normalized subject product plus a set of candidate
analogs.

#### MLB route

1. Extract the product identifier from the link, noting whether it is a catalog
   product or an individual listing.
2. Look up the canonical title, category, and attributes for that identifier
   when available. If the lookup is unavailable for that listing, continue with
   the JoomPulse market data instead.
3. Fetch JoomPulse market data for the subject. For a catalog product, several
   competing listings may come back; pick the representative one (the strongest
   seller / buy-box winner) for the card and read competition from the number of
   buy-box sellers and total sellers. This step is **Mercado Livre only** — it has
   no counterpart on Shopee.
4. Build the subject from that data, then find analogs.

#### Shopee route

1. A Shopee product link carries **two bare numeric identifiers** — the shop and
   the item — with no `MLB`-style prefix and no catalogue-versus-listing
   distinction, because an item belongs to a single shop. Read both out of the
   link.
2. Fetch the item's Shopee market data: title, category path, brand, current
   price and the lowest price seen **since May 2026**, estimated sales and revenue
   over the last 30 days, the item's lifetime monthly average and the direction
   flag comparing the two, rating, review count, favourites, whether it ships
   cross-border, how many photos it has, and the shop with its tier.
3. Check how recently the item was last seen before presenting it as live.
4. Build the subject from that data, then find analogs. **Skip catalogue and
   buy-box work entirely** — Shopee has neither, so catalogue status, a buy-box
   winner, a buy-box price and a seller count are meaningless there. Omit those
   lines instead of leaving them empty.

#### JoomPulse route

Look up the product directly in JoomPulse by its identifier, optionally enriching
the title and attributes from the canonical product lookup, then find analogs.
This route is Mercado Livre only.

#### Photo route

On **Mercado Livre**, image-based matching is primary and visual inspection is the
fallback. On **Shopee there is no image search at all**, so the photo route there
is always the fallback: read the picture yourself and search by what you see.
Accept common image formats, including phone formats such as HEIC/HEIF. Always
tell the seller the results are **visually similar — not a guaranteed exact
match.**

1. On Mercado Livre, use the available JoomPulse image-based product search to
   find similar listings from the photo. Alongside the matches, this search can
   return a quick opportunity summary — an overall verdict on whether the product
   is worth selling, the number of matching listings, and aggregate market stats.
   For a fast answer you can present that summary directly (still labeled as a
   visual match); otherwise carry the matched listings into the analog pipeline
   below.
2. If image search is unavailable or returns nothing — and **always on Shopee** —
   inspect the photo yourself: note the product type, brand and model if legible,
   color, material, and key attributes. Turn that into search terms and run the
   Keyword route. Label the subject card as the best visual match, not an exact
   match.

#### Tabular route

Normalize the rows into product records (handle pt-BR column headers and
`R$ 1.234,56`-style prices). For each row: an `MLB`-style identifier takes the MLB
route, a bare numeric shop-and-item pair takes the Shopee route, and otherwise its
title drives the Keyword route. One row yields one subject. For several rows,
analyze each — cap at a small number and say so when you do. All rows in one run
must belong to the same marketplace.

#### Keyword route

Build a clean search query from the title or photo description, plus a broadened
fallback query. On Shopee, titles mix Portuguese, English and Chinese, so prepare
**short tokens in both languages** instead of one long phrase.

### Step 2 — Find analogs

Both the keyword and photo paths feed the same analog pipeline:

1. **Search for candidates.**
   - **Mercado Livre:** use JoomPulse search by meaning to find listings similar
     to the subject, keeping the closest matches. Query in pt-BR first and
     English second. If recall is too low, retry once with the broadened query.
     For the photo route, the image-search results play this role.
   - **Shopee:** there is **no image search and no search by meaning**.
     Comparables come from the subject's own category plus a title search — and
     because titles mix Portuguese, English and Chinese, search **short tokens in
     both languages** rather than one long phrase, then merge the hits.
2. **Augment when recall is thin.** Optionally widen the candidate set using
   category and keyword search, or constrain to the subject's category. On Shopee,
   category analytics stop at three levels — if the subject sits deeper, work the
   comparables through the item view and say which you used.
3. **Merge and drop the subject.** Deduplicate the candidate identifiers and
   remove the subject itself.
4. **Validate and fetch market data.** Look up the candidates to confirm they are
   live and to fetch the fields each row needs — on Mercado Livre price, sales,
   revenue, logistics and catalog / buy-box fields; on Shopee price, 30-day sales
   and revenue, the lifetime monthly average and direction, rating, reviews,
   favourites, cross-border shipping, photo count and shop tier, with **no
   catalogue or buy-box fields at all**.
5. **Rank.** Score each candidate by a blend of similarity to the subject,
   demand (estimated revenue), and how crowded the listing is, then sort by that
   score. Drop candidates with no sales. Present a single ranked list — do not
   split analogs into thematic sub-tables. On Shopee, never rank on a difference
   of a few units: the sold counters are rounded, so small gaps are noise.

## Output

Respond in the seller's language. The visible reply contains only the result, in
this order, with no commentary about how it was produced:

1. An optional one-line framing sentence, naming the **marketplace**.
2. The subject product card.
3. The ranked analogs table.
4. The disclaimer.
5. The download offer.

Use plain markdown so it renders cleanly in any client.

**Subject card (Mercado Livre)** — product name and image, category and brand,
current price and historic minimum price, estimated monthly sales and revenue,
logistics (Mercado Envios Full / free shipping / international), catalog /
buy-box status (whether it is in the catalog, the number of buy-box sellers and
the buy-box price, and the total number of sellers), and links to the product on
Mercado Livre and on JoomPulse. On the photo route, label the card as the best
visual match, not an exact match.

**Subject card (Shopee)** — same shape with the marketplace's own fields: item
title and image, category path and brand, current price and the lowest price
**since May 2026** (label it that way — it is not an all-time low), estimated
sales and revenue over the last 30 days, the item's lifetime monthly average with
the direction flag comparing the two, rating, review count, favourites, whether
it ships cross-border, photo count, the shop and its tier (Official store /
Preferred (Indicado) / Common), and links to the item and the shop on Shopee —
**there is no JoomPulse product page for Shopee items**, so never invent one.
**Omit catalogue status, buy-box sellers, the buy-box price and the seller
count** — they do not exist on Shopee, so leave the lines out rather than showing
them empty. Free shipping, the fulfilment programme and the listing tier have no
Shopee equivalent either: omit them or show `—`, never a "Não".

**Analogs table (Mercado Livre)** — one row per comparable product, with the
product name, brand, price (current and historic minimum), estimated monthly
sales and revenue, logistics, catalog / buy-box status, number of sellers, review
rating, and a links column holding the Mercado Livre and JoomPulse links. Keep
both links for every product.

**Analogs table (Shopee)** — one row per comparable item, with the item name,
brand, price (current and the lowest since May 2026), estimated sales and revenue
over the last 30 days, the lifetime monthly average and the direction flag,
rating, reviews, favourites, cross-border shipping, photo count, shop tier, and a
links column holding the item and shop links on Shopee. **No catalogue, buy-box
or seller-count columns** — drop them, do not leave them blank.

You may translate the column headers and card labels into the seller's language.
Note that the sales windows are **not** the same on the two marketplaces: Mercado
Livre reports weekly and monthly figures, Shopee reports 30-day figures only —
label the Shopee columns as 30 days and never present a 30-day figure under a
weekly or monthly heading. Empty field → `—`; never guess or fabricate.

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

**Download** — offer a downloadable spreadsheet (`.xlsx` plus `.csv`) of the
subject and analogs. On Mercado Livre give separate Mercado Livre and JoomPulse
link columns so the seller can see the source of every product's data; on Shopee
give the item and shop link columns instead, and use the Shopee column set.

## Notes & Guardrails

The seller should never see a system or stack error — only a friendly next step.

- **Wrong marketplace assumed:** if an identifier or link is not found on the
  marketplace you assumed, check the other one before telling the seller the
  product does not exist.
- **Subject not tracked in JoomPulse / no sales:** JoomPulse tracks products that
  have sales, so a product may not be tracked. Say so, show whatever canonical
  product facts are available, and still surface analogs by category or keywords.
  On Shopee, coverage is a lower bound — only items with at least one lifetime
  sale are tracked — so an absent item is not proof that it does not sell.
- **Valid product, no market data:** show the canonical product facts and note
  that there is no JoomPulse estimate; draw analogs from the item's category.
- **Photo:** on Mercado Livre, image search first, then visual inspection if it is
  unavailable or empty; on Shopee there is no image search, so go straight to
  visual inspection plus a title and category search. Always label results as
  similar, not exact; if the match is ambiguous, show the top candidates and ask
  the seller to confirm.
- **Search returns nothing:** an empty result for a niche or non-pt-BR query is
  normal — retry once with an English or broadened query, then move on. On Shopee,
  also try short tokens in the other language before giving up. If search is
  temporarily unavailable, say so briefly and rely on the other data.
- **No catalogue or buy-box on Shopee:** never present catalogue status, a buy-box
  winner, a buy-box price or a seller count for a Shopee item, and never map a
  shop tier onto a Mercado Livre seller medal — both are fabrication.
- **Market data temporarily unavailable:** retry once quietly; if it is still
  down, say market data is temporarily unavailable. Never paste internal error
  text, HTTP codes, or field names to the seller.
- **Never silently limit coverage** — if you analyze only some rows or some
  candidates, say so.
- **Prefer precision over recall.** A shorter list of confident analogs is better
  than a long list of weak ones.
