# Security

## Secret handling
- Stripe secret key + webhook signing secret → Supabase Edge Function env vars or Vercel env vars only
- Never committed to repo, never exposed in frontend
- Frontend uses Stripe publishable key only (safe to expose)
- Supabase service-role key → server-side API routes only, never in client bundle
- Anon key → safe for client (RLS-protected)

## Permission model (v1 → end state)

### v1 (demo-first)
- All tables have permissive RLS: anyone can read/write
- This is intentional for demo — no login wall
- Lead limit (10 free) enforced server-side via count query, not client trust

### Lock-down sprint (end state)
- `leads`, `lead_activities`: `auth.uid() = user_id` on all policies
- `access_grants`: user reads own grant only
- No anonymous writes after lock-down

## Approved-tools rule
- Only named, server-side API routes interact with the DB
- No raw SQL from client; all writes go through typed API handlers
- (Later) Agent tools are a fixed allow-list — never raw execution

## Audit principle
- Every payment event (checkout created, payment succeeded, access upgraded) is logged
- (Later) every agentic action is logged with actor, target, timestamp
- Logs are append-only; no delete policy in v1

## What could NOT be verified in v1
- Rate-limiting on lead creation (add before real users)
- Prompt-injection resistance (no AI in v1, so N/A now)
- CSRF on forms (Next.js server actions mitigate; verify before production)