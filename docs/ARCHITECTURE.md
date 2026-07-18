# Architecture

## Stack
- **Frontend**: Next.js 14 (App Router)
- **Database**: Supabase (Postgres + RLS)
- **Auth**: Supabase Auth (added in lock-down sprint)
- **Payments**: Stripe Checkout + webhooks
- **Deploy**: Vercel

## Now vs Later
**Now**: lead CRUD, activity log, AI score, Stripe checkout, pro gate
**Later**: auth/RLS, team workspaces, email sequences, CRM import

## Key User Action — Add & Score a Lead
1. Founder submits lead form (name, email, company, notes)
2. API route validates and inserts row into `leads`
3. Background call to OpenAI via `openrouter` scores the lead → stored with source + confidence + review_status
4. Dashboard re-fetches leads sorted by score
5. If lead count > 5 and user is free tier → server returns 402, UI shows upgrade prompt
6. Founder clicks Upgrade → API creates Stripe Checkout session → redirect
7. Stripe webhook → sets `subscriptions.status = 'active'`

## Layer Plan
1. **Data** — tables + seed rows (runs without AI)
2. **App logic** — CRUD routes, pro gate, Stripe webhook
3. **Intelligence** — AI scoring layered on top; app functions if scoring fails

## Core Without AI
Removing OpenAI calls leaves full lead CRUD + payment flow intact.
