create table if not exists leads (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  name text not null,
  email text,
  company text,
  status text not null default 'new',
  notes text,
  score numeric,
  score_source text,
  score_confidence numeric,
  score_review_status text default 'unreviewed',
  created_at timestamptz not null default now()
);

alter table leads enable row level security;
drop policy if exists "leads_v1_read" on leads;
create policy "leads_v1_read" on leads for select using (true);
drop policy if exists "leads_v1_write" on leads;
create policy "leads_v1_write" on leads for all using (true) with check (true);

create table if not exists activities (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  lead_id uuid references leads(id) on delete cascade,
  note text not null,
  activity_date date,
  created_at timestamptz not null default now()
);

alter table activities enable row level security;
drop policy if exists "activities_v1_read" on activities;
create policy "activities_v1_read" on activities for select using (true);
drop policy if exists "activities_v1_write" on activities;
create policy "activities_v1_write" on activities for all using (true) with check (true);

create table if not exists subscriptions (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  stripe_customer_id text,
  stripe_session_id text,
  status text not null default 'free',
  created_at timestamptz not null default now()
);

alter table subscriptions enable row level security;
drop policy if exists "subscriptions_v1_read" on subscriptions;
create policy "subscriptions_v1_read" on subscriptions for select using (true);
drop policy if exists "subscriptions_v1_write" on subscriptions;
create policy "subscriptions_v1_write" on subscriptions for all using (true) with check (true);

insert into leads (name, email, company, status, notes, score, score_source, score_confidence, score_review_status) values
  ('Sarah Chen', 'sarah@acmefintech.com', 'Acme Fintech', 'qualified', 'Met at YC event. $2M ARR, ready to buy Q1. Budget confirmed.', 9, 'openrouter/gpt-4o-mini', 0.91, 'unreviewed'),
  ('Marcus Webb', 'marcus@buildfast.io', 'BuildFast', 'contacted', 'Inbound from Twitter DM. Early stage, no budget yet but very interested.', 5, 'openrouter/gpt-4o-mini', 0.74, 'unreviewed'),
  ('Priya Nair', 'priya@loophealth.com', 'Loop Health', 'new', 'Referred by Sarah. Healthcare SaaS, Series A, evaluating tools in March.', 7, 'openrouter/gpt-4o-mini', 0.80, 'unreviewed'),
  ('James Okoro', 'james@driftlabs.co', 'Drift Labs', 'closed', 'Signed contract last week. 12-month deal.', 10, 'openrouter/gpt-4o-mini', 0.97, 'reviewed'),
  ('Lena Park', 'lena@skyventures.vc', 'Sky Ventures', 'new', 'VC contact, may intro portfolio founders. No direct deal yet.', 4, 'openrouter/gpt-4o-mini', 0.65, 'unreviewed')
on conflict do nothing;

insert into activities (lead_id, note, activity_date) values
  ((select id from leads where email = 'sarah@acmefintech.com' limit 1), 'Had 30-min intro call. Strong fit. Sending proposal.', '2025-01-10'),
  ((select id from leads where email = 'marcus@buildfast.io' limit 1), 'Replied to DM. Scheduled demo for next week.', '2025-01-12'),
  ((select id from leads where email = 'james@driftlabs.co' limit 1), 'Contract signed. Sent onboarding email.', '2025-01-08')
on conflict do nothing;