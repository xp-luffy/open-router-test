# Tasks & Sprints

## Sprint 1 — Core pipeline (v1 functional milestone)
**Goal**: Lead CRUD + pipeline board working with seed data, no login.
- [ ] Create `leads` + `lead_activities` + `access_grants` tables with permissive RLS + seed data
- [ ] Build pipeline board: leads grouped by stage, seed rows visible on load
- [ ] Add lead form (modal) → POST → DB insert → board updates
- [ ] Edit lead (inline or modal) → PATCH → board updates
- [ ] Delete lead → DELETE with confirm → board updates
- [ ] Change stage (click to cycle or dropdown) → PATCH → board updates
- [ ] Log activity against a lead → POST to `lead_activities`
- [ ] Empty state: "No leads yet — add your first"
- [ ] Error state on failed save: toast + retry
- [ ] Loading state: skeleton cards while fetching

**DoD**: A stranger opens the URL, sees 5 seed leads across stages, adds a new lead, changes its stage, logs an activity, and deletes one — all persisted to DB.

## Sprint 2 — Payment + free-tier gate
**Goal**: Free limit + Stripe Checkout → paid access.
- [ ] Server-side lead count check: if `access_grants.tier = 'free'` and lead count ≥ 10, block new leads
- [ ] Paywall banner: "You've hit 10 leads — upgrade for unlimited"
- [ ] Stripe Checkout session creation (server route, test mode)
- [ ] Stripe webhook → updates `access_grants` to `tier = 'paid'`
- [ ] Success redirect → board reloads with limit lifted
- [ ] Create `access_grants` row for new visitors (tier = 'free')

**DoD**: With 10+ leads, new-lead form is blocked. Click Upgrade → Stripe test checkout → pay → limit lifted → can add lead 11.

## Sprint 3 — Lock it down (auth + per-user isolation)
**Goal**: Login, per-user data, secure RLS.
- [ ] Supabase Auth: signup + login pages
- [ ] Migrate RLS: replace permissive policies with `auth.uid() = user_id`
- [ ] Associate existing seed leads with a demo user or remove them
- [ ] `access_grants` scoped to `auth.uid()`
- [ ] Stripe checkout passes `user_id` → webhook writes correct grant
- [ ] Logout works, redirects to a logged-out state

**DoD**: Two logged-in users see only their own leads. Free limit applies per user. Paid upgrade works per user.

## Text Gantt
```
Sprint 1: Core pipeline (DB + CRUD + board)     ████████
Sprint 2: Payment + free-tier gate               ████████
Sprint 3: Lock it down (auth + RLS)              ████████
```

**v1 functional milestone**: end of Sprint 1 (pipeline usable end-to-end).
**Payment milestone**: end of Sprint 2 (can take a real test payment).
**Secure milestone**: end of Sprint 3 (per-user isolation).