# Amethyst SMP — Vercel + Supabase starter files

## Folder layout
- `public/index.html`: public site (preserves the purple Amethyst design and reads published server information).
- `admin/index.html`: Supabase email/password sign-in and server settings editor.
- `supabase/setup.sql`: row-level security policies. Replace the owner UUID before running it.

## Before deploying
1. In both HTML files replace `PASTE_YOUR_SUPABASE_PUBLISHABLE_KEY_HERE` with the project's **publishable** key from Supabase > Project Settings > API Keys. This key is designed to be public; NEVER use a `service_role` or secret key.
2. In Supabase Authentication, create an owner user and confirm the account. Copy that user's UUID from Authentication > Users.
3. Replace every `REPLACE_WITH_OWNER_USER_UUID` in `supabase/setup.sql` with the exact owner UUID, then run the SQL in Supabase SQL Editor.
4. Make sure the `public.server_info` table exists and has at least one row. Existing project setup is expected to include it.
5. Enable/verify email/password auth in Supabase. Add the admin site's exact Vercel URL to Authentication > URL Configuration > Redirect URLs if needed.

## Deploy one GitHub repository to two Vercel projects
Put these folders at the root of the same repository:
- `public/index.html`
- `admin/index.html`
- `supabase/setup.sql`

In Vercel project `amethyst-smp`, set Root Directory to `public`.
In Vercel project `amethyst-smp-admin`, set Root Directory to `admin`.
Set each project's Framework Preset to Other if needed. Since these are plain static HTML files, no build command is required and output directory can be left blank/default as appropriate.

## Important
The admin HTML is only the interface. The SQL owner policies are the actual database security boundary. Do not skip them. The public site only queries rows where `published = true`. The admin editor saves to the existing latest row.
