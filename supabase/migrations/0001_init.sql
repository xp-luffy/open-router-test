-- leads
create table if not exists leads (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  company text not null,
  contact_name text,
  contact_email text,
  stage text not null default 'new',
  deal_value numeric,
  source text,
  notes text,
  priority text default 'medium',
  created_at timestamptz not null default now()
);

alter table leads enable row level security;
drop policy if exists "leads_v1_read" on leads;
create policy "leads_v1_read" on leads for select using (true);
drop policy if exists "leads_v1_write" on leads;
create policy "leads_v1_write" on leads for all using (true) with check (true);

-- lead_activities
create table if not exists lead_activities (
  id uuid primary key default gen_random_uuid(),
  lead_id uuid not null references leads(id) on delete cascade,
  user_id uuid,
  activity_type text not null,
  summary text,
  occurred_at timestamptz not null default now(),
  created_at timestamptz not null default now()
);

alter table lead_activities enable row level security;
drop policy if exists "lead_activities_v1_read" on lead_activities;
create policy "lead_activities_v1_read" on lead_activities for select using (true);
drop policy if exists "lead_activities_v1_write" on lead_activities;
create policy "lead_activities_v1_write" on lead_activities for all using (true) with check (true);

-- access_grants
create table if not exists access_grants (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  tier text not null default 'free',
  stripe_session_id text,
  paid_at timestamptz,
  created_at timestamptz not null default now()
);

alter table access_grants enable row level security;
drop policy if exists "access_grants_v1_read" on access_grants;
create policy "access_grants_v1_read" on access_grants for select using (true);
drop policy if exists "access_grants_v1_write" on access_grants;
create policy "access_grants_v1_write" on access_grants for all using (true) with check (true);

-- seed: demo access grant
insert into access_grants (tier) values ('free')
on conflict do nothing;

-- seed: 5 demo leads
insert into leads (company, contact_name, contact_email, stage, deal_value, source, notes, priority) values
  ('Acme Corp', 'Jane Doe', 'jane@acme.com', 'new', 15000, 'Cold email', 'Met at SaaStr conference', 'high'),
  ('Globex Inc', 'John Smith', 'john@globex.com', 'contacted', 8000, 'LinkedIn', 'Sent intro email, awaiting reply', 'medium'),
  ('Initech', 'Bill Lumbergh', 'bill@initech.com', 'qualified', 25000, 'Referral', 'Demo scheduled for next week', 'high'),
  ('Umbrella Ltd', 'Alice Cooper', 'alice@umbrella.com', 'won', 12000, 'Webinar', 'Closed deal — annual contract', 'low'),
  ('Stark Industries', 'Pepper Potts', 'pepper@stark.com', 'new', 50000, 'Conference', 'Interested in enterprise plan', 'high')
on conflict do nothing;

-- seed: activities for demo leads
insert into lead_activities (lead_id, activity_type, summary) values
  ((select id from leads where company = 'Globex Inc' limit 1), 'email', 'Sent cold intro email with pricing one-pager'),
  ((select id from leads where company = 'Initech' limit 1), 'meeting', 'Discovery call — 30 min, 3 stakeholders attended'),
  ((select id from leads where company = 'Initech' limit 1), 'email', 'Sent follow-up with demo calendar link'),
  ((select id from leads where company = 'Umbrella Ltd' limit 1), 'meeting', 'Contract signing call'),
  ((select id from leads where company = 'Stark Industries' limit 1), 'note', 'Met at conference, very interested in enterprise tier')
on conflict do nothing;