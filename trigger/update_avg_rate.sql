/*Вам доступна база данных, принадлежащая интернет-магазину Amazon. Она включает таблицы Products и Reviews. Первая таблица содержит информацию о доступных в магазине товарах, вторая — информацию об отзывах на товары.

Таблица Products
+----+---------------------------+------------+
| id | name                      | avg_rating |
+----+---------------------------+------------+
| 10 | Instant Pot Duo 7-in-1    | 5.00       |
| 20 | Amazon Echo Dot (4th Gen) | 5.00       |
| 30 | PlayStation 5             | 5.00       |
| 40 | Apple AirPods Pro         | 5.00       |
| 50 | Samsung 65-inch QLED TV   | 5.00       |
+----+---------------------------+------------+
Первое поле этой таблицы содержит идентификатор товара, второе — название, третье — средний рейтинг.
Таблица Reviews
+----+------------+--------+
| id | product_id | rating |
+----+------------+--------+
| 1  | 10         | 5      |
| 2  | 20         | 5      |
| 3  | 30         | 5      |
| 4  | 40         | 5      |
| 5  | 50         | 5      |
+----+------------+--------+
Первое поле этой таблицы содержит идентификатор отзыва, второе — идентификатор товара, на который оставлен отзыв, третье — оценку товара (от 
1
1 до 
5
5).
Напишите запрос, создающий триггер, который после добавления нового отзыва обновляет средний рейтинг соответствующего товара.

Скрипт для создания таблиц Products и Reviews
DROP TABLE IF EXISTS Reviews;
DROP TABLE IF EXISTS Products;

-- Создание таблицы Products
CREATE TABLE Products
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    name       VARCHAR(50),
    avg_rating DECIMAL(3, 2)
);

INSERT INTO Products
VALUES (10, 'Instant Pot Duo 7-in-1', 5),
       (20, 'Amazon Echo Dot (4th Gen)', 5),
       (30, 'PlayStation 5', 5),
       (40, 'Apple AirPods Pro', 5),
       (50, 'Samsung 65-inch QLED TV', 5);

-- Создание таблицы Reviews
CREATE TABLE Reviews
(
    id          INT PRIMARY KEY AUTO_INCREMENT,
    product_id  INT,
    rating      INT,
    FOREIGN KEY (product_id) REFERENCES Products (id)
);

INSERT INTO Reviews (product_id, rating)
VALUES (10, 5),
       (20, 5),
       (30, 5),
       (40, 5),
       (50, 5);*/
DELIMITER //
CREATE TRIGGER CH_Orders
AFTER INSERT ON Reviews
FOR EACH ROW
BEGIN
    DECLARE new_avg_rating DECIMAL(3,2);
    SELECT AVG(rating) INTO new_avg_rating
    FROM Reviews
    WHERE product_id = NEW.product_id;
    IF new_avg_rating IS NOT NULL THEN
        UPDATE Products
        SET avg_rating = new_avg_rating
        WHERE id = NEW.product_id;
    END IF;
END //
DELIMITER ;
