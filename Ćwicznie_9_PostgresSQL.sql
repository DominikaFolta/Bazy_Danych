
CREATE DATABASE "Projekt"
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Polish_Poland.1250'
    LC_CTYPE = 'Polish_Poland.1250'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;
	
	CREATE DATABASE Tabela_geochronologiczna;


-- utworzenie tabeli GeoTabela
CREATE TABLE GeoEon(id_eon VARCHAR(3) PRIMARY KEY NOT NULL, nazwa_eon VARCHAR(16));
CREATE TABLE GeoEra(id_era VARCHAR(3) PRIMARY KEY NOT NULL, id_eon VARCHAR(3), nazwa_era VARCHAR(16));
CREATE TABLE GeoOkres(id_okres VARCHAR(3) PRIMARY KEY NOT NULL, id_era VARCHAR(3), nazwa_okres Varchar(16));
CREATE TABLE GeoEpoka(id_epoka VARCHAR(4) PRIMARY KEY NOT NULL, id_okres VARCHAR(3), nazwa_epoka VARCHAR(16));
CREATE TABLE GeoPiêtro(id_pietro INT PRIMARY KEY NOT NULL, id_epoka VARCHAR(4), nazwa_pietro VARCHAR(16));

ALTER TABLE GeoEra
ADD CONSTRAINT fk_id_eon FOREIGN KEY (id_eon) REFERENCES GeoEon(id_eon);
ALTER TABLE GeoOkres
ADD CONSTRAINT fk_id_era FOREIGN KEY (id_era) REFERENCES GeoEra(id_era);
ALTER TABLE GeoEpoka
ADD CONSTRAINT fk_id_okres FOREIGN KEY (id_okres) REFERENCES GeoOkres(id_okres);
ALTER TABLE GeoPiêtro
ADD CONSTRAINT fk_id_epoka FOREIGN KEY (id_epoka) REFERENCES GeoEpoka(id_epoka);

INSERT INTO GeoEon VALUES
('EON', 'Fanerozoik');

INSERT INTO GeoEra VALUES
('ER1', 'EON', 'Kenozoik'),
('ER2', 'EON', 'Mezozoik'),
('ER3', 'EON', 'Paleozoik');

INSERT INTO GeoOkres VALUES
('OK1', 'ER1', 'Czwartorzêd'),
('OK2','ER1', 'Neogen'),
('OK3','ER1', 'Paleogen'),
('OK4','ER2', 'Kreda'),
('OK5','ER2', 'Jura'),
('OK6','ER2', 'Trias'),
('OK7','ER3', 'Perm'),
('OK8','ER3', 'Karbon'),
( 'OK9', 'ER3', 'Dewon');

INSERT INTO GeoEpoka VALUES
('EP11','OK1','Halocen'),
('EP12','OK1','Plejstocen'),
('EP13','OK2','Pliocen'),
('EP14','OK2','Miocen'),
('EP15','OK3','Oligocen'),
('EP16','OK3','Eocen'),
('EP17','OK3','Paleocen'),
('EP18','OK4','Górna'),
('EP19','OK4','Dolna'),
('EP20','OK5','Górna'),
('EP21','OK5','Œrodkowa'),
('EP22','OK5','Dolna'),
('EP23','OK6','Górna '),
('EP24','OK6','Œrodkowa'),
('EP25','OK6','Dolna'),
('EP26','OK7','Górny'),
('EP27','OK7','Dolny'),
('EP28','OK8','Górny'),
('EP29','OK8','Dolny'),
('EP30','OK9','Górny'),
('EP31','OK9','Œrodkowy'),
('EP32','OK9','Dolny');

INSERT INTO GeoPiêtro VALUES
(1,'EP11','megalaj'),
(2,'EP11','northgrip'),
(3,'EP11','grenland'),
(4,'EP12','póŸny'),
(5,'EP12','chiban'),
(6,'EP12','kalabr'),
(7,'EP12','gelas'),
(8,'EP13','piacent'),
(9,'EP13','zankl'),
(10,'EP14','messyn'),
(11,'EP14','torton'),
(12,'EP14','serrawal'),
(13,'EP14','lang'),
(14,'EP14','burdyga³'),
(15,'EP14','akwitan'),
(16,'EP15','szat'),
(17,'EP15','rupel'),
(18,'EP16','priabon'),
(19,'EP16','barton'),
(20,'EP16','lutet'),
(21,'EP16','iprez'),
(22,'EP17','tanet'),
(23,'EP17','zeland'),
(24,'EP17','dan'),
(25,'EP18','mastrycht'),
(26,'EP18','kampan'),
(27,'EP18','santon'),
(28,'EP18','koniak'),
(29,'EP18','turon'),
(30,'EP18','cenoman'),
(31,'EP19','alb'),
(32,'EP19','apt'),
(33,'EP19','barrem'),
(34,'EP19','hoteryw'),
(35,'EP19','walan¿yn'),
(36,'EP19','berrias'),
(37,'EP20','tyton'),
(38,'EP20','kimeryd'),
(39,'EP20','oksford'),
(40,'EP21','kelowej'),
(41,'EP21','baton'),
(42,'EP21','bajos'),
(43,'EP21','aalen'),
(44,'EP22','toark'),
(45,'EP22','pliensbach'),
(46,'EP22','synemur'),
(47,'EP22','hettang'),
(48,'EP23','retyk'),
(49,'EP23','noryk'),
(50,'EP23','karnik'),
(51,'EP24','ladyn'),
(52,'EP24','anizyk'),
(53,'EP25','olenek'),
(54,'EP25','ind'),
(55,'EP26','tatar'),
(56,'EP26','kazañ'),
(57,'EP26','ufa'),
(58,'EP27','kungur'),
(59,'EP27','artinsk'),
(60,'EP27','sakmar'),
(61,'EP27','assel'),
(62,'EP28','g¿el'),
(63,'EP28','kasimow'),
(64,'EP28','moskow'),
(65,'EP28','baszkir'),
(66,'EP29','serpuchow'),
(67,'EP29','wizen'),
(68,'EP29','turnej'),
(69,'EP30','famen'),
(70,'EP30','fran'),
(71,'EP31','¿ywet'),
(72,'EP31','eifel'),
(73,'EP32','ems'),
(74,'EP32','prag'),
(75,'EP32','lochkow');


