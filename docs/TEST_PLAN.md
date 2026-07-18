# Test Plan

## Core Success Scenario (manual walkthrough)
1. Open live URL in a private/incognito window — lead list renders with 5 seed leads. ✓
2. Click "Add Lead" — form opens with all fields visible.
3. Submit empty form — validation errors appear on required fields; nothing saved. ✓
4. Fill in name, company, email, source=referral, status=qualified, add notes >100 chars — submit.
5. New lead appears in list with score ≥70. Refresh page — lead still present. ✓
6. Click lead → detail page shows, activity timeline is empty with empty-state copy. ✓
7. Edit status → negotiating — score updates on save, list re-orders. ✓
8. Add 4 more leads to reach the 5-lead free limit.
9. Attempt to add a 6th lead — upgrade banner appears; add form is blocked. ✓
10. Click "Upgrade" → Stripe Checkout opens in sandbox mode.
11. Enter test card `4242 4242 4242 4242` — payment completes.
12. Return to app — success page shown, `subscription_active = true` in DB. ✓
13. Add 6th lead — no longer blocked. ✓
14. Delete a lead — confirmation dialog appears; lead removed from list; refresh confirms deletion. ✓

## Empty State Cases
- Delete all leads → list shows "No leads yet. Add your first lead." with CTA button.
- Lead with no activities → detail page shows "No activity logged yet."
- Score = 0 → red badge shown, not blank.

## Error Cases
- Supabase unreachable → list shows "Unable to load leads. Retry." button. Core does not crash.
- Stripe webhook with invalid signature → 400 returned, no DB write, error logged.
- OpenRouter timeout → AI fields show "AI unavailable"; lead still saves normally.
- Free user tries to add lead via direct API POST → server returns 403 with JSON error.

## Payment Verification
- Confirm Stripe dashboard shows test payment received.
- Confirm `audit_logs` has a row: `action=subscription.activate`, `risk_level=high`.
- Test declined card (`4000 0000 0000 0002`) → user returned to upgrade page with "Payment failed" message.
- Test webhook replay (Stripe dashboard) → idempotency: `subscription_active` stays true, no duplicate log rows.
