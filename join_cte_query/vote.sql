/*Вам доступна база данных, принадлежащая организации по проведению выборов в городе Брайт Фоллс. Она включает таблицу Votes, которая хранит информацию о голосах избирателей.

Таблица Votes
+----------+-----------+
| voter    | candidate |
+----------+-----------+
| Shaun    | Eric      |
| Donna    | Emily     |
| Donna    | Moro      |
| Tina     | Deborah   |
| Tina     | Michael   |
| Laura    | NULL      |
| James    | Michael   |
| James    | Emily     |
| Wanda    | Eric      |
| Dustin   | NULL      |
| William  | Victoria  |
| Kylie    | Emily     |
| Traci    | Amber     |
| William  | Stephen   |
| Tina     | Christina |
| Kylie    | Vincent   |
| Shaun    | Michael   |
| Samantha | Stephen   |
| James    | Christina |
| Shaun    | Vincent   |
| Shaun    | Deborah   |
| Melissa  | Amber     |
| Samantha | Amber     |
| Shaun    | Bryan     |
| Donna    | Amber     |
| Melissa  | Eric      |
| Robin    | NULL      |
| Wanda    | Emily     |
| James    | Stephen   |
| Tina     | Amber     |
| Kevin    | NULL      |
| Shaun    | Victoria  |
| Wanda    | Bryan     |
| Michelle | NULL      |
| Traci    | Emily     |
| Shaun    | Stephen   |
| William  | Michael   |
| William  | Emily     |
| John     | NULL      |
| Melissa  | Michael   |
+----------+-----------+
Первое поле этой таблицы содержит имя избирателя, второе — имя кандидата, за которого отдан голос. Если избиратель решил не голосовать, значением поля candidate является NULL.
Каждый избиратель имеет 1 голос, который он может отдать одному или нескольким кандидатам. Если избиратель голосует за нескольких кандидатов, его голос распределяются между ними поровну. Например, если избиратель голосует за 2кандидатов, каждый из них получит по 0.5 голосов.

Напишите запрос, который определяет имя кандидата, набравшего наибольшее количество голосов.

Результат запроса
+-----------+
| candidate |
+-----------+
| Emily     |
+-----------+
Скрипт для создания таблицы Votes
DROP TABLE IF EXISTS Votes;
CREATE TABLE Votes
(
    voter     VARCHAR(50),
    candidate VARCHAR(50)
);

INSERT INTO Votes (voter, candidate)
VALUES ('Shaun', 'Eric'),
       ('Donna', 'Emily'),
       ('Donna', 'Moro'),
       ('Tina', 'Deborah'),
       ('Tina', 'Michael'),
       ('Laura', NULL),
       ('James', 'Michael'),
       ('James', 'Emily'),
       ('Wanda', 'Eric'),
       ('Dustin', NULL),
       ('William', 'Victoria'),
       ('Kylie', 'Emily'),
       ('Traci', 'Amber'),
       ('William', 'Stephen'),
       ('Tina', 'Christina'),
       ('Kylie', 'Vincent'),
       ('Shaun', 'Michael'),
       ('Samantha', 'Stephen'),
       ('James', 'Christina'),
       ('Shaun', 'Vincent'),
       ('Shaun', 'Deborah'),
       ('Melissa', 'Amber'),
       ('Samantha', 'Amber'),
       ('Shaun', 'Bryan'),
       ('Donna', 'Amber'),
       ('Melissa', 'Eric'),
       ('Robin', NULL),
       ('Wanda', 'Emily'),
       ('James', 'Stephen'),
       ('Tina', 'Amber'),
       ('Kevin', NULL),
       ('Shaun', 'Victoria'),
       ('Wanda', 'Bryan'),
       ('Michelle', NULL),
       ('Traci', 'Emily'),
       ('Shaun', 'Stephen'),
       ('William', 'Michael'),
       ('William', 'Emily'),
       ('John', NULL),
       ('Melissa', 'Michael');
Примечание 1. Гарантируется, что только один кандидат набрал наибольшее количество голосов.

Примечание 2. При решении задачи используйте обобщенное табличное выражение для визуального упрощения запроса.*/
with t1 as (select count(distinct v1.voter) m, v1.candidate from Votes as v1
inner join Votes as v2 on v1.voter= v2.voter
group by v1.candidate)
select candidate from t1
where m = (select max(m) from t1 ) and candidate is not NULL
