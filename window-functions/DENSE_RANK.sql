/*Вам доступна база данных, принадлежащая анимационной студии Pixar. Она включает таблицу Films, которая хранит информацию о фильмах студии.

Таблица Films
+----+---------------------+----------------+--------------+
| id | title               | director       | release_year |
+----+---------------------+----------------+--------------+
| 1  | Toy Story 2         | John Lasseter  | 1999         |
| 2  | WALL-E              | Andrew Stanton | 2008         |
| 3  | Ratatouille         | Brad Bird      | 2007         |
| 4  | Up                  | Pete Docter    | 2009         |
| 5  | Brave               | Brenda Chapman | 2012         |
| 6  | Monsters University | Dan Scanlon    | 2013         |
| 7  | Cars 2              | John Lasseter  | 2011         |
| 8  | Finding Nemo        | Andrew Stanton | 2003         |
| 9  | Toy Story           | John Lasseter  | 1995         |
| 10 | The Incredibles     | Brad Bird      | 2004         |
+----+---------------------+----------------+--------------+
Первое поле этой таблицы содержит идентификатор фильма, второе — название, третье — имя и фамилию режиссера, четвертое — год выхода.

Скрипт для создания таблицы Films
DROP TABLE IF EXISTS Films;
CREATE TABLE Films
(
    id           INT PRIMARY KEY AUTO_INCREMENT,
    title        VARCHAR(20),
    director     VARCHAR(20),
    release_year INT
);

INSERT INTO Films (title, director, release_year) 
VALUES ('Toy Story 2', 'John Lasseter', 1999),
       ('WALL-E', 'Andrew Stanton', 2008),
       ('Ratatouille', 'Brad Bird', 2007),
       ('Up', 'Pete Docter', 2009),
       ('Brave', 'Brenda Chapman', 2012),
       ('Monsters University', 'Dan Scanlon', 2013),
       ('Cars 2', 'John Lasseter', 2011),
       ('Finding Nemo', 'Andrew Stanton', 2003),
       ('Toy Story', 'John Lasseter', 1995),
       ('The Incredibles', 'Brad Bird', 2004);

ЗАДАНИЕ:
Напишите запрос, который извлекает из предложенной базы данных имена и фамилии всех режиссеров, а также указывает для каждого режиссера количество снятых им фильмов. Помимо этого, режиссеры должны быть пронумерованы, начиная с 1, в порядке убывания количества снятых фильмов. При этом если два режиссера имеют равное количество снятых фильмов, то их номера также должны совпадать.

Поле с номером режиссера должно располагаться на первом месте и иметь псевдоним place, в то время как поле с количеством снятых фильмов должно располагаться на последнем месте и иметь псевдоним number_of_films.

Записи в результирующей таблице должны быть расположены в порядке возрастания значения поля place, при совпадении — в порядке возрастания значения поля director.

Результат запроса
+-------+----------------+-----------------+
| place | director       | number_of_films |
+-------+----------------+-----------------+
| 1     | John Lasseter  | 3               |
| 2     | Andrew Stanton | 2               |
| 2     | Brad Bird      | 2               |
| 3     | Brenda Chapman | 1               |
| 3     | Dan Scanlon    | 1               |
| 3     | Pete Docter    | 1               |
+-------+----------------+-----------------+*/
WITH t1 AS (
  SELECT director,COUNT(*) number_of_films FROM Films
  GROUP BY director
  )
SELECT dense_rank() over (ORDER BY number_of_films DESC) AS place,director,number_of_films FROM t1
ORDER BY place,director;
