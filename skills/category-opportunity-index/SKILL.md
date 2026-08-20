---
name: category-opportunity-index
description: >
  Reports the JoomPulse opportunity level (low, medium, high) for one category on
  Mercado Livre (Brasil) or Shopee Brasil, with that month's snapshot — estimated
  revenue and sales, sellers, listings, average ticket — plus concentration and
  month-over-month growth, and a plain-language verdict on entering it. Use for a
  one-shot snapshot of a category the seller names. Triggers: "is this category
  worth entering", "opportunity index for this category", "how big is this
  market", "category opportunity on Shopee"; pt-BR "qual o índice de
  oportunidade", "vale a pena entrar nessa categoria", "tamanho de mercado da
  categoria", "índice de oportunidade na Shopee", "vale a pena vender nessa
  categoria da Shopee". Ask which marketplace when unclear; never mix the two.
  Sales and revenue are JoomPulse estimates, not real transactions. To rank the
  sellers in a category use the top-sellers skill; for trending search terms the
  top-keywords skill; to compare against a user-supplied previous snapshot the
  category-monitor skill.
---

# Category Opportunity Index

This skill answers a single question for **one** category on **Mercado Livre
(Brasil) or Shopee Brasil**: is it worth entering? Given a marketplace and a
category named in free text, it reads that category's **opportunity index** (low,
medium, or high) and its current monthly market indicators — estimated revenue,
estimated sales, sellers, listings, and average ticket — then writes a short
pt-BR summary that interprets the opportunity level together with how
concentrated the market is and which way it is growing. On Mercado Livre the
summary can also draw on a year of history and a seasonality read; on Shopee
neither exists yet, and the report says so plainly instead of guessing.

This is a point-in-time snapshot, not a tracker. To rank the sellers inside a
category, use the top-sellers-in-category skill. For the trending search terms
shoppers use in a category, use the top-keywords-in-my-category skill. To compare
a category's aggregates against a user-supplied previous snapshot, use the
category-monitor skill. This skill answers "how attractive is this category right
now?" for a category the user names.

## Prerequisites

- JoomPulse MCP access is configured for the current agent environment.
- The user provides a marketplace — Mercado Livre (Brasil) or Shopee Brasil — and
  names the category to evaluate (free text is fine).
- The available JoomPulse tools can resolve a category name to a category on
  **either** marketplace and return that category's current monthly market
  indicators, plus — on Mercado Livre — its recent monthly history.

If JoomPulse MCP access is unavailable, stop and explain that the skill requires
JoomPulse MCP setup before it can report a category's opportunity index.

## Scope

- **Mercado Livre (Brasil) and Shopee Brasil**, one at a time. Other marketplaces
  are out of scope.
- **Sales and revenue are JoomPulse estimates** — not real transactions. The
  seller, listing, and average-ticket figures shown here are estimates too.
  Disclose this in every output. The estimates are built differently on each
  marketplace: on Mercado Livre from historical listing data, on Shopee from the
  marketplace's own rounded sold counters refined with review movement. Use the
  matching disclaimer.
- **Read-only.** The skill never writes or modifies anything.
- **Language:** detect the seller's language and respond in it. Default to
  pt-BR.
- **Keep the workflow invisible.** The seller wants the answer, not a play-by-
  play. If one approach does not return data, switch to another quietly; only if
  every approach fails do you say one short, friendly sentence. Never fill gaps
  from general knowledge, and never fabricate a number — show `—` when a value
  is missing.

**Shopee data — what differs from Mercado Livre**

- **Estimates come from Shopee's own rounded sold counters**, refined with review
  movement. Treat small gaps between items as noise and never rank on a difference
  of a few units. Price, rating and review count are real.
- **Coverage is not a census**: only items with at least one lifetime sale are
  tracked, so any count is a lower bound and an absent item is not evidence it does
  not sell.
- **History starts May 2026** — there is no long-run trend and no seasonal read.
- **Category analytics stop at three levels**; the item view reaches deeper. Say
  which you used.
