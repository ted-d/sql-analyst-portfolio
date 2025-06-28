/*Функция SOLVE()

Функция должна возвращать корень многочлена с коэффициентами a, b и c. Если многочлен с переданными коэффициентами имеет два корня, функция SOLVE() должна вернуть меньший из них, если не имеет корней — значение NULL.

Тестовые данные
№	Запрос	Результат запроса
1	SELECT SOLVE(1, -5, 6)	2.0
2	SELECT SOLVE(2, 4, -6)	-3.0
3	SELECT SOLVE(3, -9, 6)	1.0
4	SELECT SOLVE(1, -4, 4)	2.0
5	SELECT SOLVE(4, -4, 1)	0.5
6	SELECT SOLVE(9, -12, 0)	0.0
7	SELECT SOLVE(1, 0, 2)	NULL
8	SELECT SOLVE(2, 0, 3)	NULL
9	SELECT SOLVE(3, 0, 5)	NULL
10	SELECT SOLVE(1, -6, 9)	3.0
11	SELECT SOLVE(2, 7, 3)	-3.0
12	SELECT SOLVE(4, -12, 9)	1.5
13	SELECT SOLVE(1, 6, 9)	-3.0
14	SELECT SOLVE(3, 6, 3)	-1.0
15	SELECT SOLVE(2, 0, 8)	NULL
16	SELECT SOLVE(-3, 0, 75)	-5.0
Примечание 1. В качестве типов параметров функции, типа возвращаемого значения и типов переменных допустимо использовать любые согласованные с условием задачи типы данных.

Примечание 2. В этой задаче допускается выполнять более одного SQL-запроса.*/
DELIMITER //
CREATE FUNCTION SOLVE(a INT, b INT, c INT)
RETURNS FLOAT
DETERMINISTIC

BEGIN
DECLARE D FLOAT;
SET D  := POW(b,2) - 4 * a * c;
RETURN (CASE 
WHEN D>0 THEN IF(
    (
        -b+SQRT(POW(b,2) - 4*a*c)
    )/(2*a)>
    (
        -b-SQRT(POW(b,2) - 4*a*c)
    )/(2*a),(
        -b-SQRT(POW(b,2) - 4*a*c)
    )/(2*a), (
        -b+SQRT(POW(b,2) - 4*a*c)
    )/(2*a)
)
WHEN D = 0 THEN -b /(2*a)
        ELSE NULL
END
       );
END//
DELIMITER ;

SELECT SOLVE(1, 0, 2)
