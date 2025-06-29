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
Напишите запрос, который разбивает режиссеров на группы по три человека (первый-второй-третий, четвертый-пятый-шестой, и так далее), определяет средний рейтинг режиссеров каждой группы и отображает полученный результат в виде таблицы из двух полей:

group_number — номер группы
avg_rating — средний рейтинг режиссеров группы
Записи в результирующей таблице должны быть расположены в порядке убывания значения поля group_number.

Результат запроса
+--------------+------------+
| group_number | avg_rating |
+--------------+------------+
| 3            | 53.6667    |
| 2            | 65.0000    |
| 1            | 89.6667    |
+--------------+------------+
*/
SET @Y:=(SELECT max(id) div 3 FROM Directors);
WITH t1 AS (
  SELECT ntile(@Y) over(ORDER BY  id) group_number, rating FROM Directors
  ) 
SELECT group_number,avg(rating) avg_rating FROM t1
GROUP BY group_number
ORDER BY 1 DESC
