# Vetting a supplier catalogue

Turn a supplier's catalogue into a **buy-list backed by evidence** rather than by the
supplier's pitch. The supplier knows what they want to sell; this establishes what the market
will actually absorb, and at what margin.

## What to ask for

- **The products** — name, SKU or EAN for each catalogue item to check. If the seller has a
  PDF or spreadsheet catalogue, ask them to give the items as text; automated extraction from
  a catalogue file is not available here (see Boundaries).
- **The supplier's unit price** for each item — this is the seller's cost, and JoomPulse does
  not know it.
- Keep **one supplier per list** so catalogues can be compared against each other.

## Method

For each catalogue product, build the market panel from JoomPulse:

1. **Comparable listings** — the best-selling similar products on the marketplace.
2. **Typical selling price** across that set.
3. **Average monthly revenue per listing** and **average sales volume per listing** — these
   answer "if I list this, what does a normal result look like?"
4. **The competing sellers** — how many, how strong, how entrenched.

Then compute the real margin per item using
[margin-and-fees.md](margin-and-fees.md): market price minus supplier cost, marketplace
fees, freight, any import duties, and operational costs.

## The four checks

Buy an item only if it passes **all four**:

1. **Healthy positive margin** after every fee
2. **Proven sales volume** among comparable listings — not one or two isolated sales
3. **Market price comfortably above the supplier's price**
4. **Beatable competition** — on price, content, quality or reputation

Discard anything that fails even one check. The value of vetting a catalogue is that most of
it does not survive; a buy-list that keeps 40 of 50 items has not been vetted.

## Procedure

1. For each product, retrieve comparable listings, the typical price, average revenue and
   volume per listing, competing sellers and saturation.
2. Apply the margin analysis with the supplier's cost.
3. Mark each of the four checks pass or fail, per item.
4. Rank the survivors by expected contribution, not by margin percentage alone — a strong
   percentage on an item nobody buys is not a good buy.

## Output

A buy-list table: per product — typical market price, average revenue and volume per listing,
competition, and an explicit pass/fail on each of the four checks. Lead with the verdict: how
many of the catalogue's items are worth buying, and which one is the strongest.

Offer a spreadsheet export so the seller can add their own costs and share it. Recommend
re-running when supplier prices or market conditions change.

State the estimate disclaimer once. Show `—` for anything unavailable.

## Boundaries

- **Automated catalogue extraction is not available.** There is no reading of PDF or scanned
  catalogues here — the seller supplies the items as text. Never invent SKUs or prices to
  fill gaps.
- **Supplier discovery is not available.** This vets a catalogue the seller already has; it
  does not find suppliers, verify their legitimacy, or quote their prices.
- **Never invent a supplier cost.** Without it, an item can only be screened on demand and
  competition — say so, and mark the margin check as not assessed.
- Import landed cost is a separate question — see
  [import-vs-domestic.md](import-vs-domestic.md).
