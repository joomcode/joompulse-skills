---
name: top-sellers-in-category
description: >
  Ranks the top sellers in one Mercado Livre (Brasil) category by estimated average monthly
  revenue via JoomPulse, and returns a downloadable leaderboard — per seller: estimated
  monthly sales and revenue, 365-day completed sales, cancellation rate, month-over-month
  sales growth, medal, brands, product counts, international shipping, and listing-type
  counts.
  It can also track how the ranking moved: supply a previous-period leaderboard for the same
  category and it shows each seller's movement (rose / fell / new) plus the biggest movers.
  Triggers: "top sellers in this category", "biggest stores in a category", "rank sellers by
  revenue", and the pt-BR "principais vendedores da categoria", "maiores lojas da categoria",
  "quem mais vende nessa categoria". Sales and revenue are JoomPulse estimates, not real
  transactions. To monitor one seller over time use the seller-overview-tracker skill; to rank
  brands use the top-brand-position-tracker skill.
---

# Top Sellers In Category

This skill returns the **top sellers in one Mercado Livre (Brasil) category**,
ranked by estimated average monthly revenue. For each seller it shows estimated
average monthly sales and revenue, completed sales over the last 365 days,
cancellation rate, month-over-month sales growth, medal, brands, how their
products split between all listings and listings with sales, international
shipping, and classic versus premium listing counts.

By default it produces **today's leaderboard** as a downloadable table. It can
also show **how the ranking moved over time**: if you supply a previous-period
leaderboard that this skill produced for the same category, it compares the two
and reports each seller's movement (rose / fell / new) plus the biggest movers.
**The baseline is the table you supply — there is no hidden session memory.**

To monitor a single named seller over time, use the seller-overview-tracker skill.
To rank brands rather than sellers, use the top-brand-position-tracker skill.

## Prerequisites

- JoomPulse MCP access is configured for the current agent environment.
- The user names a category (free text is fine).
- For a period comparison, the user supplies a previous leaderboard that this
  skill produced for the same category (pasted or uploaded). Without it, the skill
  produces a standalone leaderboard.
- The available JoomPulse tools can find the sellers active in a category and
  return each seller's profile (estimated average monthly sales and revenue,
  last-365-day completed sales, cancellation rate, month-over-month sales growth,
  seller medal, brands, listing distribution, international shipping, classic and
  premium listing counts). Reputation is read when available.

If JoomPulse MCP access is unavailable, stop and explain that the skill requires
JoomPulse MCP setup before it can rank a category's sellers.

## Scope

- **Mercado Livre (Brasil) only.** Other marketplaces are out of scope.
- **Sales and revenue are JoomPulse estimates** derived from historical listing
  data — not real transactions. Cancellation rate and last-365-day completed sales
  are real history. Disclose the estimate caveat in every output. **Use the real
  figures to sanity-check the estimated ones**, never the other way round.
- **Read-only.** The skill never writes or modifies anything; it does not store the
  leaderboard — the user keeps the downloadable table and brings it back next period.
- **Language:** detect the seller's language and respond in it. Default to pt-BR.
- **The baseline is user-supplied.** Never claim a movement without a previous
  leaderboard to compare against, and never infer or fabricate one from memory.

## Workflow

### Step 1 — Resolve the category and find its sellers

Ask for a category if none was given, then use JoomPulse to match the free text to
a category and find the sellers active in it.

### Step 2 — Rank by estimated average monthly revenue

Rank the sellers by **estimated average monthly revenue**, highest first. Keep a
sensible top (default about 50, up to about 100 on request), and treat the count
as a cap — show fewer if fewer exist.

**Check every row against real sales before ranking it.** The revenue figure is an
estimate; completed sales over the last year are real. Two different problems hide
here, and they need different handling — do not treat them alike:

- **No real trading history.** A shop with a handful of listings and a seven-figure
  monthly estimate against a few hundred completed sales, or none at all, is an
  artifact of one listing with an odd counter rather than a business. **Move these
  out of the ranking** into a short labelled group ("estimativa não confiável")
  with the estimate, the real completed sales and the listing count side by side,
  and say the ranking excludes them. Flagging them in a note while still ranking
  them is not enough: it spends leaderboard positions on artifacts and pushes real
  sellers out.
