PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "schema_migrations" ("version" varchar NOT NULL PRIMARY KEY);
INSERT INTO schema_migrations VALUES('20241028180230');
INSERT INTO schema_migrations VALUES('20241029212412');
INSERT INTO schema_migrations VALUES('20241029212525');
INSERT INTO schema_migrations VALUES('20241029213941');
INSERT INTO schema_migrations VALUES('20241029214223');
INSERT INTO schema_migrations VALUES('20241111173057');
INSERT INTO schema_migrations VALUES('20241126234129');
INSERT INTO schema_migrations VALUES('20241127134142');
INSERT INTO schema_migrations VALUES('20241127135423');
INSERT INTO schema_migrations VALUES('20241127141408');
INSERT INTO schema_migrations VALUES('20241127165444');
INSERT INTO schema_migrations VALUES('20241127165452');
INSERT INTO schema_migrations VALUES('20241127172041');
INSERT INTO schema_migrations VALUES('20241128180111');
INSERT INTO schema_migrations VALUES('20241128181033');
INSERT INTO schema_migrations VALUES('20241128204831');
INSERT INTO schema_migrations VALUES('20241128210822');
INSERT INTO schema_migrations VALUES('20241218135846');
INSERT INTO schema_migrations VALUES('20241227165001');
INSERT INTO schema_migrations VALUES('20250121181118');
CREATE TABLE IF NOT EXISTS "ar_internal_metadata" ("key" varchar NOT NULL PRIMARY KEY, "value" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
INSERT INTO ar_internal_metadata VALUES('environment','development','2025-01-19 00:55:26.935046','2025-01-19 00:55:26.935046');
CREATE TABLE IF NOT EXISTS "categories" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "active_view_index" boolean);
INSERT INTO categories VALUES(1,'DVDs','2025-01-19 00:55:28.717130','2025-01-19 00:55:28.717130',NULL);
CREATE TABLE IF NOT EXISTS "cart_products" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "cart_id" integer NOT NULL, "product_id" integer NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "quantidade_produto_carrinho" integer, CONSTRAINT "fk_rails_a4f3e327f3"
FOREIGN KEY ("cart_id")
  REFERENCES "carts" ("id")
