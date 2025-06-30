/*Вам доступна база данных, принадлежащая сервису "Кинопоиск". Она включает таблицу Directors, которая хранит информацию о различных популярных режиссерах.

Таблица Directors
+----+-------------------+---------+--------+
| id | full_name         | country | rating |
+----+-------------------+---------+--------+
| 1  | Christopher Nolan | England | 90     |
| 2  | Steven Spielberg  | USA     | 79     |
| 3  | Quentin Tarantino | USA     | 100    |
| 4  | Martin Scorsese   | USA     | 41     |
| 5  | David Fincher     | USA     | 100    |
| 6  | Ridley Scott      | England | 54     |
| 7  | Stanley Kubrick   | USA     | 79     |
| 8  | Clint Eastwood    | USA     | 74     |
| 9  | James Cameron     | Canada  | 8      |
+----+-------------------+---------+--------+
Первое поле этой таблицы содержит идентификатор режиссера, второе — имя и фамилию, третье — страну рождения, четвертое — рейтинг по стобалльной шкале.


Скрипт для создания таблицы Directors
DROP TABLE IF EXISTS Directors;
CREATE TABLE Directors
(
    id        INT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(40),
    country   VARCHAR(40),
    rating    INT
);

TRUNCATE Directors;
INSERT INTO Directors (full_name, country, rating)
VALUES ('Christopher Nolan', 'England', 90),
       ('Steven Spielberg', 'USA', 79),
       ('Quentin Tarantino', 'USA', 100),
       ('Martin Scorsese', 'USA', 41),
       ('David Fincher', 'USA', 100),
       ('Ridley Scott', 'England', 54),
       ('Stanley Kubrick', 'USA', 79),
       ('Clint Eastwood', 'USA', 74),
       ('James Cameron', 'Canada', 8);
Тестовые данные
Тест №2
Тест №3
Примечание 1. Первым режиссером считается режиссер с идентификатором 1, вторым — с идентификатором 2, и так далее.

Примечание 2. Гарантируется, что количество записей в таблице Directors делится на 3 без остатка.

Примечание 3. При использовании функции NTILE() необходимо помнить, что ее аргументом должно являться целое число.

Примечание 4. В этой задаче допускается выполнять более одного SQL-запроса.

ЗАДАНИЕ
1)Напишите запрос, который разбивает режиссеров на группы по три человека (первый-второй-третий, четвертый-пятый-шестой, и так далее),
определяет средний рейтинг режиссеров каждой группы и отображает полученный результат в виде таблицы из двух полей:
group_number — номер группы
avg_rating — средний рейтинг режиссеров группы
Записи в результирующей таблице должны быть расположены в порядке убывания значения поля group_number.

2)Напишите запрос, который извлекает из предложенной базы данных информацию обо всех режиссерах (имя и фамилия, страна рождения, рейтинг),
а также пронумеровывает их, начиная с 1, в рамках страны рождения в порядке убывания рейтинга. При этом если два режиссера из одной страны имеют равные рейтинги, то их номера также должны совпадать.
Поле с номером режиссера должно располагаться на первом месте и иметь псевдоним rank_in_country.

3)Напишите запрос, который извлекает из предложенной базы данных информацию о режиссерах (имя и фамилия, рейтинг) со вторым по величине наибольшим рейтингом.
Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля full_name

4)Напишите запрос, который извлекает из предложенной таблицы Directors всю информацию обо всех режиссерах, сначала указывая режиссеров из второй половины таблицы (идентификаторы с 6 по 10),
а затем — из первой (идентификаторы с 1 по 5).
В рамках каждой половины режиссеры должны быть расположены в порядке убывания рейтинга, при совпадении — в порядке возрастания идентификатора.

5)Напишите запрос, который извлекает из предложенной базы данных информацию о режиссерах (имя и фамилия, страна рождения, рейтинг),
которые в рамках своей страны имеют самый высокий рейтинг. Если в стране несколько режиссеров с самым высоким рейтингом, то в результирующую таблицу должны быть добавлены они все.
Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля country, при совпадении — в порядке возрастания значения поля full_name.

6)Напишите запрос, который разбивает режиссеров на пары (первый-второй, третий-четвертый, и так далее) и определяет, родились ли режиссеры каждой пары в одной и той же стране.
Запрос должен отобразить полученный результат в виде таблицы из двух полей:
pair — имя и фамилия обоих режиссеров пары в следующем формате:
<имя и фамилия первого режиссера>, <имя и фамилия второго режиссера>
from_same_country — значение yes, если режиссеры родились в одной и той же стране, или no в противном случае*/
/*======================1=========================*/
SET @Y:=(SELECT max(id) div 3 FROM Directors);
WITH t1 AS (
  SELECT ntile(@Y) over(ORDER BY  id) group_number, rating FROM Directors
  ) 
SELECT group_number,avg(rating) avg_rating FROM t1
GROUP BY group_number
ORDER BY 1 DESC;
/*======================2=========================*/
SELECT dense_rank() over(partition by country order by rating desc) rank_in_country , full_name,country,rating FROM Directors
ORDER BY 3,1 DESC,id DESC;
/*======================3=========================*/
with t1 as(select dense_rank() over(ORDER BY rating DESC) as ran, full_name,rating FROM Directors) 
SELECT  full_name ,rating FROM t1
WHERE ran=2
ORDER BY 1;
/*======================4=========================*/
SELECT  id,full_name,country,rating FROM Directors
ORDER BY NTILE(2) OVER (ORDER BY id DESC),rating DESC,id ;
/*======================5=========================*/
with t1 as (SELECT  full_name,country,rating,rank() over(partition by country ORDER BY rating DESC) num  FROM Directors)
SELECT  full_name,country,rating FROM t1
WHERE num=1
ORDER BY 2,1;
/*======================6=========================*/
set @Y:=(Select max(id) div 2 from Directors);
select concat(t1.full_name,', ',t2.full_name)as pair,case
when t1.country=t2.country then 'yes'
else  'no'
end as from_same_country from (Select id,ntile(@Y) over(order by id) as num, full_name,country from Directors) as t1
inner join
(Select id,ntile(@Y) over(order by id) as num, full_name,country from Directors)as t2 on t1.num=t2.num and t1.id<t2.id;
