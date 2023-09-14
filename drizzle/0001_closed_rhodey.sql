CREATE TABLE IF NOT EXISTS "job" (
	"id" text PRIMARY KEY NOT NULL,
	"created_at" timestamp NOT NULL,
	"storeId" text NOT NULL,
	"created_by" text NOT NULL,
	"fileUrl" text NOT NULL,
	"pickup_date" timestamp,
	"pages_from" integer NOT NULL,
	"pages_to" integer NOT NULL,
	"color" boolean DEFAULT false NOT NULL,
	"duplex" boolean DEFAULT false NOT NULL,
	"copies" integer DEFAULT 1 NOT NULL,
	"status" varchar NOT NULL,
	"expires_at" timestamp NOT NULL
);
--> statement-breakpoint
CREATE TABLE IF NOT EXISTS "company" (
	"id" text PRIMARY KEY NOT NULL,
	"name" text NOT NULL,
	"owner" text NOT NULL,
	"created_at" timestamp NOT NULL,
	"updated_at" timestamp NOT NULL,
	"altitude" integer NOT NULL,
	"longitude" integer NOT NULL,
	"street" text NOT NULL,
	"streetNumber" text NOT NULL,
	"postalCode" text NOT NULL,
	"city" text NOT NULL,
	"country" text DEFAULT 'DE' NOT NULL,
	"phone" text NOT NULL,
	"email" text NOT NULL
);
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "job" ADD CONSTRAINT "job_storeId_company_id_fk" FOREIGN KEY ("storeId") REFERENCES "company"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "job" ADD CONSTRAINT "job_created_by_user_id_fk" FOREIGN KEY ("created_by") REFERENCES "user"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
