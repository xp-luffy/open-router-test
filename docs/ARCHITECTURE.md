# Architecture

## Stack
- **Frontend:** Next.js 14 (App Router)
- **Database + Auth:** Supabase (Postgres, RLS)
- **Payments:** Stripe Checkout (test mode first)
- **Hosting:** Vercel

## Now vs Later
**Now:** lead CRUD, rule-based scoring, Stripe Checkout, payment gate, seed demo data
**Later:** login/auth, per-user data isolation, AI scoring, email sequences

## Key User Action — Add a Lead & Pay
1. Visitor lands on `/` — sees seeded demo leads (no login)
2. Fills "Add Lead" form → POST `/api/leads` → inserted into `leads` table
3. If lead count > 5 → API returns `payment_required`
4. Frontend redirects to Stripe Checkout session (created server-side)
5. Stripe webhook hits `/api/webhooks/stripe` → writes `payments` row, sets `activated = true`
6. User redirected to `/success` → lead limit lifted, lead list refreshes

## Layer Plan
1. **Data layer** — tables, constraints, RLS policies, seed data
2. **App logic** — CRUD API routes, payment gate, Stripe webhook
3. **Smart features** — rule-based score on insert (later: AI re-score)

## Core Without AI
Scoring is a Postgres function (`0–100` from status + email domain + company present). Removing AI leaves a fully functional lead tracker.