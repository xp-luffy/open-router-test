# Tasks

## Sprint 1 — DB, seed data, lead CRUD (demo-first)
**Goal:** Anyone can open the URL and see real leads, add a new one, edit and delete it.

- [ ] Apply migration SQL to Supabase
- [ ] Seed 5 demo leads with varied statuses
- [ ] `/` route: lead list with loading / empty / error / partial / ready states
- [ ] Add lead form — all fields, client + server validation, persists to DB
- [ ] Edit lead inline or via modal — updates DB, UI reflects
- [ ] Delete lead — confirmation dialog, removes from DB and list
- [ ] Lead detail page with activity timeline (read-only at this stage)
- [ ] No login wall — anonymous visitor sees everything

**Definition of Done:** A fresh browser with no cookies opens the live URL, sees 5 leads, adds a 6th with real data, edits its status, deletes it — all changes visible on refresh. Empty state renders when all leads deleted.

---

## Sprint 2 — Lead scoring engine
**Goal:** Every lead shows a computed score; list sorts by score.

- [ ] `score.recompute` function: source + status + recency + notes + activity weights
- [ ] Score stored in `leads.score` on every create/update
- [ ] Score badge on lead card (colour-coded: ≥80 green, ≥50 amber, <50 red)
- [ ] Sort leads by score descending as default
- [ ] Score breakdown tooltip on hover
- [ ] Audit log entry on score recalculation

**Definition of Done:** Edit a lead's status from `new` → `negotiating`; score updates within the same save; list re-orders; audit_logs has a new row.

---

## Sprint 3 — Stripe checkout and paid tier ✅ v1 functional milestone
**Goal:** Free tier limited to 5 leads; paying moves to unlimited.

- [ ] Count leads on add — block at 6 for free users, show upgrade banner
- [ ] `/api/stripe/checkout` server route — creates session, returns URL (secret key server-only)
- [ ] Stripe sandbox product: $9/mo, unlimited leads
- [ ] `/api/webhooks/stripe` — validates signature, sets `subscription_active = true`
- [ ] Upgrade redirect flow: banner → checkout → success page → UI unlocks
- [ ] Audit log entry for subscription activation (risk: high)
- [ ] Test cancel and failed payment paths in sandbox
- [ ] Smoke-test: walk full payment flow, confirm webhook fires, DB updated, UI reflects

**Definition of Done:** In Stripe sandbox, complete a payment. Webhook fires. `subscription_active` flips to true in DB. Lead count limit removed. Failed card returns user to upgrade page with error message.

---

## Sprint 4 — Lock it down (auth + per-user RLS)
**Goal:** Each user sees only their own leads; no cross-user leakage.

- [ ] Supabase Auth: email/password signup and login pages
- [ ] Replace v1 permissive RLS with `auth.uid() = user_id` policies on all tables
- [ ] Assign `user_id` on all writes post-auth
- [ ] Seed demo user owns demo rows
- [ ] Stripe customer ID linked to `auth.users` record
- [ ] Unauthenticated write attempts return 401; reads of own data still work
- [ ] Verify: user A cannot see user B's leads via direct API call

**Definition of Done:** Two test accounts each add leads; neither can read the other's data via Supabase client or API. RLS policies confirmed in Supabase dashboard.

---

## Sprint 5 — AI summaries and next-action drafts
**Goal:** AI suggests a lead summary and next step; founder approves before it's saved.

- [ ] Server action calls OpenRouter with lead notes + activities
- [ ] Response stored as `ai_summary` + `ai_next_action` with source, confidence, `review_status = unreviewed`
- [ ] UI shows AI fields with confidence badge and Approve / Reject buttons
- [ ] Approve → `review_status = approved`; field promoted to main notes area
- [ ] Sanitise all user text before sending to OpenRouter (strip injection patterns)
- [ ] Fallback: if OpenRouter unavailable, show "AI unavailable" — core app unaffected

**Definition of Done:** Add a lead with notes, trigger AI summary, see draft appear with confidence score, click Approve — `review_status` flips in DB.

---

## Sprint 6 — Hardening and launch
**Goal:** Production-ready, deployed, rollback tested.

- [ ] Security pass: injection, XSS, CSRF, npm audit, rate-limiting, PII in logs
- [ ] Document any risks that could not be verified
- [ ] Production Stripe keys in Vercel env (not sandbox)
- [ ] Deploy to Vercel production domain
- [ ] Smoke-test as logged-out stranger: live URL returns 200, shows lead list
- [ ] Pin prior Vercel deployment as rollback target
- [ ] README: setup steps, required env vars, how to run payment test

**Definition of Done:** Live URL loads for a stranger with no cookies. Production Stripe checkout completes. Rollback deployment confirmed reachable.

---

## Gantt
```
Week 1: Sprint 1 (DB + CRUD) → Sprint 2 (Scoring)
Week 2: Sprint 3 (Stripe — v1 milestone) → Sprint 4 (Auth lock-down)
Week 3: Sprint 5 (AI layer) → Sprint 6 (Launch)
```
