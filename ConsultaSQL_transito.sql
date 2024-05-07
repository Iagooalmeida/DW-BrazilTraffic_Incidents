--Estudo de padrões temporais
-- 1. Horários de pico de acidentes:
SELECT 
    DATEPART(HOUR, Dim_Data.horario) AS hora, COUNT(*) AS total_acidentes
FROM 
    [dados_BrazilTraffic_Incidents].[schema_star].[Fatos_Acidentes]
JOIN 
    [dados_BrazilTraffic_Incidents].[schema_star].[Dim_Data] 
    ON Fatos_Acidentes.id_data = Dim_Data.id
GROUP BY   
    DATEPART(HOUR, Dim_Data.horario)
ORDER BY total_acidentes DESC;

-- 2. Meses com maior ocorrência de acidentes
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
WHERE rn = 1
ORDER BY MONTH(DATEFROMPARTS(1, MONTH(DATEFROMPARTS(2000, MONTH(CONVERT(DATE, subquery.nome_mes + ' 1, 2000', 106)), 1)), 1));

-- 3. Número total de acidentes por dia da semana
SELECT 
    Dim_Data.dia_semana, COUNT(*) AS total_acidentes
FROM 
    [dados_BrazilTraffic_Incidents].[schema_star].[Fatos_Acidentes]
JOIN 
    [dados_BrazilTraffic_Incidents].[schema_star].[Dim_Data] ON Fatos_Acidentes.id_data = Dim_Data.id
GROUP BY 
    Dim_Data.dia_semana
ORDER BY 
    CASE Dim_Data.dia_semana
        WHEN 'segunda-feira' THEN 1
        WHEN 'terça-feira' THEN 2
        WHEN 'quarta-feira' THEN 3
        WHEN 'quinta-feira' THEN 4
        WHEN 'sexta-feira' THEN 5
        WHEN 'sábado' THEN 6
        WHEN 'domingo' THEN 7
    END;

-- 4. Número total de acidentes por dia da semana e condição meteorológica
SELECT 
    Dim_Data.dia_semana, 
    Dim_Condicoes.condicao_metereologica, 
    COUNT(*) AS total_acidentes
FROM 
    [dados_BrazilTraffic_Incidents].[schema_star].[Fatos_Acidentes]
JOIN 
    [dados_BrazilTraffic_Incidents].[schema_star].[Dim_Data] 
    ON Fatos_Acidentes.id_data = Dim_Data.id
JOIN 
    [dados_BrazilTraffic_Incidents].[schema_star].[Dim_Condicoes] 
    ON Fatos_Acidentes.id_condicoes = Dim_Condicoes.id
GROUP BY 
    Dim_Data.dia_semana, 
    Dim_Condicoes.condicao_metereologica
ORDER BY 
    CASE Dim_Data.dia_semana
        WHEN 'segunda-feira' THEN 1
        WHEN 'terça-feira' THEN 2
        WHEN 'quarta-feira' THEN 3
        WHEN 'quinta-feira' THEN 4
        WHEN 'sexta-feira' THEN 5
        WHEN 'sábado' THEN 6
        WHEN 'domingo' THEN 7
    END;

-- 5. Número total de acidentes por localização (estado)
SELECT 
    Dim_Localizacao.uf, COUNT(*) AS total_acidentes
FROM 
    [dados_BrazilTraffic_Incidents].[schema_star].[Fatos_Acidentes]
JOIN 
    [dados_BrazilTraffic_Incidents].[schema_star].[Dim_Localizacao] 
    ON Fatos_Acidentes.id_localizacao = Dim_Localizacao.id
GROUP BY Dim_Localizacao.uf;

-- 6. Número total de acidentes por tipo de radar
SELECT 
    Dim_Radar.tipo_de_radar, COUNT(*) AS total_acidentes
FROM 
    [dados_BrazilTraffic_Incidents].[schema_star].[Fatos_Acidentes]
JOIN 
    [dados_BrazilTraffic_Incidents].[schema_star].[Dim_Radar] 
    ON Fatos_Acidentes.id_radar = Dim_Radar.id_radar
GROUP BY Dim_Radar.tipo_de_radar;

-- 7.Consulta para encontrar o município com o maior número de mortes em acidentes
-- filtrado por um intervalo de datas:
SELECT 
    municipio, uf, Dim_Data.data_inversa AS datas, SUM(mortos) AS total_mortes
FROM 
    [dados_BrazilTraffic_Incidents].[schema_star].[Fatos_Acidentes]
JOIN 
    [dados_BrazilTraffic_Incidents].[schema_star].[Dim_Localizacao] 
    ON Fatos_Acidentes.id_localizacao = Dim_Localizacao.id 
JOIN 
    [dados_BrazilTraffic_Incidents].[schema_star].[Dim_Data] 
    ON Fatos_Acidentes.id_data = Dim_Data.id
WHERE 
    CONVERT(DATE, Dim_Data.data_inversa, 103) >= '2021-03-11' 
    AND CONVERT(DATE, Dim_Data.data_inversa, 103) <= '2021-12-31'
GROUP BY 
    municipio,
    uf,
    Dim_Data.data_inversa
ORDER BY total_mortes DESC;

-- 8.Consulta para obter a contagem de acidentes por estado e a causa de acidente, ordenados por estado
SELECT Dim_Localizacao.uf, Dim_Detalhes_Acidente.causa_acidente, COUNT(*) AS total_acidentes
FROM 
    [dados_BrazilTraffic_Incidents].[schema_star].[Fatos_Acidentes] Fatos_Acidentes
JOIN 
    [dados_BrazilTraffic_Incidents].[schema_star].[Dim_Localizacao] Dim_Localizacao 
    ON Fatos_Acidentes.id_localizacao = Dim_Localizacao.id
JOIN 
    [dados_BrazilTraffic_Incidents].[schema_star].[Dim_Detalhes_Acidente] Dim_Detalhes_Acidente 
    ON Fatos_Acidentes.id_acidente = Dim_Detalhes_Acidente.id
GROUP BY Dim_Localizacao.uf, Dim_Detalhes_Acidente.causa_acidente
ORDER BY Dim_Localizacao.uf;

