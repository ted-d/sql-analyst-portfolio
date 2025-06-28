/*Вам доступна база данных, принадлежащая службе такси Uber. Она включает таблицы Users и Trips. Первая таблица хранит информацию о пользователях такси, включая водителей и пассажиров, вторая — информацию о поездках пассажиров.

Таблица Users
+----+--------+--------+
| id | banned | role   |
+----+--------+--------+
| 1  | yes    | client |
| 2  | yes    | client |
| 3  | no     | client |
| 4  | no     | client |
| 5  | no     | client |
| 6  | no     | driver |
| 7  | no     | driver |
| 8  | no     | driver |
| 9  | no     | driver |
| 10 | yes    | driver |
| 11 | no     | driver |
+----+--------+--------+
Первое поле этой таблицы содержит идентификатор пользователя, второе — статус блокировки пользователя (yes — заблокирован, no — не заблокирован), третье — роль (driver — водитель, client — пассажир).

Таблица Trips
+----+-----------+-----------+---------------------+------------+
| id | client_id | driver_id | status              | request_at |
+----+-----------+-----------+---------------------+------------+
| 1  | 3         | 6         | completed           | 2023-10-01 |
| 2  | 4         | 8         | completed           | 2023-10-01 |
| 3  | 2         | 9         | completed           | 2023-10-01 |
| 4  | 1         | 8         | cancelled_by_client | 2023-10-01 |
| 5  | 5         | 11        | completed           | 2023-10-02 |
| 6  | 5         | 11        | cancelled_by_driver | 2023-10-02 |
| 7  | 2         | 10        | completed           | 2023-10-02 |
| 8  | 2         | 8         | completed           | 2023-10-02 |
| 9  | 3         | 11        | completed           | 2023-10-02 |
| 10 | 3         | 7         | cancelled_by_driver | 2023-10-03 |
| 11 | 2         | 6         | cancelled_by_driver | 2023-10-03 |
| 12 | 4         | 8         | completed           | 2023-10-03 |
| 13 | 2         | 11        | completed           | 2023-10-03 |
| 14 | 3         | 10        | completed           | 2023-10-04 |
| 15 | 1         | 10        | completed           | 2023-10-05 |
| 16 | 4         | 8         | completed           | 2023-10-05 |
| 17 | 2         | 8         | cancelled_by_driver | 2023-10-05 |
| 18 | 5         | 9         | completed           | 2023-10-05 |
| 19 | 2         | 6         | completed           | 2023-10-05 |
| 20 | 5         | 8         | completed           | 2023-10-06 |
| 21 | 3         | 9         | completed           | 2023-10-06 |
| 22 | 2         | 10        | completed           | 2023-10-07 |
| 23 | 2         | 6         | completed           | 2023-10-07 |
| 24 | 3         | 6         | completed           | 2023-10-08 |
| 25 | 3         | 7         | completed           | 2023-10-08 |
| 26 | 5         | 8         | completed           | 2023-10-09 |
| 27 | 2         | 8         | completed           | 2023-10-09 |
| 28 | 2         | 11        | completed           | 2023-10-09 |
| 29 | 4         | 10        | completed           | 2023-10-09 |
| 30 | 3         | 11        | completed           | 2023-10-10 |
+----+-----------+-----------+---------------------+------------+
Первое поле этой таблицы содержит идентификатор поездки, второе — идентификатор пассажира, третье — идентификатор водителя, четвертое — статус поездки (completed — завершена, cancelled_by_driver — отменена водителем, cancelled_by_client — отменена пассажиром), пятое — дату поездки.

Каждый день службе такси необходимо знать коэффициент отмененных поездок, который вычисляется путем деления количества отмененных в день поездок (водителем или пассажиром) на количество всех совершенных в этот день поездок. Причем те поездки, в которых водитель или пассажир заблокированы, не учитываются.

Напишите запрос, который для дней 2023-10-01, 2023-10-02 и 2023-10-03 определяет коэффициент отмененных поездок и отображает полученный результат в виде таблицы из двух полей:

day — день
cancellation_rate — коэффициент поездок, отмененных в этот день 
Значения в поле cancellation_rate должны быть округлены до 2 знаков после запятой.

Результат запроса
+------------+-------------------+
| day        | cancellation_rate |
+------------+-------------------+
| 2023-10-01 | 0.00              |
| 2023-10-03 | 0.50              |
| 2023-10-02 | 0.33              |
+------------+-------------------+
Скрипт для создания таблиц Trips и Users
DROP TABLE IF EXISTS Trips;
DROP TABLE IF EXISTS Users;

-- Создание таблицы Users
CREATE TABLE Users
(
    id       INT AUTO_INCREMENT PRIMARY KEY,
    banned   VARCHAR(50),
    role     ENUM ('client', 'driver')
);

INSERT INTO Users(banned, role)
VALUES ('yes', 'client'),
       ('yes', 'client'),
       ('no', 'client'),
       ('no', 'client'),
       ('no', 'client'),
       ('no', 'driver'),
       ('no', 'driver'),
       ('no', 'driver'),
       ('no', 'driver'),
       ('yes', 'driver'),
       ('no', 'driver');

-- Создание таблицы Trips
CREATE TABLE Trips
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    client_id  INT,
    driver_id  INT,
    status     ENUM ('completed', 'cancelled_by_driver', 'cancelled_by_client'),
    request_at VARCHAR(50)
);

TRUNCATE Trips;
INSERT INTO Trips(client_id, driver_id, status, request_at)
VALUES (3, 6, 'completed', '2023-10-01'),
       (4, 8, 'completed', '2023-10-01'),
       (2, 9, 'completed', '2023-10-01'),
       (1, 8, 'cancelled_by_client', '2023-10-01'),
       (5, 11, 'completed', '2023-10-02'),
       (5, 11, 'cancelled_by_driver', '2023-10-02'),
       (2, 10, 'completed', '2023-10-02'),
       (2, 8, 'completed', '2023-10-02'),
       (3, 11, 'completed', '2023-10-02'),
       (3, 7, 'cancelled_by_driver', '2023-10-03'),
       (2, 6, 'cancelled_by_driver', '2023-10-03'),
       (4, 8, 'completed', '2023-10-03'),
       (2, 11, 'completed', '2023-10-03'),
       (3, 10, 'completed', '2023-10-04'),
       (1, 10, 'completed', '2023-10-05'),
       (4, 8, 'completed', '2023-10-05'),
       (2, 8, 'cancelled_by_driver', '2023-10-05'),
       (5, 9, 'completed', '2023-10-05'),
       (2, 6, 'completed', '2023-10-05'),
       (5, 8, 'completed', '2023-10-06'),
       (3, 9, 'completed', '2023-10-06'),
       (2, 10, 'completed', '2023-10-07'),
       (2, 6, 'completed', '2023-10-07'),
       (3, 6, 'completed', '2023-10-08'),
       (3, 7, 'completed', '2023-10-08'),
       (5, 8, 'completed', '2023-10-09'),
       (2, 8, 'completed', '2023-10-09'),
       (2, 11, 'completed', '2023-10-09'),
       (4, 10, 'completed', '2023-10-09'),
       (3, 11, 'completed', '2023-10-10');*/
SELECT
  request_at AS day,
  ROUND(SUM(CASE WHEN status IN ('cancelled_by_client', 'cancelled_by_driver') THEN 1 ELSE 0 END) / COUNT(*), 2) AS cancellation_rate
FROM
  Users u
  LEFT JOIN Trips t ON u.id IN (client_id, driver_id)
                      AND (client_id, driver_id) NOT IN (
                          SELECT client_id, driver_id
                          FROM Users u
                          INNER JOIN Trips t ON u.id IN (client_id, driver_id) AND banned = 'yes'
                      )
WHERE
  request_at IN ('2023-10-01', '2023-10-02', '2023-10-03')
  
GROUP BY
  day;