- **No seller medals** — Shopee has three mutually exclusive shop tiers: **Official
  store**, **Preferred (Indicado)** and **Common**. There is no ladder; inventing
  Shopee medals is fabrication.
- **No catalogue and no buy-box**, and an item belongs to one shop.
- **No fulfilment programme, no free-shipping flag and no listing tier** — show `—`
  rather than guessing.
- **Concentration is measured differently** and thresholds do not transfer between
  marketplaces.
- Item titles mix Portuguese, English and Chinese — search both languages.

## Workflow

### Step 0 — Decide the marketplace

JoomPulse covers **two separate marketplaces**: Mercado Livre (Brasil) and Shopee
Brasil. They are independent datasets with different coverage, history and
mechanics. Decide which one the request belongs to **before reading any data**:

- **The seller said so.** "Shopee" means Shopee; "Mercado Livre", "MeLi" or "ML"
  means Mercado Livre.
- **An identifier gives it away.** An identifier beginning `MLB` is Mercado Livre;
  a bare 10–11 digit number is a Shopee item or shop. A `mercadolivre.com.br` link
  is Mercado Livre, a `shopee.com.br` link is Shopee. If an identifier is not found
  on the marketplace you assumed, check the other one before telling the seller it
  does not exist.
- **The request only makes sense on one of them** — buy-box, catalogue position,
  seller medals, a fulfilment programme or search keywords are Mercado Livre only.
- **Otherwise ask** — one short question, mentioning that both are available.
  **Never guess and never default.**

**Never mix data from the two marketplaces in one query, one table or one total.**
They are separate pipelines with different grains and estimate methods; a combined
figure is simply wrong. If the seller wants both, run the analysis twice and report
the two side by side, comparing direction and orders of magnitude — never exact
numbers.

### Step 1 — Resolve the category

1. If the user did not name a category, ask which one to evaluate
   (for example *"Para qual categoria você quer o Índice de Oportunidade?"*).
2. Use JoomPulse to match the free text to a category **on the marketplace chosen
   in Step 0**, retrieving candidate categories with their name, depth level, and
   opportunity index for the current month.
3. Pick the best match. If several plausible categories come back, list the top
   candidates (name and level) and ask the user to choose — do not silently
   guess between unrelated categories. If nothing matches, check the other
   marketplace before saying the category was not found, then ask for a broader
   or rephrased term.
4. On **Shopee**, category analytics stop at **three levels**. If the seller names
   a deeper niche, evaluate the closest available level instead, say which level
   you used, and do not promise a deeper drill-down.

### Step 2 — Get the current monthly indicators

First **settle which month you are reading.** On Mercado Livre the latest month is
flagged reliably. On Shopee that flag is not trustworthy, so resolve the most
recent month that actually has data and use that one — then name the month in the
report so the seller knows exactly which period the figures describe.

For the chosen category, use JoomPulse to obtain that month's market indicators:

- Opportunity index (low / medium / high).
- Estimated monthly revenue and estimated monthly sales.
- Number of sellers and number of listings. On **Shopee** these count only the
  sellers and the items that **had sales in that month** — label them that way and
  never present them as the category's whole population.
- Average ticket.
- Context for the summary: the concentration measure, the month-over-month revenue
  growth direction, and — **on Mercado Livre only** — any seasonality signal.

**Concentration is not the same measurement on the two marketplaces.** On Mercado
Livre it is the leading seller's share of orders, expressed 0–100%. On Shopee it is
an index computed across all the sellers in the category: give it its own label,
never describe it as one seller holding a share of the shelf, never apply the
Mercado Livre thresholds to it, and never compare or combine the two marketplaces'
values.

All indicators are monthly values. Use the always-positive monthly totals for
market size, never a month-over-month delta — never label a change figure as a
total or as "revenue".

### Step 3 — Get ~12 months of history for the trend line (Mercado Livre only)

