# PRD — Lead Tracker for Founders

## Problem
Founders lose track of leads across spreadsheets, DMs, and notebooks. They need one lightweight place to capture, score, and follow up on leads — and pay for it on day one.

## Target User
Early-stage founder managing their own pipeline; no sales team.

## Core Objects
- **Lead** — a potential customer contact with status and score
- **Activity** — a note or touchpoint logged against a lead
- **Subscription** — payment tier (free / pro)

## MVP Checklist
- [ ] Add / edit / delete a lead (name, email, company, status, notes)
- [ ] Log an activity against a lead (note text, date)
- [ ] AI scores each lead 1–10 with a reason (auto, reviewable)
- [ ] Dashboard lists leads sorted by score
- [ ] Free tier: up to 5 leads; Pro tier: unlimited
- [ ] Stripe Checkout session created and webhook confirms payment
- [ ] Pro gate enforced server-side

## Non-Goals (v1)
- Team/multi-user workspaces
- Email sending or calendar integration
- CRM import/export
- Mobile app

## Success Criteria
A founder visits the live URL, sees demo leads, adds a real lead, clicks Upgrade, completes Stripe test-mode checkout, and immediately gets Pro access — all without contacting support.

## Definition of Done
Every button persists to the database; UI reflects the change on reload; empty/error/loading states handled; no secrets in frontend; real Stripe test payment confirmed end-to-end.
