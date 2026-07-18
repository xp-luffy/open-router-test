# Test Plan

## Success Scenario (manual walkthrough)
1. Visit `/` (logged out) → lead list loads with ≥3 seeded rows. ✓
2. Click **New Lead** → fill name, company, email, status=New → Save → appears in list with score. ✓
3. Click lead → detail view shows activity log → add a Note → activity appears instantly. ✓
4. Change status to Qualified → score increases; activity row logged. ✓
5. Create leads until 5 exist → try to create #6 → blocked with upgrade prompt. ✓
6. Click **Upgrade** → redirected to Stripe Checkout (test mode). ✓
7. Enter card `4242 4242 4242 4242`, any expiry/CVC → complete payment. ✓
8. Redirected to `/success` → plan shows **Paid**. ✓
9. Create lead #6 → saves successfully. ✓

## Empty States
- New session with 0 leads → empty state with **Add your first lead** CTA.
- Lead with no activities → "No activity yet" placeholder.

## Error Cases
- Stripe API unreachable → toast: "Payment service unavailable, try again."
- DB insert fails → toast: "Couldn't save lead — please retry."
- Duplicate Stripe webhook event → idempotency check; no double-upgrade.

## Security Checks
- Open browser DevTools → confirm no `STRIPE_SECRET_KEY` or `SERVICE_ROLE_KEY` in network responses.
- Manually POST to `/api/checkout` with malformed body → returns 400, no stack trace exposed.
- Stripe webhook with wrong signature → returns 400, no DB write.