# Market structure

Read how a market is built: how big it is, how concentrated, which way it is moving, and who is
gaining. This answers "can I compete here", which is a different question from "is there demand
here".

## What to ask for

- **The category or niche**, at whatever depth the seller has in mind.
- Optionally a **time window**, if the question is about share shifting rather than the current
  picture.

For a quick ranking of the fastest-growing sub-categories, the
**growing-leaf-category-tracker** skill in this repo answers that directly.

## Method

**1. Size and structure.** Via JoomPulse: total revenue and order volume, how many sellers have
sales, and how concentrated the shelf is:

- **Concentration tier** — low or medium means the market is not dominated.
- **Top-seller share** — the proportion of orders the single largest seller holds. Above roughly
  half means one seller owns the shelf, and entering means taking share from them directly.
- **Brand concentration** — whether one brand owns the category regardless of who sells it.

**2. Movement.** The trend over time — growing, stable or declining — and where share is
shifting. A market can be large and shrinking, or small and accelerating; the two call for
opposite decisions.

**3. Emerging players.** Flag **fast-growth sellers** (rising quickly from a small base) and
**new entrants**. These are the earliest signal of where a category is heading, and they are
usually invisible in a revenue-ranked list.

## Interpretation

The combinations matter more than any single figure:

- **Large, low concentration, growing** — the best case; room to enter.
- **Large, high concentration** — entering means competing with the incumbent head-on. Possible
  only with a stated edge.
- **Small but accelerating, with new entrants arriving** — often more attractive than a large
  static market, especially for a seller who can move quickly.
- **Large and declining** — the trap. The size looks reassuring; the direction is what matters.

## Procedure

1. Retrieve category-level revenue, orders, concentration, saturation, the longer-term trend and
   seller counts.
2. Rank sellers by growth and trend to identify fast-growth sellers and recent entrants.
3. Where the question is about share shifting, compare the current picture against the earlier
   window and say who gained.

## Screening many categories at once

Some questions are not about one market but a **ranked list across many** — "the 10 most
competitive categories to avoid", "where is it hardest to enter now". These have three
failure modes that a single-category answer never hits.

**1. Every row must come from returned data.** Ask the category data for the whole
candidate set in one pass, filtered on the criteria, and rank what comes back. Never
hand-pick candidates from your own knowledge of the marketplace, and never **top a list up
to a round number**: if the seller asked for 10 and the data supports 6, return 6 and say
that only 6 met the filters. A list padded to reach 10 is presented as measurement while
part of it is recall — the same defect as an unlabelled date, and harder to spot because it
sits in a table.

**2. Show the composite.** Any "most competitive" or "worst to enter" ranking combines
several signals — concentration, seller count, growth, entry barrier. Name the components,
say how they order the list (which dominates, how ties break), and show each component's
value per row. A ranking whose scoring is invisible cannot be checked or argued with, and
"trust me, these are the worst 10" is not an analysis.

**3. Chase the components that need a second query.** Some criteria do not exist as
category-level fields — an accumulated-reviews barrier to entry, for example. Do not settle
for a proxy you happen to already have, and do not merely *offer* to fetch the real figure:

- Fetch the nearest real measure at whatever level it does exist — e.g. the review counts of
  the leading listings in each shortlisted category — and use that.
- If you genuinely cannot, **exclude that component from the score** and say the ranking
  omits it. Do not quietly fold a weak proxy into the composite and still describe the
  score as covering the requested criterion.

A category-level badge or medal mix is a legitimate *hint* about entrenched incumbents, but
it is not a review-count barrier. Say which one you actually measured.

## Off-marketplace demand signal

JoomPulse measures the **supply and sales** side of a category. If the Semrush integration is
connected, the **demand** side can be added: the search-volume trend for the category's main
terms in Brazil.

The combination is what is informative — **rising supply with rising search** is a genuinely
heating market; **flat search behind rising supply** suggests over-supply and sharpening price
competition. Label such figures as **Google search demand, not marketplace data**.

## Output

**Verdict first:** is this a market the seller can compete in, and why.

Then: size, concentration and top-seller share; the trend; and a short "who is gaining" list of
fast-growth sellers and new entrants. Colour or band the concentration so the shape is readable
at a glance.

State the estimate disclaimer once. Use full BRL precision. Show `—` for unavailable values.

## Boundaries

- Revenue and order figures are estimates.
- **Short history is not a trend.** If only a few months of history come back, treat the trend as
  unavailable rather than reading direction into a short window.
- Concentration describes the shelf, not the difficulty of any individual product — a
  distributed category can still contain a locked-up niche.
- **A ranked list is only as long as the data supports.** Returning fewer rows than asked
  for, with the reason, is correct; padding to the requested count is not.
- **No accumulated-reviews barrier exists as a category field.** Measure it at the listing
  level or leave it out of the score and say so.
