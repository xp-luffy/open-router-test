# Data Model

## leads
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | gen_random_uuid() |
| user_id | uuid | nullable until lock-down sprint |
| created_at | timestamptz | auto |
| name | text NOT NULL | |
| company | text | |
| email | text | |
| source | text | referral / inbound / cold-outbound / conference / other |
| status | text NOT NULL | new / contacted / qualified / negotiating / closed-won / closed-lost |
| notes | text | |
| score | numeric | computed: source weight + status weight + recency bonus |
| subscription_tier | text | free / paid |
| stripe_customer_id | text | |
| stripe_subscription_id | text | |
| subscription_active | boolean | set by webhook |
| ai_summary | text | **AI field** |
| ai_summary_source | text | e.g. "openrouter/gpt-4o" |
| ai_summary_confidence | numeric | 0–1 |
| ai_summary_review_status | text | unreviewed / approved / rejected |
| ai_next_action | text | **AI field** |
| ai_next_action_source | text | |
| ai_next_action_confidence | numeric | |
| ai_next_action_review_status | text | unreviewed / approved / rejected |

## activities
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid | nullable |
| created_at | timestamptz | auto |
| lead_id | uuid FK → leads | cascade delete |
| type | text | call / email / meeting / proposal / note |
| description | text | |
| occurred_at | timestamptz | |

## audit_logs
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid | nullable |
| created_at | timestamptz | auto |
| action | text | e.g. "lead.create", "subscription.activate" |
| object_type | text | leads / activities / subscription |
| object_id | uuid | |
| delta | jsonb | before/after snapshot |
| risk_level | text | low / medium / high / critical |

## RLS
- v1: permissive SELECT + ALL for anonymous demo access
- Lock-down sprint: replace with `auth.uid() = user_id` owner-scoped policies
