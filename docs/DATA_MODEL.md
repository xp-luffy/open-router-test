# Data Model

## leads
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | owner (scoped at lock-down) |
| name | text not null | |
| company | text | |
| email | text | |
| status | text | new / contacted / qualified / won / lost |
| score | numeric | AI field |
| score_source | text | 'rule_v1' or 'openrouter' |
| score_confidence | numeric | 0–1 |
| score_review_status | text | default 'unreviewed' |
| notes | text | |
| created_at | timestamptz | |

## activities
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| lead_id | uuid FK → leads.id | |
| user_id | uuid nullable | |
| type | text | call / email / note / status_change |
| body | text | |
| created_at | timestamptz | |

## plans
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | |
| status | text | 'free' / 'paid' |
| stripe_customer_id | text | |
| stripe_session_id | text | |
| created_at | timestamptz | |

## RLS
All tables: v1 permissive policies (select/all = true). Replaced with `auth.uid() = user_id` at lock-down sprint.