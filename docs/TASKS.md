# Tasks

## Sprint 1 — DB + Lead CRUD (demo-first) `[v1 functional milestone]`
**Goal**: App loads with seed leads; founder can add/edit/delete a lead; scores display.
- [ ] Run migration SQL (leads, activities, subscriptions + seed rows)
- [ ] `/` page renders lead list (loading / empty / error / partial / ready states)
- [ ] Add lead form → POST → persists → list refreshes
- [ ] Edit lead inline → PATCH → persists
- [ ] Delete lead → DELETE → removed from list
- [ ] Activity log panel per lead (add note, list notes)
- [ ] `score_lead` tool called on save; score + reason displayed on card
- [ ] No login wall — anonymous visitor sees demo data

**Definition of Done**: Live preview URL returns 200; all CRUD actions persist and survive reload; score appears on every lead card; empty state shows "Add your first lead" CTA.

---

## Sprint 2 — Stripe Payments + Pro Gate
**Goal**: Founder can upgrade to Pro; free tier capped at 5 leads server-side.
- [ ] `subscriptions` table read on each lead-create attempt
- [ ] >5 leads on free tier → 402 + upgrade banner
- [ ] "Upgrade to Pro" button → `create_checkout_session` → Stripe test-mode redirect
- [ ] Stripe webhook `checkout.session.completed` → write subscription row → pro access granted
- [ ] Pro badge shown in header when active
- [ ] Test: complete Stripe test-mode checkout end-to-end

**Definition of Done**: Real Stripe test payment completes; subscription row written; lead-create no longer blocked; all confirmed in Supabase dashboard.

---

## Sprint 3 — Lock It Down (Auth + RLS)
**Goal**: Per-user data isolation; each founder sees only their leads.
- [ ] Supabase Auth email/password signup + login pages
- [ ] `user_id` populated on all inserts post-auth
- [ ] Replace v1 permissive RLS policies with `auth.uid() = user_id`
- [ ] Subscription lookup scoped to authenticated user
- [ ] Redirect unauthenticated users to `/login` (homepage still public/demo until user signs in)

**Definition of Done**: Two test accounts cannot see each other's leads; Supabase RLS editor confirms policies active; signup → add lead → pay → pro access works as new user.

---

## Gantt
```
Sprint 1  |████████| DB, CRUD, AI score, demo
Sprint 2  |        |████████| Stripe, pro gate
Sprint 3  |                |████████| Auth, RLS
```
