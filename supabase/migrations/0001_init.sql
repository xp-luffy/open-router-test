create table if not exists leads (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  name text not null,
  company text,
  email text,
  status text not null default 'new',
  score numeric default 0,
  score_source text default 'rule_v1',
  score_confidence numeric default 0.65,
  score_review_status text default 'unreviewed',
  notes text,
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
  type text not null,
  body text,
  created_at timestamptz not null default now()
);

alter table activities enable row level security;
drop policy if exists "activities_v1_read" on activities;
create policy "activities_v1_read" on activities for select using (true);
drop policy if exists "activities_v1_write" on activities;
create policy "activities_v1_write" on activities for all using (true) with check (true);

create table if not exists plans (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  status text not null default 'free',
  stripe_customer_id text,
  stripe_session_id text,
  created_at timestamptz not null default now()
);

alter table plans enable row level security;
drop policy if exists "plans_v1_read" on plans;
create policy "plans_v1_read" on plans for select using (true);
drop policy if exists "plans_v1_write" on plans;
create policy "plans_v1_write" on plans for all using (true) with check (true);

insert into leads (name, company, email, status, score, score_source, score_confidence, notes) values
  ('Sarah Chen', 'Acme Robotics', 'sarah@acmerobotics.io', 'qualified', 72, 'rule_v1', 0.65, 'Interested in annual plan. Follow up after demo.'),
  ('Marcus Obi', 'Northstar Labs', 'marcus@northstarlabs.com', 'contacted', 37, 'rule_v1', 0.65, 'Replied to cold email. Needs pricing info.'),
  ('Priya Kapoor', 'Finledger', 'priya@finledger.co', 'new', 12, 'rule_v1', 0.65, 'Came in via Twitter DM.'),
  ('Tom Varga', 'Stackwave', 'tom@stackwave.dev', 'won', 90, 'rule_v1', 0.65, 'Closed last week. Upsell opportunity Q3.')
on conflict do nothing;

insert into activities (lead_id, type, body) values
  ((select id from leads where email='sarah@acmerobotics.io' limit 1), 'call', 'Intro call — 30 min. Positive signal.'),
  ((select id from leads where email='sarah@acmerobotics.io' limit 1), 'status_change', 'Status moved to Qualified.'),
  ((select id from leads where email='marcus@northstarlabs.com' limit 1), 'email', 'Sent pricing deck.')
on conflict do nothing;

insert into plans (status) values ('free') on conflict do nothing;