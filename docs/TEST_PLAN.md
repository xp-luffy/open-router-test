# Test Plan

## Core Success Scenario
1. Open live URL as anonymous visitor → lead list loads with seed data (not a login page)
2. Click "Add Lead" → fill name/email/company/notes → submit
3. New lead appears in list with an AI score (1–10) and reason
4. Edit the lead's status to "qualified" → change persists on reload
5. Add an activity note → note appears in lead's activity panel
6. Create 5 more leads → 6th attempt returns upgrade prompt
7. Click "Upgrade to Pro" → Stripe test-mode checkout opens
8. Use Stripe test card `4242 4242 4242 4242` → complete payment
9. Redirected back to app → Pro badge visible → 6th lead now saves successfully
10. Reload page → Pro status persists (from DB, not localStorage)

## Empty States
- New session with no leads → empty state shows "Add your first lead" button (not blank screen)
- Lead with no activities → panel shows "No activities yet — log one below"

## Error States
- Submit lead form with blank name → inline validation error, no DB write
- OpenRouter unavailable → lead saves with score = null, card shows "Score pending"
- Stripe webhook missing signature → returns 400, no subscription written

## Reload / Persistence Check
- After every CRUD action, hard-reload the page and confirm the change survived

## Security Smoke Test (pre-lock-down)
- Confirm `STRIPE_SECRET_KEY` not present in browser network tab
- Confirm Stripe webhook rejects requests without valid signature
