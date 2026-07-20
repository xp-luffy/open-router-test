# PRD — LeadTracker

## Problem
Founders track leads in spreadsheets — messy, no stage pipeline, no follow-up nudges. They need a dead-simple lead pipeline they can open, use, and pay for in one sitting.

## Target user
Solo founder or small team (1–3 people) managing 5–50 outbound leads at a time.

## Core objects
- **Lead** — a company/person you're selling to. Fields: company, contact_name, contact_email, stage, deal_value, source, notes, priority.
- **LeadActivity** — a logged interaction (email, call, meeting). Fields: lead_id, activity_type, summary, occurred_at.
- **AccessGrant** — tracks whether the current visitor has paid access (free vs paid tier).

## MVP (v1) — checklist
- [ ] Lead pipeline board: list of leads grouped by stage (New → Contacted → Qualified → Won/Lost)
- [ ] Add / edit / delete a lead (persists to DB, not localStorage)
- [ ] Log an activity against a lead
- [ ] Free tier: up to 10 leads, then paywall banner
- [ ] Checkout button → Stripe Checkout (test mode) → upgrades to paid tier (unlimited leads)
- [ ] App renders with seed demo data — no login required to see the pipeline
- [ ] Empty state when no leads exist; error state on failed save

## Non-goals (v1)
- User accounts / login (deferred to lock-down sprint)
- Team collaboration, multiple users
- Email automation / sending
- AI lead scoring / enrichment (later phase)
- Custom pipeline stages

## Success criteria
A stranger opens the URL, sees a pipeline with demo leads, adds a new lead, hits the 10-lead free limit, clicks Checkout, completes a Stripe test payment, and their lead limit is lifted — all in one session, no login needed for the demo.