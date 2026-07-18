# Security

## Secret Handling
- `STRIPE_SECRET_KEY`, `STRIPE_WEBHOOK_SECRET`, `SUPABASE_SERVICE_ROLE_KEY` live in Vercel environment variables only
- Next.js API routes (server-side) use secrets; client bundles never see them
- `NEXT_PUBLIC_` prefix only for genuinely public keys (Supabase anon key, Stripe publishable key)

## Permission Model
- **v1**: permissive RLS (demo-first) — no sensitive real data until Sprint 4
- **Sprint 4**: `auth.uid() = user_id` RLS policies replace v1 policies; service-role key used only in webhook handler, never in client
- Stripe webhook validated with `stripe.webhooks.constructEvent()` — unsigned requests rejected with 400

## Approved Tools Rule
Only named tools in `AGENTIC_LAYER.md` may be invoked. No `run_any`, `eval`, or dynamic code execution. Every tool call produces an `audit_logs` row.

## Audit Principle
Every write (insert / update / delete) through the API appends an `audit_logs` row server-side. Client cannot skip this — log is written in the same DB transaction.

## Pre-Launch Security Checklist
- [ ] `npm audit` — no high/critical vulnerabilities
- [ ] No secrets in git history (`git log` + `gitleaks` scan)
- [ ] Stripe webhook signature verified before any DB write
- [ ] Rate-limiting on `/api/leads` (POST) and `/api/webhooks/stripe`
- [ ] XSS: all user input rendered via React (no `dangerouslySetInnerHTML`)
- [ ] RLS owner policies verified: User A query returns 0 rows for User B's leads
- **Cannot verify without external test**: blind SSRF, third-party dependency supply chain — flag for human review before production launch
