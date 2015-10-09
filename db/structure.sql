CREATE TABLE "categories" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "title" varchar(255) NOT NULL);
CREATE TABLE "credentials" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "login" varchar(100), "password" varchar(500), "site" varchar(200), "user_id" integer(15), "category_id" integer);
CREATE TABLE "messages" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "sender_id" integer, "recipient_id" integer, "sender_deleted" boolean DEFAULT 'f', "recipient_deleted" boolean DEFAULT 'f', "subject" varchar(255), "body" text, "read_at" datetime, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE [notes] (
  [id] INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, 
  [created_at] datetime NOT NULL, 
  [updated_at] datetime NOT NULL, 
  [title] varchar(50) NOT NULL, 
  [body] text(1000), 
  [user_id] integer(19) NOT NULL, 
  [category_id] integer(19));
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "sessions" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "session_id" varchar(255) NOT NULL, "data" text, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "tasks" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "login" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "password" varchar(200), "email" varchar(100) NOT NULL);
CREATE INDEX "index_sessions_on_session_id" ON "sessions" ("session_id");
CREATE INDEX "index_sessions_on_updated_at" ON "sessions" ("updated_at");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20140201113241');

INSERT INTO schema_migrations (version) VALUES ('20140521232453');

INSERT INTO schema_migrations (version) VALUES ('20140621023109');

INSERT INTO schema_migrations (version) VALUES ('20140629152007');

INSERT INTO schema_migrations (version) VALUES ('20150926230955');