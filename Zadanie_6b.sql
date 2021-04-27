--1-- nowa baza danych o nazwie firma
CREATE DATABASE firma1;

--2-- nowy schemat o nazwie rozliczenia
CREATE SCHEMA ksiegowosc;


--4--dodanie 4 tabel do schematu rozliczenia 
CREATE TABLE ksiegowosc.pracownicy(id_pracownika VARCHAR(5) PRIMARY KEY NOT NULL, imie VARCHAR(50) NOT NULL, nazwisko VARCHAR(50) NOT NULL, adres VARCHAR(50), telefon VARCHAR(15));
CREATE TABLE ksiegowosc.godziny(id_godziny INTEGER PRIMARY KEY NOT NULL, data_wyp³aty DATE, liczba_godzin FLOAT, id_pracownika VARCHAR(5));
CREATE TABLE ksiegowosc.premie(id_premii VARCHAR(4) PRIMARY KEY NOT NULL, rodzaj VARCHAR(50), kwota MONEY NOT NULL);
CREATE TABLE ksiegowosc.pensje(id_pensji INTEGER PRIMARY KEY NOT NULL, stanowisko VARCHAR(50), kwota MONEY NOT NULL, id_premii VARCHAR(5));
CREATE TABLE ksiegowosc.wynagrodzenie(id_wynagrodzenia INTEGER PRIMARY KEY NOT NULL, data_data DATE, id_pracownika VARCHAR(5), id_godziny INTEGER, id_premii VARCHAR(4), id_pensji INTEGER);
ALTER TABLE ksiegowosc.godziny
ADD CONSTRAINT fk_id_pracownika FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);
ALTER TABLE ksiegowosc.pensje
ADD CONSTRAINT fk_id_premii FOREIGN KEY (id_premii) REFERENCES ksiegowosc.premie(id_premii);

ALTER TABLE ksiegowosc.wynagrodzenie
ADD CONSTRAINT fk_id_pracownika2 FOREIGN KEY (id_pracownika) REFERENCES ksiegowosc.pracownicy(id_pracownika);
ALTER TABLE ksiegowosc.wynagrodzenie
ADD CONSTRAINT fk_id_godziny FOREIGN KEY (id_godziny) REFERENCES ksiegowosc.godziny(id_godziny);
ALTER TABLE ksiegowosc.wynagrodzenie
ADD CONSTRAINT fk_id_premii2 FOREIGN KEY (id_premii) REFERENCES ksiegowosc.premie(id_premii);
ALTER TABLE ksiegowosc.wynagrodzenie
ADD CONSTRAINT fk_id_pensji FOREIGN KEY (id_pensji) REFERENCES ksiegowosc.pensje(id_pensji);

--5--Wypê³nianie tabel 10 rekordami
INSERT INTO ksiegowosc.pracownicy VALUES
('PR1', 'Adam', 'Nowakowski', 'Kwiatowa 32', '123456789'),
('PR2', 'Marek', 'Górski', ' Wolna 22', '346222322'),
('PR3', 'Joanna', 'Nowakowska', 'Akacjowa 123', '107756362'),
('PR4', 'Nina', 'Tracz', 'Wolna 22', '285601002'),
('PR5', 'Stefan', 'Drozd', 'Prosta 1', '333436678'),
('PR6', 'Piotr', 'Kowalski', 'D³uga 321', '111241321'),
('PR7', 'Tomasz', 'Górka', 'Rzeczna 98', '980005811'),
('PR8', 'Rafa³', 'Wolski', 'Zachodnia 12', '300004224'),
('PR9', 'Magdalena', 'Piotrowska', 'S³oneczna 733', '233340049'),
('PR10', 'Monika', 'Witak', 'Kamienna 55', '224345673');
SELECT * FROM ksiegowosc.pracownicy;

INSERT INTO  ksiegowosc.godziny VALUES
(30, '10.04.2020', 155, 'PR1'),
(35, '11.04.2020', 143, 'PR2'),
(40, '10.04.2020', 168, 'PR3'),
(45, '10.04.2020', 160, 'PR4'),
(50, '12.04.2020', 140, 'PR5'),
(55, '09.04.2020', 155, 'PR6'),
(60, '12.04.2020', 170, 'PR7'),
(65, '10.04.2020', 169, 'PR8'),
(70, '11.04.2020', 168,'PR9' ),
(75, '10.04.2020', 159, 'PR10');
SELECT * FROM ksiegowosc.godziny;

INSERT INTO ksiegowosc.premie VALUES
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
SELECT * FROM ksiegowosc.premie;


INSERT INTO ksiegowosc.pensje  VALUES
(001, 'Kucharz', 2900, NULL),
(002, 'Kelner', 2500, 'p11'),
(003, 'Barman', 4200, NULL),
(004, 'Kasjer', 2700, 'p16'),
(005, 'Piekarz', 970, NULL),
(006, 'Kelner', 1600, NULL),
(007, 'Kasjer', 800, NULL),
(008, 'Recepcjonista', 3450, 'p26'),
(009, 'Recepcjonista', 600, NULL),
(010, 'Kelner', 900, 'p31');
SELECT * FROM ksiegowosc.pensje;


