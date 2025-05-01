-- Drop FK on job_listing
alter table "public"."job_listing" drop constraint "job_listing_resume_id_fkey";
alter table "public"."job_listing" drop column "resume_id";

-- Add FK to application
alter table "public"."application" add column "resume_id" uuid;
alter table "public"."application" add constraint "application_resume_id_fkey" FOREIGN KEY (resume_id) REFERENCES resume(id) ON UPDATE CASCADE ON DELETE SET NULL not valid;
alter table "public"."application" validate constraint "application_resume_id_fkey";