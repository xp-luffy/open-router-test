# PRD — open-router-test

## Problem
Founders lose track of leads across spreadsheets and inboxes. They need one simple place to capture, qualify, and follow up — and they'll pay for a tool that removes that friction immediately.

## Target User
Early-stage founders managing their own sales pipeline (1–5 person team).

## Core Objects
- **Lead** — the central record: person, contact info, source, status, notes
- **Payment** — Stripe checkout result that unlocks full access

## MVP Checklist (v1 must-haves)
- [ ] Lead list page visible without login (seeded demo data)
- [ ] Add / edit / delete a lead (name, email, source, status, notes)
- [ ] Status workflow: new → contacted → qualified → converted / lost
- [ ] Stripe Checkout (test mode) — one paid tier
- [ ] Webhook writes payment record; paid status gates "Add Lead"
- [ ] Empty, loading, and error states on every screen
- [ ] No secrets in the frontend bundle

## Non-Goals (v1)
- Team accounts / multi-user sharing
- Email sending or sequences
- AI suggestions or scoring
- Mobile app

## Success Criteria
**End-to-end scenario:** A founder opens the live URL, sees 5 demo leads, clicks "Upgrade", completes a Stripe test payment, is redirected back, and can now add a real lead — which appears in the list instantly and persists on refresh.

**Definition of Done:** That exact journey completes without error on the deployed URL. The payment record exists in the database. The new lead row is real (not seed data). A logged-out stranger on a fresh browser sees the demo list and the upgrade prompt.
