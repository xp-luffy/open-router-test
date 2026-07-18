# Intelligence Layer

## Messy Input
Founder pastes a name, company name, and email — no structure guaranteed.

## Auto-Structure (on insert)
```json
{
  "name": "Sarah Chen",
  "company": "Acme Corp",
  "email": "sarah@acmecorp.com",
  "status": "new",
  "score": 62,
  "score_source": "rules_v1",
  "score_confidence": 0.75,
  "score_review_status": "unreviewed"
}
```

## Scoring Rules (v1, rule-based)
| Signal | Points |
|---|---|
| Company name present | +20 |
| Business email domain (not gmail/yahoo) | +25 |
| Status = qualified | +30 |
| Status = contacted | +15 |
| Notes present | +5 |

Max = 80 rule points; confidence set to `0.75` for rule-based.

## Events to Track
- Lead created
- Lead status changed
- Score updated
- Payment completed

## v1 vs Later
**v1:** Postgres trigger computes score on insert/update using rules above
**Later:** OpenAI call re-scores with company context; sets `score_source = 'gpt-4o'`, `score_confidence` from logprobs, `score_review_status = 'pending'`