# PRD — open-router-test

## Problem
Founders lose track of leads across spreadsheets, DMs, and notes. They need one place to capture, score, and follow up on leads — and they'll pay for it.

## Target User
Early-stage founders managing their own pipeline (0–2 salespeople).

## Core Objects
- **Lead** — the central record (name, company, status, score, notes)
- **Activity** — every action taken on a lead (call, email, note)
- **Plan** — free vs paid tier gate
- **Checkout Session** — Stripe payment record

## MVP Must-Haves
- [ ] Lead list view: create, edit, delete leads
- [ ] Lead detail view: add activities / notes
- [ ] Status pipeline: New → Contacted → Qualified → Closed Won / Lost
- [ ] AI lead score (rule-based v1, confidence stored)
- [ ] Free tier: up to 5 leads; Paid tier: unlimited
- [ ] Stripe Checkout for paid upgrade
- [ ] Payment confirmation unlocks paid tier
- [ ] Demo seed data visible without login

## Non-Goals (v1)
- Email sync / calendar integration
- Team / multi-user access
- Custom pipeline stages
- Mobile app

## Success Criteria
A founder visits the live URL (no login), sees demo leads, creates a real lead, hits the 5-lead free limit, clicks Upgrade, completes a Stripe test-mode payment, and the paid tier unlocks — all within 5 minutes.

## Definition of Done
Every button persists to the database. The upgrade flow completes a real Stripe test-mode charge. Empty, error, and loading states are handled on every screen. No secrets in the frontend. Passing test steps documented in TEST_PLAN.md.