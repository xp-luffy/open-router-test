create table if not exists leads (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  name text not null,
  company text,
  email text,
  source text,
  status text not null default 'new',
  notes text,
  score numeric default 0,
  subscription_tier text default 'free',
  stripe_customer_id text,
  stripe_subscription_id text,
  subscription_active boolean default false,
  ai_summary text,
  ai_summary_source text,
  ai_summary_confidence numeric,
  ai_summary_review_status text default 'unreviewed',
  ai_next_action text,
  ai_next_action_source text,
  ai_next_action_confidence numeric,
  ai_next_action_review_status text default 'unreviewed'
);

alter table leads enable row level security;
drop policy if exists "leads_v1_read" on leads;
create policy "leads_v1_read" on leads for select using (true);
drop policy if exists "leads_v1_write" on leads;
create policy "leads_v1_write" on leads for all using (true) with check (true);

create table if not exists activities (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  lead_id uuid references leads(id) on delete cascade,
  type text not null,
  description text,
  occurred_at timestamptz default now()
);

alter table activities enable row level security;
drop policy if exists "activities_v1_read" on activities;
create policy "activities_v1_read" on activities for select using (true);
drop policy if exists "activities_v1_write" on activities;
create policy "activities_v1_write" on activities for all using (true) with check (true);

create table if not exists audit_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  action text not null,
  object_type text not null,
  object_id uuid,
  delta jsonb,
  risk_level text default 'low'
);

alter table audit_logs enable row level security;
drop policy if exists "audit_logs_v1_read" on audit_logs;
create policy "audit_logs_v1_read" on audit_logs for select using (true);
drop policy if exists "audit_logs_v1_write" on audit_logs;
create policy "audit_logs_v1_write" on audit_logs for all using (true) with check (true);

insert into leads (name, company, email, source, status, notes, score, subscription_active) values
  ('Sarah Chen', 'Acme Ventures', 'sarah@acmev.com', 'referral', 'qualified', 'Met at SaaStr. Very interested in the pipeline view. Follow up by Friday.', 82, false),
  ('Marcus Webb', 'Bloom Analytics', 'marcus@bloomanalytics.io', 'cold-outbound', 'contacted', 'Responded to LinkedIn message. Wants a demo next week.', 61, false),
  ('Priya Nair', 'NorthStar Labs', 'priya@northstarlabs.co', 'inbound', 'new', 'Signed up from the landing page. No contact yet.', 45, false),
  ('Daniel Ruiz', 'Foxhound Media', 'druiz@foxhoundmedia.com', 'referral', 'negotiating', 'Referred by Sarah Chen. Has budget. Sent proposal on Monday.', 91, false),
  ('Lena Fischer', 'Compact AI', 'lena@compactai.de', 'conference', 'closed-won', 'Closed after two calls. Paid annual plan. Great fit.', 100, true);

insert into activities (lead_id, type, description, occurred_at) values
  ((select id from leads where email = 'sarah@acmev.com'), 'meeting', 'Intro call — 30 min. Good energy, budget TBC.', now() - interval '3 days'),
  ((select id from leads where email = 'marcus@bloomanalytics.io'), 'email', 'Sent intro email with one-pager attached.', now() - interval '5 days'),
  ((select id from leads where email = 'druiz@foxhoundmedia.com'), 'proposal', 'Sent $299/mo proposal via email.', now() - interval '2 days'),
  ((select id from leads where email = 'lena@compactai.de'), 'call', 'Closing call. Agreed on annual plan.', now() - interval '10 days');