# Tasks & Sprints

## Sprint 1 — DB + Lead CRUD (demo-first)
**Goal**: Anyone can open the app and see real leads, add new ones, edit and delete them.

- [ ] Apply migration SQL to Supabase (leads, activities, audit_logs, lead_access + seed data)
- [ ] `/` lead list page: table with name, company, status badge, created date
- [ ] Loading skeleton, empty state ("Add your first lead"), error toast
- [ ] Add Lead drawer/modal: form with name, email, company, source, status — POST `/api/leads`
- [ ] Edit Lead: inline status change + notes — PATCH `/api/leads/[id]`
- [ ] Delete Lead: confirmation dialog — DELETE `/api/leads/[id]`
- [ ] Every write appends an `audit_logs` row server-side

**Definition of Done**: Stranger hits live URL → sees 5 demo leads → adds a lead → edits its status → deletes it → DB reflects all changes. No dead buttons.

---

## Sprint 2 — Activity Log + Lead Detail
**Goal**: Every lead has a full history; every change is traceable.

- [ ] `/leads/[id]` detail page: all fields + edit form
- [ ] Activity feed on detail page: chronological list of actions
- [ ] Every status change / note save writes an `activities` row
- [ ] Empty state on activity feed ("No activity yet")
- [ ] Error state if lead not found (404 page)

**Definition of Done**: Change a lead's status twice → activity feed shows both entries with timestamps → audit_logs shows matching rows in Supabase.

---

## Sprint 3 — Stripe Checkout + Paid Gate ✦ v1 functional ✦
**Goal**: The tool can take a real (test) payment and gate features.

- [ ] Create Stripe test-mode product + price ($29/mo); store price ID in env
- [ ] `/upgrade` page with plan comparison (free vs paid)
- [ ] POST `/api/checkout` → creates Stripe Checkout Session → returns URL
- [ ] Redirect to Stripe-hosted checkout; success → `/success`, cancel → `/upgrade`
- [ ] POST `/api/webhooks/stripe` → verify signature → upsert `lead_access.plan = 'paid'`
- [ ] Free tier: show "5 lead limit" banner when at cap; disable Add Lead form
- [ ] Paid tier: unlimited leads + CSV export button (downloads leads as .csv)
- [ ] Sandbox test: Stripe test card 4242 4242 4242 4242 → payment succeeds → DB flips to paid → export unlocks

**Definition of Done**: Full payment flow in test mode confirmed end-to-end; no real money charged; DB record proves plan = 'paid'.

---

## Sprint 4 — Lock It Down
**Goal**: Per-user data isolation; strangers see only demo data.

- [ ] Enable Supabase Auth (email/password)
- [ ] Signup + login pages (`/login`, `/signup`)
- [ ] On lead create: set `user_id = auth.uid()`
- [ ] Replace v1 permissive RLS policies with `auth.uid() = user_id` owner-scoped policies
- [ ] Stripe customer ID stored against `auth.uid()` in `lead_access`
- [ ] Protect `/api/*` routes: reject unauthenticated requests with 401
- [ ] Unauthenticated visitors see a demo landing page, not real user data

**Definition of Done**: Logged-in User A cannot read User B's leads (verified by direct Supabase query). Logged-out visitor sees demo page.

---

## Sprint 5 — Polish + Launch
**Goal**: Production-ready, deployed, rollback path documented.

- [ ] Mobile-responsive layout (lead list + detail + checkout)
- [ ] Rate-limiting on POST `/api/leads` and POST `/api/webhooks/stripe`
- [ ] `npm audit` — resolve any high/critical findings
- [ ] Scan for secrets in git history
- [ ] Deploy to Vercel production (env vars set, Stripe webhook endpoint updated)
- [ ] Document rollback: Vercel instant rollback + Supabase point-in-time restore
- [ ] Walk the full journey as a logged-out stranger on the live URL

**Definition of Done**: Live URL returns 200 unauthenticated. Real Stripe payment succeeds in production. Security checklist in SECURITY.md fully checked.

---

## Gantt (sprint → deliverable)
```
Sprint 1 | DB schema · Lead list · Add/Edit/Delete CRUD
Sprint 2 | Lead detail · Activity log · Audit trail
Sprint 3 | Stripe checkout · Paid gate · CSV export  ← v1 functional
Sprint 4 | Auth · RLS owner policies · Per-user isolation
Sprint 5 | Rate-limiting · Security pass · Production deploy
```
