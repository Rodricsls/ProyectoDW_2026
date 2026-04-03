-- ============================================================
-- Silver Layer DDL — Sakila Schema (ClickHouse / ReplacingMergeTree)
-- All fields are NOT Nullable (cleaned/validated data).
-- Deduplication based on _processed_at (keeps latest version).
-- ============================================================

-- ---------- actor ----------
CREATE TABLE IF NOT EXISTS silver.actor (
    actor_id      Int32,
    first_name    String,
    last_name     String,
    last_update   DateTime,
    _processed_at DateTime DEFAULT now()
)
ENGINE = ReplacingMergeTree(_processed_at)
ORDER BY actor_id;

-- ---------- address ----------
CREATE TABLE IF NOT EXISTS silver.address (
    address_id    Int32,
    address       String,
    address2      String,
    district      String,
    city_id       Int32,
    postal_code   String,
    phone         String,
    location     String,
    last_update   DateTime,
    _processed_at DateTime DEFAULT now()
)
ENGINE = ReplacingMergeTree(_processed_at)
ORDER BY address_id;

-- ---------- category ----------
CREATE TABLE IF NOT EXISTS silver.category (
    category_id   Int32,
    name          String,
    last_update   DateTime,
    _processed_at DateTime DEFAULT now()
)
ENGINE = ReplacingMergeTree(_processed_at)
ORDER BY category_id;

-- ---------- city ----------
CREATE TABLE IF NOT EXISTS silver.city (
    city_id       Int32,
    city          String,
    country_id    Int32,
    last_update   DateTime,
    _processed_at DateTime DEFAULT now()
)
ENGINE = ReplacingMergeTree(_processed_at)
ORDER BY city_id;

-- ---------- country ----------
CREATE TABLE IF NOT EXISTS silver.country (
    country_id    Int32,
    country       String,
    last_update   DateTime,
    _processed_at DateTime DEFAULT now()
)
ENGINE = ReplacingMergeTree(_processed_at)
ORDER BY country_id;

-- ---------- customer ----------
CREATE TABLE IF NOT EXISTS silver.customer (
    customer_id   Int32,
    store_id      Int32,
    first_name    String,
    last_name     String,
    email         String,
    address_id    Int32,
    active        UInt8,
    create_date   DateTime,
    last_update   DateTime,
    _processed_at DateTime DEFAULT now()
)
ENGINE = ReplacingMergeTree(_processed_at)
ORDER BY customer_id;

-- ---------- film ----------
CREATE TABLE IF NOT EXISTS silver.film (
    film_id              Int32,
    title                String,
    description          String,
    release_year         Int32,
    language_id          Int32,
    original_language_id Int32,
    rental_duration      Int32,
    rental_rate          Decimal(4,2),
    length               Int32,
    replacement_cost     Decimal(5,2),
    rating               String,
    special_features     String,
    last_update          DateTime,
    _processed_at        DateTime DEFAULT now()
)
ENGINE = ReplacingMergeTree(_processed_at)
ORDER BY film_id;

-- ---------- film_actor ----------
CREATE TABLE IF NOT EXISTS silver.film_actor (
    actor_id      Int32,
    film_id       Int32,
    last_update   DateTime,
    _processed_at DateTime DEFAULT now()
)
ENGINE = ReplacingMergeTree(_processed_at)
ORDER BY (actor_id, film_id);

-- ---------- film_category ----------
CREATE TABLE IF NOT EXISTS silver.film_category (
    film_id       Int32,
    category_id   Int32,
    last_update   DateTime,
    _processed_at DateTime DEFAULT now()
)
ENGINE = ReplacingMergeTree(_processed_at)
ORDER BY (film_id, category_id);

-- ---------- film_text ----------
CREATE TABLE IF NOT EXISTS silver.film_text (
    film_id       Int32,
    title         String,
    description   String,
    _processed_at DateTime DEFAULT now()
)
ENGINE = ReplacingMergeTree(_processed_at)
ORDER BY film_id;

-- ---------- inventory ----------
CREATE TABLE IF NOT EXISTS silver.inventory (
    inventory_id  Int32,
    film_id       Int32,
    store_id      Int32,
    last_update   DateTime,
    _processed_at DateTime DEFAULT now()
)
ENGINE = ReplacingMergeTree(_processed_at)
ORDER BY inventory_id;

-- ---------- language ----------
CREATE TABLE IF NOT EXISTS silver.language (
    language_id   Int32,
    name          String,
    last_update   DateTime,
    _processed_at DateTime DEFAULT now()
)
ENGINE = ReplacingMergeTree(_processed_at)
ORDER BY language_id;

-- ---------- payment ----------
CREATE TABLE IF NOT EXISTS silver.payment (
    payment_id    Int32,
    customer_id   Int32,
    staff_id      Int32,
    rental_id     Int32,
    amount        Decimal(5,2),
    payment_date  DateTime,
    last_update   DateTime,
    _processed_at DateTime DEFAULT now()
)
ENGINE = ReplacingMergeTree(_processed_at)
ORDER BY payment_id;

-- ---------- rental ----------
CREATE TABLE IF NOT EXISTS silver.rental (
    rental_id     Int32,
    rental_date   DateTime,
    inventory_id  Int32,
    customer_id   Int32,
    return_date   DateTime,
    staff_id      Int32,
    last_update   DateTime,
    _processed_at DateTime DEFAULT now()
)
ENGINE = ReplacingMergeTree(_processed_at)
ORDER BY rental_id;

-- ---------- staff ----------
CREATE TABLE IF NOT EXISTS silver.staff (
    staff_id      Int32,
    first_name    String,
    last_name     String,
    address_id    Int32,
    picture       String,
    email         String,
    store_id      Int32,
    active        UInt8,
    username      String,
    password      String,
    last_update   DateTime,
    _processed_at DateTime DEFAULT now()
)
ENGINE = ReplacingMergeTree(_processed_at)
ORDER BY staff_id;

-- ---------- store ----------
CREATE TABLE IF NOT EXISTS silver.store (
    store_id         Int32,
    manager_staff_id Int32,
    address_id       Int32,
    last_update      DateTime,
    _processed_at    DateTime DEFAULT now()
)
ENGINE = ReplacingMergeTree(_processed_at)
ORDER BY store_id;