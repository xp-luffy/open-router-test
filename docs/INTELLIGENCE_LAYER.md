# Intelligence Layer

## Messy Input
Free-text notes field on a lead: "Met at YC event, building fintech, $2M ARR, ready to buy Q1"

## Auto-Structure (scored on save)
```json
{
  "score": 8,
  "reason": "High ARR signal, clear timeline, warm intro",
  "source": "openrouter/gpt-4o-mini",
  "confidence": 0.82,
  "review_status": "unreviewed"
}
```
Stored in `leads.score`, `score_source`, `score_confidence`, `score_review_status`.

## Events to Track
- Lead created
- Lead notes updated (re-score triggered)
- Score reviewed / overridden by founder

## Scoring Rules (v1 — rule-based fallback)
- Mentions budget/ARR → +3
- Has email → +1
- Status = 'qualified' → +2
- No notes → score = 3 (default)

## Ranking
Dashboard sorts by `score DESC`, then `created_at DESC`.

## v1 vs Later
**v1**: score on create/update, display reason, allow manual override
**Later**: batch re-score, lead clustering, suggested next action
