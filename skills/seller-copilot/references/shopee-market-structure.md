# Market structure on Shopee

How a Shopee category is built: how big, how concentrated, who holds it, and which way it is
moving. This answers "can I compete here", which is a different question from "is there demand
here".

## What to ask for

- **The category**, at whatever depth the seller has in mind.

## The concentration measure — read this before quoting it

Shopee concentration is an **index computed across all sellers' shares**, running from 0 to 1
and banded low / medium / high. It is **not** "the share held by the largest seller", and the
two are not interchangeable.

This matters because the obvious sentence — *"the top seller holds more than half the
category"* — is **not** something this figure can support. A category can score high on the
index because a handful of mid-sized sellers split it, with no single dominant player at all.

So:

- Describe it as **how tightly the category is held across all sellers**, not as one seller's
  share.
- If the seller specifically wants the leading seller's share, that has to come from ranking
  the sellers themselves — see [shopee-discover-competitors.md](shopee-discover-competitors.md) — and say
  that is a different measurement.
- **Never compare this index against a concentration figure from another marketplace.** They
  are computed differently; the numbers are not on the same scale.

## What else to read

**Size and shape.** Estimated revenue and orders, how many sellers have sales, how many items
carry them, and the average order value.

**Seller mix.** Official (Shopee Mall) shops, preferred (verified) shops, and regular sellers,
as shares. A category dominated by official shops is a harder entry than the raw seller count
suggests; one that is mostly regular sellers is still open.

**Where the sellers are.** The location split — the largest Brazilian states, cross-border
sellers, and everything else. A high cross-border share means competing against different
economics and different lead times, which changes the advice even when the headline numbers
look attractive.

**Movement.** Month over month only. Say so.

## Interpretation

The combinations matter more than any single figure:

- **Sizeable, low concentration, growing** — the best case; room to enter.
- **Sizeable but tightly held** — entering means taking share from established sellers. Possible
  only with a stated edge.
- **Small but accelerating, with sellers arriving** — often more attractive than a large static
  category, especially for a seller who can move quickly.
- **Sizeable and shrinking** — the trap. The size looks reassuring; the direction is what
  matters.

## Procedure

1. Resolve the category and **pin one level**. Every ancestor level repeats its whole subtree,
   so mixing levels inflates the totals several times over.
2. Read the latest month at that level, plus the previous month for movement.
3. Read the seller mix and location split.
4. Where the question is about who holds the category, rank the sellers themselves rather than
   inferring it from the concentration index.
5. **Confirm the month on the returned rows** rather than trusting a "current period" marker.

## Screening several categories at once

Ranked lists across categories have three failure modes worth guarding against:

1. **Every row must come from returned data.** Never top a list up to a round number — if six
   categories meet the filters, return six and say so.
2. **Show the composite.** If the ranking combines concentration, growth and earnings per
   seller, name the components and give each one's value per row. An unexplained ranking cannot
   be argued with.
3. **Compare like with like** — same level, same month. A level-3 category against a level-1
   category is not a comparison.

## Output

**Verdict first:** is this a category the seller can compete in, and why.

Then size, concentration band, seller mix and location split, and the month-over-month move.
Band the concentration so the shape reads at a glance, and say which level and month the figures
describe.

State the estimate disclaimer once. Use full BRL precision. Show `—` for unavailable values.

## Boundaries

- **Revenue and order figures are estimates** from rounded public counters.
- **Month over month is the only movement available.** No longer-run trend, no seasonal shape —
  the history starts in May 2026. Two or three months is not a trend; say so rather than
  implying direction.
- **Brand concentration is not computable** — brand coverage is a lower bound, so a brand-share
  figure would be misleading. Do not produce one.
- Concentration describes the category, not the difficulty of any individual product — an open
  category can still contain a locked-up niche.
