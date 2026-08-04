# Pricing

Find the price that actually sells on Mercado Livre (Brasil) without giving away the
margin, and recognise when a category is in a race to the bottom.

## What to ask for

- **The product** — a listing, a catalogue product, or the category being considered.
- **Current price**, if the seller already sells it.
- **The goal** — defend share, raise price, or enter a new niche. The recommendation
  differs.
- For a margin-safe recommendation, the cost inputs listed in
  [margin-and-fees.md](margin-and-fees.md).

## Method

1. **Build the price distribution** of the competing set — the same or closely comparable
   products via JoomPulse. Use the **whole distribution**, not the average. An average is
   pulled around by outliers and hides where the market actually transacts.
2. **Find the sweet spot** — the price range where most units actually sell. This, not the
   cheapest price, is the target band.
3. **Locate the seller.** Where does their price sit against the band: inside it, above it,
   below it? Being above the sweet spot is not automatically wrong if the listing justifies
   it (reputation, fulfilment, content) — say what would have to be true.
4. **Read the direction of travel.** If prices in the set are trending down, the category is
   in a race to the bottom. Chasing the floor there destroys margin without winning
   durable share; the better answer is to compete on content, quality, fulfilment and
   reputation. Say this explicitly rather than recommending a cut.
5. **Protect the margin floor.** Before recommending any price, run it through
   [margin-and-fees.md](margin-and-fees.md). **Never recommend a price below break-even.**
   Where margin is thin, prefer a *cost* change over a *price* change — renegotiating with
   the supplier, armed with competitor and import price evidence, is usually the stronger
   move than discounting.

## Procedure

1. Retrieve the competing set's current prices, and their recent price history where the
   question involves a trend, via JoomPulse.
2. Compute the distribution and identify the range where sales concentrate.
3. Position the seller's price against it.
4. If margin matters at all — and for any recommendation to *change* price it does — apply
   the margin analysis and state the floor.
5. Recommend a band, not a single figure, and name the trade-off at each end of it.

## Output

Lead with the recommendation — the price or band, and why — before any table. Then:

- The distribution and where sales concentrate
- The seller's current position against it
- The direction prices are moving in the set
- The margin floor, if cost inputs were available, and the fact that it is an estimate
  unless the seller supplied real costs

State the estimate disclaimer once. Use full BRL precision (`R$ 89,90`), never rounded or
abbreviated. Show `—` where a figure is unavailable.

## Boundaries

- **No same-day or live price alerts.** JoomPulse provides periodic snapshots; a price
  comparison is accurate as of the snapshot, and change-over-time needs a previous
  snapshot the seller supplies.
- **Live price fetching from Mercado Livre is outside JoomPulse.** If the seller needs the
  price as of this minute, point them at the listing.
- Never recommend a price without saying what it does to margin — a price recommendation
  with no margin check is advice the seller cannot safely act on.
