/*Вам доступна база данных, принадлежащая маркетплейсу Ozon. Она включает таблицы Customers, Orders и Notifications.
Первая таблица содержит информацию о покупателях магазина, вторая — информацию о заказанных товарах, третья — информацию об уведомлениях покупателей.

Таблица Customers
+----+--------+
| id | name   |
+----+--------+
| 10 | Ivan   |
| 20 | John   |
| 30 | Mark   |
| 40 | Elon   |
| 50 | Pavel  |
| 60 | Andrey |
| 70 | Peter  |
| 80 | Ben    |
+----+--------+
Первое поле этой таблицы содержит идентификатор покупателя, второе — имя.

Таблица Orders
+----+-------------+------------+--------+-----------+
| id | customer_id | store      | amount | status    |
+----+-------------+------------+--------+-----------+
| 1  | 20          | Ozon       | 101    | Created   |
| 2  | 40          | PCUniverse | 799    | Shipped   |
| 3  | 10          | PCUniverse | 99     | Delivered |
| 4  | 30          | DarkStore  | 99     | Created   |
| 5  | 50          | Ozon       | 678    | Delivered |
| 6  | 10          | Ozon       | 458    | Created   |
+----+-------------+------------+--------+-----------+
Первое поле этой таблицы содержит идентификатор заказа, второе — идентификатор покупателя, третье— название магазина,
в котором был совершен заказ, четвертое — сумму заказа в долларах, пятое — статус заказа (Created — создан, Shipped — отправлен, Delivered — доставлен).

Таблица Notifications
+----+----------+-------------------------------------------------------------+
| id | order_id | message                                                     |
+----+----------+-------------------------------------------------------------+
| 1  | 1        | John, new status of your delivery on 2024-08-26: Created    |
| 2  | 2        | Elon, new status of your delivery on 2024-08-26: Shipped    |
| 3  | 3        | Ivan, new status of your delivery on 2024-08-26: Delivered  |
| 4  | 4        | Mark, new status of your delivery on 2024-08-26: Created    |
| 5  | 5        | Pavel, new status of your delivery on 2024-08-26: Delivered |
| 6  | 6        | Ivan, new status of your delivery on 2024-08-26: Created    |
+----+----------+-------------------------------------------------------------+
Первое поле этой таблицы содержит идентификатор уведомления, второе — идентификатор заказа, третье — сообщение с уведомлением покупателя.

Напишите запрос, создающий триггер, который после добавления нового заказа также добавляет сообщение для покупателя.
При этом сообщение должно быть записано в следующем формате:

<Имя покупателя>, new status of your delivery on <текущая дата>: <статус заказа>
Также запрос должен включать создание триггера, который после обновления статуса заказа также обновляет сообщение для покупателя.
При этом сообщение должно быть записано в том же формате, что и при добавлении заказа.

Скрипт для создания таблиц Customers, Orders и Notifications
DROP TABLE IF EXISTS Notifications;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Customers;

CREATE TABLE Customers
(
    id   INT,
    name VARCHAR(40)
);

INSERT INTO Customers (id, name)
VALUES (10, 'Ivan'),
       (20, 'John'),
       (30, 'Mark'),
       (40, 'Elon'),
       (50, 'Pavel'),
       (60, 'Andrey'),
       (70, 'Peter'),
       (80, 'Ben');

CREATE TABLE Orders
(
    id          INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    store       VARCHAR(40),
    amount      INT,
    status      VARCHAR(40)
);

INSERT INTO Orders (store, customer_id, amount, status)
VALUES ('Ozon', 20, 101, 'Created'),
       ('PCUniverse', 40, 799, 'Shipped'),
       ('PCUniverse', 10, 99, 'Delivered'),
       ('DarkStore', 30, 99, 'Created'),
       ('Ozon', 50, 678, 'Delivered'),
       ('Ozon', 10, 458, 'Created');

CREATE TABLE Notifications
(
    id          INT PRIMARY KEY AUTO_INCREMENT,
    order_id    INT,
    message     TEXT,
    FOREIGN KEY (order_id) REFERENCES Orders (id)
);

INSERT INTO Notifications (order_id, message)
VALUES (1, 'John, new status of your delivery on 2024-08-26: Created'),
       (2, 'Elon, new status of your delivery on 2024-08-26: Shipped'),
       (3, 'Ivan, new status of your delivery on 2024-08-26: Delivered'),
       (4, 'Mark, new status of your delivery on 2024-08-26: Created'),
       (5, 'Pavel, new status of your delivery on 2024-08-26: Delivered'),
       (6, 'Ivan, new status of your delivery on 2024-08-26: Created');
Тестовые данные
Примечание 1. Имена создаваемых триггеров могут быть произвольными.

Примечание 2. Поле id таблицы Notifications использует ограничение AUTO_INCREMENT.

Примечание 3. В этой задаче допускается выполнять более одного SQL-запроса.*/
DELIMITER //
CREATE TRIGGER CH_Orders
AFTER insert ON Orders
FOR EACH ROW
BEGIN
   insert into Notifications(order_id,message)
    VALUES (
        NEW.id, 
        CONCAT((SELECT name FROM Customers WHERE id = NEW.customer_id), ", new status of your delivery on ", CAST(NOW() AS DATE), ": ", NEW.status)
    );  
END //
CREATE TRIGGER TR_UPDATE
after UPDATE
ON Orders
FOR EACH ROW
BEGIN
    update Notifications
    SET message = ( select concat(name,", ","new status of your delivery on ",CAST(now() AS DATE),": ",status)as message from Orders as t1
    inner join Customers as t2 on t2.id = t1.customer_id
         where t1.id =NEW.id )
    where order_id = New.id;
END//
DELIMITER ;
