-- Amethyst SMP Supabase setup
-- Run this in Supabase Dashboard > SQL Editor after replacing OWNER_USER_UUID below.
-- Find your user UUID in Authentication > Users after creating/signing into the owner account.
-- Do not add service_role keys to website files.

alter table public.server_info enable row level security;

-- Public site may read published records only.
drop policy if exists "Public can read published server info" on public.server_info;
create policy "Public can read published server info"
on public.server_info for select
to anon, authenticated
using (published = true);

-- Authenticated owner-only access. Replace the UUID literal below with your own Supabase Auth user UUID.
-- Repeat the owner check on SELECT/INSERT/UPDATE/DELETE so unapproved users cannot manage the row.
drop policy if exists "Owner can read all server info" on public.server_info;
create policy "Owner can read all server info"
on public.server_info for select
to authenticated
using (auth.uid() = 'REPLACE_WITH_OWNER_USER_UUID'::uuid);

drop policy if exists "Owner can insert server info" on public.server_info;
create policy "Owner can insert server info"
on public.server_info for insert
to authenticated
with check (auth.uid() = 'REPLACE_WITH_OWNER_USER_UUID'::uuid);

drop policy if exists "Owner can update server info" on public.server_info;
create policy "Owner can update server info"
on public.server_info for update
to authenticated
using (auth.uid() = 'REPLACE_WITH_OWNER_USER_UUID'::uuid)
with check (auth.uid() = 'REPLACE_WITH_OWNER_USER_UUID'::uuid);

drop policy if exists "Owner can delete server info" on public.server_info;
create policy "Owner can delete server info"
on public.server_info for delete
to authenticated
using (auth.uid() = 'REPLACE_WITH_OWNER_USER_UUID'::uuid);
