# Intelligence Layer

## v1 — Rule-Based Only
No AI in v1. The core app runs entirely on deterministic logic.

## Messy Inputs (what founders type)
- Free-text source: "saw you on LinkedIn", "friend told me", "cold email"
- Inconsistent status words: "maybe", "hot", "waiting"

## Auto-Structure Schema (v1 normalisation)
```json
{
  "source_raw": "saw you on LinkedIn",
  "source_normalised": "LinkedIn",
  "status_raw": "hot",
  "status_normalised": "qualified"
}
```
Normalisation is a lookup map in application code — no AI call needed.

## Events to Track
- `lead_created` — source, initial status
- `status_changed` — from / to / time elapsed
- `lead_won` — time-to-close, source

## Scoring Rules (rule-based)
| Signal | Points |
|---|---|
| Status = qualified | +20 |
| Status = negotiating | +40 |
| Has email | +10 |
| Source = Referral | +15 |

Score stored as `score_value` on the lead when AI layer is added.

## v1 vs Later
- **v1**: manual status, rule-based score display
- **Next**: AI suggests next action based on days-since-last-activity
- **Later**: enrichment API auto-fills company size, LinkedIn profile
