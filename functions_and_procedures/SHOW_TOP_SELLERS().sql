/*SHOW_TOP_SELLERS()
Вам доступна база данных, принадлежащая маркетплейсу Ozon. Она включает таблицу Orders, которая хранит информацию о заказах покупателей.

Таблица Orders
​+----+--------------+--------+
| id | store        | amount |
+----+--------------+--------+
| 1  | Ozon         | 101    |
| 2  | PCUniverse   | 799    |
| 3  | PCUniverse   | 99     |
| 4  | DarkStore    | 99     |
| 5  | DarkStore    | 1015   |
| 6  | Ozon         | 678    |
| 7  | PCUniverse   | 858    |
| 8  | Ozon         | 458    |
| 9  | Ozon         | 801    |
| 10 | DarkStore    | 325    |
| 11 | Gloria Jeans | 811    |
| 12 | Mvideo       | 422    |
| 13 | Mvideo       | 667    |
| 14 | Gloria Jeans | 83     |
| 15 | Gloria Jeans | 1500   |
| 16 | Ozon         | 242    |
| 17 | PCUniverse   | 679    |
| 18 | Gloria Jeans | 328    |
| 19 | Ozon         | 1      |
| 20 | DarkStore    | 42     |
| 21 | PCUniverse   | 189    |
| 22 | Gloria Jeans | 317    |
| 23 | DarkStore    | 522    |
| 24 | Mvideo       | 10     |
| 25 | Gloria Jeans | 400    |
+----+--------------+--------+
Первое поле этой таблицы содержит идентификатор заказа, второе — название магазина, в котором был совершен заказ, третье — сумму заказа в долларах.

Реализуйте процедуру SHOW_TOP_SELLERS(), которая не принимает никаких аргументов. Процедура должна извлекать из предложенной базы данных названия трех магазинов с наибольшей общей суммой продаж.

Результат выполнения процедуры SHOW_TOP_SELLERS()
+--------------+
| store        |
+--------------+
| Gloria Jeans |
| PCUniverse   |
| Ozon         |
+--------------+
Скрипт для создания таблицы Orders
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders
(
    id     INT PRIMARY KEY AUTO_INCREMENT,
    store  VARCHAR(40),
    amount INT
);

INSERT INTO Orders (store, amount)
VALUES ('Ozon', 101),
       ('PCUniverse', 799),
       ('PCUniverse', 99),
       ('DarkStore', 99),
       ('DarkStore', 1015),
       ('Ozon', 678),
       ('PCUniverse', 858),
       ('Ozon', 458),
       ('Ozon', 801),
       ('DarkStore', 325),
       ('Gloria Jeans', 811),
       ('Mvideo', 422),
       ('Mvideo', 667),
       ('Gloria Jeans', 83),
       ('Gloria Jeans', 1500),
       ('Ozon', 242),
       ('PCUniverse', 679),
       ('Gloria Jeans', 328),
       ('Ozon', 1),
       ('DarkStore', 42),
       ('PCUniverse', 189),
       ('Gloria Jeans', 317),
       ('DarkStore', 522),
       ('Mvideo', 10),
       ('Gloria Jeans', 400);
Примечание 1. Гарантируется, что все магазины имеют различные общие суммы продаж.

Примечание 2. Названия магазинов могут быть расположены в произвольном порядке.

Примечание 3. В этой задаче допускается выполнять более одного SQL-запроса.*/
DELIMITER //
CREATE PROCEDURE SHOW_TOP_SELLERS()
DETERMINISTIC
BEGIN
SELECT store FROM Orders
GROUP BY store
ORDER BY SUM(amount) DESC LIMIT 3;
END//
DELIMITER;
CALL SHOW_TOP_SELLERS();