- **A real business with an inflated estimate.** A seller with tens of thousands of
  completed sales is a genuine operation even where the estimate runs several times
  its real pace. **Keep it in the ranking** and say beside it that the estimate
  looks high against real volume, so its position may be too generous. Excluding a
  seller with real trading history because an estimate is imprecise removes a
  competitor the seller actually faces — a worse error than showing them too high.

The distinction is the **real** figure, not the ratio: near-zero completed sales
means exclude, substantial completed sales means keep and caveat. Say how many
shops you examined to fill the ranking.

**Name the shops that look like one company.** The ranking is of shops, not
companies, and a retailer may run several storefronts — a shared name with regional
suffixes is the usual tell. Where two or more rows share a name stem, group them in
a short note, give the combined estimated revenue, and say plainly whether that
combination would change the leader or the leader's share. **Do not assert common
ownership**: it is not verifiable here, and unrelated registration dates and
identifiers argue against a single operator as often as for one. Present it as an
alternative reading of the same rows, and leave the ranking itself by shop.

### Step 3 — Present today's leaderboard and offer it for download

Render the leaderboard for **today** (head it with the category name and the date).
This table is the deliverable — and **offer it as a downloadable file (`.csv` /
`.xlsx`)** so the user can save it and bring it back next period as the baseline.
On a standalone leaderboard there is **no movement column and no legend**.

### Step 4 — Offer comparison, and compare if a previous leaderboard is supplied

Invite the user to send a previous leaderboard for the same category to compare
periods. **If they provide one**, align by seller and report:

- a **Variação** column per seller: 🟢 subiu N / 🔴 caiu N / 🆕 novo / = igual, and
  note sellers that **left** the top in a short "saíram do top" line;
- a short **Destaques** block — biggest risers 🟢 and biggest fallers 🔴.

A movement **requires both an old and a new position/value** for the same seller —
no previous entry means "novo", never a fabricated trend. Show the 🟢/🔴 legend
**only** in the comparison (where the markers actually appear), never on a plain
leaderboard. The change column header is a word ("Variação"), never a bare "Δ".

## Output

Respond in the seller's language (default pt-BR).

**Leaderboard (always):** a markdown table, plus a downloadable `.csv` / `.xlsx`:

| Vendedor | Medalha | Vendas méd. (mês) | Receita média (mês) | Vendas 365d | Taxa de cancelamento | Crescimento mensal | Marcas | Produtos (todos) | Produtos (com venda) | Envio internacional | Clássico | Premium |
|---|:--|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|--:|

- **The Vendedor name is plain text.** Sellers have no JoomPulse page — the
  dashboard link template is for listing ids only — so a URL built from a shopId
  404s. Headers are pt-BR by default; translate them only when the seller writes
  in another language.
- **Full precision in the money columns** — `R$ 1.279.436,00`, never `R$ 1,28 mi`.
  This is a ranking: rounding collapses the rows into each other, and a tail of
  `R$ 0,7x mi` values cannot be ordered or audited by the reader. If the table is
  too wide, drop a column rather than shortening a number.
- **Crescimento mensal is the seller's month-over-month sales growth** — the figure
  the JoomPulse seller page shows. Name it that way rather than "trend", so it
  cannot be confused with an older run-rate measure that is empty for most sellers.
- **Medalha is a column, not only a chart colour.** The downloadable file is the
  baseline the seller brings back next period, so it has to carry every field the
  report and its panel use — a file that cannot reproduce the chart is not a
  baseline.
- **Say which figures are category-scoped and which are store-wide.** Sales,
  revenue, brands and product counts are for this category; completed sales,
  cancellation rate, growth, international shipping and the listing-type counts are
  the whole store. That is why the listing-type counts do not add up to the category
  product count, and it needs saying every time, not just when it looks odd.
- **If the table is too wide for the surface, drop columns from the right** —
  listing types first, then international shipping, then brands — and say which were
  dropped; the downloadable file always keeps all of them. Never move sellers into a
  numbered list, a paragraph, or a trailing "and below them, X, Y, Z" sentence, and
  never carry only the leaders in the table with the rest in prose. The user saves this
  table and pastes it back next period, and a list cannot be compared row against row.
  **If the sellers you ranked are not all rows of one markdown table, you have not
  produced the leaderboard.**

