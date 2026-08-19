---
name: pulse-find-exact-same-product
description: >
  Finds the listings that appear to represent the same real-world product as a
  reference item, on JoomPulse — Mercado Livre (Brasil) or Shopee Brasil. Use it
  to find duplicate listings, match a product across listings from a title, a
  link or an identifier, or check whether a product is already being sold on the
  other marketplace. Triggers: "find the same product", "duplicate listings",
  "is this product already on Shopee", "find this item on Shopee"; pt-BR "achar
  o mesmo produto", "anúncios duplicados", "esse produto já existe na Shopee",
  "procurar esse item na Shopee". Ask which marketplace when unclear; never mix
  the two. On Mercado Livre the shared catalogue anchors a match; Shopee has no
  shared catalogue, so matching is a short-token title search confirmed by
  brand, category and a plausible price band, and photo search is unsupported
  there.
---

# Find Exact Same Product

This skill finds listings that appear to represent the same real-world product
as a reference product, on **Mercado Livre (Brasil) or Shopee Brasil**, using
JoomPulse market data. The seller picks a marketplace and hands over a reference
— a title, a link, an identifier or a picture — and the skill returns the
listings it can confirm are the same product, each with a short reason.

"The same product" means the candidate listing matches the reference item's
identity: brand, model, variant, color, size, capacity, pack count, bundle
contents, and other defining attributes visible from the provided product data.
Formatting, casing, punctuation, and translation differences are acceptable when
the underlying product is clearly the same.

What confirms that identity differs by marketplace. On Mercado Livre several
sellers can list the very same catalogue product, so the shared catalogue is the
strongest anchor available. On Shopee nothing links different shops' listings of
one product, and an item belongs to a single shop, so a match has to be built
from a title search and then confirmed on attributes.

## Prerequisites

- JoomPulse MCP access is configured for the current agent environment.
- The user provides a marketplace — Mercado Livre (Brasil) or Shopee Brasil —
  and a reference product: a title, a product link, a product identifier, or a
  product image.
- The available JoomPulse tools can search marketplace listings on **either**
  marketplace and return enough product data to compare candidates: title,
  category, price, seller or shop, rating and review count, and, where the
  marketplace records it, brand.
- The image route needs an image-based product search, which exists on Mercado
  Livre only.

If JoomPulse MCP access is unavailable, stop and explain that the skill requires
JoomPulse MCP setup before it can search or compare products.

## Scope

- **Mercado Livre (Brasil) and Shopee Brasil**, one at a time. Other
  marketplaces are out of scope.
- **What anchors a match differs.** On Mercado Livre, the listings of one
  catalogue product are the reference set. On Shopee there is no shared
  catalogue identifier linking different sellers' listings of the same product,
  so that anchor does not exist: matching is a title search plus attribute
  confirmation.
- **A title-only match is not a confirmed match** on Shopee. Confirm on brand
  plus category plus a plausible price band, and label anything weaker as a
  likely candidate, not a match.
- **The photo route is unsupported on Shopee** — there is no image-similarity
  search. Say so plainly instead of attempting it.
- **An absent match is not proof** the product is not sold on Shopee: coverage
  includes only items with at least one lifetime sale, and brand is recorded for
  tracked items only.
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

### Step 1 — Resolve the reference product

- If the user provides a **title**, use it directly as the reference.
- If the user provides a **link or an identifier**, fetch the available product
  details first. A Mercado Livre listing code or link resolves on Mercado Livre;
  a Shopee link carries two bare numeric identifiers — the shop and the item —
  and resolves on Shopee.
- If the user provides an **image**:
  - On Mercado Livre, use the available image-based product search workflow to
    generate candidate listings.
  - On Shopee there is **no image-similarity search** — say so plainly rather
    than attempting one. You may still read the picture yourself, describe what
    you see (brand, product type, colour, pack size) and search on those words,
    but label the result as a search by your own reading of the photo, never as
    an image match.
- Echo back what you captured — the marketplace and the reference product — so
  the user can correct it before you search.

### Step 2 — Search for candidate listings

