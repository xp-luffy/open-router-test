# Agentic Layer

## Risk Levels & Actions

### Low — auto-execute (no approval)
- Tag a lead's source from URL param on capture
- Compute and update lead score on status change
- Mark `converted_at` timestamp when status set to `converted`

### Medium — light approval (founder confirms)
- Draft a follow-up email for a lead (shown as draft, not sent)
- Suggest a status change based on days since last update

### High — approval required before execution
- Send any external message or email on behalf of the founder
- Create a Stripe refund

### Critical — human only, never automated
- Delete all leads
- Issue refunds > $100
- Any legal or compliance action

## Named Tools (approved list)
- `db.insert_lead` — writes one lead row
- `db.update_lead_status` — updates status + sets converted_at if applicable
- `stripe.create_checkout_session` — initiates payment
- `stripe.verify_webhook` — validates incoming Stripe event

## Audit Log Fields
`action`, `table_name`, `record_id`, `old_value jsonb`, `new_value jsonb`, `actor_id`, `created_at`

## v1 vs Later
- v1: low-risk auto-actions only (scoring, timestamps)
- Next: draft email suggestion (medium)
- Later: full agentic follow-up queue
