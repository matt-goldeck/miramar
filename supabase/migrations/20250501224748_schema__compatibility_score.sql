-- Create table
create table "public"."compatibility_score" (
    "id" bigint generated by default as identity not null,
    "created_at" timestamp with time zone not null default now(),
    "job_listing_id" uuid not null,
    "resume_id" uuid not null,
    "total_score" smallint not null,
    "explanation" text not null,
    "score_breakdown" jsonb not null
);

-- RLS
alter table "public"."compatibility_score" enable row level security;
-- allow SELECT for owner
CREATE POLICY "Select own compatibility_score"
ON public."compatibility_score"
FOR SELECT
USING (
  (
    SELECT "resume"."user_id"
    FROM public."resume"
    WHERE "resume".id = "compatibility_score".resume_id
  ) = auth.uid()
);
-- allow INSERT for owner
CREATE POLICY "Insert own compatibility_score"
ON public."compatibility_score"
FOR INSERT
WITH CHECK (
  (
    SELECT "resume"."user_id"
    FROM public."resume"
    WHERE "resume".id = "compatibility_score".resume_id
  ) = auth.uid()
);
-- allow UPDATE for owner
CREATE POLICY "Update own compatibility_score"
ON public."compatibility_score"
FOR UPDATE
USING (
  (
    SELECT "resume"."user_id"
    FROM public."resume"
    WHERE "resume".id = "compatibility_score".resume_id
  ) = auth.uid()
);
-- allow DELETE for owner
CREATE POLICY "Delete own compatibility_score"
ON public."compatibility_score"
FOR DELETE
USING (
  (
    SELECT "resume"."user_id"
    FROM public."resume"
    WHERE "resume".id = "compatibility_score".resume_id
  ) = auth.uid()
);

-- PK
CREATE UNIQUE INDEX compatibility_score_pkey ON public.compatibility_score USING btree (id);
alter table "public"."compatibility_score" add constraint "compatibility_score_pkey" PRIMARY KEY using index "compatibility_score_pkey";

-- FKs to resume and job_listing
alter table "public"."compatibility_score" add constraint "compatibility_score_job_listing_id_fkey" FOREIGN KEY (job_listing_id) REFERENCES job_listing(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;
alter table "public"."compatibility_score" validate constraint "compatibility_score_job_listing_id_fkey";
alter table "public"."compatibility_score" add constraint "compatibility_score_resume_id_fkey" FOREIGN KEY (resume_id) REFERENCES resume(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;
alter table "public"."compatibility_score" validate constraint "compatibility_score_resume_id_fkey";

-- Unicity: one score per job listing and resume
create unique index "compatibility_score_job_listing_id_resume_id_key" on "public"."compatibility_score" using btree (job_listing_id, resume_id);

-- role based access
grant all on table "public"."compatibility_score" to "anon";
grant all on table "public"."compatibility_score" to "authenticated";
grant all on table "public"."compatibility_score" to "service_role";