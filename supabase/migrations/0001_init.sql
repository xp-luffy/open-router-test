create table if not exists leads (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  name text not null,
  company text,
  email text,
  status text not null default 'new',
  notes text,
  score numeric default 0,
  score_source text default 'rules_v1',
  score_confidence numeric default 0.75,
  score_review_status text default 'unreviewed',
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
  plan text default 'pro_monthly',
  status text default 'pending',
  activated_at timestamptz,
  created_at timestamptz not null default now()
);

alter table payments enable row level security;
drop policy if exists "payments_v1_read" on payments;
create policy "payments_v1_read" on payments for select using (true);
drop policy if exists "payments_v1_write" on payments;
create policy "payments_v1_write" on payments for all using (true) with check (true);

create or replace function compute_lead_score()
returns trigger language plpgsql as $$
declare
  s numeric := 0;
begin
  if new.company is not null and new.company <> '' then s := s + 20; end if;
  if new.email is not null and new.email not ilike '%gmail%' and new.email not ilike '%yahoo%' and new.email not ilike '%hotmail%' then s := s + 25; end if;
  if new.status = 'qualified' then s := s + 30;
  elsif new.status = 'contacted' then s := s + 15; end if;
  if new.notes is not null and new.notes <> '' then s := s + 5; end if;
  new.score := s;
  new.score_source := 'rules_v1';
  new.score_confidence := 0.75;
  return new;
end;
$$;

drop trigger if exists trg_lead_score on leads;
create trigger trg_lead_score
  before insert or update on leads
  for each row execute function compute_lead_score();

insert into leads (name, company, email, status, notes) values
  ('James Whitfield', 'Horizon Labs', 'james@horizonlabs.io', 'qualified', 'Met at SaaStr, strong intent'),
  ('Priya Nair', 'Stackflow Inc', 'priya@stackflow.com', 'contacted', 'Replied to cold email, wants demo'),
  ('Carlos Mendez', 'NovaBuild', 'carlos@novabuild.co', 'new', 'Signed up via landing page'),
  ('Aisha Okonkwo', 'Clearpath AI', 'aisha@clearpathAI.com', 'qualified', 'Inbound, budget confirmed'),
  ('Tom Regan', 'Freelance', 'tomregan82@gmail.com', 'new', '');