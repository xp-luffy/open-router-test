# Architecture

## Stack
- **Frontend**: Next.js (App Router) + TailwindCSS, deployed on Vercel
- **Database**: Supabase (Postgres + RLS)
- **Payments**: Stripe Checkout (test mode in v1)
- **Auth**: Supabase Auth — added in lock-down sprint, NOT v1

## Build now vs later

**Now (v1)**
- Lead pipeline board + CRUD (no login)
- Activity logging
- Free-tier lead limit enforcement (server-side)
- Stripe Checkout → access upgrade
- Seed demo data so app is instantly viewable

**Later**
- User accounts + per-user lead isolation (RLS owner policies)
- AI lead scoring + enrichment
- Email follow-up drafts
- Team collaboration

## Key user action flow
1. Visitor opens URL → pipeline renders with seed leads
2. Clicks "Add Lead" → form modal → saves to `leads` table
3. Drags/clicks lead to change stage → updates `leads.stage`
4. Logs an activity → inserts into `lead_activities`
5. At 10 leads, paywall banner appears → click "Upgrade"
6. Stripe Checkout opens → test card → success → `access_grants` updated → limit lifted

## Layer plan
1. **Data**: `leads`, `lead_activities`, `access_grants` tables + seed rows + permissive RLS
2. **App logic**: CRUD API routes, stage transitions, lead-count check, Stripe webhook
3. **Smart features** (later): lead scoring, enrichment, follow-up suggestions

## Why the core runs without AI
The pipeline is pure CRUD + a server-side count check + Stripe redirect. No AI call is needed to add, move, or view leads. AI scoring is additive and can be switched off with zero impact on the core loop.