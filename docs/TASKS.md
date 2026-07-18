# Tasks & Sprints

## Sprint 1 — DB + Lead CRUD (demo-first)
**Goal:** Core tables live; lead list + detail screens render with seed data; no login required.
- [ ] Run migration SQL (leads, activities, plans, seed rows)
- [ ] Lead list page: shows all leads, status badge, score
- [ ] Lead create form: name, company, email, status, notes → persists to DB
- [ ] Lead edit / delete: works, reflects immediately in list
- [ ] Activity log on lead detail: add activity, list renders
- [ ] Empty state on lead list; loading skeleton; DB error toast
- [ ] Rule-based score calculated and stored on every lead save

**Definition of Done:** Visiting `/` shows seeded leads. Creating, editing, deleting a lead persists. Score appears. No login prompt.

---

## Sprint 2 — Paid Tier + Stripe Checkout ✦ v1 functional milestone
**Goal:** Free/paid gate works; real Stripe test-mode payment completes; paid tier unlocks.
- [ ] `plans` row created for demo session (free by default)
- [ ] Block lead #6+ creation with upgrade prompt
- [ ] `/api/checkout` route creates Stripe Checkout Session (server-side)
- [ ] Stripe webhook handler verifies signature, sets plan = paid
- [ ] `/success` page re-fetches plan, shows unlocked state
- [ ] Stripe test-mode end-to-end verified (card 4242…)
- [ ] Error state if Stripe call fails

**Definition of Done:** Stripe test payment completes, plan flips to paid, 6th lead saves successfully.

---

## Sprint 3 — Lock it Down (auth + per-user isolation)
**Goal:** Real users can sign up; their data is isolated; demo data remains public.
- [ ] Supabase Auth (email + password)
- [ ] Sign-up / login pages
- [ ] `user_id` populated on all writes post-login
- [ ] RLS policies: `auth.uid() = user_id` on all tables
- [ ] Per-user `plans` row; Stripe Customer tied to user email
- [ ] Rate limiting on lead creation (Supabase Edge Function or middleware)
- [ ] Seed rows preserved as anonymous demo; new users start empty

**Definition of Done:** Two separate accounts see only their own leads. Logged-out visitor still sees demo data.

---

## Gantt (week view)
```
Week 1: Sprint 1 ████████  Sprint 2 ████████
Week 2: Sprint 3 ████████
```