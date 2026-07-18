# Agentic Layer

## Risk Levels and Actions

### Low — auto-execute
- Recalculate lead score on save
- Tag lead source from URL param on inbound signup
- Generate AI summary draft (stored as `unreviewed`)

### Medium — user approves before executing
- Promote AI next-action draft to activity log
- Change lead status based on AI recommendation
- Send internal Slack/email notification on status change

### High — explicit approval required
- Trigger Stripe checkout session (user must click)
- Cancel subscription

### Critical — human only, never automated
- Issue refund
- Delete all leads (bulk)
- Export PII data

## Named Tools (approved list)
- `leads.create` / `leads.update` / `leads.delete`
- `activities.log`
- `score.recompute`
- `stripe.create_checkout_session`
- `stripe.cancel_subscription`
- `openrouter.generate_summary` (server-side only)
- `audit.write`

## Audit Log Fields
`action`, `object_type`, `object_id`, `user_id`, `delta` (before/after), `risk_level`, `created_at`

## v1 Scope
Only low-risk auto actions and the Stripe checkout (high, user-initiated). Medium and critical actions are Sprint 5+.
