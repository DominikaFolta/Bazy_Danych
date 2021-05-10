CREATE DATABASE fibonacci;


WITH Fibonacci AS
(
     SELECT 0 as FibN, 1 as N
     UNION ALL
     SELECT N, FibN + N
     FROM Fibonacci
     WHERE N < 1000000000
)
SELECT FibN as Fibonacci
     FROM Fibonacci;
