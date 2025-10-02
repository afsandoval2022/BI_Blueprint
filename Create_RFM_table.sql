-- SQLite
-- Actualizar R_score y R_label basado en Recency
Create table RFM as
SET
    R_score = CASE
        WHEN Recency <= 6  THEN 4
        WHEN Recency <= 13 THEN 3
        WHEN Recency <= 26 THEN 2
        ELSE 1
    END,
    R_label = CASE
        WHEN Recency <= 6  THEN 'Más reciente'
        WHEN Recency <= 13 THEN 'Moderadamente reciente'
        WHEN Recency <= 26 THEN 'Poco reciente'
        ELSE 'Menos reciente'
    END;

-- Actualizar F_score y F_label basado en Frequency
UPDATE RFM
SET
    F_score = CASE
        WHEN Frequency <= 17 THEN 1
        WHEN Frequency <= 19 THEN 2
        WHEN Frequency <= 22 THEN 3
        ELSE 4
    END,
    F_label = CASE
        WHEN Frequency <= 17 THEN 'Menos frecuente'
        WHEN Frequency <= 19 THEN 'Baja frecuencia'
        WHEN Frequency <= 22 THEN 'Moderada frecuencia'
        ELSE 'Más frecuente'
    END;

-- Actualizar M_score y M_label basado en Monetary
UPDATE RFM
SET
    M_score = CASE
        WHEN Monetary <= 1075 THEN 1
        WHEN Monetary <= 1182 THEN 2
        WHEN Monetary <= 1345 THEN 3
        ELSE 4
    END,
    M_label = CASE
        WHEN Monetary <= 1075 THEN 'Menor gasto'
        WHEN Monetary <= 1182 THEN 'Bajo gasto'
        WHEN Monetary <= 1345 THEN 'Moderado gasto'
        ELSE 'Mayor gasto'
    END;
