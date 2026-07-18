# Intelligence Layer

## Messy Inputs
- Founder pastes a name + company + email and maybe a note
- Status changes and activity counts are implicit signals

## Auto-Structure (v1 rule-based scoring)
```json
{
  "lead_id": "uuid",
  "score": 72,
  "score_source": "rule_v1",
  "score_confidence": 0.65,
  "score_review_status": "unreviewed",
  "breakdown": {
    "status_weight": 40,
    "activity_count_bonus": 20,
    "email_present": 12
  }
}
```

## Scoring Rules (v1)
| Signal | Points |
|---|---|
| status = qualified | +40 |
| status = contacted | +20 |
| each activity logged | +5 (max 20) |
| email present | +12 |
| notes > 50 chars | +8 |

## Events to Track
- Lead created
- Status changed
- Activity logged
- Score recalculated

## v1 vs Later
**v1:** Rule-based formula, recalculates on every lead save.
**Later:** OpenRouter LLM re-scores from notes + activity history; confidence rises when LLM and rule scores agree.