**Comparison (only when a previous leaderboard is supplied):** the same table plus
a **Variação** column, and a **Destaques** block (maiores altas / maiores quedas).

**Disclaimer (every report):**

> ⚠️ Vendas e receita são estimativas do JoomPulse com base no histórico de
> anúncios — não são transações reais. Taxa de cancelamento e vendas dos últimos
> 365 dias são dados reais do Mercado Livre.

## Visualization

**Render the visuals every time the data supports them.** As soon as the analysis
is done, present the cards and charts described below as a **self-contained visual
panel** — an artifact where the client renders artifacts, an inline widget where
it renders widgets. Do not ask permission first, do not describe the panel instead
of drawing it, and do not offer it as an optional extra: the cards and charts are
part of the answer, not a follow-up.

- **Order:** the cards first, then the charts, then the written read.
- **The data table always stays markdown in the response text**, never inside the
  panel — the panel carries cards and charts only.
- **The estimate disclaimer always stays in the response text** as well.
- **Skip an individual chart when its own data threshold is not met** (each
  threshold is stated below): a chart nobody can read is worse than no chart.
  Skipping one chart never means skipping the panel.
- **Only the cards and charts specified below.** Do not invent extra ones, and do
  not promote a categorical value to a bar — a chip or plain text is the honest
  rendering for it.
- **If no visual surface is available at all**, fall back to the markdown table
  plus the same figures written as text cards. Never block on visuals, and never
  leave the answer without its numbers.

The panel contains:

- **Four cards:** number of sellers in the category (and how many have sales), the
  leader's share of the shortlist's revenue, the average monthly revenue across
  the top, and the average ticket.
- **A horizontal bar** of the top ~10 sellers by estimated average monthly revenue,
  **colored by seller medal** — platina = purple, ouro = amber, prata = blue, sem
  medalha = white with a thin border (white needs the border to stay visible on a
  light background). Include a small legend mapping color to medal. When one seller
  dwarfs the rest, you may show that leader as a separate highlighted figure and
  chart the remaining leaders so the medal colors stay readable.
- **A small "registered versus with sales" comparison** for sellers — how many of
  the category's sellers actually sell. **Do not chart the same comparison for
  products, and never describe the product gap as stock sitting idle or failing to
  convert.** On a catalog product only the seller holding the buy-box shows sales,
  so every other seller of that product reads zero: a shop with thousands of
  listings and a third of them "with sales" is mostly showing buy-box position, not
  dead inventory. If the product split appears at all, label it buy-box coverage
  and say what it is not — the panel renders every time now, so an unlabelled
  version of this chart would mislead on every run rather than occasionally.

Presentation rules: use the medal palette consistently; render a chart only when
the data supports it; the movement/Variação column uses a word header, never a bare
"Δ", and its 🟢/🔴 legend appears only when a comparison is shown.

## Notes & Guardrails

The seller should never see a system or stack error — only a friendly next step.

- **No previous leaderboard supplied:** render today's leaderboard only (no
  movement column, no legend) and invite the user to save it for next time.
- **Supplied table is for a different category, malformed, or unreadable:** say so
  plainly and fall back to the leaderboard only; do not force a misaligned comparison.
- **Small sample:** if only a few sellers come back, say so rather than implying it
  is the whole category.
- **Missing values.** Show `—` for any figure that is unavailable. Never print `0`
  or `0,00%` for something unknown: a cancellation rate of `0,00%` on a seller with
  no completed sales reads as a perfect record when nothing was measured at all.
- **Growth on a small base.** A percentage computed on a handful of real sales is
  noise, not a trend. Show it, but say so beside it, and never lead the risers list
  with one.
- **Market data temporarily unavailable:** retry once after a short pause rather
  than immediately; if it still fails, say the service is busy and to try again in a
  few minutes. Never paste internal error text, HTTP codes, or field names to the
  seller. Name the downloadable file so the seller can find it, but never expose an
  internal working path — a temporary or scratch directory is not a save location.
- **An empty result is not a failure.** A category with no sellers to rank is an
  answer; say that and offer a broader category. Never report it as an outage.
- **Never silently limit coverage** — state the top cap you used.
