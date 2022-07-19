CREATE TABLE "users" (
  "id" bigserial PRIMARY KEY,
  "name" varchar NOT NULL,
  "email" varchar UNIQUE NOT NULL,
  "created_at" timestamptz DEFAULT (now())
);

CREATE TABLE "bucketlists" (
  "id" bigserial PRIMARY KEY,
  "name" varchar NOT NULL,
  "created_at" timestamptz DEFAULT (now()),
  "owner_id" bigint NOT NULL
);

CREATE TABLE "countries" (
  "code" bigserial PRIMARY KEY,
  "name" varchar,
  "continent_name" varchar
);

CREATE TABLE "bucketlist_items" (
  "id" bigserial PRIMARY KEY,
  "name" varchar NOT NULL,
  "category" varchar NOT NULL,
  "location" bigint,
  "created_at" timestamptz NOT NULL DEFAULT (now())
);

CREATE TABLE "users_bucketlist_items" (
  "id" SERIAL PRIMARY KEY,
  "owner_id" bigint NOT NULL,
  "bucketlist_id" bigint NOT NULL,
  "bucketlist_item_id" bigint NOT NULL,
  "completed" boolean NOT NULL,
  "completed_on" timestamptz DEFAULT null,
  "created_at" timestamp DEFAULT (now())
);

CREATE INDEX ON "users" ("email");

CREATE INDEX ON "bucketlist_items" ("name");

CREATE INDEX ON "bucketlist_items" ("category");

CREATE INDEX ON "users_bucketlist_items" ("owner_id");

CREATE INDEX ON "users_bucketlist_items" ("bucketlist_item_id");

CREATE INDEX ON "users_bucketlist_items" ("owner_id", "bucketlist_item_id");

COMMENT ON COLUMN "bucketlist_items"."category" IS 'must have at least one';

ALTER TABLE "bucketlists" ADD FOREIGN KEY ("owner_id") REFERENCES "users" ("id");

ALTER TABLE "bucketlist_items" ADD FOREIGN KEY ("location") REFERENCES "countries" ("code");

ALTER TABLE "users_bucketlist_items" ADD FOREIGN KEY ("owner_id") REFERENCES "users" ("id");

ALTER TABLE "users_bucketlist_items" ADD FOREIGN KEY ("bucketlist_id") REFERENCES "bucketlists" ("id");

ALTER TABLE "users_bucketlist_items" ADD FOREIGN KEY ("bucketlist_item_id") REFERENCES "bucketlist_items" ("id");
