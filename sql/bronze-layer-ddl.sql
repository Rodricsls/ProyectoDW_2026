-- ============================================================
-- Bronze Layer DDL — Sakila Schema (ClickHouse / MergeTree)
-- All business fields are Nullable except the ORDER BY key.
-- Metadata columns _ingested_at and _source appended to each table.
-- ============================================================

-- ---------- actor ----------
CREATE TABLE IF NOT EXISTS bronze.raw_actor (
    actor_id     Int32,
    first_name   Nullable(String),
    last_name    Nullable(String),
    last_update  Nullable(DateTime),
    _ingested_at DateTime DEFAULT now(),
    _source      String   DEFAULT 'mysql'
)
ENGINE = MergeTree()
ORDER BY actor_id;

-- ---------- address ----------
CREATE TABLE IF NOT EXISTS bronze.raw_address (
    address_id   Int32,
    address      Nullable(String),
    address2     Nullable(String),
    district     Nullable(String),
    city_id      Nullable(Int32),
    postal_code  Nullable(String),
    phone        Nullable(String),
    location     Nullable(String),
    last_update  Nullable(DateTime),
    _ingested_at DateTime DEFAULT now(),
    _source      String   DEFAULT 'mysql'
)
ENGINE = MergeTree()
ORDER BY address_id;

-- ---------- category ----------
CREATE TABLE IF NOT EXISTS bronze.raw_category (
    category_id  Int32,
    name         Nullable(String),
    last_update  Nullable(DateTime),
    _ingested_at DateTime DEFAULT now(),
    _source      String   DEFAULT 'mysql'
)
ENGINE = MergeTree()
ORDER BY category_id;

-- ---------- city ----------
CREATE TABLE IF NOT EXISTS bronze.raw_city (
    city_id      Int32,
    city         Nullable(String),
    country_id   Nullable(Int32),
    last_update  Nullable(DateTime),
    _ingested_at DateTime DEFAULT now(),
    _source      String   DEFAULT 'mysql'
)
ENGINE = MergeTree()
ORDER BY city_id;

-- ---------- country ----------
CREATE TABLE IF NOT EXISTS bronze.raw_country (
    country_id   Int32,
    country      Nullable(String),
    last_update  Nullable(DateTime),
    _ingested_at DateTime DEFAULT now(),
    _source      String   DEFAULT 'mysql'
)
ENGINE = MergeTree()
ORDER BY country_id;

-- ---------- customer ----------
CREATE TABLE IF NOT EXISTS bronze.raw_customer (
    customer_id  Int32,
    store_id     Nullable(Int32),
    first_name   Nullable(String),
    last_name    Nullable(String),
    email        Nullable(String),
    address_id   Nullable(Int32),
    active       Nullable(UInt8),
    create_date  Nullable(DateTime),
    last_update  Nullable(DateTime),
    _ingested_at DateTime DEFAULT now(),
    _source      String   DEFAULT 'mysql'
)
ENGINE = MergeTree()
ORDER BY customer_id;

-- ---------- film ----------
CREATE TABLE IF NOT EXISTS bronze.raw_film (
    film_id              Int32,
    title                Nullable(String),
    description          Nullable(String),
    release_year         Nullable(Int32),
    language_id          Nullable(Int32),
    original_language_id Nullable(Int32),
    rental_duration      Nullable(Int32),
    rental_rate          Nullable(Decimal(4,2)),
    length               Nullable(Int32),
    replacement_cost     Nullable(Decimal(5,2)),
    rating               Nullable(String),
    special_features     Nullable(String),
    last_update          Nullable(DateTime),
    _ingested_at         DateTime DEFAULT now(),
    _source              String   DEFAULT 'mysql'
)
ENGINE = MergeTree()
ORDER BY film_id;

