# Tasks

## Sprint 1 — DB + Lead CRUD (demo-viewable)
**Goal:** App renders at `/` with seeded leads; add/edit/delete works against the database.
- Create `leads` and `payments` tables with v1 RLS policies
- Seed 5 realistic demo leads with scores
- Build lead list page (loading / empty / partial / error / ready states)
- Build Add Lead form → POST `/api/leads` → persists to DB
- Edit lead status inline → PATCH `/api/leads/[id]`
- Delete lead with confirmation → DELETE `/api/leads/[id]`
- Score computed by Postgres trigger on insert/update

**DoD:** Visiting the live URL shows 5 demo leads. Adding, editing, deleting a lead persists and reflects immediately. No login required.

---

## Sprint 2 — Stripe Checkout & Payment Gate ✦ v1 functional
**Goal:** Free limit enforced; real Stripe test payment unlocks unlimited leads.
- Add lead-count gate (>5 returns `payment_required`)
- `/api/checkout` creates Stripe Checkout session (server-side)
- Upgrade banner shown when limit hit
- `/api/webhooks/stripe` validates signature → writes `payments` row → sets activated
- `/success` page confirms payment and refreshes lead list
- Lead limit lifted after active payment row exists

**DoD:** In Stripe test mode — add 6th lead → redirected to Stripe → complete with test card → redirected to `/success` → 6th lead can now be saved. `payments` row in DB with status `active`.

---

## Sprint 3 — Lock It Down (auth + per-user isolation)
**Goal:** Real users can sign up; their data is private.
- Supabase Auth (email/password)
- Login / signup pages
- Replace permissive RLS with `auth.uid() = user_id` policies
- Associate leads + payments to `user_id` on create
- Add `audit_logs` table; log lead mutations + payment events
- Rate-limit `/api/leads`

**DoD:** User A cannot read User B's leads. Logged-out visitor sees only demo rows (or redirect to login). npm audit passes with no high/critical issues.

---

## Gantt
```
Sprint 1  [DB + Lead CRUD]         Week 1 days 1-3
Sprint 2  [Stripe + Gate]  ← v1✦   Week 1 days 4-7
Sprint 3  [Lock it down]            Week 2
```