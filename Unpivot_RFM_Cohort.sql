-- Unpivot RFM_Cohort_Analysis para mostrar labels y scores por cada estado
SELECT
    idCustomer,
    'Estado_1' AS Estado_Column,
    'Enero' AS Fecha,
    Estado_1 AS Estado,
    R_label,
    F_label,
    M_label,
    (R_score || F_score || M_score) AS Scores_Concat
FROM RFM_Cohort_Analysis

UNION ALL

SELECT
    idCustomer,
    'Estado_2' AS Estado_Column,
    'Febrero' AS Fecha,
    Estado_2 AS Estado,
    R_label,
    F_label,
    M_label,
    (R_score || F_score || M_score) AS Scores_Concat
FROM RFM_Cohort_Analysis

UNION ALL

SELECT
    idCustomer,
    'Estado_3' AS Estado_Column,
    'Marzo' AS Fecha,
    Estado_3 AS Estado,
    R_label,
    F_label,
    M_label,
    (R_score || F_score || M_score) AS Scores_Concat
FROM RFM_Cohort_Analysis

UNION ALL

SELECT
    idCustomer,
    'Estado_4' AS Estado_Column,
    'Abril' AS Fecha,
    Estado_4 AS Estado,
    R_label,
    F_label,
    M_label,
    (R_score || F_score || M_score) AS Scores_Concat
FROM RFM_Cohort_Analysis

UNION ALL

SELECT
    idCustomer,
    'Estado_5' AS Estado_Column,
    'Mayo' AS Fecha,
    Estado_5 AS Estado,
    R_label,
    F_label,
    M_label,
    (R_score || F_score || M_score) AS Scores_Concat
FROM RFM_Cohort_Analysis

UNION ALL

SELECT
    idCustomer,
    'Estado_6' AS Estado_Column,
    'Junio' AS Fecha,
    Estado_6 AS Estado,
    R_label,
    F_label,
    M_label,
    (R_score || F_score || M_score) AS Scores_Concat
FROM RFM_Cohort_Analysis

UNION ALL

SELECT
    idCustomer,
    'Estado_7' AS Estado_Column,
    'Julio' AS Fecha,
    Estado_7 AS Estado,
    R_label,
    F_label,
    M_label,
    (R_score || F_score || M_score) AS Scores_Concat
FROM RFM_Cohort_Analysis

UNION ALL

SELECT
    idCustomer,
    'Estado_8' AS Estado_Column,
    'Agosto' AS Fecha,
    Estado_8 AS Estado,
    R_label,
    F_label,
    M_label,
    (R_score || F_score || M_score) AS Scores_Concat
FROM RFM_Cohort_Analysis

UNION ALL

SELECT
    idCustomer,
    'Estado_9' AS Estado_Column,
    'Septiembre' AS Fecha,
    Estado_9 AS Estado,
    R_label,
    F_label,
    M_label,
    (R_score || F_score || M_score) AS Scores_Concat
FROM RFM_Cohort_Analysis

UNION ALL

SELECT
    idCustomer,
    'Estado_10' AS Estado_Column,
    'Octubre' AS Fecha,
    Estado_10 AS Estado,
    R_label,
    F_label,
    M_label,
    (R_score || F_score || M_score) AS Scores_Concat
FROM RFM_Cohort_Analysis

UNION ALL

SELECT
    idCustomer,
    'Estado_11' AS Estado_Column,
    'Noviembre' AS Fecha,
    Estado_11 AS Estado,
    R_label,
    F_label,
    M_label,
    (R_score || F_score || M_score) AS Scores_Concat
FROM RFM_Cohort_Analysis

UNION ALL

SELECT
    idCustomer,
    'Estado_12' AS Estado_Column,
    'Diciembre' AS Fecha,
    Estado_12 AS Estado,
    R_label,
    F_label,
    M_label,
    (R_score || F_score || M_score) AS Scores_Concat
FROM RFM_Cohort_Analysis

ORDER BY idCustomer, Fecha;