# Trends and seasonality

Two different questions that get confused: **what is growing right now** (momentum) and **when
does this category peak** (calendar). Establish which one the seller is asking before answering.

## What to ask for

- **Scope** — one category, a set of them, or marketplace-wide.
- **Which lens** — momentum, or seasonality. If the seller asks "when should I stock", they want
  seasonality even if they said "trends".

For a quick ranking of the fastest-growing sub-categories, the
**growing-leaf-category-tracker** skill in this repo does that directly.

## Momentum

1. Compare revenue month over month across subcategories and rank by growth rate.
2. **Filter out tiny-absolute-revenue noise before ranking.** A small base produces enormous
   percentages; an unfiltered growth ranking is mostly rounding error. This single step is what
   separates a useful ranking from a misleading one.
3. Use **review velocity** as a product-level momentum proxy where category data is too coarse.
4. **Explain why each one is moving** — a seasonal driver, an event, a news cycle. A growth rate
   with no explanation cannot be acted on, because the seller cannot tell whether it will last.

## Seasonality

1. **Always read a 24-month window.** A three-month view can show false stability, and is the
   most common way to misread a seasonal category as a declining one.
2. Identify the **peak month** and the **most lucrative holiday** for the category.
3. Mark the commercial and official holidays and how demand actually reacts around each — the
   reaction is often earlier than the date.
4. **Reframe slow months as planning opportunities** — time to source, prepare listings and build
   stock — rather than as risk to avoid.
5. **Distinguish a sustained decline from a seasonal dip** before recommending any reaction. This
   is the judgement that matters most; reacting to a trough as though it were a decline is how
   sellers exit good categories.

## Forward-looking signals from outside the marketplace

Marketplace data is backward-looking by nature. Where the question is "what is about to happen",
external signals can be layered in:

- **Annual seasonality** — the recurring calendar shape of the category
- **Scheduled events** — holidays, Carnaval, sporting fixtures, film, music and series releases
- **Hype trends** — sudden socially-driven demand
- Where the **Semrush integration is connected** — rising search niches for Brazil

These see demand **before** the marketplace does, which is exactly why they must be
**cross-checked against real marketplace opportunity before being recommended**, and **labelled
with their source per signal**. A rising external signal on an already-crowded shelf is not an
opportunity; a rising external signal with room on the shelf is.

### A date or event you supply from your own knowledge is an external claim

This is the easiest rule here to break without noticing, because it does not feel like
presenting a signal — it feels like adding helpful context. Product launch dates, event
dates and news events are **not JoomPulse data**. Whenever one is stated it must carry a
marker, **including inside a table cell or an annotation column**, which is exactly where
it slips through unmarked.

- Unmarked: `nov/24 | R$ 49.890.486,38 | Black Friday + console X lançou 07/nov`
- Marked: `nov/24 | R$ 49.890.486,38 | Black Friday; lançamento console X 07/nov *(externo)*`

Mark it once per table with a footnote — "datas marcadas *(externo)* não são dados do
JoomPulse" — rather than repeating it on every row. If you are not confident a date is
right, say so or leave it out: an unmarked wrong date reads as marketplace data, which is
worse than no annotation at all. The revenue beside it stays a JoomPulse estimate either way.

## Procedure

1. For momentum: the longer-term category trend plus month-over-month movement, with the
   noise filter applied before ranking.
2. For seasonality: up to 24 months of history per category, with peaks, troughs and holidays
   marked.
3. For product-level momentum: review velocity.
4. Optionally seed from the external signals above, then confirm each against marketplace
   opportunity.

## Output

**Verdict first** — what is moving and whether it will last, or when to stock and by when to
order.

Then the trend or seasonal shape, the peak month and the key holiday, and a **concrete timing
recommendation** that works backwards from the peak or event date by the seller's sourcing and
shipping lead time. "Order by mid-September for the November peak" is the useful form; "demand
rises in November" is not.

Label the source of every signal — marketplace data or external — and mark any date or event
you supplied yourself as external, annotation columns included. State the estimate disclaimer
once. Show `—` for unavailable values.

## Boundaries

- **Short history is not a trend.** With only a few months of data, say the trend is unavailable.
- **No real-time or same-day signals.** These are periodic snapshots.
- Growth percentages on small bases are unreliable even after filtering — show the absolute
  figure beside the percentage so the seller can judge.
- External signals describe interest, not marketplace sales. Never merge them into one number
  with marketplace data.
