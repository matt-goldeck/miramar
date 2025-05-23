-- enum
create type "public"."application_outcome_enum" as enum ('ghosted', 'rejected', 'turned_down', 'accepted');

-- outcome table
create table "public"."application_outcome" (
    "id" bigint generated by default as identity not null,
    "created_at" timestamp with time zone not null default now(),
    "application_id" bigint not null,
    "notes" text,
    "outcome" application_outcome_enum not null
);

-- RLS
alter table "public"."application_outcome" enable row level security;
-- allow SELECT for owner
CREATE POLICY "Select own outcome"
ON public."application_outcome"
FOR SELECT
USING (
  (
    SELECT "application".user_id
    FROM public."application"
    WHERE "application".id = "application_outcome".application_id
  ) = auth.uid()
);

-- allow INSERT for owner
CREATE POLICY "Insert own outcome"
ON public."application_outcome"
FOR INSERT
WITH CHECK (
  (
    SELECT "application".user_id
    FROM public."application"
    WHERE "application".id = "application_outcome".application_id
  ) = auth.uid()
);

-- allow UPDATE for owner
CREATE POLICY "Update own outcome"
ON public."application_outcome"
FOR UPDATE
USING (
  (
    SELECT "application".user_id
    FROM public."application"
    WHERE "application".id = "application_outcome".application_id
  ) = auth.uid()
);

-- allow DELETE for owner
CREATE POLICY "Delete own outcome"
ON public."application_outcome"
FOR DELETE
USING (
  (
    SELECT "application".user_id
    FROM public."application"
    WHERE "application".id = "application_outcome".application_id
  ) = auth.uid()
);

-- Unicity -- one outcome per application
create unique index "application_outcome_application_id_key" on "public"."application_outcome" using btree (application_id);

-- PK
CREATE UNIQUE INDEX application_outcome_pkey ON public.application_outcome USING btree (id);
alter table "public"."application_outcome" add constraint "application_outcome_pkey" PRIMARY KEY using index "application_outcome_pkey";

-- FKs
alter table "public"."application_outcome" add constraint "application_outcome_application_id_fkey" FOREIGN KEY (application_id) REFERENCES application(id) ON UPDATE CASCADE ON DELETE CASCADE not valid;

alter table "public"."application_outcome" validate constraint "application_outcome_application_id_fkey";

-- role based access
grant all on table "public"."application_outcome" to "anon";
grant all on table "public"."application_outcome" to "authenticated";
grant all on table "public"."application_outcome" to "service_role";