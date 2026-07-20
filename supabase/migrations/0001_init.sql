create table if not exists leads (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  name text not null,
  email text not null,
  source text,
  status text not null default 'new',
  notes text,
  converted_at timestamptz,
  created_at timestamptz not null default now()
);

alter table leads enable row level security;
drop policy if exists "leads_v1_read" on leads;
create policy "leads_v1_read" on leads for select using (true);
drop policy if exists "leads_v1_write" on leads;
create policy "leads_v1_write" on leads for all using (true) with check (true);

create table if not exists payments (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  stripe_session_id text,
  stripe_customer_id text,
  amount_cents integer,
  currency text default 'usd',
  status text not null default 'pending',
  created_at timestamptz not null default now()
);

alter table payments enable row level security;
drop policy if exists "payments_v1_read" on payments;
create policy "payments_v1_read" on payments for select using (true);
drop policy if exists "payments_v1_write" on payments;
create policy "payments_v1_write" on payments for all using (true) with check (true);

insert into leads (id, name, email, source, status, notes) values
  ('a1000000-0000-0000-0000-000000000001', 'Priya Sharma', 'priya@examplefound.com', 'LinkedIn', 'qualified', 'Interested in the enterprise plan, follow up Thursday'),
  ('a1000000-0000-0000-0000-000000000002', 'Marcus Webb', 'marcus@launchpad.io', 'Cold email', 'contacted', 'Replied positively, waiting on budget approval'),
  ('a1000000-0000-0000-0000-000000000003', 'Sofia Reyes', 'sofia@buildco.dev', 'Referral', 'converted', 'Closed — paid annual'),
  ('a1000000-0000-0000-0000-000000000004', 'James Okafor', 'james@venturepath.co', 'Twitter', 'new', 'Found us via the Product Hunt launch'),
  ('a1000000-0000-0000-0000-000000000005', 'Anna Kowalski', 'anna@startupnest.pl', 'Conference', 'lost', 'Went with a competitor, revisit Q3');