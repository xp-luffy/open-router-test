# Security

## Secrets
- `SUPABASE_SERVICE_ROLE_KEY` and `STRIPE_SECRET_KEY` live only in Vercel environment variables — never in frontend code or committed to git
- `STRIPE_WEBHOOK_SECRET` used server-side only to verify webhook signatures
- Next.js server components and API routes are the only callers of secrets

## Permission Model
- v1: permissive RLS (demo-first) — all reads/writes open, no user data yet
- Lock-down sprint: `auth.uid() = user_id` owner policies replace v1 policies before any real user data is stored
- Stripe webhook endpoint verifies `stripe-signature` header on every request; unauthenticated calls are rejected

## Approved Tools Rule
- Agents and API routes call only named functions (`db.insert_lead`, `stripe.create_checkout_session`, etc.)
- No `eval`, `exec`, or dynamic SQL string construction
- No `run_any` / `send_any` patterns permitted

## Audit Principle
- Every status change, payment event, and delete is written to `audit_logs` with actor, timestamp, old + new value
- Audit rows are append-only (no update/delete policy on `audit_logs`)

## What Cannot Be Verified Without External Review
- Full OWASP injection surface of third-party Supabase client
- Stripe webhook replay-attack window beyond signature TTL
- npm supply-chain for indirect dependencies (run `npm audit` and address high/critical findings before launch)
