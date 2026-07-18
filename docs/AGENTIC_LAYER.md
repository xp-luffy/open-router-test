# Agentic Layer

## Risk Levels & Actions

### Low — Auto (no approval needed)
- Tag lead source from free-text input
- Normalise status string on save
- Append activity row on every status change

### Medium — Light Approval (founder confirms)
- Draft a follow-up email for a lead (shown as draft, not sent)
- Suggest status upgrade based on inactivity rule

### High — Always Approval
- Send an email to a lead (requires explicit send button)
- Initiate a Stripe refund request

### Critical — Human Only
- Delete all leads (bulk)
- Issue refund / cancel subscription
- Any legal communication

## Named Tools (v1 + planned)
| Tool | Risk | v1? |
|---|---|---|
| `upsert_lead` | Low | ✓ |
| `append_activity` | Low | ✓ |
| `write_audit_log` | Low | ✓ |
| `create_stripe_session` | High | ✓ |
| `handle_stripe_webhook` | High | ✓ |
| `draft_follow_up_email` | Medium | Later |
| `send_email` | High | Later |

## Audit Log Fields
`id, user_id, table_name, record_id, action, payload (jsonb), created_at`

Every tool call writes an audit row. Agent inherits the authenticated user's permissions — no elevated access.
