/*Вам доступна база данных, принадлежащая сервису "Кинопоиск". Она включает таблицу Actors, которая хранит информацию о различных популярных актерах.

Таблица Actors
+----+----------+-------------+-------------+------------------------+
| id | name     | surname     | birth_date  | birth_time             |
+----+----------+-------------+-------------+------------------------+
| 1  | Paul     | Walker      | 12 Sep 1973 | Hours: 19, Minutes: 10 |
| 2  | Emma     | Wiklund     | 13 Sep 1968 | Hours: 6, Minutes: 15  |
| 3  | Scarlett | Johansson   | 22 Nov 1984 | Hours: 18, Minutes: 30 |
| 4  | Angelina | Jolie       | 04 Jun 1975 | Hours: 5, Minutes: 55  |
| 5  | Trevor   | Duke-Moretz | 13 Sep 1986 | Hours: 10, Minutes: 10 |
| 6  | Meryl    | Streep      | 22 Jun 1949 | Hours: 8, Minutes: 5   |
| 7  | Tyler    | Hoechlin    | 11 Sep 1987 | Hours: 2, Minutes: 47  |
| 8  | Tom      | Hanks       | 09 Jul 1956 | Hours: 15, Minutes: 20 |
| 9  | Jennifer | Aniston     | 11 Feb 1969 | Hours: 14, Minutes: 25 |
| 10 | Andrew   | Lincoln     | 14 Sep 1973 | Hours: 1, Minutes: 40  |
+----+----------+-------------+-------------+------------------------+
Первое поле этой таблицы содержит идентификатор актера, второе — имя, третье — фамилию, четвертое — дату рождения, пятое — время рождения.

Напишите запрос, извлекающий из предложенной базы данных информацию об актерах (имя, фамилия, дата рождения, время рождения), которые родились в сентябре. При этом дата и время рождения каждого актера должны быть записаны в формате ISO.

Результат запроса
+--------+-------------+------------+------------+
| name   | surname     | birth_date | birth_time |
+--------+-------------+------------+------------+
| Paul   | Walker      | 1973-09-12 | 19:10:00   |
| Emma   | Wiklund     | 1968-09-13 | 06:15:00   |
| Trevor | Duke-Moretz | 1986-09-13 | 10:10:00   |
| Tyler  | Hoechlin    | 1987-09-11 | 02:47:00   |
| Andrew | Lincoln     | 1973-09-14 | 01:40:00   |
+--------+-------------+------------+------------+
Таблица спецификаторов формата
Спецификатор	Описание
%M	Полное название месяца (January..December)
%b	Сокращенное название месяца (Jan..Dec)
%W	Полное название дня недели (Sunday..Saturday)
%a	Сокращенное название дня недели (Sun..Sat)
%Y	Год (0000..9999)
%m	Номер месяца (00..12)
%d	День месяца (00..31)
%w	Номер дня недели (0..6)
%H	Часы (00..23)
%i	Минуты (00..59)
%S	Секунды (00..59)
%f	Микросекунды (000000..999999)
%T	Время в формате HH:MM:SS
Скрипт для создания таблицы Actors
DROP TABLE IF EXISTS Actors;
CREATE TABLE Actors
(
   id         INT AUTO_INCREMENT PRIMARY KEY,
   name       VARCHAR(20),
   surname    VARCHAR(20),
   birth_date VARCHAR(20),
   birth_time VARCHAR(30)
);

INSERT INTO Actors (name, surname, birth_date, birth_time)
VALUES ('Paul', 'Walker', '12 Sep 1973', 'Hours: 19, Minutes: 10'),
       ('Emma', 'Wiklund', '13 Sep 1968', 'Hours: 6, Minutes: 15'),
       ('Scarlett', 'Johansson', '22 Nov 1984', 'Hours: 18, Minutes: 30'),
       ('Angelina', 'Jolie', '04 Jun 1975', 'Hours: 5, Minutes: 55'),
       ('Trevor', 'Duke-Moretz', '13 Sep 1986', 'Hours: 10, Minutes: 10'),
       ('Meryl', 'Streep', '22 Jun 1949', 'Hours: 8, Minutes: 5'),
       ('Tyler', 'Hoechlin', '11 Sep 1987', 'Hours: 2, Minutes: 47'),
       ('Tom', 'Hanks', '09 Jul 1956', 'Hours: 15, Minutes: 20'),
       ('Jennifer', 'Aniston', '11 Feb 1969', 'Hours: 14, Minutes: 25'),
       ('Andrew', 'Lincoln', '14 Sep 1973', 'Hours: 1, Minutes: 40');
Примечание 1. Записи в результирующей таблице могут быть расположены в произвольном порядке.

Примечание 2. Компоненты времени (часы, минуты, секунды) в поле birth_time результирующей таблицы необязательно должны быть предварены незначащими нулями.*/
SELECT name,surname ,str_to_date(birth_date,'%d %b %Y') AS birth_date, time_format(str_to_date(birth_time,'Hours: %H, Minutes: %i'),get_format(Time,'ISO')) AS birth_time FROM Actors
WHERE MONTH(str_to_date(birth_date,'%d %b %Y'))=9;
