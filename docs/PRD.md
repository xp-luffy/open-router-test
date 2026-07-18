# PRD — open-router-test

## Problem
Founders lose track of leads across spreadsheets and inboxes. There is no lightweight tool they can start using in minutes and pay for without a sales call.

## Target User
Early-stage founders managing their own sales pipeline (0–2 person sales team).

## Core Objects
- **Lead** — the central record: name, email, company, source, status, notes
- **Activity** — append-only log of every status change or note on a lead
- **Audit Log** — server-side record of every write action
- **Lead Access** — tracks free vs paid plan per user, linked to Stripe

## MVP Must-Haves (v1)
- [ ] Add, edit, delete a lead with name / email / company / source / status / notes
- [ ] Lead list view with status badges
- [ ] Activity log per lead (every status change recorded)
- [ ] Stripe Checkout (test mode) — one paid tier, $29/mo
- [ ] Free tier capped at 5 leads; paid tier unlimited + CSV export
- [ ] Stripe webhook updates `lead_access.plan` in DB on payment success
- [ ] App is viewable and demoable without login

## Non-Goals (v1)
- Team seats / shared pipelines
- Email notifications
- AI scoring or enrichment
- CRM integrations
- User login / per-user isolation (Sprint 4)

## Success Criteria
A founder visits the live URL, sees real-looking demo leads, adds their own lead, changes its status (activity row written), clicks Upgrade, completes Stripe test checkout, and the app unlocks paid features — all without a single dead button or manual DB edit.
