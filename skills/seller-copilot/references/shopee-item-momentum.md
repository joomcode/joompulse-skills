# Item momentum on Shopee

How one item has been selling over time. Shopee carries a **week-by-week series per item**,
which is genuinely richer than what the other marketplace offers — but only if its limits are
stated, because the series looks more precise than it is.

**This file covers momentum, not seasonality.** See the boundary at the end.

## What to ask for

- **The item**, by Shopee link or item identifier.
- **The window** — default to everything available, which is not long.

## The one thing to get right: the weekly figure is smoothed, not measured

Shopee publishes only a **rolling roughly-monthly sold counter**. The weekly series is that
counter rescaled to a week, with single-week gaps filled from neighbouring weeks.

Consequences, all of which must reach the answer whenever weekly numbers are shown:

- It is a **smoothed estimate, not a true weekly count**. A run of identical weekly values is an
  artefact of the rescaling, not a remarkably steady product.
- **A single week means very little.** Read the shape across several weeks; do not build a story
  on one bar.
- **Small week-to-week differences are noise.** Do not describe a 3% move as a change.
- The underlying counter is **rounded into buckets**, so the precision implied by an exact number
  is false. Round in the answer rather than quoting spurious digits.

Describe it as "estimated weekly sales, smoothed from Shopee's rolling counter" the first time
it appears. Never present it as observed weekly transactions.

## What else forms the picture

**Price history.** Available as intervals — a price and the span it held — rather than a daily
value. Expand it against the weekly series to see whether a sales change followed a price
change. **It is item-level only:** per-variant price history is not available, so never claim a
particular size or colour moved in price.

**Review history.** Recorded as **change points**, not as one row per day: a row appears when
the count or rating moved. Two consequences: the series is sparse and gaps mean "no change", not
"no data"; and **counts must never be added together across rows** — each row already carries the
running total, so summing them multiplies the truth.

Review accumulation is the closest thing to an independent demand check, since it does not come
from the same rounded counter as the sales estimate. Where the two disagree, say so.

**The item's own direction flag** — current rate against its lifetime average — is a quick read
that agrees or disagrees with the series. When it disagrees, trust the series and say why.

## Procedure

1. Resolve the item; confirm it is still being observed.
2. Pull the weekly series across the available window and read its **shape**, not its points.
3. Overlay the price intervals and check whether moves line up with price changes.
4. Pull the review change points as an independent cross-check.
5. State the window explicitly, including that it begins in May 2026 at the earliest.

## Output

**Verdict first:** is this item rising, flat or fading, and how confident you are given the
smoothing.

Then the series — weeks against estimated units and revenue, with price shown alongside so the
reader can see cause and effect — plus a short note on what the review history says.

Mark the estimate disclaimer once, and label the weekly figure as smoothed the first time it
appears. Any date or event you supply yourself — a shopping festival, a holiday — is an
**external claim** and must carry a marker saying so, including inside a table cell.

Show `—` for weeks with no observation. Do not interpolate visually and do not join across a gap
as though it were measured.

## Boundaries

- **This cannot tell you whether a product is seasonal.** Shopee history begins in May 2026 —
  well under a year — and there are no seasonal fields at all. A rise across the available window
  is momentum, not a season. If the seller asks when to stock, say the history is too short to
  establish a seasonal pattern, and offer the momentum read instead. **Do not infer a season from
  a few months, and do not import a seasonal shape from another marketplace.**
- **No year-on-year comparison** is possible for the same reason.
- **Weekly values are smoothed and interpolated**, not measured.
- **No per-variant history** — price and sales are item-level only.
- **Review rows are change points**; never sum them.
- Price is real; sales and revenue are estimates.
