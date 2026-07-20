# Agentic Layer

## v1: NONE
No agentic actions in v1. All actions are direct user-initiated CRUD + Stripe redirect.

## Later: Draftable actions (low risk — auto)
- **Draft follow-up email** — reads lead context, generates draft text → stored in `lead_activities` with `activity_type = 'email_draft'`, `review_status = 'unreviewed'` → user edits and sends manually
- **Auto-tag priority** — rule-based, updates `leads.priority` → logged in audit
- **Summarise activity history** — reads all activities for a lead, produces a summary string

## Later: Executable after approval (medium risk)
- **Update lead stage** — agent suggests stage change → user clicks Approve → DB update
- **Create follow-up task** — agent drafts → user approves → row inserted

## Later: Human-only (critical risk)
- **Send email to lead** — never auto-send; user must manually copy/send
- **Delete a lead** — irreversible, human-only
- **Process refund** — Stripe refund, human-only

## Named tools (later)
- `draft_follow_up_email(lead_id)` — returns draft text, no side effects
- `suggest_stage_change(lead_id)` — returns suggestion, no write
- `summarise_lead_history(lead_id)` — returns summary string

Never expose raw query execution or arbitrary API calls.

## Audit-log fields (created at lock-down sprint)
`id, user_id, action, target_table, target_id, detail_json, created_at`

Every approved agentic action writes a row before executing.