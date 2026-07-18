# Data Model

## leads
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | gen_random_uuid() |
| user_id | uuid nullable | owner; FK added at lock-down |
| name | text NOT NULL | |
| email | text | |
| company | text | |
| source | text | LinkedIn / Referral / Cold outreach / etc. |
| status | text NOT NULL default 'new' | new / qualified / negotiating / won / lost |
| notes | text | |
| created_at | timestamptz | |

## activities
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | |
| lead_id | uuid FK → leads.id | cascade delete |
| action | text NOT NULL | e.g. 'status_changed', 'note_added' |
| old_value | text | |
| new_value | text | |
| created_at | timestamptz | |

## audit_logs
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | |
| table_name | text | |
| record_id | uuid | |
| action | text | insert / update / delete |
| payload | jsonb | full diff snapshot |
| created_at | timestamptz | |

## lead_access
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | tied to auth user at lock-down |
| stripe_customer_id | text | |
| stripe_subscription_id | text | |
| plan | text default 'free' | free / paid |
| paid_at | timestamptz | |
| created_at | timestamptz | |

## AI Fields (future)
Any AI-generated score on a lead stores: `score_value numeric`, `score_source text`, `score_confidence numeric`, `score_review_status text default 'unreviewed'`.

## RLS
- v1: permissive read + write for all tables (demo-first)
- Sprint 4: replaced with `auth.uid() = user_id` owner-scoped policies
