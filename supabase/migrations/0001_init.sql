create table if not exists leads (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  name text not null,
  email text,
  company text,
  source text,
  status text not null default 'new',
  notes text,
  created_at timestamptz not null default now()
);

create table if not exists activities (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  lead_id uuid references leads(id) on delete cascade,
  action text not null,
  old_value text,
  new_value text,
  created_at timestamptz not null default now()
);

create table if not exists audit_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  table_name text not null,
  record_id uuid,
  action text not null,
  payload jsonb,
  created_at timestamptz not null default now()
);

create table if not exists lead_access (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  stripe_customer_id text,
  stripe_subscription_id text,
  plan text not null default 'free',
  paid_at timestamptz,
  created_at timestamptz not null default now()
);

alter table leads enable row level security;
alter table activities enable row level security;
alter table audit_logs enable row level security;
alter table lead_access enable row level security;

drop policy if exists "leads_v1_read" on leads;
create policy "leads_v1_read" on leads for select using (true);
drop policy if exists "leads_v1_write" on leads;
create policy "leads_v1_write" on leads for all using (true) with check (true);

drop policy if exists "activities_v1_read" on activities;
create policy "activities_v1_read" on activities for select using (true);
drop policy if exists "activities_v1_write" on activities;
create policy "activities_v1_write" on activities for all using (true) with check (true);

drop policy if exists "audit_logs_v1_read" on audit_logs;
create policy "audit_logs_v1_read" on audit_logs for select using (true);
drop policy if exists "audit_logs_v1_write" on audit_logs;
create policy "audit_logs_v1_write" on audit_logs for all using (true) with check (true);

drop policy if exists "lead_access_v1_read" on lead_access;
create policy "lead_access_v1_read" on lead_access for select using (true);
drop policy if exists "lead_access_v1_write" on lead_access;
create policy "lead_access_v1_write" on lead_access for all using (true) with check (true);

insert into leads (id, name, email, company, source, status, notes) values
  (gen_random_uuid(), 'Priya Sharma', 'priya@founderhq.io', 'FounderHQ', 'LinkedIn', 'qualified', 'Interested in annual plan'),
  (gen_random_uuid(), 'Marcus Webb', 'marcus@launchfast.co', 'LaunchFast', 'Cold outreach', 'new', null),
  (gen_random_uuid(), 'Sofia Chen', 'sofia@arcstudio.com', 'Arc Studio', 'Referral', 'negotiating', 'Needs team pricing'),
  (gen_random_uuid(), 'James Okafor', 'james@zeroday.vc', 'ZeroDay VC', 'Conference', 'won', 'Paid - annual'),
  (gen_random_uuid(), 'Lena Müller', 'lena@stackbloom.de', 'Stackbloom', 'Product Hunt', 'new', null);