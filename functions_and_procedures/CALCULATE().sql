/*Реализуйте функцию CALCULATE(), которая принимает три аргумента в следующем порядке:

a — число с плавающей точкой
b — число с плавающей точкой
operation — один из четырех символов, определяющих математическую операцию: +, -, * или /
Функция должна возвращать значение выражения a operation b.

Тестовые данные
№	Запрос	Результат запроса
1	SELECT CALCULATE(-23.25, -55.89, '+')	-79.14
2	SELECT CALCULATE(-12.55, 72.91, '-')	-85.46
3	SELECT CALCULATE(21.88, -98.34, '*')	-2151.68
4	SELECT CALCULATE(-99.18, 23.52, '/')	-4.21684
5	SELECT CALCULATE(-7.13, 57.2, '+')	50.07
6	SELECT CALCULATE(-87.52, -66.18, '-')	-21.34
7	SELECT CALCULATE(-23.9, -84.23, '+')	-108.13
8	SELECT CALCULATE(-15.83, 78.67, '/')	-0.20122
9	SELECT CALCULATE(73.18, -58.88, '/')	-1.24287
10	SELECT CALCULATE(-85.15, -59.24, '-')	-25.91
11	SELECT CALCULATE(-75.53, -13.52, '*')	1021.17
12	SELECT CALCULATE(77.34, 16.74, '*')	1294.67
13	SELECT CALCULATE(-62.18, 56.34, '+')	-5.84
14	SELECT CALCULATE(-78.19, -5.3, '-')	-72.89
15	SELECT CALCULATE(9.74, -66.7, '*')	-649.658
Примечание 1. Гарантируется, что при выполнении операции деления делитель не равен нулю.

Примечание 2. Символ + определяет сложение, - — вычитание, * — умножение, / — деление.

Примечание 3. В качестве типов параметров функции, типа возвращаемого значения и типов переменных допустимо использовать любые согласованные с условием задачи типы данных.

Примечание 4. В этой задаче допускается выполнять более одного SQL-запроса.*/
delimiter//
CREATE FUNCTION CALCULATE(a FLOAT,b FLOAT,operation TEXT)
returns float
deterministic
begin
declare num float;
return (case 
when operation = '+' then  a+b
when operation = '-' then  a-b
when operation = '*' then  a*b
when operation = '/' then  a/b
end ) ;

end//
DELIMITER ;