On **Mercado Livre**, use JoomPulse to retrieve the category's recent monthly
history (estimated revenue and estimated sales per month) for roughly the last 12
months. Order the months oldest to newest. If fewer than about six months of
history come back (a new or sparse category), treat history as unavailable and
skip the trend line — show the cards only.

On **Shopee**, skip this step entirely. History only begins in May 2026, so about
three months exist and the six-month rule above would fire on every single run.
Do not draw a trend and do not pass three points off as one: state plainly that a
long-run trend is not available for Shopee yet, and report the snapshot plus the
month-over-month change instead.

### Step 4 — Build the report (pt-BR)

1. Lead with the **opportunity index**, prominently: 🟢 alto / 🟡 médio / 🔴
   baixo (show `—` if it is missing), noting the marketplace, the category name
   and level, and the month the figures describe.
2. Show the monthly indicators table (see Output).
3. Write a 2–4 sentence **resumo** that interprets the opportunity index
   together with concentration and growth:
   - What the level means — high implies good room for new sellers; low implies
     little relative upside.
   - **Concentration** — on Mercado Livre, high concentration (roughly above
     half) means the market is dominated by a few sellers and is harder to break
     into; low means demand is spread out and more accessible. On Shopee, report
     the index under its own label and read it in relative terms only — no
     share-of-the-shelf phrasing, no borrowed thresholds, no cross-marketplace
     comparison.
   - **Growth** — rising means the category is expanding; falling means it is
     contracting.
   - **Seasonality** — on Mercado Livre, optionally note it if relevant. On
     Shopee there is no seasonality data at all: say the read is unavailable
     there, and never state that a category is not seasonal.
   - End on a practical takeaway: worth entering / enter with caution / not very
     attractive right now.
4. On **Shopee**, name the category level you actually used, and do not promise a
   deeper drill-down than the three levels available.
5. Add the mandatory disclaimer for the marketplace you queried, and — on Mercado
   Livre — optionally the JoomPulse category dashboard link.

## Output

Respond in the seller's language, default pt-BR, with no commentary about how the
report was produced. The indicators table always renders as markdown so it shows
cleanly in any client.

**Opportunity badge** — a heading line naming the marketplace, the category and
the month the figures cover, for example:

> **Índice de Oportunidade: ALTO** 🟢 (Mercado Livre · categoria: <nome>, nível
> L<level> · mês de referência: …)

**Monthly indicators table:**

| Indicador | Valor (mensal) |
|---|---|
| GMV Estimado (Mensal) | R$ … |
| Vendas Estimadas (Mensal) | … |
| Vendedores Ativos | … |
| Anúncios Ativos | … |
| Ticket Médio | R$ … |

On **Shopee**, keep the same five rows but rename the two count rows so they say
what they actually cover — for example *Vendedores com vendas no mês* and
*Anúncios com vendas no mês*. Wherever concentration appears, give it its own
Shopee label as an index across all sellers, never "Monopolização" and never a
top-seller share.

Format money as `R$` with pt-BR conventions (comma decimal, dot thousands, for
example `R$ 1,2 mi`, `8.400`, `R$ 49,90`) and round large values sensibly. Empty
cells show `—`.

**Resumo** — the 2–4 sentence interpretation described in the workflow.

**Disclaimer (every report) — use the variant for the marketplace you queried.**

Mercado Livre:

> ⚠️ GMV, vendas, vendedores e anúncios são estimativas do JoomPulse com base no
> histórico de anúncios — não são transações reais. / GMV, sales, sellers, and
> listings are JoomPulse estimates based on historical listing data — not actual
> transactions.

Shopee:

> ⚠️ Receita, vendas, vendedores e anúncios são estimativas do JoomPulse a partir
> dos contadores arredondados da própria Shopee — não são transações reais, e
> diferenças pequenas são ruído. Só itens com pelo menos uma venda no histórico
> são rastreados, então as contagens são um piso. / Revenue, sales, sellers, and
> listings are JoomPulse estimates built from Shopee's own rounded sold counters —
> not actual transactions, and small gaps are noise. Only items with at least one
> lifetime sale are tracked, so the counts are a lower bound.

