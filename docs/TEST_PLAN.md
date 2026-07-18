# Test Plan

## Success Scenario (manual walkthrough)
1. Open live URL — lead list loads with 5 seeded leads, no login prompt
2. Click "Add Lead" → fill name=Test User, company=Acme, email=test@acme.com → Submit
3. Confirm new lead appears in list with a computed score (0–100)
4. Add 5 more leads until count = 6 → expect upgrade banner / blocked
5. Click "Upgrade" → Stripe Checkout opens in test mode
6. Enter card `4242 4242 4242 4242`, any future date, any CVC → Pay
7. Redirected to `/success` — confirm success message
8. Return to lead list — all leads visible, 6th lead saves cleanly
9. Check Supabase `payments` table — row with `status = active` exists

## Empty State
- Delete all leads → list shows "No leads yet. Add your first lead." with Add button

## Error Cases
- Submit Add Lead form with empty name → inline validation error, no DB write
- Stripe webhook with bad signature → returns 400, no DB write, error logged
- `/api/leads` called with malformed body → returns 422, UI shows "Something went wrong"

## Loading States
- Simulate slow network → spinner shown on lead list fetch and on form submit

## Payment Verification
- Stripe Dashboard → test payments → confirm session appears
- Confirm `payments` row in Supabase with matching `stripe_session_id`

## Security Spot-Check
- View page source / network tab → confirm no `STRIPE_SECRET_KEY` or `SUPABASE_SERVICE_ROLE_KEY` visible
- Stripe webhook: replay request without signature header → expect 400