# Intelligence Layer

## v1: NONE
No AI in v1. The pipeline is pure CRUD + stage transitions + Stripe checkout. This is intentional — the core must work with AI switched off.

## Later: Lead scoring

### Messy inputs
- Free-text notes pasted from email threads
- Company names with inconsistent casing / suffixes (Inc, LLC, Ltd)
- Contact info incomplete (email missing, name only)

### Auto-structure schema (JSON)
```json
{
  "lead_id": "uuid",
  "score": 78,
  "score_source": "rule_engine_v1",
  "score_confidence": 0.85,
  "score_factors": {
    "email_engagement": 30,
    "company_fit": 25,
    "deal_value_weight": 15,
    "stage_velocity": 8
  },
  "suggested_next_action": "Send follow-up email — no contact in 7 days",
  "review_status": "unreviewed"
}
```

### Events to track
- `lead.created`, `lead.stage_changed`, `activity.logged`, `lead.idle_7d`

### Scoring rules (rule-based start)
- Responded within 3 days → +30
- Company matches ICP keyword → +25
- Deal value > $10k → +15
- Stage advanced in < 7 days → +8
- No activity 14+ days → -20
- Score range: 0–100, bands: cold (<30), warm (30–70), hot (>70)

### What gets ranked
Leads sorted by score descending in a "Hot leads" view.

## v1 vs later
- **v1**: manual stage management, no scoring
- **Later**: auto-score on `lead.created` + `activity.logged`, ranked hot-leads view, follow-up drafts