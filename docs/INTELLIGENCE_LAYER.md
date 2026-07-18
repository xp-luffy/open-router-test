# Intelligence Layer

## Messy Input
Founders paste unstructured notes: "Met Sarah at conf, she runs a 10-person team, budget unclear, follow up next week"

## Auto-Structure Schema (v1 rule-based scoring)
```json
{
  "lead_id": "uuid",
  "score_breakdown": {
    "source_weight": 25,
    "status_weight": 40,
    "recency_bonus": 15
  },
  "total_score": 80,
  "computed_at": "2024-01-15T10:00:00Z"
}
```

## Scoring Rules (v1 — rule-based, no AI)
| Factor | Logic | Max Points |
|---|---|---|
| Source | referral=25, inbound=20, conference=15, cold=5 | 25 |
| Status | closed-won=40, negotiating=35, qualified=25, contacted=15, new=5 | 40 |
| Recency | created within 7d=15, 30d=10, 90d=5, older=0 | 15 |
| Notes length | >100 chars=10, >20=5 | 10 |
| Activity count | ≥3=10, ≥1=5 | 10 |

## Events to Track
- Lead created, edited, deleted
- Status changed
- Activity logged
- Score recalculated
- Subscription upgraded

## AI Layer (Sprint 5)
- **Input:** lead notes + activity descriptions
- **Output:** `ai_summary` (2-sentence digest) + `ai_next_action` (one suggested step)
- **Stored:** value + source (model name) + confidence + review_status
- **v1:** scoring is entirely rule-based — AI is additive and can be disabled
