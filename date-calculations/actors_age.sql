/*Вам доступна база данных, принадлежащая сервису "Кинопоиск". Она включает таблицу Actors, которая хранит информацию о различных популярных актерах.

Таблица Actors
+----+----------+-------------+------------+
| id | name     | surname     | birth_date |
+----+----------+-------------+------------+
| 1  | Paul     | Walker      | 1973-09-12 |
| 2  | Emma     | Wiklund     | 1968-09-13 |
| 3  | Scarlett | Johansson   | 1984-11-22 |
| 4  | Angelina | Jolie       | 1975-06-04 |
| 5  | Trevor   | Duke-Moretz | 1986-09-13 |
| 6  | Meryl    | Streep      | 1949-06-22 |
| 7  | Tyler    | Hoechlin    | 1987-09-11 |
| 8  | Tom      | Hanks       | 1956-07-09 |
| 9  | Jennifer | Aniston     | 1969-02-11 |
| 10 | Andrew   | Lincoln     | 1973-09-14 |
+----+----------+-------------+------------+
Напишите запрос, который извлекает из предложенной базы данных имена и фамилии актеров, а также определяет текущий возраст каждого актера.
При этом вычисление текущего возраста должно выполняться без учета каких-либо часовых поясов.

Поле с текущим возрастом актера должно иметь псевдоним age.

Записи в результирующей таблице должны быть расположены в порядке убывания значения поля age.

Возможный результат запроса
+----------+-------------+-----+
| name     | surname     | age |
+----------+-------------+-----+
| Meryl    | Streep      | 74  |
| Tom      | Hanks       | 67  |
| Emma     | Wiklund     | 55  |
| Jennifer | Aniston     | 54  |
| Paul     | Walker      | 50  |
| Andrew   | Lincoln     | 50  |
| Angelina | Jolie       | 48  |
| Scarlett | Johansson   | 38  |
| Trevor   | Duke-Moretz | 37  |
| Tyler    | Hoechlin    | 36  |
+----------+-------------+-----+
Скрипт для создания таблицы Actors
DROP TABLE IF EXISTS Actors;
CREATE TABLE Actors
(
    id         INT AUTO_INCREMENT PRIMARY KEY,
    name       VARCHAR(20),
    surname    VARCHAR(20),
    birth_date DATE
);

INSERT INTO Actors (name, surname, birth_date)
VALUES ('Paul', 'Walker', '1973-09-12'),
       ('Emma', 'Wiklund', '1968-09-13'),
       ('Scarlett', 'Johansson', '1984-11-22'),
       ('Angelina', 'Jolie', '1975-06-04'),
       ('Trevor', 'Duke-Moretz', '1986-09-13'),
       ('Meryl', 'Streep', '1949-06-22'),
       ('Tyler', 'Hoechlin', '1987-09-11'),
       ('Tom', 'Hanks', '1956-07-09'),
       ('Jennifer', 'Aniston', '1969-02-11'),
       ('Andrew', 'Lincoln', '1973-09-14');
Примечание. Результат запроса, представленный в условии задачи, является актуальным лишь на момент создания задачи и может отличаться от вашего.*/
SELECT name,surname,timestampdiff(YEAR,birth_date,CURRENT_DATE()) AS age FROM Actors
ORDER BY age DESC
