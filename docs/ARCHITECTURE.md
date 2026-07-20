# Architecture

## Stack
- **Frontend:** Next.js 14 (App Router) on Vercel
- **Database + Auth:** Supabase (Postgres, RLS, Auth)
- **Payments:** Stripe Checkout + webhooks
- **Styling:** Tailwind CSS

## Now vs Later
| Now (v1) | Later |
|---|---|
| Lead CRUD | Team seats |
| Stripe one-time or monthly tier | Usage analytics |
| Permissive RLS (demo-first) | Owner-scoped RLS (lock-down sprint) |
| Manual status updates | AI follow-up drafts |

## Key User Action — Flow
1. Visitor loads `/leads` → Supabase query returns leads (seeded rows if new)
2. Visitor clicks **Upgrade** → POST `/api/checkout` → Stripe Checkout session created → redirect
3. Stripe redirects back with `session_id` → success page shown
4. Stripe fires `checkout.session.completed` webhook → `/api/stripe-webhook` verifies signature → inserts `payments` row with `status = paid`
5. App reads payment record → unlocks **Add Lead** button
6. User submits lead form → POST to Supabase `leads` table → list re-fetches → new row visible

## Layer Order
1. **Data first** — schema, RLS, seed data
2. **App logic** — CRUD, payment gate, webhook handler
3. **Smart features** — scoring, AI drafts (later sprints)

## AI-off Guarantee
All lead tracking and payment gating run entirely on Postgres + Stripe. No AI call is in the critical path. Removing AI features leaves a fully functional app.
