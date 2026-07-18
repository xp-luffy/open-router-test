# Data Model

## leads
| field | type | notes |
|---|---|---|
| id | uuid PK | gen_random_uuid() |
| user_id | uuid nullable | owner (set at lock-down) |
| name | text not null | |
| email | text | |
| company | text | |
| status | text | 'new' \| 'contacted' \| 'qualified' \| 'closed' |
| notes | text | |
| score | numeric | AI field |
| score_source | text | e.g. 'openrouter/gpt-4o' |
| score_confidence | numeric | 0–1 |
| score_review_status | text | default 'unreviewed' |
| created_at | timestamptz | now() |

## activities
| field | type | notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | |
| lead_id | uuid | FK → leads.id |
| note | text not null | |
| activity_date | date | |
| created_at | timestamptz | now() |

## subscriptions
| field | type | notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | |
| stripe_customer_id | text | |
| stripe_session_id | text | |
| status | text | 'free' \| 'active' \| 'cancelled' |
| created_at | timestamptz | now() |

## RLS
- All tables: RLS enabled, v1 permissive policies (select + all = true)
- Lock-down sprint: replace with `auth.uid() = user_id`

## Relationships
`activities.lead_id → leads.id`; `subscriptions.user_id` links to auth user at lock-down.