SELECT * FROM GeoEon;
SELECT * FROM GeoEra;
SELECT * FROM GeoOkres;
SELECT * FROM GeoEpoka;
SELECT * FROM GeoPiêtro;


CREATE TABLE GeoTabela AS (SELECT * FROM GeoPiêtro 
						   NATURAL JOIN GeoEpoka 
						   NATURAL JOIN GeoOkres 
						   NATURAL JOIN GeoEra 
						   NATURAL JOIN GeoEon );			   
SELECT * FROM GeoTabela;

-- utworzenie tabeli Milion
CREATE SCHEMA Dziesiec;

CREATE TABLE Dziesiec.a1(cyfra int, bit int);
CREATE TABLE Dziesiec.a2(cyfra int, bit int);
CREATE TABLE Dziesiec.a3(cyfra int, bit int);
CREATE TABLE Dziesiec.a4(cyfra int, bit int);
CREATE TABLE Dziesiec.a5(cyfra int, bit int);
CREATE TABLE Dziesiec.a6(cyfra int, bit int);

INSERT INTO Dziesiec.a1 VALUES (0,1),(1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1);
INSERT INTO Dziesiec.a2 VALUES (0,1),(1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1);
INSERT INTO Dziesiec.a3 VALUES (0,1),(1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1);
INSERT INTO Dziesiec.a4 VALUES (0,1),(1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1);
INSERT INTO Dziesiec.a5 VALUES (0,1),(1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1);
INSERT INTO Dziesiec.a6 VALUES (0,1),(1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(8,1),(9,1);


CREATE TABLE Milion(liczba int,cyfra int, bit int);
INSERT INTO  Milion SELECT a1.cyfra +10*a2.cyfra +100*a3.cyfra + 1000*a4.cyfra + 10000*a5.cyfra + 10000*a6.cyfra 
AS liczba, a1.cyfra AS cyfra, a1.bit AS bit 
FROM Dziesiec.a1, Dziesiec.a2, Dziesiec.a3, Dziesiec.a4, Dziesiec.a5, Dziesiec.a6;

SELECT * FROM Milion;


--Zapytanie 1
SELECT COUNT(*) FROM Milion INNER JOIN GeoTabela 
ON (mod(Milion.liczba,68)=(GeoTabela.id_pietro));

--Zapytanie 2
SELECT COUNT(*) FROM Milion INNER JOIN  GeoPiêtro  
ON (mod(Milion.liczba,68)=GeoPiêtro.id_pietro) 
NATURAL JOIN GeoEpoka NATURAL JOIN GeoOkres 
NATURAL JOIN GeoEra NATURAL JOIN GeoEon;

--Zapytanie 3
SELECT COUNT(*) FROM Milion WHERE mod(Milion.liczba,68)=(SELECT id_pietro 
FROM GeoTabela WHERE mod(Milion.liczba,68)=(id_pietro));

--Zapytanie 4
SELECT COUNT(*) FROM Milion WHERE mod(Milion.liczba,68) in
(SELECT GeoPiêtro.id_pietro FROM GeoPiêtro 
NATURAL JOIN GeoEpoka NATURAL JOIN GeoOkres NATURAL JOIN GeoEra NATURAL JOIN GeoEon);

--Dodanie indeksów
CREATE INDEX indx_Eon ON GeoEon(id_eon);
CREATE INDEX indx_Era ON GeoEra(id_era, id_eon);
CREATE INDEX indx_Okres ON GeoOkres(id_okres, id_era);
CREATE INDEX indx_Epoka ON GeoEpoka(id_epoka, id_okres);
CREATE INDEX indx_Piêtro ON GeoPiêtro(id_pietro, id_epoka);

CREATE INDEX indx_Liczba ON Milion(liczba);
CREATE INDEX indx_GeoTabela ON GeoTabela(id_pietro, id_epoka, id_era, id_okres, id_eon);