INSERT INTO ksiegowosc.wynagrodzenie VALUES
(1, '04.05.2020', 'PR1', 30, 'p11', 001),
(2, '04.09.2020', 'PR2', 35, 'p12', 005),
(3, '04.30.2020', 'PR3', 40, NULL, 003),
(4, '04.12.2020', 'PR4', 45, 'p16', 003),
(5, '04.12.2020', 'PR5', 50, 'p20', 005),
(6, '04.30.2020', 'PR6', 55, NULL, 001),
(7, '04.13.2020', 'PR7', 60, 'p26', 007),
(8, '04.12.2020', 'PR8', 65, NULL, 009),
(9, '04.28.2020', 'PR9', 70, 'p31', 004),
(10, '04.13.2020', 'PR10', 75, 'p32', 010);
SELECT * FROM ksiegowosc.wynagrodzenie;

SELECT * FROM ksiegowosc.pracownicy;
SELECT * FROM ksiegowosc.godziny;
SELECT * FROM ksiegowosc.pensje;
SELECT * FROM ksiegowosc.premie;
SELECT * FROM ksiegowosc.wynagrodzenie;

--6a)-- Zmodyfikuj numer telefonu w tabeli pracownicy, dodaj¹c do niego kierunkowy dla Polski
--w nawiasie (+48)

ALTER TABLE ksiegowosc.pracownicy ADD telefon2 VARCHAR(15);
SELECT CAST(telefon AS VARCHAR(15)) AS telefon
FROM ksiegowosc.pracownicy;

UPDATE ksiegowosc.pracownicy
SET  telefon2 = '+48 '+telefon
SELECT * FROM ksiegowosc.pracownicy;

--6b)-- Zmodyfikuj atrybut telefon w tabeli pracownicy tak, aby numer oddzielony by³ myœlnikami wg
--- wzoru: ‘555-222-333’

SELECT id_pracownika, imie, nazwisko, adres, CONCAT(SUBSTRING(telefon, 1, 3),'-', SUBSTRING(telefon, 4, 3),'-', SUBSTRING(telefon, 7, 3)) AS telefon, telefon2
FROM ksiegowosc.pracownicy;

--c)-- Wyœwietl dane pracownika, którego nazwisko jest najd³u¿sze, u¿ywaj¹c du¿ych liter
SELECT TOP 1 id_pracownika, 
UPPER(imie) as imie, 
UPPER(nazwisko) as  nazwisko 
FROM ksiegowosc.pracownicy
ORDER BY LEN(nazwisko) desc;

--d)-- Wyœwietl dane pracowników i ich pensje zakodowane przy pomocy algorytmu md5
SELECT HashBytes('MD5', 'imie') AS imie, HashBytes('MD5', 'nazwisko') AS nazwisko,
HashBytes('MD5', 'kwota')AS pensja FROM ksiegowosc.wynagrodzenie
INNER JOIN ksiegowosc.pracownicy ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika 
INNER JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji;

--f)-- Wyœwietl pracowników, ich pensje oraz premie. Wykorzystaj z³¹czenie lewostronne.
SELECT imie, nazwisko, adres, premie.kwota AS premia, pensje.kwota AS pensja FROM ksiegowosc.wynagrodzenie
LEFT JOIN ksiegowosc.pracownicy ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika
LEFT JOIN ksiegowosc.premie ON wynagrodzenie.id_premii = premie.id_premii
LEFT JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji;

--g)-- wygeneruj raport (zapytanie), które zwróci w wyniki treœæ wg poni¿szego szablonu:
--Pracownik Jan Nowak, w dniu 7.08.2017 otrzyma³ pensjê ca³kowit¹ na kwotê 7540 z³, gdzie
--wynagrodzenie zasadnicze wynosi³o: 5000 z³, premia: 2000 z³, nadgodziny: 540 z³

SELECT CONCAT( 'Pracownik ', imie, nazwisko, 'w dniu ', CAST(data_wyp³aty AS VARCHAR(15)),
' otrzyma³ pensjê ca³kowit¹ na kwotê ', CAST((premie.kwota  + pensje.kwota) AS VARCHAR(15)), ' z³',
' gdzie wynagrodzenie zasadnicze wynosi³o: ', CAST(pensje.kwota AS VARCHAR(15)),' z³',
', premia: ', CAST(premie.kwota AS VARCHAR(15))) AS Raport FROM ksiegowosc.wynagrodzenie
INNER JOIN ksiegowosc.pracownicy ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika
INNER JOIN ksiegowosc.premie ON wynagrodzenie.id_premii = premie.id_premii
INNER JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
INNER JOIN ksiegowosc.godziny ON wynagrodzenie.id_godziny = godziny.id_godziny
ORDER BY premie.kwota, pensje.kwota;
