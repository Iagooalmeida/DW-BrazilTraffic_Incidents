# Análise de Incidentes de Trânsito no Brasil  

*Dados dos Dados Abertos da PRF 2018-2023 (Polícia Rodoviária Federal)*  

**Data do Relatório:** 08/05/2024  

## Sobre o conjunto de dados  

O conjunto de dados de Incidentes de Trânsito no Brasil abrange uma ampla gama de informações relacionadas aos incidentes de trânsito ocorridos no país nos últimos seis anos. Esses dados fornecem uma visão abrangente do comportamento do tráfego no Brasil, permitindo a análise de tendências, identificação de rodovias perigosas e uma compreensão mais profunda das características do tráfego nas rodovias brasileiras.
  
## Descrição dos Dados  

Os dados incluem uma variedade de informações detalhadas sobre os incidentes de trânsito, como localização específica das rodovias, data, hora, tipo de incidente, causa e número de feridos. As informações de localização abrangem cidade, estado e coordenadas geográficas, permitindo uma análise precisa da distribuição geográfica dos incidentes.

## Fonte dos Dados  

[Link da base de dados](https://www.kaggle.com/datasets/tgomesjuliana/police-traffic-incidents?select=Dados_PRF_2023.csv)  

## Conjunto de Dados Modelo Estrela DW

O conjunto de dados utilizado neste projeto é composto por várias tabelas armazenadas no banco de dados "dados_BrazilTraffic_Incidents" no ambiente Microsoft Fabric. As tabelas principais schema Star são as seguintes:

1. **Dim_Data:** Esta tabela contém informações sobre a data e hora dos incidentes de trânsito, incluindo o ID da data, a data no formato "AAAA-MM-DD", o dia da semana e o horário.
2. **Dim_Localizacao:** Essa tabela inclui detalhes sobre a localização dos incidentes, como o ID da localização, a UF (Unidade Federativa), a BR (Rodovia), o KM, o município, a latitude e a longitude.
3. **Dim_Condicoes:** Esta tabela contém informações sobre as condições de tráfego no momento dos incidentes, incluindo o ID das condições, a condição meteorológica, o tipo de pista, o traçado da via e o uso do solo.
4. **Dim_Radar:** Essa tabela fornece dados sobre os radares de tráfego, incluindo o ID do radar, a concessionária, o ano do PNV/SNV (Plano Nacional de Viação/Sistema Nacional de Viação), o tipo de radar, a rodovia, a UF, o KM, o município, o tipo de pista, o sentido, a situação, a data de inativação, a latitude, a longitude, as velocidades para veículos leves e pesados.
5. **Dim_Detalhes_Acidente:** Esta tabela contém informações detalhadas sobre as causas, tipos e classificações dos acidentes, bem como a fase do dia e o sentido da via.
6. **Fatos_Acidentes:** Esta tabela é a tabela de fatos principal, que relaciona os incidentes de trânsito com as informações das outras tabelas. Ela inclui o ID do acidente, o ID do radar, o ID da data, o ID da localização, o ID das condições, estatísticas sobre mortos, feridos leves, feridos graves, ilesos, ignorados, feridos e veículos envolvidos.

![Modelo Estrela - tabelas](img/Schema_Star_traffic.png)

## Aplicações e Cenários  

O conjunto de dados de Incidentes de Trânsito no Brasil pode ser empregado em diferentes domínios e cenários, tais como:

1. Planejamento de Tráfego:
    - Os dados podem ser utilizados para planejar rotas mais seguras e eficientes, considerando as rodovias com menor ocorrência de incidentes.
2. Educação e Conscientização no Trânsito:
    - Os dados podem ser usados para desenvolver campanhas de conscientização sobre as principais causas de incidentes de trânsito, promovendo uma cultura de segurança no tráfego.
3. Melhoria da Infraestrutura:
    - A análise dos dados pode auxiliar na identificação de trechos de rodovias com alta incidência de acidentes, direcionando recursos para a melhoria da infraestrutura nesses locais.

## Exploração e Visualização de Dados  

A análise dos incidentes de trânsito foi realizada seguindo as etapas a seguir:

1. **Carregamento e pré-processamento dos dados:** Os dados brutos foram importados para o Microsoft Fabric e transformados em um formato adequado para análise. Isso incluiu a extração das informações relevantes para as tabelas dimensionais e a criação da tabela de fatos.
2. **Exploração e visualização dos dados**: Foram utilizadas consultas SQL para explorar os dados e gerar visualizações, como gráficos, para uma melhor compreensão dos incidentes de trânsito no Brasil.
3. **Análise estatística:** Foram realizadas consultas SQL e cálculos estatísticos para identificar tendências, calcular estatísticas relevantes e obter insights sobre os incidentes de trânsito. Isso incluiu a contagem de incidentes por mês, a identificação das rodovias mais perigosas e a análise das causas e tipos de acidentes mais comuns.
4. **Documentação e apresentação:** Os resultados da análise foram documentados em um relatório utilizando a formatação Markdown. O relatório inclui uma introdução, a descrição do conjunto de dados, a metodologia utilizada, os resultados obtidos e uma conclusão.

## Resultados  

A análise dos incidentes de trânsito no Brasil utilizando o conjunto de dados fornecido resultou nos seguintes insights:

1. **Horários de pico de acidentes**:  
    - Foram identificados os momentos do dia em que ocorrem mais acidentes, proporcionando uma compreensão dos horários mais críticos para a segurança no trânsito.
2. Meses com maior ocorrência de acidentes:  
    - Foi possível identificar os meses do ano com maior número de acidentes, destacando os períodos que requerem maior atenção e medidas preventivas.
3. **Dias da semana com mais acidentes:**  
    - A análise revelou os dias da semana com maior incidência de acidentes, o que pode auxiliar na implementação de estratégias de fiscalização e prevenção específicas para esses dias.
4. **Relação entre dia da semana e condição meteorológica:**  
    - A análise mostrou como a condição climática pode afetar os acidentes de trânsito em diferentes dias da semana, fornecendo informações valiosas sobre os impactos das condições climáticas na segurança viária.
5. **Localização (estado) com maior número de acidentes:**  
    - Foram identificados os estados brasileiros com maior quantidade de acidentes, permitindo a adoção de medidas de segurança direcionadas a áreas específicas.
6. **Tipos de radares mais associados a acidentes:**  
    - A análise revelou os tipos de radares mais frequentemente relacionados a acidentes, possibilitando a implementação de ações específicas relacionadas a esses dispositivos para melhorar a segurança no trânsito.
7. **Município com maior número de mortes em acidentes:**  
    - Foi identificado o município com o maior número de mortes em acidentes dentro de um período específico, o que pode orientar a implementação de medidas de segurança direcionadas a essa região.
8. **Contagem de acidentes por estado e causa:**  
    - A análise permitiu compreender as causas dos acidentes em cada estado, fornecendo informações importantes para a implementação de medidas preventivas e educativas específicas para cada caso.

## Conclusão  

A análise de incidentes de trânsito no Brasil nos últimos 17 anos fornece insights valiosos sobre o comportamento do tráfego e a segurança no trânsito no país. A compreensão das tendências, a identificação das rodovias mais perigosas e o reconhecimento das principais causas dos incidentes podem informar medidas preventivas e melhorar a segurança no trânsito. Essas informações são cruciais para gestores de tráfego, órgãos reguladores e profissionais envolvidos na segurança no trânsito, contribuindo para a redução de acidentes e salvando vidas.
