# Architecture

## Stack
- **Frontend:** Next.js 14 (App Router) on Vercel
- **Database:** Supabase (Postgres + RLS)
- **Payments:** Stripe Checkout + webhooks
- **AI (Sprint 5):** OpenRouter API (server-side only)

## Build Sequence
**Now:** DB schema → seed data → lead CRUD → scoring engine → Stripe checkout
**Next:** Auth + per-user RLS → AI summaries → activity import
**Later:** Team workspaces → integrations → agentic outreach

## Key User Action Flow: Add a Lead and Pay
1. Visitor opens `/` — lead list loads from Supabase (seed rows visible)
2. Clicks "Add Lead" → fills form → POST to `/api/leads` (server action)
3. Server validates, computes score, inserts row → returns updated list
4. If free-tier limit reached → upgrade banner appears
5. User clicks "Upgrade" → server creates Stripe Checkout session → redirect
6. Stripe calls `/api/webhooks/stripe` on payment → server sets `subscription_active = true`
7. UI re-fetches, lead cap removed, user continues

## Layer Order
1. **Data** — schema, constraints, RLS (source of truth)
2. **App logic** — CRUD, scoring, tier enforcement (runs without AI)
3. **Smart features** — AI summaries, next-action drafts (additive, removable)

The core runs fully if OpenRouter is disabled — scoring is rule-based, summaries just don't appear.
