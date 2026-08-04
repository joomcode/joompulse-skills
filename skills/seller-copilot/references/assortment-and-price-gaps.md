# Assortment and price gaps

Two related questions: **what do competitors sell that the seller does not**, and **what are
they charging**. The first finds revenue the seller is leaving on the table; the second explains
why they may be losing the sales they do compete for.

## What to ask for

- **The competitor or competitor set** — from
  [discover-competitors.md](discover-competitors.md) if not already known.
- **The seller's own catalogue**, for the gap comparison. Without it there is no gap to
  compute — only a list of what competitors sell.
- The **product or category scope** for the price side.

## Assortment gaps

1. List the competitors' listings and **sort by revenue** — a gap only matters if the missing
   product actually earns.
2. **Subtract the seller's own catalogue** to leave the products competitors sell, and earn
   from, that the seller does not carry.
3. Rank the gaps by the revenue they represent, not by how many competitors carry them.

A long gap list is not the goal. Three products a competitor earns well from, which the seller
could plausibly source, is a better answer than forty items they cannot.

## Price intelligence

1. Read the **price distribution** across the set — the whole distribution, not the average.
   The average hides where the market actually transacts.
2. Read each product's **price history** to see repricing behaviour: how often they move price,
   in which direction, and whether the pattern is seasonal.
3. Note whether the set is drifting **downward** — a race to the bottom changes the advice from
   "match the price" to "compete on something other than price".

## Procedure

1. **Assortment, public route:** retrieve the set's listings ranked by revenue, then subtract
   the seller's own products to produce the gap list. The richer competitor matrix requires a
   connected store and the seller's identifier — use it only when available.
2. **Price:** retrieve current prices and price history for the matched products, then build the
   distribution and the trend.

## Off-marketplace view

If a competitor runs **its own e-commerce site** and the Semrush integration is connected, the
products and price points it promotes through Google Shopping can reveal assortment or price
moves not visible on its marketplace shelf. Marketplace-only competitors have no domain — skip
it for them, and always label such figures as **Google Shopping data, not marketplace data**.

## Output

**Verdict first:** the single most valuable gap, or the clearest price problem.

Then two views:

- **The gap table** — high-revenue products the seller is missing, ranked by the revenue they
  represent, with the competitor carrying each.
- **Price positioning** — the distribution, where sales concentrate, where the seller sits, and
  the direction prices are moving.

Feed the price findings into [pricing.md](pricing.md), and the gap findings into
[find-new-products.md](find-new-products.md) if the seller wants candidates validated before
sourcing.

State the estimate disclaimer once. Use full BRL precision. Show `—` for unavailable values.

## Boundaries

- **Without the seller's catalogue there is no gap analysis** — say so rather than presenting a
  competitor's assortment as a gap list.
- The connected-store competitor matrix needs an identifier; a public comparison is narrower and
  should be labelled as such.
- **No same-day price alerts.** Price history is periodic; a repricing pattern is an observation,
  not a live feed.
- A gap is not automatically an opportunity: the seller may be unable to source it, or may have
  dropped it deliberately. Present gaps as candidates, not instructions.
