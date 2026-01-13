/*
Project: SQL Fundamentals – Video Games Analysis
Author: Yorvi Reyes
Description:
    Analysis project using basic SQL concepts:
    SELECT, WHERE, AND/OR, ORDER BY, LIMIT, OFFSET,
    NULL handling and subqueries.
Dataset: Video_Games.csv
*/

"""This Dataset provides up-to-date information on the sales 
performance and popularity of various video games worldwide. 
The data includes the name, platform, year of release, genre, 
publisher, and sales in North America, Europe, Japan, and other 
regions. It also features scores and ratings from both critics 
and users, including average critic score, number of critics 
reviewed, average user score, number of users reviewed, 
developer, and rating. """

-- ==============================================================
-- 1. Perparação da data
-- ==============================================================

--Criando a tabela games_data a partir do arquivo CSV Video_Games.csv
CREATE TABLE games_data AS 
SELECT * FROM "data/Video_Games.csv";

--Mostrando a data
SHOW TABLES;
SELECT * FROM games_data LIMIT 5;

-- ==============================================================
-- 2. Limpeza da data
-- ==============================================================

UPDATE games_data
SET Year_of_Release = NULL
WHERE Year_of_Release = 'N/A';

ALTER TABLE games_data
ALTER COLUMN Year_of_Release TYPE INT;


-- ==============================================================
-- 3. Analises da data
-- ==============================================================

-- 1. Liste o nome, a plataforma e o ano de lançamento de todos os video games 
--lançados após 2010, ordenados do mais recente para o mais antigo.
SELECT Name, Platform, Year_of_Release FROM games_data
WHERE Year_of_Release > 2010
ORDER BY Year_of_Release DESC;

-- 2. Mostre todos os video games do gênero "Sports" ou "Racing" 
--que foram publicados pela Nintendo
SELECT Name FROM games_data
WHERE Genre IN ('Sports', 'Racing')
AND Publisher = 'Nintendo'
ORDER BY Name;

-- 3. Obtenha os video games que não possuem pontuação de críticos 
--(Critic_Score IS NULL), exibindo nome, plataforma e publisher
SELECT Name, Platform, Publisher FROM games_data
WHERE Critic_Score IS NULL;

-- 4. Liste os video games cuja venda global seja maior que 20 milhões, 
--mas cuja venda no Japão seja menor que 5 milhões.
SELECT Name FROM games_data
WHERE Global_Sales > 20 
AND JP_Sales < 5
ORDER BY Global_Sales DESC;

-- 5. Mostre os video games lançados entre 1995 e 2005, excluindo os do gênero 
--Role-Playing, ordenados pela Global_Sales de forma decrescente.
SELECT Name FROM games_data
WHERE Year_of_Release BETWEEN 1995 AND 2005
AND Genre NOT LIKE 'Role-Playing'
ORDER BY Global_Sales DESC;

-- 6. Obtenha os video games onde as vendas na Europa 
--sejam maiores que as vendas na América do Norte.
SELECT Name FROM games_data
WHERE EU_Sales > NA_Sales;

-- 7. Mostre os video games cuja Global_Sales seja maior que a média de 
--Global_Sales do dataset
SELECT Name FROM games_data
WHERE Global_Sales > (SELECT AVG(Global_Sales) FROM games_data);

-- 8. Liste os video games cuja Critic_Score seja maior que o Critic_Score do 
--jogo “Wii Sports”
SELECT Name FROM games_data
WHERE Critic_Score > (SELECT MAX(Critic_Score) FROM games_data --Se faz uso do MAX pra garantir que retorne um único valor
WHERE Name = 'Wii Sports');

-- 9. Encontre os video games cujo User_Count seja maior que a média de User_Count,
--mas que tenham Critic_Score menor que 80.
SELECT Name FROM games_data
WHERE User_count > (SELECT AVG(User_count) FROM games_data)
AND Critic_Score < 80;

-- 10. Mostre os 10 video games com maior venda global, mas ignore os 
--primeiros 5 resultados.
SELECT Name FROM games_data
ORDER BY Global_Sales DESC
LIMIT 10 OFFSET 5;

-- 11. Liste os video games com Rating diferente de 'E', que tenham User_Score não
--nulo, ordenados por User_Score de forma decrescente, exibindo apenas os primeiros 7.
SELECT Name FROM games_data
WHERE Rating != 'E'
AND User_Score IS NOT NULL
ORDER BY User_Score DESC
LIMIT 7;


-- 12. Encontre os video games cuja venda global seja maior que a soma das
--vendas na América do Norte e na Europa.
SELECT Name, Global_Sales, NA_Sales, EU_Sales FROM games_data
WHERE Global_Sales > (NA_Sales + EU_Sales); --E importante usar parênteses
--pra separar a soma antes da comparação.