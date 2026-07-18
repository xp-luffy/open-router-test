# Security

## Secrets
- `STRIPE_SECRET_KEY`, `STRIPE_WEBHOOK_SECRET`, `OPENROUTER_API_KEY`, `SUPABASE_SERVICE_ROLE_KEY` — Vercel env vars only, never in frontend bundles or committed to git
- Stripe Checkout session created server-side (`/api/stripe/checkout`); public key only used client-side for redirect
- Webhook endpoint validates `stripe-signature` header before processing

## Permission Model
- v1: permissive RLS (demo-first) — no sensitive user data in this phase
- Lock-down sprint: `auth.uid() = user_id` on every table; service role key used only in server actions and webhooks
- Agent actions inherit the calling user's Supabase session — no privilege escalation

## Approved Tools Rule
Only named tools in AGENTIC_LAYER.md may be called. No `eval`, no `run_any`, no raw SQL from user input.

## Audit Principle
Every write (lead CRUD, subscription change, AI action) writes a row to `audit_logs` with risk level before the action completes.

## Known Gaps to Address at Lock-Down
- Rate-limiting on `/api/leads` and `/api/stripe/checkout` (add middleware)
- Input sanitisation before any text reaches OpenRouter (strip prompt-injection patterns)
- npm audit clean before production deploy
- Verify no PII in Vercel logs or Supabase log drain
- Items that cannot be automatically verified: CSRF token validity in all form paths, full prompt-injection coverage — manual review required
