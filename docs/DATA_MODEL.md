# Data Model

## leads
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | default gen_random_uuid() |
| user_id | uuid | nullable — owner scoping added at lock-down |
| company | text | not null |
| contact_name | text | |
| contact_email | text | |
| stage | text | not null, default 'new' — one of: new, contacted, qualified, won, lost |
| deal_value | numeric | nullable |
| source | text | nullable |
| notes | text | nullable |
| priority | text | default 'medium' — low/medium/high |
| created_at | timestamptz | default now() |

**RLS (v1)**: permissive read + write for demo. Lock-down: `auth.uid() = user_id`.

## lead_activities
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| lead_id | uuid | not null, references leads(id) |
| user_id | uuid | nullable |
| activity_type | text | email, call, meeting, note |
| summary | text | |
| occurred_at | timestamptz | default now() |
| created_at | timestamptz | default now() |

**RLS (v1)**: permissive. Lock-down: `auth.uid() = user_id`.

## access_grants
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid | nullable |
| tier | text | 'free' or 'paid' |
| stripe_session_id | text | nullable |
| paid_at | timestamptz | nullable |
| created_at | timestamptz | default now() |

**RLS (v1)**: permissive. Lock-down: `auth.uid() = user_id`.

## AI fields (later phase)
When lead scoring is added, store: `score_value numeric`, `score_source text`, `score_confidence numeric`, `review_status text default 'unreviewed'` on leads.

## audit_logs (later)
Created at lock-down sprint to track sensitive actions (payment, data export).