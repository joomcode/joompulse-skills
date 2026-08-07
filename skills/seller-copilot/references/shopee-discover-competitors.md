# Discover Shopee competitors

Find who the seller actually competes with, and characterise **how** each one competes. A ranked
list of the biggest shops is a different, less useful answer.

## What to ask for

- **The category or niche**, and — if they have one — the seller's own shop or an item of theirs
  to anchor the comparison.

## Shopee's advantage here, and its one catch

The sellers-in-category view is a **full census**: every shop with tracked items in the category
appears, not a truncated leaderboard. So "how many sellers am I really up against" has a real
answer, subject to the tracking rule below.

**The catch: a shop appears once per category it sells in, at every ancestor level.** Reading
without pinning a single category therefore counts the same shop repeatedly and inflates
everything. **Always pin exactly one category** and say which level it was.

## The ranking problem — say which axis you used

**There is no revenue-within-a-category figure for Shopee shops.** This is the single most
important limitation of this analysis, because "top sellers by revenue in this category" is what
sellers usually ask for.

What exists instead, per shop within the category:

- **How many of its items sell there** — the closest proxy for presence
- **Review count within the category** — the closest proxy for accumulated volume
- **Average price and average order value within the category**
- **Rating within the category**
- **How many brands it carries there**

So rank by item presence or by review count, **state which axis you chose and why**, and do not
call the result a revenue ranking. If the seller specifically wants revenue, say the figure does
not exist at category level and offer the item-level route: sum the estimated revenue of that
shop's items in the category, labelled as an estimate built from item rows.

## Category-scoped versus store-wide — do not mix them

Each shop row carries **two families of figures**: its stats *within this category*, and its
*whole-store* totals repeated on every row.

**Never rank an in-category list by a store-wide figure.** A large generalist shop with a
marginal presence in the niche will top the list on store-wide numbers while being irrelevant to
the seller. When a store-wide figure is genuinely useful — to show that a rival is a giant elsewhere
— label it explicitly as store-wide.

## Four kinds of competitor

Segment them, because the advice differs:

- **Direct** — comparable items, comparable price band. The immediate fight.
- **Potential** — same category, different price band. They become direct if either side moves.
- **Adjacent** — serving the same need from a neighbouring category.
- **Rising** — small but growing quickly. **These matter most**: they catch demand shifts before
  the established shops, and they are invisible in any list ranked by size.

## What to read per competitor

Badge tier (official / preferred / regular), location — including whether they are cross-border —
rating and review count, price band, item count in the category, and how many of their items are
growing versus falling.

## Procedure

1. Resolve the category; **pin one level** and say which.
2. Pull the seller census for that category.
3. Rank on a stated axis; never a store-wide field.
4. Segment into the four kinds above.
5. For the handful that matter, pull the full shop profile separately — see
   [shopee-competitor-profile.md](shopee-competitor-profile.md). The two views cannot be joined in one query,
   so this is a second read, and the shop-level numbers are whole-store unless stated.

## Output

**Verdict first:** who the seller is actually competing with, and which one to watch.

Then the competitor table — shop, badge tier, location, items in category, rating, review count,
price band, and the competitor type — with the ranking axis named in the caption. Follow with a
short note on the rising shops.

State the estimate disclaimer once. Use full BRL precision. Show `—` for unavailable values.
Link shops by their username where present; there is no JoomPulse dashboard link for Shopee rows.

## Boundaries

- **No revenue-per-category figure exists.** Always say which axis the ranking used.
- **No buy-box or catalogue** — "who else sells this exact product" is not answerable. Compare
  comparable items and say so.
- **No seller medals or reputation ladder** — badge tier is official, preferred or regular, and
  nothing finer. Inventing a medal, a reputation score or a tier ladder is fabrication.
- **No cancellation rate** for Shopee shops.
- **The census covers tracked items only** — shops whose items have never sold do not appear, so
  the count is a lower bound.
- A shop's ranking is an estimate built on rounded counters — do not overstate small differences
  between adjacent rows.
