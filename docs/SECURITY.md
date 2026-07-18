# Security

## Secrets
- `STRIPE_SECRET_KEY` and `SUPABASE_SERVICE_ROLE_KEY` are server-only env vars (Next.js API routes / Edge Functions only).
- Frontend receives only the Stripe publishable key and Supabase anon key.
- Never logged, never returned in API responses.

## Permission Model (v1 → lock-down)
- v1: permissive RLS (`using (true)`) — demo-safe, no real user data yet.
- Lock-down sprint: all policies replaced with `auth.uid() = user_id`; service-role key used only in webhook handler.

## Approved Tools Rule
Agent may only call named tools listed in `AGENTIC_LAYER.md`. No `run_any` / `eval` / raw SQL execution from agent context.

## Stripe Webhook
- Signature verified with `stripe.webhooks.constructEvent` before any DB write.
- Replay protection: `stripe_session_id` stored; duplicate events are no-ops.

## Audit Principle
Every score recalculation, status change, and payment event writes a row to `activities` or the audit log. No meaningful action is silent.

## Known Limitations (v1)
- No rate limiting on lead creation (add in lock-down sprint).
- No CSRF token on API routes (mitigated by Supabase JWT at lock-down).
- Penetration testing not performed — recommend before real user data ingestion.