-- nowa baza danych o nazwie firma
CREATE DATABASE Firma;

-- nowy schemat o nazwie rozliczenia
CREATE SCHEMA Rozliczenia;


-- dodanie 4 tabel do schematu rozliczenia 
CREATE TABLE Rozliczenia.pracownicy(id_pracownika VARCHAR(4) PRIMARY KEY NOT NULL, imie VARCHAR(50) NOT NULL, nazwisko VARCHAR(50) NOT NULL, adres VARCHAR(50), telefon INTEGER);
CREATE TABLE Rozliczenia.godziny(id_godziny INTEGER PRIMARY KEY NOT NULL, data_wyp³aty DATE, liczba_godzin FLOAT, id_pracownika VARCHAR(4));
CREATE TABLE Rozliczenia.premie(id_premii VARCHAR(4) PRIMARY KEY NOT NULL, rodzaj VARCHAR(50), kwota MONEY NOT NULL);
CREATE TABLE Rozliczenia.pensje(id_pensji INTEGER PRIMARY KEY NOT NULL, stanowisko VARCHAR(50), kwota MONEY NOT NULL, id_premii VARCHAR(4));
ALTER TABLE Rozliczenia.godziny
ADD CONSTRAINT fk_id_pracownika FOREIGN KEY (id_pracownika) REFERENCES Rozliczenia.pracownicy(id_pracownika);
ALTER TABLE Rozliczenia.pensje
ADD CONSTRAINT fk_id_premii FOREIGN KEY (id_premii) REFERENCES Rozliczenia.premie(id_premii);

INSERT INTO Rozliczenia.pracownicy VALUES
('PR1', 'Adam', 'Nowakowski', 'Kwiatowa 32', 123456789),
('PR2', 'Marek', 'Górski', ' Wolna 22', 346222322),
('PR3', 'Joanna', 'Klecha', 'Akacjowa 123', 107756362),
('PR4', 'Nina', 'Tracz', 'Wolna 22', 285601002),
('PR5', 'Stefan', 'Drozd', 'Prosta 1', 333436678),
('PR6', 'Piotr', 'Kowalski', 'D³uga 321', 111241321),
('PR7', 'Tomasz', 'Górka', 'Rzeczna 98', 980005811),
('PR8', 'Rafa³', 'Wolski', 'Zachodnia 12', 300004224),
('PR9', 'Magdalena', 'Piotrowska', 'S³oneczna 733', 233340049),
('PR10', 'Monika', 'Witak', 'Kamienna 55', 224345673);

INSERT INTO Rozliczenia.godziny VALUES
(30, '10.04.2020', 47, 'PR1'),
(35, '11.04.2020', 40.5, 'PR2'),
(40, '10.04.2020', 44, 'PR3'),
(45, '10.04.2020', 45, 'PR4'),
(50, '12.04.2020', 45, 'PR5'),
(55, '09.04.2020', 49, 'PR6'),
(60, '12.04.2020', 48.5, 'PR7'),
(65, '10.04.2020', 47.5, 'PR8'),
(70, '11.04.2020', 45,'PR9' ),
(75, '10.04.2020', 44, 'PR10');

INSERT INTO Rozliczenia.premie VALUES
('p11', 'Premia cotygodniowa1', 50),
('p12', 'Premia miesiêczna1', 100),
('p14', 'Premiê motywacyjna1', 150),
('p16', 'Premiê zadaniowa2', 200),
('p20', 'Nagroda1', 300),
('p23', 'Premia cotygodniowa2', 350),
('p26', 'Premia miesiêczna2', 400),
('p30', 'Premiê motywacyjna2', 450),
('p31', 'Premiê zadaniowa2', 500),
('p32', 'Nagroda2', 550);

INSERT INTO Rozliczenia.pensje  VALUES
(001, 'Kucharz', 4000, NULL),
(002, 'Kelner', 3700, 'p11'),
(003, 'Barman', 4400, NULL),
(004, 'Kasjer', 3500, 'p16'),
(005, 'Piekarz', 3400, NULL),
(006, 'Kelner', 3100, NULL),
(007, 'Kasjer', 3500, NULL),
(008, 'Recepcjonista', 3450, 'p26'),
(009, 'Recepcjonista', 3700, NULL),
(010, 'Kelner', 3200, 'p31');


--Pokazuje tabele
SELECT * FROM Rozliczenia.pracownicy;
SELECT * FROM Rozliczenia.godziny;
SELECT * FROM Rozliczenia.pensje;
SELECT * FROM Rozliczenia.premie;

--Wyœwietlanie nazwisk i adresów pracowników
SELECT nazwisko, adres
FROM Rozliczenia.pracownicy;

--Zmienia date w tabeli godziny, ¿eby wyœwietla³a dzieñ tygonia i miesi¹c
--UPDATE Rozliczenia.godziny
--SET data_wyp³aty = DATEPART(day, '10.04.2020');
SELECT DATEPART(day, '10.04.2020') [miesi¹c] , DATEPART(month, '10.04.2020')[dzieñ]
SELECT DATEPART(day, '11.04.2020') [miesi¹c] , DATEPART(month, '11.04.2020')[dzieñ]
SELECT DATEPART(day, '10.04.2020') [miesi¹c], DATEPART(month, '10.04.2020') [dzieñ]
SELECT DATEPART(day, '10.04.2020') [miesi¹c], DATEPART(month, '10.04.2020') [dzieñ]
SELECT DATEPART(day, '12.04.2020') [miesi¹c], DATEPART(month, '12.04.2020') [dzieñ]
SELECT DATEPART(day, '09.04.2020') [miesi¹c], DATEPART(month, '09.04.2020') [dzieñ]
SELECT DATEPART(day, '12.04.2020') [miesi¹c], DATEPART(month, '12.04.2020') [dzieñ]
SELECT DATEPART(day, '10.04.2020') [miesi¹c], DATEPART(month, '10.04.2020') [dzieñ]
SELECT DATEPART(day, '11.04.2020') [miesi¹c], DATEPART(month, '11.04.2020') [dzieñ]
SELECT DATEPART(day, '10.04.2020') [miesi¹c], DATEPART(month, '10.04.2020') [dzieñ]
FROM Rozliczenia.godziny;

-- Zmiana nazwy kolumny 
EXEC sp_rename 'Rozliczenia.pensje.kwota', 'kwota_brutto', 'COLUMN';
SELECT * FROM Rozliczenia.pensje;

--Dodanie nowej kolumny
ALTER TABLE Rozliczenia.pensje ADD kwota_netto Float;
SELECT * FROM Rozliczenia.pensje;

--Wypê³nianie nowej kolumny
UPDATE Rozliczenia.pensje
SET kwota_netto = ROUND((Rozliczenia.pensje.kwota_brutto - (Rozliczenia.pensje.kwota_brutto * 0.23)/(1+0.23)),2)
SELECT * FROM Rozliczenia.pensje;