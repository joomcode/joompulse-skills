# Assortment and price gaps on Shopee

What competitors sell that the seller doesn't, and how the two price ranges line up. Two
questions that are usually asked together and should be answered together.

## What to ask for

- **The seller's own range** — their shop, or a list of what they sell. Without it there is no
  gap analysis; ask rather than guessing.
- **The competitor set** — from [shopee-discover-competitors.md](shopee-discover-competitors.md) if not already
  established, or a shop the seller names.
- **The category** to bound the comparison.

## Method — the gap side

1. Pull the competitor's items in the bounded category.
2. Pull the seller's own items in the same category.
3. **Sort the gaps by estimated revenue, not by count.** A gap only matters if the missing item
   actually earns. Twenty missing products that sell nothing are not a finding.
4. For each candidate gap, sanity-check demand the way
   [shopee-validate-product.md](shopee-validate-product.md) does before recommending it. A gap is not
   automatically an opportunity.

**Three items a competitor earns well from, which the seller could plausibly source, is a better
answer than forty items they cannot.**

## Method — the price side

Use the **whole distribution**, not the average. An average is dragged around by outliers and
hides where the market actually transacts.

- Where do the seller's prices sit against the competitor's range — below, inside, above?
- Where in the range do **units** actually move? That is the meaningful band, and it is often not
  the cheapest end.
- **Read the price history** before advising. An item whose price has drifted steadily downwards
  is in a race to the bottom, and the advice changes from "match the price" to "compete on
  something other than price".

Price history is available as intervals — a price and the span it held — and is **item-level
only**, so never claim a particular variant, size or colour moved.

## Interpreting the two together

- **A gap at a price band the seller already serves** — the easiest win; they know the buyer.
- **A gap at a band they don't serve** — a real decision, not a quick add. Say what entering that
  band would require.
- **No gaps, but a price disadvantage** — the answer is pricing, not assortment. Hand off to
  [shopee-pricing.md](shopee-pricing.md) rather than inventing assortment advice.
- **Gaps everywhere and no price disadvantage** — usually means the competitor is simply larger.
  Say so; "add forty products" is not advice.

## Procedure

1. Bound the category and **pin one level**.
2. Read the competitor's items and the seller's, in that same bounded scope.
3. Difference the two ranges; sort candidates by estimated revenue.
4. Build the price distribution for both sides and locate where units move.
5. Check the price history of the contested items.
6. Validate the top gap candidates before recommending them.

## Output

**Verdict first:** the single gap worth acting on, and whether the seller's pricing is helping or
hurting.

Then two views — the gap table (item, estimated sales and revenue, price, why it matters) and the
price comparison showing both ranges and where units concentrate. Cap the gap table at ten rows
by default, state the total, and **never pad it to reach a round number**.

State the estimate disclaimer once. Use full BRL precision. Show `—` for unavailable values.

## Boundaries

- **Without the seller's own range there is no gap analysis.** Ask for it; do not assume a
  catalogue.
- **Sales and revenue are estimates** from rounded counters; prices are real. Do not rank gaps on
  small estimated differences.
- **Tracked items only** — a competitor may carry products that have never sold and are therefore
  invisible here, so the assortment view is a lower bound, not their full catalogue.
- **No per-variant view.** A competitor's size or colour range is not visible; do not infer it.
- **No catalogue or buy-box**, so "the same product" is a judgement about comparable items rather
  than a platform fact. Say which items you treated as comparable.
- **A gap is not automatically an opportunity** — the seller may be unable to source it, or may
  have dropped it deliberately. Ask before assuming it is an oversight.
