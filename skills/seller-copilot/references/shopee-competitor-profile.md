# Profile a Shopee shop

Read one shop — a competitor's, or the seller's own — and say what the numbers mean together. A
profile that lists nine metrics without a read has not answered the question.

## What to ask for

- **The shop**, by Shopee link, username, shop identifier, or name.
- Whether they want the **whole store** or the shop **within one category**. These are different
  reads and the figures differ; see below.

## Whole-store versus in-category — decide first

The shop profile is **whole-store**: every rollup covers all categories the shop sells in. For
how a shop performs *inside one category*, that is a different read — see
[shopee-discover-competitors.md](shopee-discover-competitors.md), which carries category-scoped figures.

Getting this wrong produces confidently wrong answers: a generalist shop can look enormous
store-wide while being a minor presence in the niche the seller cares about. **Say which read you
did**, every time.

The two cannot be joined in one query. If the answer needs both, that is two reads, integrated in
prose.

## What to read, and what is real

Mark provenance as you report — this profile mixes real observations with estimates:

- **Badge tier** — official (Shopee Mall), preferred (verified), or regular. **Real**, and
  mutually exclusive. There is no medal ladder, no reputation score and no reputation history on
  Shopee; **inventing any of these is fabrication.**
- **Shop rating and review count** — **real**. Note this is the shop-level rating, distinct from
  the ratings of individual items.
- **Follower count** — **real**.
- **Location** — **real**. A Brazilian state, or a marker showing the shop ships cross-border.
- **Shop age**, from its creation date — **real**.
- **Item counts** — how many tracked items, how many with sales, how many carry video, how many
  ship cross-border, how many brands. Real counts, but **over tracked items only**.
- **Average price and average order value** — average price is real; **average order value is an
  estimate**, since it is weighted by the estimated sold figures.
- **How its items are trending** — counts of items growing, stable and falling. **Estimates.**

Do not blanket-label the profile as estimated: the badge tier, ratings, review and follower
counts are exactly the figures a seller should be able to trust, and calling them estimates pushes
them to discount the firmest evidence in the profile. Equally, do not present the trend counts or
average order value as observed.

## Interpretation

The figures matter less than the combination:

- **Many items but few with sales** — a shop listing widely and converting narrowly. The
  headline item count overstates it.
- **A high share of falling items** — losing grip, whatever the size. An opening.
- **Small, young, with most items growing** — the one to watch; they have found something.
- **A strong rating on a thin review count** is not yet evidence. Say so rather than treating it
  as equivalent to a strong rating on thousands.
- **Official tier with a modest catalogue** — a brand operating its own store, not a reseller.
  Competing with it means competing with the brand.
- **Cross-border** — a different cost base and delivery promise; note it, because it changes what
  "matching their price" would cost the seller.

## Procedure

1. Resolve the shop; confirm which one when the name is ambiguous rather than picking.
2. Decide whole-store or in-category, and say which.
3. Read the profile, marking provenance per figure.
4. Where the question is competitive, put the figures beside the category norms from
   [shopee-market-structure.md](shopee-market-structure.md) so "large" means something.
5. For the shop's actual assortment, read its items — see
   [shopee-assortment-and-price-gaps.md](shopee-assortment-and-price-gaps.md).

## Output

**Verdict first:** what kind of operator this is, and what it means for the seller.

Then the profile table — badge tier, location, age, rating and reviews, followers, item counts,
price and order value, trend mix — with provenance marked. Close with the interpretation, not
just the numbers.

State the estimate disclaimer once. Use full BRL precision. Show `—` for unavailable values.

## Boundaries

- **No revenue history per shop.** There is no monthly or weekly revenue series for a Shopee
  shop, so "how much did this shop make last month" is not answerable directly. The nearest real
  route is summing the estimated revenue of its items — say that is what you did and that it is an
  estimate built from item rows.
- **No cancellation rate**, no reputation ladder, no medal history.
- **No stored history for the shop profile** — it is a snapshot. Period-over-period comparison
  needs a previous snapshot the seller supplies.
- **Counts cover tracked items only** — items that have never sold are invisible, so every count
  is a lower bound.
- **Brand counts are a lower bound** and brand share is not computable.
