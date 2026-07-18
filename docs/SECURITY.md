# Security

## Secrets
- `OPENROUTER_API_KEY`, `STRIPE_SECRET_KEY`, `STRIPE_WEBHOOK_SECRET` in Vercel env vars only
- Never referenced in client components or exposed via public API routes
- Supabase `service_role` key used only in server-side routes

## Permissions
- v1: permissive RLS (demo mode) — no sensitive data yet
- Lock-down sprint: all policies replace with `auth.uid() = user_id`; free/pro gate enforced server-side via `subscriptions` table, never just client state

## Approved Tools Only
- Agents call only named tools (`score_lead`, `create_checkout_session`, `confirm_subscription`)
- No raw `eval`, `exec`, or untyped HTTP proxies

## Audit Principle
- Every Stripe webhook and every AI scoring call writes a row to `audit_logs`
- Payment actions (high risk) log input + output snapshots before and after

## Known Gaps to Verify at Lock-Down
- Rate-limiting on lead-create route (prevent abuse)
- npm audit clean before go-live
- Prompt-injection risk in notes field → sanitise before passing to OpenRouter
- CSRF protection on webhook endpoint (Stripe signature verification required)
