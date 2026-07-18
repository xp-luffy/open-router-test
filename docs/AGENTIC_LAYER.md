# Agentic Layer

## Risk Levels & Actions

### Low — auto-execute
- Score lead on insert (Postgres trigger)
- Tag lead status from form submit

### Medium — light approval
- Bulk-update lead status (UI confirmation dialog)

### High — always approval
- Initiate Stripe Checkout session (user explicitly clicks Pay)
- Send payment receipt email (v2)

### Critical — human only
- Issue refund
- Delete payment record
- Any bulk-delete of leads

## Named Tools (v1)
- `leads.create` — insert validated lead row
- `leads.update_status` — change status field only
- `payments.create_checkout_session` — server-side Stripe session
- `payments.activate` — webhook handler, marks payment active

## Audit Log Fields (added at lock-down sprint)
`id, actor_id, action, object_type, object_id, payload_json, created_at`

## v1 Scope
Only auto-scoring and the Stripe checkout flow. Approval queues and AI-initiated actions are v2.