# Find products to sell on Shopee

A shortlist of concrete candidates, each checked before it is recommended. **Not a list of
bestsellers** — bestsellers are the most contested shelves, and handing a new seller the top of
the category is handing them the hardest fight.

## What to ask for

- **The category or niche**, and any constraint that narrows it: budget, price band, whether
  they want to import.
- If nothing is named, ask for a category. Do not pick one.

## Where the item view helps

Category analytics stop at three levels, but the **item view reaches deeper** — items carry
their own category path several levels down. So a niche that is invisible in
[shopee-category-evaluation.md](shopee-category-evaluation.md) can still be worked here. Say which you used.

## What to read per candidate

- **Estimated units and revenue over the last 30 days**, and the item's estimated lifetime
  monthly average. The gap between the two is the momentum read.
- **A direction flag** comparing the current rate against the item's own lifetime average —
  growing, stable or falling. Unlike some marketplaces, this is a legitimate item-level signal
  here; use it.
- **Price** — real, not estimated.
- **Rating and review count** — real. Reviews are also the closest thing to a demand history.
- **Favourites** — a soft interest signal with no direct equivalent elsewhere.
- **Shop tier** — official, preferred or regular — and whether the item ships cross-border.
- **Content signals** — photo count, whether the item has video.
- **When the item was created**, and **when it was last seen**. An item not seen recently may
  simply be gone; do not present a stale row as a live opportunity.

## The four checks

Every candidate must pass all four. A shortlist that passes three of four is not a shortlist;
it is a list of things that will disappoint.

1. **Real demand** — estimated sales at a level worth the effort, not a handful of units.
2. **Beatable competition** — the shelf is not held by official shops with thousands of reviews
   the seller cannot match for a year.
3. **A reachable price band** — where units actually move, not the cheapest or the most
   expensive corner.
4. **Room to differentiate** — weak ratings, thin content, or no brand, so a better offer has
   somewhere to land.

Say which check each rejected candidate failed. **An empty shortlist is a real answer** — say
the category has nothing worth entering rather than lowering the bar to fill rows.

## Coverage — state this once

The item data is **not a census of Shopee**. Only items with at least one lifetime sale are
tracked. So "how many items exist in this niche" is a lower bound, and an absent item is not
evidence the product is unsold — it may simply be untracked.

Sold counters are **rounded by Shopee into buckets** before JoomPulse sees them. Treat small
differences between candidates as noise, and do not rank on a gap of a few units.

## What cannot seed a shortlist here

- **No keyword or search-demand data exists for Shopee.** If the seller asks for the most
  searched terms, say the data does not exist for this marketplace rather than substituting a
  competition count, which measures something else entirely.
- **No seasonal signal.** "What should I stock for the season" cannot be answered from Shopee
  history yet.
- Any date or event you supply from your own knowledge — a shopping festival, a holiday — is an
  **external claim** and must be marked as such, including inside a table cell.

## Procedure

1. Resolve the category; confirm the level and say which you used.
2. Pull candidate items, ranked by estimated recent sales or revenue.
3. Apply the four checks; drop anything that fails one.
4. For survivors worth a closer look, read the week-by-week history — see
   [shopee-item-momentum.md](shopee-item-momentum.md) — to tell a rising item from one already fading.
5. Check the last-seen date before presenting anything.

## Output

**Verdict first:** the candidates worth pursuing, and the single one you would start with.

Then the shortlist table — item, price, estimated recent sales and revenue, direction, rating
and review count, shop tier — with a one-phrase reason per row saying what made it stand out.

State the estimate disclaimer once. Use full BRL precision. Show `—` for missing values. Link
items in Shopee's own item-link form; there is no JoomPulse dashboard link for Shopee rows.

## Boundaries

- **Sales and revenue are estimates** from rounded counters; price and reviews are real.
- **A stock budget does not translate into units.** A budget constrains the seller's **unit
  cost**, which the marketplace does not show — only selling prices. Use selling price as an
  upper-bound proxy, say so, and ask for unit cost before implying what the budget buys.
- **No supplier, landed cost or fee data** — so a candidate is a demand-and-competition verdict,
  never a profitability one. Say that plainly.
- Kits and bundles are harder to read than single items — say so rather than treating a kit like
  a simple product.
