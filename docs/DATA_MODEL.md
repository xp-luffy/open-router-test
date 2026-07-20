# Data Model

## leads
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | gen_random_uuid() |
| user_id | uuid nullable | set at lock-down sprint |
| name | text NOT NULL | |
| email | text NOT NULL | |
| source | text | LinkedIn, Referral, Cold email, etc. |
| status | text NOT NULL default 'new' | new / contacted / qualified / converted / lost |
| notes | text | free-form |
| converted_at | timestamptz | set when status → converted |
| created_at | timestamptz NOT NULL | default now() |

## payments
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | set at lock-down sprint |
| stripe_session_id | text | from Stripe Checkout |
| stripe_customer_id | text | from webhook event |
| amount_cents | integer | |
| currency | text default 'usd' | |
| status | text NOT NULL default 'pending' | pending / paid / failed |
| created_at | timestamptz NOT NULL | |

## AI fields (future — lead scoring)
When added: `score numeric`, `score_source text`, `score_confidence numeric`, `score_review_status text default 'unreviewed'`.

## RLS
- v1: permissive read + write for all (demo-first)
- Lock-down sprint: replace with `auth.uid() = user_id` owner policies
