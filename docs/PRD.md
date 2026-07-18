# PRD — open-router-test

## Problem
Founders waste time manually tracking leads with no visibility into which ones are worth pursuing. They need a dead-simple paid tool that captures, scores, and surfaces the leads most likely to convert.

## Target User
Early-stage founders managing a small pipeline (<200 leads) without a full CRM.

## Core Objects
- **Lead** — name, company, email, status, score, notes
- **Payment** — plan, stripe_session_id, status, activated_at

## MVP Checklist (v1 must-haves)
- [ ] Add / edit / delete a lead with status (new → contacted → qualified → closed)
- [ ] Lead list with status filter and score column
- [ ] Auto-score each lead (rule-based: company + email + status signals)
- [ ] Stripe Checkout for a single paid tier ($29/mo)
- [ ] Payment status gates adding more than 5 leads (free limit)
- [ ] Demo mode: app renders with seed data, no login required

## Non-Goals (v1)
- Team / multi-user accounts
- Email sending or sequences
- CRM integrations
- AI-generated outreach drafts

## Success Criteria
A founder visits the live URL, sees 5 demo leads, adds a real lead, hits the 5-lead limit, completes Stripe Checkout in test mode, is redirected back, and can now add unlimited leads — all without a login wall. Payment row is written to the database.

## Definition of Done
The success scenario above passes end-to-end in a live preview deployment. Every button persists to the database. Empty, error, and loading states are handled. No secrets in frontend. Payment verified in Stripe test mode.