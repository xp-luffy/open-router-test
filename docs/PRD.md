# PRD — open-router-test Lead Tracker

## Problem
Founders lose track of leads across notes, spreadsheets, and DMs. They need a single place to capture, score, and move leads through a pipeline — and a way to charge for access from day one.

## Target User
Early-stage founders managing ≤100 leads personally. No ops team, no CRM budget.

## Core Objects
- **Lead** — the central record: name, company, email, source, status, score, notes
- **Activity** — timestamped events on a lead (call, email, meeting, proposal)
- **Audit Log** — every write action with risk level

## MVP Checklist
- [ ] Lead list viewable by anonymous visitor (seed data visible on first load)
- [ ] Add / edit / delete lead — all persist to DB, UI reflects immediately
- [ ] Rule-based lead score (source + status + recency) shown on every lead
- [ ] Activity log per lead — add and view entries
- [ ] Free tier: ≤5 leads; Paid tier: unlimited ($9/mo)
- [ ] Stripe Checkout (sandbox) — upgrade flow works end-to-end, webhook updates DB
- [ ] Every screen handles loading, empty, error, partial, and ready states

## Non-Goals (v1)
- Multi-user teams or shared workspaces
- Email sending or sequence automation
- CRM integrations
- AI summaries (Sprint 5)
- Mobile-native app

## Success Criteria
A founder visits the live URL, sees demo leads, adds their first real lead, hits the 5-lead free limit, completes a Stripe sandbox checkout, and the UI unlocks unlimited lead creation — all without a login wall. A real (sandbox) payment has been received and logged.
