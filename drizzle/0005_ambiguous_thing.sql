CREATE TABLE IF NOT EXISTS "storePricingRule" (
	"id" text PRIMARY KEY NOT NULL,
	"storeId" text NOT NULL,
	"paperSize" varchar NOT NULL,
	"type" varchar NOT NULL,
	"priceInCents" integer NOT NULL,
	"quanitityFrom" integer NOT NULL
);
--> statement-breakpoint
ALTER TABLE "company" RENAME TO "store";--> statement-breakpoint
ALTER TABLE "job" DROP CONSTRAINT "job_storeId_company_id_fk";
--> statement-breakpoint
ALTER TABLE "job" ADD COLUMN "priceInCents" integer NOT NULL;--> statement-breakpoint
ALTER TABLE "job" ADD COLUMN "paperSize" varchar NOT NULL;--> statement-breakpoint
ALTER TABLE "store" ADD COLUMN "supportedPaperSizes" json DEFAULT '["A4"]'::json NOT NULL;--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "job" ADD CONSTRAINT "job_storeId_store_id_fk" FOREIGN KEY ("storeId") REFERENCES "store"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
--> statement-breakpoint
DO $$ BEGIN
 ALTER TABLE "storePricingRule" ADD CONSTRAINT "storePricingRule_storeId_store_id_fk" FOREIGN KEY ("storeId") REFERENCES "store"("id") ON DELETE cascade ON UPDATE no action;
EXCEPTION
 WHEN duplicate_object THEN null;
END $$;
