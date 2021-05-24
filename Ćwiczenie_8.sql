
CREATE DATABASE AdventureWorks2019

-- Wykorzystanie bazy danych AdventureWorks
USE AdventureWorks2019;

-- 1. Przygotuj blok anonimowy, który:
-- - znajdzie średnią stawkę wynagrodzenia pracowników,

BEGIN
--SELECT* FROM [AdventureWorks2019].[HumanResources].[EmployeePayHistory];

SELECT AVG([Rate]) AS 'Średnia_stawka'
  FROM [AdventureWorks2019].[HumanResources].[EmployeePayHistory];

-- - wyświetli szczegóły pracowników, których stawka wynagrodzenia jest niższa niż średnia.

SELECT[Rate],[PersonType],[FirstName],[MiddleName],[LastName],[EmailPromotion],[EmailAddress], [PhoneNumber]
	FROM [AdventureWorks2019].[Person].[Person] 
	LEFT JOIN [AdventureWorks2019].[HumanResources].[EmployeePayHistory]
	ON [Person].[Person].BusinessEntityID = [HumanResources].[EmployeePayHistory].BusinessEntityID
	LEFT JOIN [AdventureWorks2019].[Person].[EmailAddress]
	ON [Person].[Person].BusinessEntityID = [Person].[EmailAddress].BusinessEntityID
	LEFT JOIN [AdventureWorks2019].[Person].[PersonPhone] 
	ON [Person].[Person].BusinessEntityID = [Person].[PersonPhone].BusinessEntityID
	WHERE Rate < (SELECT AVG([Rate]) FROM [AdventureWorks2019].[HumanResources].[EmployeePayHistory]);

END;


-- 2. Utwórz funkcję, która zwróci datę wysyłki określonego zamówienia.
SELECT* FROM [AdventureWorks2019].[Sales].[SalesOrderHeader];

CREATE OR ALTER FUNCTION ShipDate(@OrderID INT)
	RETURNS VARCHAR(50)
	AS
	BEGIN
		DECLARE @result VARCHAR(50)
		SET @result = (SELECT CONVERT(VARCHAR(50),[OrderDate],13)
		FROM [AdventureWorks2019].[Sales].[SalesOrderHeader]
		WHERE  SalesOrderID = @OrderID)
		RETURN @result
END;

	SELECT dbo.ShipDate(43659) AS 'Data_wysyłki';
	SELECT dbo.ShipDate(43751) AS 'Data_wysyłki';

-- 3. Utwórz procedurę składowaną, która jako parametr przyjmuję nazwę produktu, a jako
--rezultat wyświetla jego identyfikator, numer i dostępność.
SELECT*FROM [AdventureWorks2019].[Production].[Product];

CREATE OR ALTER PROCEDURE Product(@name AS NVARCHAR(50))
	AS
	BEGIN
		SELECT [Name],[ProductID],[ProductNumber],[FinishedGoodsFlag] 
		FROM [AdventureWorks2019].[Production].[Product]
		WHERE [Name] = @name;
END;

	EXEC Product 'Mountain-100 Black, 44';
	EXEC Product 'External Lock Washer 6';

-- 4. Utwórz funkcję, która zwraca numer karty kredytowej dla konkretnego zamówienia
SELECT*FROM [AdventureWorks2019].[Sales].[CreditCard];

CREATE OR ALTER FUNCTION CartNumber(@OrderID INT)
	RETURNS VVARCHAR(25)
	AS
	BEGIN
		DECLARE @result VARCHAR(25)
		SET @result = 
			(SELECT [CardNumber]
			FROM [AdventureWorks2019].[Sales].[CreditCard] 
			LEFT JOIN [AdventureWorks2019].[Sales].[SalesOrderHeader]
			ON [Sales].[CreditCard].[CreditCardID] = [Sales].[SalesOrderHeader].[CreditCardID]
			WHERE  SalesOrderID = @OrderID)
		RETURN @result
END;

	SELECT dbo.CartNumber(43751) AS 'Numer_karty_kredytowej';


-- 5. Utwórz procedurę składowaną, która jako parametry wejściowe przyjmuje dwie liczby, num1
-- i num2, a zwraca wynik ich dzielenia. Ponadto wartość num1 powinna zawsze być większa niż
-- wartość num2. Jeżeli wartość num1 jest mniejsza niż num2, wygeneruj komunikat o błędzie
-- „Niewłaściwie zdefiniowałeś dane wejściowe”.

CREATE OR ALTER PROCEDURE WynikDzielenia(@num1 AS FLOAT, @num2 AS FLOAT)
	AS 
	BEGIN
	DECLARE @result FLOAT
	IF(@num1 < @num2)
		BEGIN
		PRINT 'Niewlasciwie zdefiniowales dane wejsciowe'
		END
	ELSE 
		BEGIN
		SET @result = @num1/@num2
		PRINT  @result
		END
END;

	EXEC WynikDzielenia 20,5;
	EXEC WynikDzielenia 20,50;


-- 6. Napisz procedurę, która jako parametr przyjmie NationalIDNumber danej osoby, a zwróci
-- stanowisko oraz liczbę dni urlopowych i chorobowych.
SELECT*FROM [AdventureWorks2019].[HumanResources].[Employee];

CREATE OR ALTER PROCEDURE Person(@NationalID AS NVARCHAR(15))
	AS
	BEGIN
		SELECT [NationalIDNumber],[JobTitle],[VacationHours],[SickLeaveHours]
			FROM [AdventureWorks2019].[HumanResources].[Employee]
			WHERE [NationalIDNumber] = @NationalID;
END;

EXEC Person 480168528;


-- 7. Napisz procedurę będącą kalkulatorem walutowym. Wykorzystaj dwie tabele: Sales.Currency
--  oraz Sales.CurrencyRate. Parametrami wejściowymi mają być: kwota, waluty oraz data
--  (CurrencyRateDate). Przyjmij, iż zawsze jedną ze stron jest dolar amerykański (USD).
--  Zaimplementuj kalkulację obustronną, tj: 1400 USD → PLN lub PLN → USD
SELECT*FROM [AdventureWorks2019].[Sales].[CurrencyRate];


CREATE OR ALTER PROCEDURE KalkulatorWalutowy(@kwota MONEY, @waluta1 NCHAR(3), @waluta2 NCHAR(3), @data DATETIME)
	AS 
	BEGIN
	DECLARE @result MONEY
		IF(@waluta1 = 'USD')
			BEGIN
				SET @result = @kwota*(SELECT [AverageRate] FROM [AdventureWorks2019].[Sales].[CurrencyRate] 
					WHERE [CurrencyRateDate] = @data AND [ToCurrencyCode] = @waluta2)
					PRINT(@waluta1 + '->' + @waluta2)
					PRINT(@result)
			END
		ELSE
			BEGIN
				SET @result = @kwota/(SELECT [AverageRate] FROM [AdventureWorks2019].[Sales].[CurrencyRate] 
				WHERE [CurrencyRateDate] = @data AND [ToCurrencyCode] = @waluta1)
				PRINT(@waluta1 + '->' + @waluta2 ) 
				PRINT(@result)
			END
	END;

EXEC KalkulatorWalutowy 1000, 'USD','GBP','2011-05-31 00:00:00.000'
EXEC KalkulatorWalutowy 1000, 'VEB','USD','2011-06-18 00:00:00.000' 
