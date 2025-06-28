/*Вам доступна база данных, принадлежащая социальной сети "ВКонтакте". Она включает таблицу Users, которая хранит информацию о пользователях сети.

Таблица Users
+----+---------+----------+--------------+
| id | name    | surname  | phone_number |
+----+---------+----------+--------------+
| 1  | Matt    | Damon    | +79087333025 |
| 2  | Edward  | Norton   | +79642218964 |
| 3  | Nicolas | Cage     | +79808814813 |
| 4  | Ben     | Affleck  | +79042778299 |
| 5  | John    | Travolta | +79640950623 |
+----+---------+----------+--------------+
Первое поле этой таблицы содержит идентификатор пользователя, второе — имя, третье — фамилию, четвертое — номер телефона.
Напишите запрос, создающий триггер, который перед изменением номера телефона пользователя переводит его в следующий формат:

+7dddddddddd
Также запрос должен включать создание триггера, который при добавлении информации о новом пользователе переводит его номер телефона в формат, приведенный выше.

Гарантируется, что номер телефона пользователя всегда указывается в одном из следующих форматов:

+7dddddddddd
+8dddddddddd
+7 ddd ddd dd dd
+8 ddd ddd dd dd
где d — цифра в диапазоне [0; 9].

Скрипт для создания таблицы Users
DROP TABLE IF EXISTS Users;
CREATE TABLE Users
(
    id           INT AUTO_INCREMENT,
    name         VARCHAR(20),
    surname      VARCHAR(20),
    phone_number VARCHAR(20),
    PRIMARY KEY (id)
);

INSERT INTO Users (name, surname, phone_number)
VALUES ('Matt', 'Damon', '+79087333025'),
       ('Edward', 'Norton', '+79642218964'),
       ('Nicolas', 'Cage', '+79808814813'),
       ('Ben', 'Affleck', '+79042778299'),
       ('John', 'Travolta', '+79640950623');*/
DELIMITER //
CREATE TRIGGER TR_INSERT
before insert
ON Users
FOR EACH ROW
BEGIN
    SET NEW.phone_number = CONCAT('+7',SUBSTRING(replace(NEW.phone_number,' ',''),3));
END//
CREATE TRIGGER TR_UPDATE
BEFORE UPDATE
ON Users
FOR EACH ROW
BEGIN
    SET NEW.phone_number = CONCAT('+7',SUBSTRING(replace(new.phone_number,' ',''),3));
END//

DELIMITER ;
