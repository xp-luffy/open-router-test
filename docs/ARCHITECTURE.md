# Architecture

## Stack
- **Frontend**: Next.js 14 (App Router) on Vercel
- **Database + Auth**: Supabase (Postgres + RLS + Auth)
- **Payments**: Stripe Checkout + Webhooks
- **Env secrets**: Vercel environment variables only — never in source

## Now vs Later
| Now (v1) | Later |
|---|---|
| Lead CRUD, activity log | AI lead scoring |
| Stripe checkout + paid gate | Team seats |
| Demo-first, no login wall | Email notifications |
| Owner-scoped RLS (Sprint 4) | CRM integrations |

## Key User Action — End-to-End Flow
1. Founder opens `/` — lead list loads from Supabase (seeded demo rows visible immediately)
2. Clicks **Add Lead** — form submits to `/api/leads` (POST) → inserted into `leads` table
3. Changes status on a lead → `leads` row updated + `activities` row appended + `audit_logs` row written, all server-side
4. Clicks **Upgrade** → redirected to Stripe Checkout (server-created session, price ID from env)
5. Completes payment → Stripe fires `checkout.session.completed` webhook → `/api/webhooks/stripe` verifies signature, upserts `lead_access.plan = 'paid'`
6. UI re-fetches `lead_access` → paid features unlock

## Layer Plan
1. **Database** — tables + constraints + RLS policies (truth lives here)
2. **API routes** — CRUD + Stripe session creation + webhook handler
3. **UI** — reads from DB, writes through API, never touches Stripe secret keys
4. **Smart features** — AI scoring added on top later; removing it leaves a fully functional app
