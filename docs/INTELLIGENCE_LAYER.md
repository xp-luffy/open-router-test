# Intelligence Layer

## Messy Input → Structured Data
Founders paste or type lead info loosely. The form enforces structure at entry: name, email, source (dropdown), status (enum). No free-form parsing needed in v1.

## Events to Track (v1)
- `lead.created` — source, timestamp
- `lead.status_changed` — from, to, lead_id
- `payment.completed` — amount, stripe_session_id

## Scoring Rules (rule-based first, no AI)
| Signal | Points |
|---|---|
| Source = Referral | +20 |
| Source = Inbound | +15 |
| Status = qualified | +10 |
| Notes length > 50 chars | +5 |

Score stored as `score numeric` on `leads` with `score_source = 'rule_engine_v1'`, `score_confidence = 1.0`, `score_review_status = 'unreviewed'`.

## What Gets Ranked
- Lead list default sort: score DESC, then created_at DESC

## v1 vs Later
| v1 | Later |
|---|---|
| Rule-based score | LLM-suggested follow-up action |
| Manual status | Auto-status from email reply detection |
| Static source dropdown | AI extraction from pasted text |
