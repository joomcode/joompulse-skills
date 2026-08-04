# Evaluate a category

Is this category worth entering? Judged on demand, competition and room to earn — not on size
alone. This is the opportunity engine the product-discovery analyses reuse.

For a one-shot snapshot of a single named category, the **category-opportunity-index** skill in
this repo answers that directly and more cheaply. Use this file when the question is comparative,
or when the answer feeds a product decision.

## What to ask for

- **The category or niche**, at whatever depth the seller has in mind, or a list to compare.
- If the seller names nothing, ask which category. **If free text matches several plausible
  categories, list the candidates with their level and let the seller pick — never guess between
  unrelated categories.**
- Optionally: whether they want the revenue-per-seller comparison (specialise versus go broad).

## The screening rubric

A category worth entering usually shows:

- **High opportunity level** — the composite signal of an under-exploited category: low
  concentration, low saturation, and room left in revenue.
- **Average revenue per seller of roughly R$ 10.000 – 50.000 per month** — real money without
  overcrowding. Much lower and there is nothing to earn; much higher and it usually means a few
  large sellers hold it.
- **Few sellers holding badges or medals — around 0–20%** — the category is still developing.
- **Total category revenue of about R$ 5 million or more** — a substantial market.
- **Low or medium concentration** — the largest seller does not dominate. Where the top seller
  holds more than half of orders, treat the shelf as dominated.
- **No single brand owning the shelf** — otherwise the opportunity belongs to the brand, not to
  new sellers.

Use it as a rubric, not a checklist: a category can miss one criterion and still be worth
entering if the seller has a specific edge. Say which criterion it misses and what the edge would
have to be.

## Confirm from more than one angle

- **Sellers** — is the field open or dominated?
- **Brands** — is it concentrated behind one name?
- **Products and category trend** — growing or stable is good; falling is a warning regardless of
  how well the category screens today.
- **Seasonality over a 24-month window** — a three-month view can show false stability. Identify
  the peak month and the strongest holiday, and treat slow months as time to prepare rather than
  as risk. See [trends-and-seasonality.md](trends-and-seasonality.md).
- **Fast-growth sellers** — flag those rising quickly from a small base; they spot shifts before
  the leaders and are worth watching after entry.

## Decision rule

Enter when the category clears the rubric **and** the trend is growing or stable. Reject
saturated shelves, dominated shelves, and single-brand shelves — those three reject a category
regardless of how large it is.

## Procedure

1. Retrieve category revenue, orders, concentration, saturation, opportunity level, seller count
   and badge share.
2. Rank or compare candidates **by the rubric, not by revenue alone**.
3. Optionally compute average revenue per seller — total revenue divided by sellers — for the
   specialise-versus-broad question.
4. Check the longer-term trend.
5. If the category came from an external signal — a season, an event, a search trend — confirm it
   has real room here, and label the originating source.
6. **If fewer than about six months of history come back, treat the trend as unavailable** rather
   than reading a false signal from a short window.

## Output

**Verdict first, in plain language** — enter, enter with a condition, or avoid — then the
opportunity view: category against revenue, orders, concentration, saturation, opportunity level
and badge share, banded so the shape reads at a glance. When comparing several categories, rank
them and say which one you would pick and why.

Never fabricate a missing value — show `—`. State the estimate disclaimer once. Use full BRL
precision.

## Boundaries

- Revenue and order figures are estimates.
- **Short history is not a trend.**
- Screening well is not the same as being winnable: a well-screening category can still contain a
  locked-up niche, and a well-screening category the seller knows nothing about is riskier than a
  slightly worse one they understand. Say so where it applies.
