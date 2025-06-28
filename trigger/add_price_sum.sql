/*ОПИСАНИЕ
Вам доступна база данных, принадлежащая онлайн-кинотеатру "Окко". Она включает таблицы Films, Users и Purchases. Первая таблица хранит информацию о доступных в кинотеатре фильмах,
вторая — информацию о пользователях кинотеатра, третья — информацию о покупках пользователей.

Таблица Films
+----+---------------------+----------------+-------+
| id | title               | director       | price |
+----+---------------------+----------------+-------+
| 1  | Toy Story 2         | John Lasseter  | 2.99  |
| 2  | WALL-E              | Andrew Stanton | 4.99  |
| 3  | Ratatouille         | Brad Bird      | 4.99  |
| 4  | Up                  | Pete Docter    | 4.99  |
| 5  | Brave               | Brenda Chapman | 7.99  |
| 6  | Monsters University | Dan Scanlon    | 7.99  |
| 7  | Cars 2              | John Lasseter  | 7.99  |
| 8  | Finding Nemo        | Andrew Stanton | 4.99  |
| 9  | Toy Story           | John Lasseter  | 2.99  |
| 10 | The Incredibles     | Brad Bird      | 4.99  |
+----+---------------------+----------------+-------+
Первое поле этой таблицы содержит идентификатор фильма, второе — название, третье — имя и фамилию режиссера, четвертое — цену в долларах. 

Таблица Users
+----+---------+----------+----------------+
| id | name    | surname  | total_spending |
+----+---------+----------+----------------+
| 1  | Matt    | Damon    | 23.96          |
| 2  | Edward  | Norton   | 10.98          |
| 3  | Nicolas | Cage     | 10.98          |
| 4  | Ben     | Affleck  | 7.98           |
| 5  | John    | Travolta | 0.0            |
+----+---------+----------+----------------+
Первое поле этой таблицы содержит идентификатор пользователя, второе — имя, третье — фамилию, четвертое — сумму, потраченную на покупку фильмов.  

Таблица Purchases
+----+---------+---------+
| id | film_id | user_id |
+----+---------+---------+
| 1  | 1       | 1       |
| 2  | 1       | 3       |
| 3  | 2       | 4       |
| 4  | 1       | 2       |
| 5  | 9       | 4       |
| 6  | 6       | 1       |
| 7  | 7       | 2       |
| 8  | 6       | 3       |
| 9  | 5       | 1       |
| 10 | 10      | 1       |
+----+---------+---------+
Первое поле этой таблицы содержит идентификатор покупки, второе — идентификатор купленного фильма, третье — идентификатор пользователя, купившего фильм.



Скрипт для создания таблиц Films, Users и Purchases
DROP TABLE IF EXISTS Purchases;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Films;

-- Создание таблицы Films
CREATE TABLE Films
(
    id       INT PRIMARY KEY AUTO_INCREMENT,
    title    VARCHAR(20),
    director VARCHAR(20),
    price    DECIMAL(5, 2)
);

INSERT INTO Films (title, director, price)
VALUES ('Toy Story 2', 'John Lasseter', 2.99),
       ('WALL-E', 'Andrew Stanton', 4.99),
       ('Ratatouille', 'Brad Bird', 4.99),
       ('Up', 'Pete Docter', 4.99),
       ('Brave', 'Brenda Chapman', 7.99),
       ('Monsters University', 'Dan Scanlon', 7.99),
       ('Cars 2', 'John Lasseter', 7.99),
       ('Finding Nemo', 'Andrew Stanton', 4.99),
       ('Toy Story', 'John Lasseter', 2.99),
       ('The Incredibles', 'Brad Bird', 4.99);

-- Создание таблицы Users
CREATE TABLE Users
(
    id             INT PRIMARY KEY AUTO_INCREMENT,
    name           VARCHAR(40),
    surname        VARCHAR(40),
    total_spending DECIMAL(5, 2)
);
INSERT INTO Users (name, surname, total_spending)
VALUES ('Matt', 'Damon', 23.96),
       ('Edward', 'Norton', 10.98),
       ('Nicolas', 'Cage', 10.98),
       ('Ben', 'Affleck', 7.98),
       ('John', 'Travolta', 0.0);

-- Создание таблицы Purchases
CREATE TABLE Purchases
(
    id      INT PRIMARY KEY AUTO_INCREMENT,
    film_id INT,
    user_id INT
);
INSERT INTO Purchases (film_id, user_id)
VALUES (1, 1),
       (1, 3),
       (2, 4),
       (1, 2),
       (9, 4),
       (6, 1),
       (7, 2),
       (6, 3),
       (5, 1),
       (10, 1);
ЗАДАНИЕ
Напишите запрос, создающий триггер, который после покупки пользователем очередного фильма прибавляет к его сумме, потраченной на покупку фильмов, стоимость только что купленного фильма.
*/
DELIMITER //
CREATE TRIGGER UPDSPEND
AFTER INSERT
ON Purchases
FOR EACH ROW
    UPDATE Users  
    INNER JOIN  Purchases  ON Purchases.user_id =  Users.id
    INNER JOIN Films  on Films.id = Purchases.film_id
    SET Users.total_spending = Users.total_spending + Films.price
    WHERE Users.id = (select  user_id from Purchases order by id desc limit 1) and Films.id = (select film_id from Purchases order by id desc limit 1)
    ;
DELIMITER ;
