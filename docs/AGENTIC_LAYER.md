# Agentic Layer

## Risk Levels & Actions

### Low — auto-execute
- Recalculate lead score on save (`score_tool`)
- Tag lead status based on activity type (`tag_tool`)
- Summarise notes into one-liner (`summarise_tool`)

### Medium — show draft, one-click approve
- Create follow-up activity suggestion (`draft_activity_tool`)
- Update lead status based on inactivity rule (`status_update_tool`)

### High — always requires approval
- Send follow-up email draft to lead (`send_email_tool`) — v2
- Trigger Stripe upgrade prompt to user (`charge_prompt_tool`)

### Critical — human only
- Issue refund
- Delete all leads (bulk)
- Any legal / data-export action

## Named Tools (v1)
`score_tool`, `tag_tool`, `summarise_tool`, `draft_activity_tool`

## Audit Log Fields
`id, user_id, lead_id, tool_name, action, input_snapshot, output_snapshot, approved_by, executed_at`

## v1 vs Later
**v1:** `score_tool` runs server-side on every lead upsert. Others are stubs.
**Later:** Agent loop polls stale leads, drafts follow-ups, surfaces for approval.