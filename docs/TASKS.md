# Tasks

## Sprint 1 — DB, seed data, lead list (demo-first)
**Goal:** The `/leads` page renders with realistic demo leads for any visitor — no login required.

- [ ] Run migration SQL in Supabase (leads + payments tables, seed 5 leads)
- [ ] Scaffold Next.js 14 project, connect Supabase client
- [ ] Build `/leads` page: table columns — Name, Email, Source, Status, Created
- [ ] Status badge component (color per status)
- [ ] Loading skeleton, empty state ("No leads yet — add your first"), error banner
- [ ] Confirm seeded rows visible at `localhost:3000/leads` without login

**Definition of Done:** `/leads` returns 200 for a logged-out browser and displays ≥ 5 seeded leads with correct status badges.

---

## Sprint 2 — Core engine: add, edit, delete leads ✦ v1 functional
**Goal:** Full lead CRUD works against the real database.

- [ ] "Add Lead" slide-over form: name (required), email (required), source (dropdown), notes
- [ ] Submit → `INSERT` into `leads` → list re-fetches → new row appears
- [ ] Click lead row → edit modal: change status, update notes, save
- [ ] Delete button with confirmation dialog → `DELETE` from `leads`
- [ ] `converted_at` auto-set when status changes to `converted`
- [ ] Toast notifications for success and failure
- [ ] All five UI states tested: loading, empty, partial, error, ready

**Definition of Done:** Add a lead, edit its status to `converted`, delete another lead — all changes survive a full page refresh. No dead buttons.

---

## Sprint 3 — Stripe Checkout + paid-tier gate
**Goal:** A real (sandbox) payment unlocks full access; the DB records the payment.

- [ ] Create Stripe product + price in test/sandbox mode
- [ ] `POST /api/checkout` — create Checkout session, return redirect URL
- [ ] `/success` page shown after Stripe redirect
- [ ] `POST /api/stripe-webhook` — verify signature, insert `payments` row with `status = paid`
- [ ] App reads `payments` table; show upgrade banner if no paid record
- [ ] Gate "Add Lead" button behind paid status (free visitors see demo list + upgrade prompt)
- [ ] Test with Stripe test card 4242 4242 4242 4242 — confirm DB row written

**Definition of Done:** Complete sandbox checkout → payment row in DB with `status = paid` → "Add Lead" unlocks → add a lead → row persists.

---

## Sprint 4 — Lock it down (auth + per-user RLS)
**Goal:** Real user accounts; each founder sees only their own leads.

- [ ] Enable Supabase Auth (email + magic link)
- [ ] Sign-up / login pages at `/login`
- [ ] On lead creation and payment, write `user_id = auth.uid()`
- [ ] Replace v1 permissive RLS policies with `auth.uid() = user_id` owner policies
- [ ] Demo seed rows remain visible to anonymous visitors (user_id = null, read-only)
- [ ] Redirect unauthenticated users to `/login` when attempting write actions

**Definition of Done:** User A cannot see User B's leads. Anonymous visitor still sees demo rows. Auth flow completes without error.

---

## Sprint 5 — Security pass + production deploy
**Goal:** App is live, secrets are safe, and the stranger test passes.

- [ ] Move all secrets to Vercel env vars; verify none appear in browser bundle
- [ ] `npm audit` — fix any high or critical findings
- [ ] Rate-limit `/api/checkout` and `/api/stripe-webhook` (e.g. upstash/ratelimit)
- [ ] Walk full journey as logged-out stranger on live Vercel URL
- [ ] Switch Stripe keys to live mode; confirm live payment end-to-end
- [ ] Document any security items that require external review

**Definition of Done:** Live URL returns 200 for a stranger. One real payment completes. No secret visible in DevTools network tab.

---

## Gantt (sprint → feature)
```
Sprint 1  |--- DB + seed + lead list
Sprint 2  |--- Add / edit / delete leads  [v1 functional ✦]
Sprint 3  |--- Stripe Checkout + payment gate
Sprint 4  |--- Auth + RLS lock-down
Sprint 5  |--- Security pass + live deploy
```
