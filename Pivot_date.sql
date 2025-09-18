-- SQLite
-- 1. Crear una tabla temporal
CREATE TABLE Sales2022_temp AS
SELECT
  IdSales,
  idCustomer,
  idProduct,
  quantity,
  total_price,
  -- Generar una fecha aleatoria en 2022
  date('2022-01-01', '+' || abs(random() % 365) || ' days') AS sale_date
FROM Sales2022;

-- 2. (Opcional) Eliminar algunos registros aleatoriamente para que no todos los clientes compren cada mes
--DELETE FROM Sales2022_temp
--WHERE abs(random()) % 4 = 0; -- Aproximadamente elimina el 25% de los registros

--2.1
-- Eliminar aproximadamente el 60% de los registros aleatoriamente
--DELETE FROM Sales2022_temp
--WHERE abs(random()) % 10 < 6;

-- 3. Reemplazar la tabla original
DROP TABLE Sales2022;
ALTER TABLE Sales2022_temp RENAME TO Sales2022;