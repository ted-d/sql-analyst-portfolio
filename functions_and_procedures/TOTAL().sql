/*Вам доступна база данных, принадлежащая маркетплейсу Ozon. Она включает таблицу Orders, которая хранит информацию о заказах покупателей.

Таблица Orders
+----+--------------+--------+
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
+----+--------------+--------+
Первое поле этой таблицы содержит идентификатор заказа, второе — название магазина, в котором был совершен заказ, третье — сумму заказа в долларах.

Реализуйте функцию TOTAL(), которая принимает один аргумент:

store_name — строка, название магазина
Функция должна возвращать общую сумму, которую заработал магазин с названием store_name.

Скрипт для создания таблицы Orders
DROP TABLE IF EXISTS Orders;
CREATE TABLE Orders
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    store      VARCHAR(40),
    amount     INT
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
       ('DarkStore', 325);
Тестовые данные
Запрос	Результат запроса
SELECT TOTAL('Ozon')	2038
SELECT TOTAL('PCUniverse')	1756
SELECT TOTAL('DarkStore')	1439
Примечание 1. В качестве типов параметров функции, типа возвращаемого значения и типов переменных допустимо использовать любые согласованные с условием задачи типы данных.

Примечание 2. В этой задаче допускается выполнять более одного SQL-запроса.*/
DELIMITER //
CREATE FUNCTION TOTAL(store_name TEXT)
RETURNS INT
NOT DETERMINISTIC
READS SQL DATA
BEGIN

 RETURN(SELECT SUM(amount) FROM Orders
              WHERE STORE =  store_name
       GROUP BY store
       );
       
END//
DELIMITER ;

SELECT TOTAL('Ozon');
