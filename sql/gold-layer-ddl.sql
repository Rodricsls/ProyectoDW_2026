-- Dimensión Cliente
CREATE TABLE IF NOT EXISTS gold.dim_customer (
    customer_key Int32,
    customer_id Int32,
    first_name String,
    last_name String,
    email String,
    active UInt8,
    address String,
    district String,
    postal_code String,
    phone String,
    city String,
    country String,
    _valid_from DateTime DEFAULT now()
)
ENGINE = ReplacingMergeTree(_valid_from)
ORDER BY customer_key;

-- Dimensión Película
CREATE TABLE IF NOT EXISTS gold.dim_film (
    film_key Int32,
    film_id Int32,
    title String,
    description String,
    release_year Int32,
    language_name String,
    original_language_name String,
    rental_duration Int32,
    rental_rate Decimal(4,2),
    length Int32,
    replacement_cost Decimal(5,2),
    rating String,
    special_features String,
    category_name String,
    _valid_from DateTime DEFAULT now()
)
ENGINE = ReplacingMergeTree(_valid_from)
ORDER BY film_key;

-- Dimensión Actor
CREATE TABLE IF NOT EXISTS gold.dim_actor (
    actor_key Int32,
    actor_id Int32,
    first_name String,
    last_name String,
    _valid_from DateTime DEFAULT now()
)
ENGINE = ReplacingMergeTree(_valid_from)
ORDER BY actor_key;

-- Dimensión Sucursal
CREATE TABLE IF NOT EXISTS gold.dim_store (
    store_key Int32,
    store_id Int32,
    address String,
    district String,
    postal_code String,
    phone String,
    city String,
    country String,
    manager_first_name String,
    manager_last_name String,
    _valid_from DateTime DEFAULT now()
)
ENGINE = ReplacingMergeTree(_valid_from)
ORDER BY store_key;

-- Dimensión Staff
CREATE TABLE IF NOT EXISTS gold.dim_staff (
    staff_key Int32,
    staff_id Int32,
    first_name String,
    last_name String,
    email String,
    username String,
    active UInt8,
    address String,
    district String,
    city String,
    country String,
    _valid_from DateTime DEFAULT now()
)
ENGINE = ReplacingMergeTree(_valid_from)
ORDER BY staff_key;

-- Dimensión Date 
CREATE TABLE IF NOT EXISTS gold.dim_date (
    date_key      Int32,
    full_date     Date,
    year          Int32,
    quarter       Int32,
    quarter_name  String,
    month         Int32,
    month_name    String,
    week          Int32,
    day           Int32,
    day_name      String,
    is_weekend    UInt8,
)
ENGINE = MergeTree()
ORDER BY date_key;


-- Fact table film_actor
CREATE TABLE IF NOT EXISTS gold.fact_film_actor (
    film_key Int32,
    actor_key Int32,
    _valid_from DateTime DEFAULT now()
)
ENGINE = ReplacingMergeTree(_valid_from)
ORDER BY (film_key, actor_key);

-- Fact table rental_payment
CREATE TABLE IF NOT EXISTS gold.fact_rental_payment (
    rental_id Int32,
    payment_id Int32,
    customer_key Int32,
    film_key Int32,
    store_key Int32,
    staff_key Int32,
    rental_date_key Int32,
    return_date_key Int32,
    payment_date_key Int32,
    inventory_id Int32,
    rental_date DateTime,
    return_date DateTime,
    payment_date DateTime,
    amount Decimal(5,2),
    rental_duration_actual Int32,
    is_overdue UInt8,
    is_returned UInt8,
    _valid_from DateTime DEFAULT now()
)
ENGINE = ReplacingMergeTree(_valid_from)
ORDER BY rental_id;