Optionally add the JoomPulse category dashboard link — **Mercado Livre only**.
There is no JoomPulse category dashboard link for Shopee, so never invent one.

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

- **Opportunity badge** at the top: Alta 🟢 / Média 🟡 / Baixa 🔴 (show `—` if
  missing), with the marketplace and the reference month.
- **Five metric cards:** estimated monthly revenue, estimated monthly sales,
  sellers, listings, and average ticket — pt-BR formatted, money with `R$`. These
  match the five rows of the monthly indicators table; on Shopee the two count
  cards carry the "com vendas no mês" wording.
- **12-month trend line** of estimated monthly revenue (one point per month, x =
  mês, y = receita; optionally a second series for estimated sales) — **Mercado
  Livre only**. Render this chart only when the data supports it — skip it
  entirely when there are fewer than about six months of history, leaving just the
  cards. Optionally add a small growth-% chip from the month-over-month change. On
  **Shopee** there is no long-run trend to draw at all: show the growth chip on its
  own and say a 12-month trend is not available yet.
- **Concentration:** on **Mercado Livre**, a 0–100% horizontal bar for the leading
  seller's share of orders; note that a **low** value is the favorable end (demand
  spread across many sellers). On **Shopee**, show the index as its own labelled
  value — not on the Mercado Livre 0–100% scale, not with the Mercado Livre
  thresholds, and never side by side with a Mercado Livre figure.
- **Seasonality chip** — **Mercado Livre only**: a pill, no bar — "Não sazonal"
  when the category is not seasonal, or "Sazonal · pico {mês}" naming the peak
  month. On **Shopee** omit the chip; if seasonality comes up, say the read is
  unavailable there, and never print "Não sazonal" — the data cannot support that
  claim.

Presentation rules: use the medal palette consistently if medals appear anywhere
(platina = purple, ouro = amber, prata = blue, sem medalha = white with a thin
border). Any change or difference column uses a word as its header ("Variação",
or "Era | Agora"), never a bare "Δ" symbol. Show a 🟢/🔴/🆕 legend only on a run
where those symbols actually appear — never on a first or baseline run. Render a
chart only when the underlying data supports it, and skip it otherwise.

## Notes & Guardrails

The seller should never see a system or stack error — only a friendly next step.

- **Ambiguous category:** list the candidate categories and ask the user to
  choose. Do not guess between unrelated categories. If nothing matches, check the
  other marketplace before saying the category does not exist.
- **No current data / empty result:** say you could not find current data for
  that category and suggest a broader or different term. Never fabricate numbers.
  On Shopee, add that only items with at least one lifetime sale are tracked, so an
  empty result is not proof the category is quiet.
- **Opportunity index missing:** show `—` for the badge and base the summary on
  concentration and growth instead.
- **Sparse history:** when fewer than about six months of history exist, omit the
  trend line and report the snapshot only. On Shopee there is no long-run history
  yet at all — say so rather than presenting a few months as a trend.
- **Reference month on Shopee:** never trust a latest-month flag there. Resolve
  the most recent month that has data and name that month in the report.
- **Category depth on Shopee:** analytics stop at three levels. Say which level
  you used and do not promise a deeper drill-down.
- **Concentration across marketplaces:** the two figures are different
  measurements. Never compare them, average them, or carry one marketplace's
  wording or thresholds onto the other.
- **Seasonality on Shopee:** the read simply does not exist. Say it is
  unavailable; never assert that a category is or is not seasonal.
- **Market data temporarily unavailable:** retry once quietly; if it is still
  down, say market data is temporarily unavailable and to try again. Never paste
  internal error text, HTTP codes, or field names to the seller.
- **Missing values:** show `—` for any empty indicator rather than guessing.
