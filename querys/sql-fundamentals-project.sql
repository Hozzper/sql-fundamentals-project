"""This Dataset provides up-to-date information on the sales 
performance and popularity of various video games worldwide. 
The data includes the name, platform, year of release, genre, 
publisher, and sales in North America, Europe, Japan, and other 
regions. It also features scores and ratings from both critics 
and users, including average critic score, number of critics 
reviewed, average user score, number of users reviewed, 
developer, and rating. """

--Criando a tabela games_data a partir do arquivo CSV Video_Games.csv
CREATE TABLE games_data AS 
SELECT * FROM "data/Video_Games.csv";

--Mostrando a data
SHOW TABLES;
SELECT * FROM games_data LIMIT 5;

UPDATE games_data
SET Year_of_Release = NULL
WHERE Year_of_Release = 'N/A';

ALTER TABLE games_data
ALTER COLUMN Year_of_Release TYPE INT;

--Liste o nome, a plataforma e o ano de lançamento de todos os video games 
--lançados após 2010, ordenados do mais recente para o mais antigo.
SELECT Name, Platform, Year_of_Release FROM games_data
WHERE Year_of_Release > 2010
ORDER BY Year_of_Release DESC;

--Mostre todos os video games do gênero "Sports" ou "Racing" 
--que foram publicados pela Nintendo
SELECT Name FROM games_data
WHERE Genre IN ('Sports', 'Racing')
AND Publisher = 'Nintendo'
ORDER BY Name;

