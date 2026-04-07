-- a) ¿Cuál es el top 10 de las películas que más se rentan?
SELECT
    f.title,
    COUNT(*) AS total_rentas
FROM gold.fact_rental_payment frp
JOIN gold.dim_film f ON frp.film_key = f.film_key
GROUP BY f.title
ORDER BY total_rentas DESC
LIMIT 10;


-- b) ¿Cuál es el país donde más se rentan películas?
SELECT
    c.country,
    COUNT(*) AS total_rentas
FROM gold.fact_rental_payment frp
JOIN gold.dim_customer c ON frp.customer_key = c.customer_key
GROUP BY c.country
ORDER BY total_rentas DESC
LIMIT 1;


-- c) ¿Muestre una lista con los montos totales pagados por todos los clientes?
SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    SUM(frp.amount) AS monto_total
FROM gold.fact_rental_payment frp
JOIN gold.dim_customer c ON frp.customer_key = c.customer_key
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY monto_total DESC;


-- d) ¿Cuál es el actor que más rentas ha registrado?
SELECT
    a.actor_id,
    a.first_name,
    a.last_name,
    COUNT(*) AS total_rentas
FROM gold.fact_rental_payment frp
JOIN gold.fact_film_actor ffa ON frp.film_key = ffa.film_key
JOIN gold.dim_actor a ON ffa.actor_key = a.actor_key
GROUP BY a.actor_id, a.first_name, a.last_name
ORDER BY total_rentas DESC
LIMIT 1;


-- e) Muestre una gráfica de serie temporal de montos cobrados por mes
SELECT
    d.year,
    d.month,
    d.month_name,
    SUM(frp.amount) AS monto_total
FROM gold.fact_rental_payment frp
JOIN gold.dim_date d ON frp.payment_date_key = d.date_key
GROUP BY d.year, d.month, d.month_name
ORDER BY d.year, d.month;