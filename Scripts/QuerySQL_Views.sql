/*Códigos com views criadas*/

-- View Horários de pico de acidentes
CREATE OR ALTER VIEW [schema_star].[View_HorarioPico_acidente]
AS 
SELECT 
    DATEPART(HOUR, Dim_Data.horario) AS hora, COUNT(*) AS total_acidentes
FROM 
    [dados_BrazilTraffic_Incidents].[schema_star].[Fatos_Acidentes]
JOIN 
    [dados_BrazilTraffic_Incidents].[schema_star].[Dim_Data] 
    ON Fatos_Acidentes.id_data = Dim_Data.id
GROUP BY   
    DATEPART(HOUR, Dim_Data.horario);

SELECT * FROM [schema_star].[View_HorarioPico_acidente]
ORDER BY total_acidentes DESC;

-- Meses com maior ocorrência de acidentes
CREATE OR ALTER VIEW [schema_star].[View_TotalAcidente_mes]
AS 
SELECT nome_mes, total_acidentes
FROM (
    SELECT
        DATENAME(MONTH, CONVERT(DATE, Dim_Data.data_inversa, 103)) AS nome_mes,
        COUNT(*) AS total_acidentes,
        ROW_NUMBER() OVER (PARTITION BY DATENAME(MONTH, CONVERT(DATE, Dim_Data.data_inversa, 103)) ORDER BY COUNT(*) DESC) AS rn
    FROM
        [dados_BrazilTraffic_Incidents].[schema_star].[Fatos_Acidentes]
        JOIN [dados_BrazilTraffic_Incidents].[schema_star].[Dim_Data] ON Fatos_Acidentes.id_data = Dim_Data.id
    GROUP BY
        DATENAME(MONTH, CONVERT(DATE, Dim_Data.data_inversa, 103))
) AS subquery
WHERE rn = 1;

SELECT * FROM [schema_star].[View_TotalAcidente_mes]
ORDER BY MONTH(DATEFROMPARTS(1, MONTH(DATEFROMPARTS(2000, MONTH(CONVERT(DATE, nome_mes + ' 1, 2000', 106)), 1)), 1));