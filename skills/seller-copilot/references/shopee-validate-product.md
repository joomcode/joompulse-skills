# Validate one Shopee product

A go/no-go on a single item the seller is considering. The job is to **fail fast and cheaply** —
most candidates should not survive.

## What to ask for

- **The item**, by Shopee link, item identifier, or a clear product description.
- **Their unit cost**, if they want anything said about profitability. JoomPulse does not hold it.
- A bare 10–11 digit identifier is a Shopee item; one beginning `MLB` belongs to the other
  marketplace and should be routed there instead.

## The two axes

Judge demand against competition, and read the quadrant:

- **High demand, low competition** — the case worth pursuing. Rare; check it twice.
- **High demand, high competition** — the case sellers most often misread as good. Viable only
  with a **named** edge: a lower landed cost, a differentiated version, an underserved variant.
  "I'll try harder" is not an edge.
- **Low demand, low competition** — usually empty rather than open. Ask why nobody is there.
- **Low demand, high competition** — avoid.

## What to read

**Demand.** Estimated units and revenue over the recent window, and the item's estimated
lifetime monthly average. Then the week-by-week series — see
[shopee-item-momentum.md](shopee-item-momentum.md) — because a healthy 30-day figure on a fading item is a
trap the snapshot alone will not show.

**Competition.** How many sellers offer comparable items in the same category niche, what they
charge, their ratings and review counts, and the mix of official, preferred and regular shops
among them. A shelf held by official shops with thousands of accumulated reviews is a slow fight
regardless of demand.

**Room to differentiate.** Rating weakness, thin photography, absent video, no brand, or a price
band with an obvious gap.

## The tie-breakers

Where the two axes leave it borderline, these can turn a "possible" into an "avoid":

- **Review accumulation of the leaders.** Reviews compound; a leader with a very large count has
  an advantage a new listing cannot close quickly. There is no shortcut to it on Shopee.
- **Badge tier of the incumbents.** Official (Mall) shops carry visibility a regular seller does
  not start with. Note it as a structural disadvantage, not a verdict.
- **Cross-border presence.** If the shelf is largely served from outside Brazil, the seller is
  competing on a different cost base and a different delivery promise.

## Procedure

1. Resolve the item and confirm it is still live — check when it was last observed. A product
   that has not been seen recently may be gone.
2. Read demand: recent estimates, lifetime average, and the direction flag.
3. Pull the week-by-week series before concluding anything about direction.
4. Read the competitive shelf in the same category niche.
5. If unit cost was supplied, say what it implies **only as far as the data allows** — see the
   boundary below.

## Output

**Verdict first** — go, go with a condition, or avoid — with a confidence level and the single
reason that decided it.

Then the evidence: demand figures with their direction, the competitive picture, and the
differentiation opening if one exists. Close with what would change the verdict.

State the estimate disclaimer once. Use full BRL precision. Show `—` for missing values.

## Boundaries

- **Sales and revenue are estimates** from Shopee's rounded public counters. A difference of a
  few units between two items is noise, not a ranking.
- **This is a demand-and-competition verdict, not a profitability one.** JoomPulse holds no
  Shopee fee, commission, supplier or landed-cost data. Even with the seller's unit cost you can
  compare cost against *selling price* — you cannot compute a real margin, because the platform's
  own deductions are unknown. Say that rather than presenting a margin.
- **Do not turn a caution into a go because the seller wants one.**
- **No buy-box or catalogue on Shopee**, so "how many sellers offer this exact product" is not a
  question the data answers — every row is a separate item. Compare comparable items instead,
  and say that is what you did.
- **The item set is not a census** — only items with at least one lifetime sale are tracked, so
  the competitive count is a lower bound.
