# Margin and fees

Work out what a Mercado Livre (Brasil) sale actually leaves the seller after every
deduction, and show it line by line.

JoomPulse holds marketplace data, **not** the seller's costs and not a fee calculator. So a
margin figure here is **reconstructed** from published Mercado Livre fee schedules plus
figures the seller supplies. Always label it as an estimate, and always say what would make
it exact.

## What to ask for

- **Selling price** — from the listing, or the price being considered.
- **Unit cost** — what the seller pays per unit. JoomPulse does not know this. Ask.
- **Freight** — shipping to the buyer, and who absorbs it.
- **Category** — Mercado Livre commission and fixed fees vary by category.
- Optional: packaging, returns allowance, advertising, and import duties where relevant.

If the seller cannot give a unit cost, do not invent one. Either continue as a
**price-only** analysis (fees and net-of-fees revenue, clearly labelled as excluding cost),
or ask them to supply it before quoting a margin.

## Cost components

Subtract each from the selling price:

1. Mercado Livre commission for the category, plus any fixed per-item fee
2. Freight / logistics contribution
3. Unit cost (supplier or import cost)
4. Import duties and taxes, where they apply
5. Operational costs — packaging, expected returns, paid advertising

```
net per unit = price − commission − fixed fees − freight − cost − taxes − operational
margin %     = net per unit ÷ price
```

## Procedure

1. Establish the price. If the seller named a listing, read its current price via
   JoomPulse; otherwise use the price they are considering.
2. Apply the category's published commission and fixed fees.
3. Subtract freight, unit cost, taxes and operational costs from the figures supplied.
4. Present **gross and net side by side**, one line per deduction, and the margin
   percentage.
5. **Label every input** as either *supplied by the seller* or *estimated from published
   fee schedules*. The seller must be able to see which numbers are theirs.
6. Run a short sensitivity check — margin at two or three plausible prices, freight
   arrangements, or unit costs — so the seller sees how fragile or robust the margin is.

## Comparing a cost change

When the question is whether to switch supplier, renegotiate, or change sourcing:

| New margin vs current | Recommendation |
|---|---|
| Clearly higher | Proceed — better margin and more room to compete on price |
| About the same | Proceed only if it adds something else (shorter lead time, reliability, flexibility); otherwise keep the existing relationship |
| Lower | Do not proceed |

For a new product launch, the bar is a **clearly healthy net margin after every fee** — not
merely a positive one. A margin that survives only at full price and zero returns is not a
healthy margin; say so.

## If the seller has an ERP integration

If the seller has an ERP connected that exposes **real** unit cost and **real** per-order
marketplace fees, use those figures in place of the estimates and relabel the output
accordingly — it stops being an estimate and becomes their actual margin. For kits or
bundles, roll up the component costs rather than treating the kit as one item.

Without such an integration, this analysis remains an estimate. Say so plainly rather than
implying precision the numbers do not have.

## Boundaries

- **Never present an estimated margin as the seller's true margin.**
- **Never invent a unit cost, freight figure, or tax rate.** Ask, or mark the analysis as
  price-only.
- Do not report internal-only data fields that may appear in results; report the
  seller-facing metrics only.
- Live price fetching and Mercado Livre's own fee calculator are outside JoomPulse. If the
  seller needs a figure guaranteed current to the minute, tell them to check the listing
  or the calculator directly.
- Import prices from sourcing platforms are not available here — treat landed cost as
  seller-supplied.

## Output

A transparent line-by-line breakdown: price at the top, each deduction on its own line,
net and margin percentage at the bottom, with every figure marked as supplied or estimated.
Lead with the verdict — is this margin healthy, thin, or negative — before the table. State
the estimate disclaimer once. Show `—` for anything unknown.
