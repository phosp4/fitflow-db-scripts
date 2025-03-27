-- Rekurzivnou CTE generujte postupnost faktorialov

-- a) od 1 do 12

WITH faktorial(n, fakt) 
AS
(
	SELECT 1, 1
	UNION ALL
	SELECT n + 1, (n + 1)*fakt 
	FROM faktorial
	WHERE n < 12
)
SELECT * FROM faktorial;

-- b) od 1 do 20

WITH faktorial(n, fakt) 
AS
(
	SELECT 1, CAST(1 AS BIGINT)
	UNION ALL
	SELECT n + 1, (n + 1)*fakt 
	FROM faktorial
	WHERE n < 20
)
SELECT * FROM faktorial;

-- c) od 1 do 33

WITH faktorial(n, fakt) 
AS
(
	SELECT 1, CAST(1 AS DECIMAL(38,0))
	UNION ALL
	SELECT n + 1, (n + 1)*fakt 
	FROM faktorial
	WHERE n < 33
)
SELECT * FROM faktorial;