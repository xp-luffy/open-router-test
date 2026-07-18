# Security

## Secrets
- `STRIPE_SECRET_KEY`, `STRIPE_WEBHOOK_SECRET`, `SUPABASE_SERVICE_ROLE_KEY` — server-side env vars only, never in frontend bundle
- Stripe publishable key is the only client-visible key

## Permission Model
- v1: permissive RLS (demo mode) — no PII risk because no real users yet
- Lock-down sprint: `auth.uid() = user_id` RLS on both tables; service-role key used only in webhook handler

## Approved Tools Rule
- Only named API routes (`/api/leads`, `/api/checkout`, `/api/webhooks/stripe`) touch the database
- No raw SQL exposed to the client
- Stripe webhook validated with `stripe.webhooks.constructEvent` (signature check) before any DB write

## Audit Principle
- Every payment event logged via Stripe Dashboard + local `payments` row
- Lock-down sprint adds `audit_logs` table for lead mutations

## Known Gaps (v1)
- No rate limiting on `/api/leads` — add before real-user launch
- No CAPTCHA on lead form — acceptable for internal/demo use
- Full security pass (injection, XSS, npm audit) required before removing demo-mode RLS