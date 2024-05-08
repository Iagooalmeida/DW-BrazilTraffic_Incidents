CREATE SCHEMA [schema_star]
GO

SELECT * FROM LakehouseBrazilTraffic_Incidents.dbo.dados_radares;

CREATE TABLE [dados_BrazilTraffic_Incidents].[dbo].[tb_radares] AS
        (SELECT * FROM LakehouseBrazilTraffic_Incidents.dbo.dados_radares)

-- Juntar as tabelas com os dados do acidente em uma tabela só
SELECT * FROM LakehouseBrazilTraffic_Incidents.dbo.dados_prf_2018
UNION ALL
SELECT * FROM LakehouseBrazilTraffic_Incidents.dbo.dados_prf_2019
UNION ALL
SELECT * FROM LakehouseBrazilTraffic_Incidents.dbo.dados_prf_2020
UNION ALL
SELECT * FROM LakehouseBrazilTraffic_Incidents.dbo.dados_prf_2021
UNION ALL
SELECT * FROM LakehouseBrazilTraffic_Incidents.dbo.dados_prf_2022
UNION ALL
SELECT * FROM LakehouseBrazilTraffic_Incidents.dbo.dados_prf_2023;

--Selecionar as colunas que serão utilizadas para a criação das dimensões e fatos
SELECT id, data_inversa, dia_semana, horario
INTO [dados_BrazilTraffic_Incidents].[schema_star].[Dim_Data]
FROM [dados_BrazilTraffic_Incidents].[dbo].[tb_dados_transito];

SELECT id, uf, br, km, municipio, latitude, longitude
INTO [dados_BrazilTraffic_Incidents].[schema_star].[Dim_Localizacao]
FROM [dados_BrazilTraffic_Incidents].[dbo].[tb_dados_transito];

SELECT id, condicao_metereologica, tipo_pista, tracado_via, uso_solo
INTO [dados_BrazilTraffic_Incidents].[schema_star].[Dim_Condicoes]
FROM [dados_BrazilTraffic_Incidents].[dbo].[tb_dados_transito];

SELECT id_radar, concessionaria, ano_do_pnv_snv, tipo_de_radar, rodovia, uf, km_m, 
        municipio, tipo_pista, sentido, situacao, data_da_inativacao, latitude, 
        longitude, velocidade_leve, velocidade_pesado
INTO [dados_BrazilTraffic_Incidents].[schema_star].[Dim_Radar]
FROM [dados_BrazilTraffic_Incidents].[dbo].[tb_radares];

SELECT id, causa_acidente, tipo_acidente, classificacao_acidente, fase_dia, sentido_via
INTO [dados_BrazilTraffic_Incidents].[schema_star].[Dim_Detalhes_Acidente]
FROM [dados_BrazilTraffic_Incidents].[dbo].[tb_dados_transito];

SELECT tb_dados_transito.id AS id_acidente, tb_radares.id_radar, tb_dados_transito.id AS id_data, 
       tb_dados_transito.id AS id_localizacao, tb_dados_transito.id AS id_condicoes, 
       mortos, feridos_leves, feridos_graves, ilesos, ignorados, feridos, veiculos
INTO [dados_BrazilTraffic_Incidents].[schema_star].[Fatos_Acidentes]
FROM [dados_BrazilTraffic_Incidents].[dbo].[tb_dados_transito]
JOIN [dados_BrazilTraffic_Incidents].[dbo].[tb_radares]
ON tb_dados_transito.uf = tb_radares.uf AND LOWER(tb_dados_transito.municipio) = LOWER(tb_radares.municipio);

