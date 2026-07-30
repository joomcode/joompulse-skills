# Profile a seller or brand

Build a picture of one named competitor — how strong they are, where they are going, and where
they are vulnerable.

## What to ask for

- **The subject** — a shop name, a seller identifier, or a brand. If the seller does not know
  who to profile, run [discover-competitors.md](discover-competitors.md) first.
- For tracking the same competitor over time, **their table from a previous run** — see below.

If the seller wants a *tracking* view of one store, the **seller-overview-tracker** skill in
this repo does exactly that; prefer it.

## What to read

Via JoomPulse, for the named seller:

Mark provenance per figure as you report it — this profile mixes the two kinds, and getting it
backwards in either direction misleads the seller:

- **Reputation and medal** — real. The trust and professionalisation signal
- **Location** — real. City and state
- **Sales over the last 60 to 365 days** — real completed-sales counters, not modelled
- **Sales trend** — real. Rising, flat or falling
- **Cancellation rate** — real
- **Average monthly revenue and sales** — **estimates**
- **Listing and catalogue counts** — as published

Do not blanket-label the whole profile as estimated. The completed-sales counter and the
cancellation rate are exactly the figures a seller should be able to trust, and calling them
estimates pushes them to discount the most solid evidence in the profile.

For a **brand** rather than a single shop: list the sellers carrying it, their share and their
growth, and flag which are **official stores** versus resellers. That distinction changes how
contestable the brand is.

## Interpretation

The figures matter less than the combination:

- Strong revenue with a **falling** trend is a competitor losing grip — an opening.
- Small revenue with a **fast-rising** trend is the one to watch; they found something.
- A **weak reputation among otherwise strong sellers** is an anomaly worth flagging — often a
  seller growing faster than their service can sustain.
- A high **cancellation rate** undercuts an otherwise strong profile.

Call out the anomaly rather than just tabulating the fields. A profile that lists nine metrics
without saying what they mean together has not answered the question.

## Tracking one seller over time

Build today's snapshot as a table the seller can keep. If they supply the same seller's table
from a previous run, compare field by field and mark each change as improved or worsened —
noting that **cancellation rate is inverted**, where a fall is an improvement.

The baseline is whatever table the seller supplies. There is no stored history here. **Never
claim something changed without a supplied baseline to compare against.**

## Off-marketplace view

If the subject is a **brand or retailer with its own website** — not a pure marketplace seller
— and the Semrush integration is connected, an off-marketplace picture can be added: which
search terms their site ranks for (indicating product and brand focus), their organic
competitors (adjacent brands), and the products and prices they promote through Google
Shopping.

Skip this entirely for pure marketplace sellers — they have no domain and the reports return
nothing. Always label these figures as **Google search data, not marketplace data**.

## Output

Lead with the verdict — how strong this competitor is and where they are vulnerable — then the
profile table: medal, reputation, revenue, sales, trend, location, cancellation rate. Flag
fast growth and any anomaly. For a brand, the top sellers with official-versus-reseller marked.

When tracking, add a change column with a legend, shown only when a comparison baseline exists.

State the estimate disclaimer once. Show `—` for unavailable values.

## Boundaries

- **Estimated** monthly revenue and sales are estimates, not the competitor's books. The
  completed-sales counter, sales trend, reputation, medal and cancellation rate are real
  marketplace history — report them as such rather than sweeping everything into one caveat.
- **No stored history.** Period-over-period comparison requires the seller to supply the earlier
  table.
- Off-marketplace data, where available, describes search behaviour and not marketplace sales —
  never merge the two into one figure.