-- ---------- film_actor ----------
CREATE TABLE IF NOT EXISTS bronze.raw_film_actor (
    actor_id     Int32,
    film_id      Int32,
    last_update  Nullable(DateTime),
    _ingested_at DateTime DEFAULT now(),
    _source      String   DEFAULT 'mysql'
)
ENGINE = MergeTree()
ORDER BY (actor_id, film_id);

-- ---------- film_category ----------
CREATE TABLE IF NOT EXISTS bronze.raw_film_category (
    film_id      Int32,
    category_id  Int32,
    last_update  Nullable(DateTime),
    _ingested_at DateTime DEFAULT now(),
    _source      String   DEFAULT 'mysql'
)
ENGINE = MergeTree()
ORDER BY (film_id, category_id);

-- ---------- film_text ----------
CREATE TABLE IF NOT EXISTS bronze.raw_film_text (
    film_id      Int32,
    title        Nullable(String),
    description  Nullable(String),
    _ingested_at DateTime DEFAULT now(),
    _source      String   DEFAULT 'mysql'
)
ENGINE = MergeTree()
ORDER BY film_id;

-- ---------- inventory ----------
CREATE TABLE IF NOT EXISTS bronze.raw_inventory (
    inventory_id Int32,
    film_id      Nullable(Int32),
    store_id     Nullable(Int32),
    last_update  Nullable(DateTime),
    _ingested_at DateTime DEFAULT now(),
    _source      String   DEFAULT 'mysql'
)
ENGINE = MergeTree()
ORDER BY inventory_id;

-- ---------- language ----------
CREATE TABLE IF NOT EXISTS bronze.raw_language (
    language_id  Int32,
    name         Nullable(String),
    last_update  Nullable(DateTime),
    _ingested_at DateTime DEFAULT now(),
    _source      String   DEFAULT 'mysql'
)
ENGINE = MergeTree()
ORDER BY language_id;

-- ---------- payment ----------
CREATE TABLE IF NOT EXISTS bronze.raw_payment (
    payment_id   Int32,
    customer_id  Nullable(Int32),
    staff_id     Nullable(Int32),
    rental_id    Nullable(Int32),
    amount       Nullable(Decimal(5,2)),
    payment_date Nullable(DateTime),
    last_update  Nullable(DateTime),
    _ingested_at DateTime DEFAULT now(),
    _source      String   DEFAULT 'mysql'
)
ENGINE = MergeTree()
ORDER BY payment_id;

-- ---------- rental ----------
CREATE TABLE IF NOT EXISTS bronze.raw_rental (
    rental_id    Int32,
    rental_date  Nullable(DateTime),
    inventory_id Nullable(Int32),
    customer_id  Nullable(Int32),
    return_date  Nullable(DateTime),
    staff_id     Nullable(Int32),
    last_update  Nullable(DateTime),
    _ingested_at DateTime DEFAULT now(),
    _source      String   DEFAULT 'mysql'
)
ENGINE = MergeTree()
ORDER BY rental_id;

-- ---------- staff ----------
CREATE TABLE IF NOT EXISTS bronze.raw_staff (
    staff_id     Int32,
    first_name   Nullable(String),
    last_name    Nullable(String),
    address_id   Nullable(Int32),
    picture      Nullable(String),
    email        Nullable(String),
    store_id     Nullable(Int32),
    active       Nullable(UInt8),
    username     Nullable(String),
    password     Nullable(String),
    last_update  Nullable(DateTime),
    _ingested_at DateTime DEFAULT now(),
    _source      String   DEFAULT 'mysql'
)
ENGINE = MergeTree()
ORDER BY staff_id;

-- ---------- store ----------
CREATE TABLE IF NOT EXISTS bronze.raw_store (
    store_id         Int32,
    manager_staff_id Nullable(Int32),
    address_id       Nullable(Int32),
    last_update      Nullable(DateTime),
    _ingested_at     DateTime DEFAULT now(),
    _source          String   DEFAULT 'mysql'
)
ENGINE = MergeTree()
ORDER BY store_id;