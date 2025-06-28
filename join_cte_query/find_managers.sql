/*Вам доступна база данных, принадлежащая компании Google. Она включает таблицы Departments, Job и Employees. Первая таблица хранит информацию об имеющихся в компании отделах, вторая — информацию о доступных должностях, третья — информацию о сотрудниках компании.

Схема базы данных


Таблица Departments
+----+--------------------------+
| id (pk)| name                     |
+----+--------------------------+
| 1  | Engineering              |
| 2  | Marketing                |
| 3  | Sales                    |
| 4  | Finance                  |
| 5  | HR                       |
| 6  | IT                       |
| 7  | Operations               |
| 8  | Customer Service         |
| 9  | Research and Development |
| 10 | Product Management       |
+----+--------------------------+
Первое поле этой таблицы содержит идентификатор отдела, второе — название.

Таблица Job
+----+---------------------------------+
| id (pk) | title                           |
+----+---------------------------------+
| 1  | Software Engineer               |
| 2  | Managing director               |
| 3  | Marketing Manager               |
| 4  | Sales Manager                   |
| 5  | Finance Analyst                 |
| 6  | Risk Management Analyst         |
| 7  | HR Manager                      |
| 8  | IT Specialist                   |
| 9  | Salesman                        |
| 10 | Operations Manager              |
| 11 | Customer Service Representative |
| 12 | Maintenance man                 |
| 13 | Research Scientist              |
| 14 | Product Manager                 |
| 15 | Quality Assurance Analyst       |
| 16 | Design Lead                     |
+----+---------------------------------+
Первое поле этой таблицы содержит идентификатор должности, второе — название.

Таблица Employees
+----+--------------------+---------------+--------+------------+----------+
| id (pk) | full_name          | department_id | job_id | manager_id | salary   |
+----+--------------------+---------------+--------+------------+----------+
| 1  | Sergey Brin        | 1             | 1      | NULL       | 10000.00 |
| 2  | Larry Page         | 1             | 1      | 1          | 9000.00  |
| 3  | Susan Wojcicki     | 1             | 1      | 1          | 8500.00  |
| 4  | John Smith         | 1             | 6      | 2          | 7500.00  |
| 5  | Alice Johnson      | 1             | 6      | 2          | 7000.00  |
| 6  | Eric Schmidt       | 2             | 2      | NULL       | 9500.00  |
| 7  | Marissa Mayer      | 2             | 2      | 5          | 9000.00  |
| 8  | Sheryl Sandberg    | 2             | 2      | 5          | 8500.00  |
| 9  | Jane Williams      | 2             | 6      | 6          | 7000.00  |
| 10 | John Doerr         | 3             | 6      | NULL       | 11000.00 |
| 11 | Sundar Pichai      | 3             | 2      | 9          | 10500.00 |
| 12 | Alana Davis        | 3             | 12     | 9          | 11000.00 |
| 13 | Bob Thompson       | 3             | 6      | 10         | 9500.00  |
| 14 | Ruth Porat         | 4             | 4      | NULL       | 11000.00 |
| 15 | Patrick Pichette   | 4             | 4      | 13         | 10500.00 |
| 16 | Alex Turner        | 4             | 4      | 13         | 6000.00  |
| 17 | Laszlo Bock        | 5             | 5      | NULL       | 12000.00 |
| 18 | Eileen Naughton    | 5             | 5      | 16         | 11500.00 |
| 19 | Michael Brown      | 5             | 5      | 16         | 8000.00  |
| 20 | Vint Cerf          | 6             | 6      | NULL       | 13000.00 |
| 21 | Urs Holzle         | 6             | 6      | 19         | 12500.00 |
| 22 | Emily White        | 6             | 6      | 19         | 7500.00  |
| 23 | Jonathan Rosenberg | 7             | 12     | NULL       | 13500.00 |
| 24 | David Clark        | 7             | 6      | 22         | 9000.00  |
| 25 | Craig Silverstein  | 8             | 8      | NULL       | 14000.00 |
| 26 | Megan Smith        | 8             | 8      | 24         | 13500.00 |
| 27 | Emma Johnson       | 8             | 8      | 24         | 8500.00  |
| 28 | Alan Eustace       | 9             | 9      | NULL       | 15000.00 |
| 29 | Jeff Dean          | 9             | 9      | 27         | 14500.00 |
| 30 | Olivia White       | 9             | 9      | 27         | 9500.00  |
| 31 | Amit Singhal       | 10            | 10     | NULL       | 16000.00 |
| 32 | Hiroshi Lockheimer | 10            | 10     | 30         | 16000.00 |
| 33 | Matthew Taylor     | 10            | 10     | 30         | 10000.00 |
+----+--------------------+---------------+--------+------------+----------+
Первое поле этой таблицы содержит идентификатор сотрудника, второе — полное имя (имя и фамилия), третье — идентификатор отдела, в котором работает сотрудник, четвертое — идентификатор занимаемой сотрудником должности, пятое — идентификатор руководителя (также является сотрудником), шестое — зарплату в неизвестной валюте. Если у сотрудника нет руководителя, значением поля manager_id является NULL.

Напишите запрос, извлекающий из предложенной базы данных полные имена и зарплаты сотрудников, которые являются менеджерами и зарплата которых больше 10000.

Записи в результирующей таблице должны быть расположены в порядке убывания зарплат сотрудников, при совпадении — в лексикографическом порядке их полных имен.

Результат запроса
+--------------------+----------+
| full_name          | salary   |
+--------------------+----------+
| Amit Singhal       | 16000.00 |
| Hiroshi Lockheimer | 16000.00 |
| Ruth Porat         | 11000.00 |
| Patrick Pichette   | 10500.00 |
+--------------------+----------+
Скрипт для создания таблиц Departments, Job и Employees
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Job;
DROP TABLE IF EXISTS Departments;

-- Создание таблицы Departments
CREATE TABLE Departments
(
    id   INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50)
);

INSERT INTO Departments (name)
VALUES ('Engineering'),
       ('Marketing'),
       ('Sales'),
       ('Finance'),
       ('HR'),
       ('IT'),
       ('Operations'),
       ('Customer Service'),
       ('Research and Development'),
       ('Product Management');

-- Создание таблицы Job
CREATE TABLE Job
(
    id    INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50)
);

INSERT INTO Job (title)
VALUES ('Software Engineer'),
       ('Managing director'),
       ('Marketing Manager'),
       ('Sales Manager'),
       ('Finance Analyst'),
       ('Risk Management Analyst'),
       ('HR Manager'),
       ('IT Specialist'),
       ('Salesman'),
       ('Operations Manager'),
       ('Customer Service Representative'),
       ('Maintenance man'),
       ('Research Scientist'),
       ('Product Manager'),
       ('Quality Assurance Analyst'),
       ('Design Lead');

-- Создание таблицы Employees
CREATE TABLE Employees
(
    id            INT PRIMARY KEY AUTO_INCREMENT,
    full_name     VARCHAR(50),
    department_id INT,
    job_id        INT,
    manager_id    INT,
    salary        DECIMAL(10, 2),
    FOREIGN KEY (department_id) REFERENCES Departments (id),
    FOREIGN KEY (job_id) REFERENCES Job (id),
    FOREIGN KEY (manager_id) REFERENCES Employees (id)
);

INSERT INTO Employees (full_name, department_id, job_id, manager_id, salary)
VALUES ('Sergey Brin', 1, 1, NULL, 10000.00),
       ('Larry Page', 1, 1, 1, 9000.00),
       ('Susan Wojcicki', 1, 1, 1, 8500.00),
       ('John Smith', 1, 6, 2, 7500.00),
       ('Alice Johnson', 1, 6, 2, 7000.00),
       ('Eric Schmidt', 2, 2, NULL, 9500.00),
       ('Marissa Mayer', 2, 2, 5, 9000.00),
       ('Sheryl Sandberg', 2, 2, 5, 8500.00),
       ('Jane Williams', 2, 6, 6, 7000.00),
       ('John Doerr', 3, 6, NULL, 11000.00),
       ('Sundar Pichai', 3, 2, 9, 10500.00),
       ('Alana Davis', 3, 12, 9, 11000.00),
       ('Bob Thompson', 3, 6, 10, 9500.00),
       ('Ruth Porat', 4, 4, NULL, 11000.00),
       ('Patrick Pichette', 4, 4, 13, 10500.00),
       ('Alex Turner', 4, 4, 13, 6000.00),
       ('Laszlo Bock', 5, 5, NULL, 12000.00),
       ('Eileen Naughton', 5, 5, 16, 11500.00),
       ('Michael Brown', 5, 5, 16, 8000.00),
       ('Vint Cerf', 6, 6, NULL, 13000.00),
       ('Urs Holzle', 6, 6, 19, 12500.00),
       ('Emily White', 6, 6, 19, 7500.00),
       ('Jonathan Rosenberg', 7, 12, NULL, 13500.00),
       ('David Clark', 7, 6, 22, 9000.00),
       ('Craig Silverstein', 8, 8, NULL, 14000.00),
       ('Megan Smith', 8, 8, 24, 13500.00),
       ('Emma Johnson', 8, 8, 24, 8500.00),
       ('Alan Eustace', 9, 9, NULL, 15000.00),
       ('Jeff Dean', 9, 9, 27, 14500.00),
       ('Olivia White', 9, 9, 27, 9500.00),
       ('Amit Singhal', 10, 10, NULL, 16000.00),
       ('Hiroshi Lockheimer', 10, 10, 30, 16000.00),
       ('Matthew Taylor', 10, 10, 30, 10000.00);
Примечание. Сотрудник считается менеджером, если в названии его должности присутствует слово Manager.*/
select full_name,salary from Job t1
inner join Employees t2 on t1.id=t2.job_id
where title like '%manager%' and salary>10000
order by 2 desc,1
