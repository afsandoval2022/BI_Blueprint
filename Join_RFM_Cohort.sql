-- Crear tabla unida RFM y Cohort_Analysis
CREATE TABLE IF NOT EXISTS RFM_Cohort_Analysis AS
SELECT
    r.idCustomer,
    r.Recency,
    r.Frequency,
    r.Monetary,
    r.R_score,
    r.F_score,
    r.M_score,
    r.R_label,
    r.F_label,
    r.M_label,
    c.Estado_1,
    c.Estado_2,
    c.Estado_3,
    c.Estado_4,
    c.Estado_5,
    c.Estado_6,
    c.Estado_7,
    c.Estado_8,
    c.Estado_9,
    c.Estado_10,
    c.Estado_11,
    c.Estado_12
FROM RFM r
LEFT JOIN (
    -- Subquery from Cohort.sql to create Cohort_Analysis
    WITH base AS (
        SELECT
            idCustomer,
            enero, febrero, marzo, abril, mayo, junio, julio,
            agosto, septiembre, octubre, noviembre, diciembre
        FROM Customer_Months
    ),
    meses AS (
        SELECT idCustomer, 1 AS mes_num, enero      AS val FROM base
        UNION ALL SELECT idCustomer, 2, febrero    FROM base
        UNION ALL SELECT idCustomer, 3, marzo      FROM base
        UNION ALL SELECT idCustomer, 4, abril      FROM base
        UNION ALL SELECT idCustomer, 5, mayo       FROM base
        UNION ALL SELECT idCustomer, 6, junio      FROM base
        UNION ALL SELECT idCustomer, 7, julio      FROM base
        UNION ALL SELECT idCustomer, 8, agosto     FROM base
        UNION ALL SELECT idCustomer, 9, septiembre FROM base
        UNION ALL SELECT idCustomer, 10, octubre   FROM base
        UNION ALL SELECT idCustomer, 11, noviembre FROM base
        UNION ALL SELECT idCustomer, 12, diciembre FROM base
    ),
    calc AS (
        SELECT
            idCustomer,
            mes_num,
            val,
            LAG(val) OVER (PARTITION BY idCustomer ORDER BY mes_num) AS prev_val,
            MIN(CASE WHEN val = 1 THEN mes_num END)
                OVER (PARTITION BY idCustomer) AS first_active
        FROM meses
    ),
    estado AS (
        SELECT
            idCustomer,
            mes_num,
            CASE
                WHEN first_active IS NULL THEN 'Null'
                WHEN val = 1 AND prev_val IS NULL THEN 'Activo'
                WHEN val = 1 AND prev_val = 1 THEN 'Recompra'
                WHEN val = 0 AND prev_val = 1 THEN 'Desercion'
                WHEN val = 0 AND prev_val = 0 AND mes_num > first_active THEN 'Repite desersion'
                WHEN val = 1 AND prev_val = 0 AND mes_num = first_active THEN 'Activo'
                WHEN val = 1 AND prev_val = 0 AND mes_num > first_active THEN 'Regreso'
                ELSE 'Null'
            END AS estado
        FROM calc
    )
    SELECT
        idCustomer,
        MAX(CASE WHEN mes_num = 1  THEN estado END) AS Estado_1,
        MAX(CASE WHEN mes_num = 2  THEN estado END) AS Estado_2,
        MAX(CASE WHEN mes_num = 3  THEN estado END) AS Estado_3,
        MAX(CASE WHEN mes_num = 4  THEN estado END) AS Estado_4,
        MAX(CASE WHEN mes_num = 5  THEN estado END) AS Estado_5,
        MAX(CASE WHEN mes_num = 6  THEN estado END) AS Estado_6,
        MAX(CASE WHEN mes_num = 7  THEN estado END) AS Estado_7,
        MAX(CASE WHEN mes_num = 8  THEN estado END) AS Estado_8,
        MAX(CASE WHEN mes_num = 9  THEN estado END) AS Estado_9,
        MAX(CASE WHEN mes_num = 10 THEN estado END) AS Estado_10,
        MAX(CASE WHEN mes_num = 11 THEN estado END) AS Estado_11,
        MAX(CASE WHEN mes_num = 12 THEN estado END) AS Estado_12
    FROM estado
    GROUP BY idCustomer
) c ON r.idCustomer = c.idCustomer;