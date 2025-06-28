/*Реализуйте функцию SAME_DIGITS(), которая принимает один аргумент:

number — положительное целое число
Функция должна возвращать число 1, если число number состоит из одинаковых цифр, или 0 в противном случае.

Тестовые данные
№	Запрос	Результат запроса
1	SELECT SAME_DIGITS(11111)	1
2	SELECT SAME_DIGITS(11112111)	0
3	SELECT SAME_DIGITS(1)	1
4	SELECT SAME_DIGITS(77)	1
5	SELECT SAME_DIGITS(56)	0
6	SELECT SAME_DIGITS(999)	1
7	SELECT SAME_DIGITS(899)	0
8	SELECT SAME_DIGITS(989)	0
9	SELECT SAME_DIGITS(998)	0
10	SELECT SAME_DIGITS(666666666)	1
11	SELECT SAME_DIGITS(666676666)	0
12	SELECT SAME_DIGITS(1777777777)	0
13	SELECT SAME_DIGITS(777777771)	0
14	SELECT SAME_DIGITS(999999999)	1
15	SELECT SAME_DIGITS(1211111)	0
16	SELECT SAME_DIGITS(1237564)	0
17	SELECT SAME_DIGITS(231)	0
18	SELECT SAME_DIGITS(132)	0
19	SELECT SAME_DIGITS(1000000)	0
Примечание 1. В качестве типов параметров функции, типа возвращаемого значения и типов переменных допустимо использовать любые согласованные с условием задачи типы данных.

Примечание 2. В этой задаче допускается выполнять более одного SQL-запроса.*/
DELIMITER //
CREATE FUNCTION SAME_DIGITS(number int)
RETURNS int
DETERMINISTIC 
BEGIN
RETURN  if(length(replace(abs(number),substr(abs(number),1,1),''))=0,1,0);
END //
DELIMITER ;
