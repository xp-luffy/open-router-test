# Test Plan

## V1 Success Scenario (walk this in order)
1. Open live URL as a logged-out stranger → lead list renders with 5 demo leads, no login wall
2. Click **Add Lead** → fill name="Test Founder", email, company, source="LinkedIn", status="new" → submit → row appears in list immediately
3. Click the new lead → detail page loads with correct fields
4. Change status to "qualified" → activity feed shows "status_changed: new → qualified" with timestamp
5. Add a note → activity feed appends "note_added" entry
6. Click **Delete** on the test lead → confirmation dialog → confirm → lead removed from list and DB
7. Add 5 leads total (free tier cap) → try to add a 6th → "Upgrade to add more leads" banner appears, form disabled
8. Click **Upgrade** → `/upgrade` page loads with plan comparison
9. Click **Start paid plan** → redirected to Stripe Checkout (test mode)
10. Enter card 4242 4242 4242 4242, any future expiry, any CVC → complete payment
11. Redirected to `/success` → UI reflects paid plan → Add Lead form re-enabled → CSV export button visible
12. Click **Export CSV** → file downloads with correct headers and lead data

## Empty States
- New Supabase project with no seed data → lead list shows "Add your first lead" empty state
- Lead with no activity → activity feed shows "No activity yet"
- Upgrade page before payment → plan = 'free' correctly shown

## Error Cases
- Submit Add Lead form with blank name → inline validation error, no DB write
- Navigate to `/leads/non-existent-id` → 404 page with "Lead not found"
- Stripe webhook sent without valid signature → returns 400, no DB change
- API route called without auth (Sprint 4+) → returns 401, no data leaked

## Regression Check (run after every sprint)
- Lead list still loads and shows seeded rows
- Add/edit/delete still persists correctly
- Stripe test payment still flips `lead_access.plan` to 'paid'
- No `console.error` in browser devtools during normal use
