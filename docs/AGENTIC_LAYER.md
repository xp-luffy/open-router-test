# Agentic Layer

## Risk Levels & Actions

### Low — auto-execute
- Score a lead from notes (OpenRouter call → write to `leads.score`)
- Tag lead status based on activity count

### Medium — show draft, founder confirms
- Suggest follow-up note text for a lead
- Flag stale leads (no activity > 14 days)

### High — approval required
- Create Stripe Checkout session (charges the user)
- Send any email on founder's behalf (v2)

### Critical — human only
- Issue refund
- Delete account data
- Any bulk delete

## Named Tools (v1)
- `score_lead(lead_id)` — reads lead, calls OpenRouter, writes score fields
- `create_checkout_session(user_id)` — calls Stripe API, returns URL
- `confirm_subscription(stripe_session_id)` — webhook handler, writes subscription row

## Audit Log Fields
`tool_name | input_snapshot | output_snapshot | actor_id | risk_level | approved_by | created_at`

## v1 vs Later
**v1**: score_lead (auto), create_checkout_session (high/approval)
**Later**: follow-up drafter, stale-lead notifier, bulk re-score
