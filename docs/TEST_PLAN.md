# Test Plan

## V1 Success Scenario (manual walkthrough)
1. Open `<live-url>/leads` in a private browser window (not logged in)
2. **Expect:** Lead list loads with ≥ 5 demo rows; status badges visible; no login wall
3. Click **Upgrade** banner
4. **Expect:** Redirected to Stripe Checkout (test mode)
5. Enter card `4242 4242 4242 4242`, any future expiry, any CVC → complete payment
6. **Expect:** Redirected to `/success` page; no error
7. Return to `/leads`
8. **Expect:** Upgrade banner gone; **Add Lead** button visible
9. Click **Add Lead** → fill name = "Test Founder", email = `test@example.com`, source = "Cold email" → Save
10. **Expect:** New row appears in list immediately; toast shows "Lead added"
11. Refresh the page
12. **Expect:** "Test Founder" row still present (not a fake insert)
13. Check Supabase `payments` table — **Expect:** one row with `status = paid` and correct `stripe_session_id`

## Empty State
- Delete all non-seed leads → **Expect:** empty state message "No leads yet — add your first" with CTA button

## Error Cases
- Submit Add Lead form with blank email → **Expect:** inline validation error, no DB call
- Kill network, submit form → **Expect:** error toast "Failed to save lead — please try again"; no silent failure
- POST fake payload to `/api/stripe-webhook` without valid signature → **Expect:** 400 response, no DB write

## Payment Gate
- In a fresh session with no payment record → **Expect:** Add Lead button is disabled/hidden; upgrade banner shown
- After payment → **Expect:** button enabled, banner gone

## Security Spot-Check
- Open DevTools → Network → inspect any API response: confirm no `SUPABASE_SERVICE_ROLE_KEY` or `STRIPE_SECRET_KEY` present
- Confirm `stripe-signature` rejection returns 400 (test with curl and wrong secret)
