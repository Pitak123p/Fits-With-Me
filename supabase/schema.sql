-- MyFit account data: each signed-in user can access only their own row.
create table if not exists public.myfit_user_data (
  user_id uuid primary key references auth.users (id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.myfit_user_data enable row level security;

revoke all on public.myfit_user_data from anon, authenticated;
grant select, insert, update on public.myfit_user_data to authenticated;

drop policy if exists "read own MyFit data" on public.myfit_user_data;
create policy "read own MyFit data"
  on public.myfit_user_data for select to authenticated
  using ((select auth.uid()) = user_id);

drop policy if exists "insert own MyFit data" on public.myfit_user_data;
create policy "insert own MyFit data"
  on public.myfit_user_data for insert to authenticated
  with check ((select auth.uid()) = user_id);

drop policy if exists "update own MyFit data" on public.myfit_user_data;
create policy "update own MyFit data"
  on public.myfit_user_data for update to authenticated
  using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);