- Use JoomPulse product search to find plausible candidates. Treat search
  results as candidate generation, not final truth.
- **Mercado Livre:** start from the listings of the same catalogue product, then
  widen to a title search inside the category if that set is thin.
- **Shopee:** title search is a **literal substring match**, and item titles mix
  Portuguese, English and Chinese. So:
  - search several **short tokens** instead of one long precise phrase — a long
    phrase typically returns nothing at all;
  - try both the Portuguese and the English wording of the same token;
  - **scope the search to a category**, because a short generic token on its own
    comes back full of unrelated bundles and accessories.
- Prefer a compact candidate set first, then broaden only when recall is clearly
  too low.

### Step 3 — Enrich candidates

- Fetch title, category, price, images, seller or shop, rating, review count,
  the attributes the marketplace records, and the link for each candidate.
- **Mercado Livre:** the catalogue product and the listing attributes carry most
  of the identifying detail.
- **Shopee:** brand is recorded only for tracked items, so expect it to be
  missing on part of the set; also check how recently each item was last seen, so
  a stale row is never presented as a live listing.
- Keep enough source data to explain why a candidate was accepted or rejected.

### Step 4 — Decide the matches

- Accept a candidate only when the defining attributes match the reference.
- Reject candidates when brand, model, size, color, capacity, pack count,
  bundle contents, or other defining attributes differ.
- **On Shopee, confirm a match on brand plus category plus a plausible price
  band — never on the title alone.** A title-only match is not a confirmed
  match: report it as a likely candidate and say what is still unverified. Where
  brand is absent, a likely candidate is the strongest claim available.
- If data is insufficient for a confident match, do not mark it as exact.
- Do not rely on title similarity alone when important attributes are missing
  or ambiguous.

### Step 5 — Return the results

- List confirmed matches with their links — the JoomPulse page on Mercado Livre,
  the item's own Shopee link on Shopee. **There is no JoomPulse dashboard link
  for Shopee rows**, so never invent one.
- Include a short rationale for each accepted match.
- If there are no confident matches, say so clearly and summarize what was
  checked, including which wordings were tried. On Shopee, add that this is not
  proof the product is not sold there — coverage includes only items with at
  least one lifetime sale.
- When useful, include rejected near-matches separately with the key reason
  they were rejected.

## Output Format

Respond in the seller's language. Lead with a short line naming the
**marketplace** and the reference product. Use a concise table when there are
multiple candidates:

| Result | Product | Link | Why it matches |
| --- | --- | --- | --- |
| Match | Product title | Product link | Same brand, model, size, and variant |

- **Mercado Livre:** the product column carries the listing code, and the link
  points at its JoomPulse page.
- **Shopee:** the product column carries the item title and its shop, and the
  link is the item's own Shopee link, built from the two numeric identifiers for
  the shop and the item. A row is a **Match** only when brand, category and
  price band agree; otherwise call it a **likely candidate** and name what is
  still unverified.

For a single match, a short paragraph with the product link and rationale is
enough. Empty field → `—`; never guess or fabricate.

## Notes

- Prefer precision over recall. A smaller list of confident matches is better
  than a broad list of uncertain candidates.
- Do not expose raw private data, internal identifiers, or implementation
  details in the final answer.
- If the user asks for bulk matching, process items one by one and make
  uncertainty explicit for each item.
- **Never mix the two marketplaces in one table.** If the seller wants to know
  whether a Mercado Livre product is also on Shopee, run the search twice and
  report the two sides separately.
- **No image-similarity search on Shopee:** say so in one short sentence and
  offer the token search based on your own reading of the photo instead. Never
  imply a photo match was performed.
- **Nothing found on Shopee:** an empty result is a floor, not a verdict —
  coverage includes only items with at least one lifetime sale, and a literal
  title search misses the wordings you did not try. Offer to try other tokens
  or another category.
- **Market data temporarily unavailable:** retry once quietly; if it is still
  down, say market data is temporarily unavailable and to try again shortly.
  Never paste internal error text, HTTP codes, or field names to the seller.