, CONSTRAINT "fk_rails_b6ff2a078a"
FOREIGN KEY ("product_id")
  REFERENCES "products" ("id")
);
INSERT INTO cart_products VALUES(1,1,1,'2025-01-19 01:03:10.905873','2025-01-19 01:03:10.905873',1);
INSERT INTO cart_products VALUES(2,1,2,'2025-01-19 01:03:10.928653','2025-01-19 01:03:10.928653',2);
CREATE TABLE IF NOT EXISTS "addresses" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "street" varchar, "cep" varchar, "state" varchar, "city" varchar, "bairro" varchar, "complemento" varchar, "number" integer, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "users" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "username" varchar, "password_digest" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
INSERT INTO users VALUES(1,'Admin','$2a$12$CKKweFd/Ip2QDK5BxsO9C.Dupp8wAb9boKN3u5xRST7iildnXBhPK','2025-01-19 01:03:56.219576','2025-01-19 01:03:56.219576');
CREATE TABLE IF NOT EXISTS "admins" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "username" varchar, "password_digest" varchar, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "carts" ("id" integer NOT NULL PRIMARY KEY, "status" varchar DEFAULT 'pending' NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "user_id" integer DEFAULT NULL, "subtotal" decimal, "total" decimal, CONSTRAINT "fk_rails_ea59a35211"
FOREIGN KEY ("user_id")
  REFERENCES "users" ("id")
);
INSERT INTO carts VALUES(1,'pending','2025-01-19 01:03:10.789483','2025-01-19 01:03:10.789483',NULL,415,NULL);
CREATE TABLE IF NOT EXISTS "active_storage_blobs" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "key" varchar NOT NULL, "filename" varchar NOT NULL, "content_type" varchar, "metadata" text, "service_name" varchar NOT NULL, "byte_size" bigint NOT NULL, "checksum" varchar, "created_at" datetime(6) NOT NULL);
CREATE TABLE IF NOT EXISTS "active_storage_attachments" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar NOT NULL, "record_type" varchar NOT NULL, "record_id" bigint NOT NULL, "blob_id" bigint NOT NULL, "created_at" datetime(6) NOT NULL, CONSTRAINT "fk_rails_c3b3935057"
FOREIGN KEY ("blob_id")
  REFERENCES "active_storage_blobs" ("id")
);
CREATE TABLE IF NOT EXISTS "active_storage_variant_records" ("id" integer PRIMARY KEY AUTOINCREMENT NOT NULL, "blob_id" bigint NOT NULL, "variation_digest" varchar NOT NULL, CONSTRAINT "fk_rails_993965df05"
FOREIGN KEY ("blob_id")
  REFERENCES "active_storage_blobs" ("id")
);
CREATE TABLE IF NOT EXISTS "orders" ("id" integer NOT NULL PRIMARY KEY, "cart_id" integer DEFAULT NULL, "status" varchar DEFAULT 'pending' NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "address_id" integer DEFAULT NULL, "user_id" integer DEFAULT NULL, CONSTRAINT "fk_rails_774ef80392"
FOREIGN KEY ("address_id")
  REFERENCES "addresses" ("id")
, CONSTRAINT "fk_rails_5cdf0e0ad4"
FOREIGN KEY ("cart_id")
  REFERENCES "carts" ("id")
, CONSTRAINT "fk_rails_f868b47f6a"
FOREIGN KEY ("user_id")
  REFERENCES "users" ("id")
);
CREATE TABLE IF NOT EXISTS "products" ("id" integer NOT NULL PRIMARY KEY, "name" varchar NOT NULL, "barcode" varchar DEFAULT NULL, "code" varchar NOT NULL, "size" varchar DEFAULT NULL, "color" varchar DEFAULT NULL, "description" text DEFAULT NULL, "size_description" text DEFAULT NULL, "active" boolean DEFAULT 1 NOT NULL, "quantity" integer DEFAULT 0 NOT NULL, "created_at" datetime(6) NOT NULL, "updated_at" datetime(6) NOT NULL, "category_id" integer NOT NULL, "preço_desconto" decimal DEFAULT NULL, "preço_custo" decimal DEFAULT NULL, "preço_final" decimal DEFAULT NULL, CONSTRAINT "fk_rails_fb915499a4"
FOREIGN KEY ("category_id")
  REFERENCES "categories" ("id")
);
INSERT INTO products VALUES(1,'Gorgeous Silk Lamp','1336618551917','668',NULL,NULL,NULL,NULL,1,0,'2025-01-19 00:55:30.824032','2025-01-19 00:55:30.824032',1,NULL,NULL,135);
INSERT INTO products VALUES(2,'Fantastic Linen Gloves','8890964024097','542',NULL,NULL,NULL,NULL,1,0,'2025-01-19 00:55:30.838193','2025-01-19 00:55:30.838193',1,NULL,NULL,140);
INSERT INTO products VALUES(3,'Intelligent Leather Shirt','8601945462537','986',NULL,NULL,NULL,NULL,1,0,'2025-01-19 00:55:30.849935','2025-01-19 00:55:30.849935',1,NULL,NULL,262);
INSERT INTO products VALUES(4,'Gorgeous Rubber Table','2253553785643','246',NULL,NULL,NULL,NULL,1,0,'2025-01-19 00:55:30.863792','2025-01-19 00:55:30.863792',1,NULL,NULL,285);
INSERT INTO products VALUES(5,'Gorgeous Marble Bench','1491078901815','210',NULL,NULL,NULL,NULL,1,0,'2025-01-19 00:55:30.880082','2025-01-19 00:55:30.880082',1,NULL,NULL,175);
INSERT INTO products VALUES(6,'Heavy Duty Rubber Pants','7961843771089','860',NULL,NULL,NULL,NULL,1,0,'2025-01-19 00:55:30.893596','2025-01-19 00:55:30.893596',1,NULL,NULL,248);
INSERT INTO products VALUES(7,'Synergistic Silk Keyboard','9985394990902','570',NULL,NULL,NULL,NULL,1,0,'2025-01-19 00:55:30.906614','2025-01-19 00:55:30.906614',1,NULL,NULL,150);
INSERT INTO products VALUES(8,'Mediocre Wooden Bag','9942097066273','772',NULL,NULL,NULL,NULL,1,0,'2025-01-19 00:55:30.918084','2025-01-19 00:55:30.918084',1,NULL,NULL,253);
INSERT INTO products VALUES(9,'Heavy Duty Steel Shirt','1369091797671','905',NULL,NULL,NULL,NULL,1,0,'2025-01-19 00:55:30.930010','2025-01-19 00:55:30.930010',1,NULL,NULL,234);
INSERT INTO products VALUES(10,'Synergistic Leather Pants','7912612222790','611',NULL,NULL,NULL,NULL,1,0,'2025-01-19 00:55:30.941314','2025-01-19 00:55:30.941314',1,NULL,NULL,131);
INSERT INTO products VALUES(11,'Sleek Wooden Watch','4441525721685','937',NULL,NULL,NULL,NULL,1,0,'2025-01-19 00:55:30.953160','2025-01-19 00:55:30.953160',1,NULL,NULL,297);
INSERT INTO products VALUES(12,'Practical Plastic Table','3920326344534','297',NULL,NULL,NULL,NULL,1,0,'2025-01-19 00:55:30.965739','2025-01-19 00:55:30.965739',1,NULL,NULL,166);
INSERT INTO products VALUES(13,'Awesome Aluminum Table','7983469301853','483',NULL,NULL,NULL,NULL,1,0,'2025-01-19 00:55:30.980451','2025-01-19 00:55:30.980451',1,NULL,NULL,284);
INSERT INTO products VALUES(14,'Aerodynamic Aluminum Knife','5612179894042','965',NULL,NULL,NULL,NULL,1,0,'2025-01-19 00:55:30.996980','2025-01-19 00:55:30.996980',1,NULL,NULL,134);
INSERT INTO products VALUES(15,'Synergistic Steel Plate','8166150285277','743',NULL,NULL,NULL,NULL,1,0,'2025-01-19 00:55:31.009422','2025-01-19 00:55:31.009422',1,NULL,NULL,138);
DELETE FROM sqlite_sequence;
INSERT INTO sqlite_sequence VALUES('categories',1);
INSERT INTO sqlite_sequence VALUES('cart_products',2);
INSERT INTO sqlite_sequence VALUES('users',1);
CREATE INDEX "index_cart_products_on_cart_id" ON "cart_products" ("cart_id");
CREATE INDEX "index_cart_products_on_product_id" ON "cart_products" ("product_id");
CREATE UNIQUE INDEX "unique_cart_product_index" ON "cart_products" ("cart_id", "product_id");
CREATE INDEX "index_carts_on_user_id" ON "carts" ("user_id");
CREATE UNIQUE INDEX "index_active_storage_blobs_on_key" ON "active_storage_blobs" ("key");
CREATE INDEX "index_active_storage_attachments_on_blob_id" ON "active_storage_attachments" ("blob_id");
CREATE UNIQUE INDEX "index_active_storage_attachments_uniqueness" ON "active_storage_attachments" ("record_type", "record_id", "name", "blob_id");
CREATE UNIQUE INDEX "index_active_storage_variant_records_uniqueness" ON "active_storage_variant_records" ("blob_id", "variation_digest");
CREATE INDEX "index_orders_on_cart_id" ON "orders" ("cart_id");
CREATE INDEX "index_orders_on_address_id" ON "orders" ("address_id");
CREATE INDEX "index_orders_on_user_id" ON "orders" ("user_id");
CREATE INDEX "index_products_on_category_id" ON "products" ("category_id");
COMMIT;
