# Data Model

## leads
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | gen_random_uuid() |
| user_id | uuid nullable | owner scope (used at lock-down) |
| name | text not null | |
| company | text | |
| email | text | |
| status | text default 'new' | new/contacted/qualified/closed |
| notes | text | |
| score | numeric | rule-based 0–100 |
| score_source | text | 'rules_v1' |
| score_confidence | numeric | 0–1 |
| score_review_status | text default 'unreviewed' | |
| created_at | timestamptz not null default now() | |

## payments
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | |
| stripe_session_id | text | |
| plan | text default 'pro_monthly' | |
| status | text default 'pending' | pending/active/cancelled |
| activated_at | timestamptz | |
| created_at | timestamptz not null default now() | |

## RLS
- v1: permissive read + write for both tables (demo-first)
- Lock-down sprint: replace with `auth.uid() = user_id` policies

## Secondary tables (lock-down sprint)
`users`, `audit_logs` — added when auth is wired.