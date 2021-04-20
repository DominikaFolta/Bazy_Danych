--1-- nowa baza danych o nazwie firma
CREATE DATABASE firma;

--2-- nowy schemat o nazwie rozliczenia
CREATE SCHEMA ksiegowosc;


--4--dodanie 4 tabel do schematu rozliczenia 
CREATE TABLE ksiegowosc.pracownicy(id_pracownika VARCHAR(5) PRIMARY KEY NOT NULL, imie VARCHAR(50) NOT NULL, nazwisko VARCHAR(50) NOT NULL, adres VARCHAR(50), telefon INTEGER);
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
('PR1', 'Adam', 'Nowakowski', 'Kwiatowa 32', 123456789),
('PR2', 'Marek', 'Górski', ' Wolna 22', 346222322),
('PR3', 'Joanna', 'Nowakowska', 'Akacjowa 123', 107756362),
('PR4', 'Nina', 'Tracz', 'Wolna 22', 285601002),
('PR5', 'Stefan', 'Drozd', 'Prosta 1', 333436678),
('PR6', 'Piotr', 'Kowalski', 'D³uga 321', 111241321),
('PR7', 'Tomasz', 'Górka', 'Rzeczna 98', 980005811),
('PR8', 'Rafa³', 'Wolski', 'Zachodnia 12', 300004224),
('PR9', 'Magdalena', 'Piotrowska', 'S³oneczna 733', 233340049),
('PR10', 'Monika', 'Witak', 'Kamienna 55', 224345673);
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

--6a--Wyœwietl tylko id pracownika oraz jego nazwisko.
SELECT id_pracownika, nazwisko
FROM ksiegowosc.pracownicy;

--6b--Wyœwietl id pracowników, których p³aca jest wiêksza ni¿ 1000.
SELECT id_pracownika FROM ksiegowosc.wynagrodzenie WHERE id_pensji IN (SELECT id_pensji FROM ksiegowosc.pensje WHERE kwota > 1000);

--6c--Wyœwietl id pracowników nieposiadaj¹cych premii, których p³aca jest wiêksza ni¿ 2000.
SELECT id_pracownika FROM ksiegowosc.wynagrodzenie WHERE id_premii is null AND id_pensji IN (SELECT id_pensji FROM ksiegowosc.pensje WHERE kwota > 2000);

--6d--Wyœwietl pracowników, których pierwsza litera imienia zaczyna siê na literê ‘J’.
SELECT id_pracownika, imie, nazwisko FROM ksiegowosc.pracownicy WHERE imie LIKE 'J%';

--6e--Wyœwietl pracowników, których nazwisko zawiera literê ‘n’ oraz imiê koñczy siê na literê ‘a’.
SELECT id_pracownika, imie, nazwisko FROM ksiegowosc.pracownicy WHERE nazwisko LIKE '%n%' AND nazwisko LIKE '%a';

--6f--Wyœwietl imiê i nazwisko pracowników oraz liczbê ich nadgodzin, przyjmuj¹c, i¿ standardowy czas pracy to 160 h miesiêcznie. 
SELECT imie, nazwisko, (liczba_godzin - 160) FROM ksiegowosc.pracownicy 
INNER JOIN ksiegowosc.godziny ON godziny.id_pracownika = pracownicy.id_pracownika WHERE liczba_godzin >= 160;

--6g--Wyœwietl imiê i nazwisko pracowników, których pensja zawiera siê w przedziale 1500 – 3000 PLN
SELECT imie, nazwisko, kwota FROM ksiegowosc.wynagrodzenie
INNER JOIN ksiegowosc.pracownicy ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika 
INNER JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji WHERE kwota > 1500 AND kwota < 3000;

--6h--Wyœwietl imiê i nazwisko pracowników, którzy pracowali w nadgodzinach i nie otrzymali premii.
SELECT imie, nazwisko, liczba_godzin, id_premii FROM ksiegowosc.wynagrodzenie 
INNER JOIN ksiegowosc.pracownicy ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika 
INNER JOIN ksiegowosc.godziny ON wynagrodzenie.id_godziny = godziny.id_godziny  WHERE liczba_godzin > 160 AND id_premii is null;

--6i--Uszereguj pracowników wed³ug pensji.
SELECT imie, nazwisko, adres, kwota FROM ksiegowosc.wynagrodzenie 
INNER JOIN ksiegowosc.pracownicy ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika 
INNER JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji ORDER BY kwota;

--6j--Uszereguj pracowników wed³ug pensji i premii malej¹co.
SELECT imie, nazwisko, adres, premie.kwota AS kwota_premii, pensje.kwota AS kwota_pensji FROM ksiegowosc.wynagrodzenie
INNER JOIN ksiegowosc.pracownicy ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika
INNER JOIN ksiegowosc.premie ON wynagrodzenie.id_premii = premie.id_premii
INNER JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
ORDER BY premie.kwota, pensje.kwota;

--6k--Zlicz i pogrupuj pracowników wed³ug pola ‘stanowisko’
SELECT stanowisko, COUNT(pensje.stanowisko) AS suma FROM ksiegowosc.wynagrodzenie 
INNER JOIN ksiegowosc.pracownicy ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika
INNER JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji
GROUP BY pensje.stanowisko;

--6l--Policz œredni¹, minimaln¹ i maksymaln¹ p³acê dla stanowiska ‘kierownik’ (je¿eli takiego nie masz, to przyjmij dowolne inne).
SELECT AVG(kwota) AS œrednia, MIN(kwota) AS minimum, MAX(kwota) AS maksimum
FROM ksiegowosc.pensje
WHERE pensje.stanowisko = 'Kelner';

--6m--Policz sumê wszystkich wynagrodzeñ.
SELECT SUM(kwota) AS suma
FROM ksiegowosc.pensje;

--6f--Policz sumê wynagrodzeñ w ramach danego stanowiska.
 SELECT stanowisko, SUM(kwota) AS suma, COUNT(stanowisko) AS stanowiska FROM ksiegowosc.pensje GROUP BY stanowisko;

--6g--Wyznacz liczbê premii przyznanych dla pracowników danego stanowiska.
 SELECT stanowisko, COUNT(premie.id_premii) AS premie FROM ksiegowosc.wynagrodzenie
  INNER JOIN ksiegowosc.premie ON wynagrodzenie.id_premii = premie.id_premii
 INNER JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji 
 GROUP BY stanowisko;

--6h--Usuñ wszystkich pracowników maj¹cych pensjê mniejsz¹ ni¿ 1200 z³.
 DELETE pracownicy FROM ksiegowosc.wynagrodzenie
 INNER JOIN ksiegowosc.pracownicy ON wynagrodzenie.id_pracownika = pracownicy.id_pracownika
 INNER JOIN ksiegowosc.pensje ON wynagrodzenie.id_pensji = pensje.id_pensji  WHERE kwota < 1200;