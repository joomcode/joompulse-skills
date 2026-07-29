# Keyword intelligence

Which search terms matter in a category, and how contested each one is. The most important thing
to get right here is what the numbers mean — see the hard limit below.

For the marketplace's own ranked list of trending search terms, the
**top-keywords-in-my-category** skill in this repo answers that directly. Use this file when the
question is about **which terms are worth targeting** rather than simply what is trending.

## What to ask for

- **The category**, or a set of seed keywords. If given free text, resolve it to a specific
  category first, and **disambiguate with the seller when several plausible matches come back**.

## Method

1. Retrieve the **trending terms** for the category.
2. For each: its **position** and its **supply depth** — how many listings compete for it.
3. **Find the under-served terms:** rising interest with **low supply depth**. That combination is
   the opportunity; a rising term everyone already targets is not.
4. Feed strong terms onward — to [find-new-products.md](find-new-products.md) for product
   candidates, or [listing-optimization.md](listing-optimization.md) for listing copy.

## The hard limit — state this every time

**Supply depth is not search volume.** It counts how many sellers target a term, not how many
shoppers search it. These are different quantities and the difference reverses the meaning:

- High supply depth = **many competitors**, not high demand
- Low supply depth = **little competition**, which is only an opportunity *if* interest exists

Never present supply depth as demand. Describe it as "how many sellers target this term".
Marketplace keyword data here carries **no search volume**.

## Adding real search volume

Where the **Semrush integration is connected**, it fills exactly that gap: real Brazilian search
volume and its trend, plus adjacent terms and the questions buyers ask.

The useful combination is **high search volume with low supply depth** — genuine demand that few
sellers are chasing. Label Semrush figures as **Google search demand, not marketplace sales**, and
validate any term against marketplace data before recommending it: people search for many things
they do not buy on this marketplace.

If the integration is not connected, degrade gracefully to supply depth only, and say that volume
is unavailable rather than implying the depth figure covers it.

## Output

**Verdict first:** the terms worth targeting, and why.

Then the keyword table — term, position, supply depth, and an "under-served" or "crowded" tag —
with search volume as an additional column only where it is genuinely available and labelled as
Google data.

Carry the supply-depth caveat wherever the figure appears. Show `—` for unavailable values.

## Boundaries

- **No search volume in marketplace keyword data.** This is the single most likely
  misinterpretation; guard against it explicitly.
- Search interest is not purchase intent, and Google interest is not marketplace demand.
- Keyword position is a snapshot; treat movement as requiring a supplied earlier baseline.
