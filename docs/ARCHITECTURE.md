# Architecture

## Stack
- **Frontend:** Next.js 14 (App Router)
- **Database:** Supabase (Postgres + RLS)
- **Auth:** Supabase Auth (added in Lock-down sprint)
- **Payments:** Stripe Checkout + Webhooks
- **Hosting:** Vercel

## Now vs Later
**Now:** Lead CRUD, activity log, status pipeline, rule-based scoring, Stripe checkout, paid-tier gate.
**Later:** Auth + per-user isolation, AI re-scoring, email follow-up drafts, team seats.

## Key User Action — Upgrade Flow (step by step)
1. Founder adds a 6th lead → UI blocks save, shows upgrade prompt.
2. Founder clicks **Upgrade** → Next.js API route creates a Stripe Checkout Session (server-side, secret key never touches browser).
3. Founder completes payment on Stripe-hosted page.
4. Stripe fires `checkout.session.completed` webhook → API route verifies signature, sets `plans.status = 'paid'` in Supabase.
5. Founder is redirected to `/success`; UI re-fetches plan status and unlocks unlimited leads.

## Layer Plan
1. **Data first** — tables, constraints, seed data, RLS policies.
2. **App logic** — CRUD routes, pipeline status transitions, lead-count gate.
3. **Smart features** — scoring formula, later: AI re-score via OpenRouter.

## Core Without AI
Scoring falls back to a rule-based formula (status weight + activity count). The app is fully functional with AI switched off.