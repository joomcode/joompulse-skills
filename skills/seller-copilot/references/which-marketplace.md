# Which marketplace?

JoomPulse covers **two separate marketplaces**: Mercado Livre (Brasil) and Shopee Brasil. They
are independent datasets with different coverage, different history and different mechanics.
Deciding which one a request belongs to is the **first** step of every analysis, before any data
is read.

Read this file whenever the marketplace is not obvious, whenever the seller mentions both, or
whenever a request assumes something one marketplace has and the other does not.

## How to decide

**1. Did the seller say?** "Shopee" means Shopee. "Mercado Livre", "MeLi", "ML" or "Mercado
Libre" means Mercado Livre. Take them at their word.

**2. Does an identifier give it away?**

- An identifier beginning **`MLB`** is Mercado Livre.
- A **bare 10–11 digit number** is a Shopee item or shop. Mercado Livre identifiers are never
  bare numbers, so a long unprefixed number is itself a strong Shopee signal.
- A `mercadolivre.com.br` link is Mercado Livre; a `shopee.com.br` link is Shopee.
- If an identifier is not found on the marketplace you assumed, **check the other one before
  telling the seller it does not exist.**

**3. Does the request only make sense on one of them?** Anything about the buy-box, catalogue
position, seller medals, a fulfilment programme or search keywords is Mercado Livre — those
mechanics and that data do not exist on Shopee.

**4. Otherwise, ask.** One short question, before querying anything: which marketplace, and
mention that both are available. **Do not guess and do not default.** Guessing wrong wastes the
analysis and produces figures for a market the seller does not sell on.

## The rule that must never break

**Never mix data from the two marketplaces in one query, one table, or one total.**

They are separate pipelines with different grains and different estimate methods. A combined
figure is not a bigger picture, it is a wrong number. This applies to totals, averages, rankings
and charts alike.

## When the seller genuinely wants both

Comparing the two is a legitimate request — "should I sell this on Shopee or Mercado Livre?" — and
the answer is **two separate analyses reported side by side in prose**, never merged.

- Run each marketplace's own procedure, using that marketplace's reference files.
- Present them as two panels with their own captions, clearly labelled.
- **Compare orders of magnitude and direction, not exact numbers**, and say that is what you are
  doing. The two estimate methods differ enough that a precise-looking gap between them is not
  trustworthy.
- Say plainly where a comparison cannot be made at all, rather than filling the gap — for example
  there is no like-for-like seasonal comparison, because only one marketplace has the history.

## What each marketplace can answer

Where a request lands on a capability the chosen marketplace lacks, **name the gap and offer the
nearest real alternative** — never substitute the other marketplace's figure.

| Analysis | Mercado Livre | Shopee |
|---|---|---|
| Category evaluation, market structure | yes | yes, three category levels only |
| Finding products, validating a product | yes | yes |
| Competitor discovery and profiling | yes | yes |
| Assortment and price gaps, pricing | yes | yes |
| Item history week by week | no | **yes — Shopee only** |
| Margin and fees | yes | **no fee data at all** |
| Keywords and search demand | yes | **does not exist** |
| Seasonality, when to stock, long-run trend | yes | **no — history starts May 2026** |
| Buy-box / catalogue comparison | yes | **no such mechanic** |
| Listing diagnosis against a competitor set | yes | partly — no fulfilment or shipping attributes |
| Seller medals and reputation ladder | yes | **badge tiers only**, no ladder |
| Cancellation rate | yes | **not available** |
| Brand rankings and share | yes | **coverage unreliable — do not compute share** |
| Import versus domestic | yes | partly — cross-border flag only |
| Supplier vetting | yes | yes, using Shopee demand data |

## Which files to read once decided

- **Mercado Livre** → the unprefixed reference files, and the focused skills in this repo where
  one already does the job.
- **Shopee** → the `shopee-` prefixed reference files, and the focused skills that cover Shopee.

**Most focused skills in this repo now cover both marketplaces.** Each one decides the
marketplace first and then reads that marketplace's own data, so a Shopee question handed to one
is answered with Shopee data. Check the skill's own scope before deferring to it.

**Four are Mercado Livre only, by design:**

- **keywords and search demand** — Shopee has no search data at all;
- **buy-box / catalogue comparison** — Shopee has no catalogue and no buy-box;
- **brand rankings** — Shopee brand coverage is too incomplete to rank;
- **top sellers in a category** — Shopee has no per-seller revenue within a category yet.

For those four, do not hand a Shopee question over: name the gap and offer the nearest real
alternative from the `shopee-` references.

## Things that differ enough to catch you out

- **Concentration is not the same measurement.** Mercado Livre reports the leading seller's
  share; Shopee reports an index across all sellers. Never compare the two values, and never
  carry the "top seller holds half the shelf" phrasing to Shopee.
- **Badge schemes differ.** Mercado Livre has a medal ladder; Shopee has three mutually exclusive
  tiers and no ladder. Inventing Shopee medals is fabrication.
- **Category depth differs** — Shopee analytics stop at three levels, Mercado Livre goes deeper.
- **Absolute thresholds do not transfer.** A revenue floor that means "substantial" on one
  marketplace means something else on the other, even though both are in BRL. Judge a category
  against its own marketplace's siblings.
- **Both are Brazil**, so currency, language and the local retail calendar are the same. The
  differences are about data, not locale.
