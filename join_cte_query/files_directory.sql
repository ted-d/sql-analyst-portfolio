/*Вам доступна база данных, принадлежащая операционной системе Windows. Она включает таблицу Files, которая хранит информацию о расположении файлов и папок внутри системы.

Таблица Files
+----+--------------------------+---------------------+
| id | name                     | parent_directory_id |
+----+--------------------------+---------------------+
| 1  | desktop                  | NULL                |
| 2  | test                     | 1                   |
| 3  | Картинки                 | 2                   |
| 4  | 1.jpg                    | 3                   |
| 5  | avatar.png               | 3                   |
| 6  | certificate.png          | 3                   |
| 7  | py.png                   | 3                   |
| 8  | World_Time_Zones_Map.png | 3                   |
| 9  | Снимок экрана.png        | 3                   |
| 10 | Неравенства.djvu         | 2                   |
| 11 | Программы                | 2                   |
| 12 | image_util.py            | 11                  |
| 13 | sort.py                  | 11                  |
| 14 | Разные файлы             | 2                   |
| 15 | astros.json              | 14                  |
+----+--------------------------+---------------------+
Первое поле этой таблицы содержит идентификатор файла или папки, второе — название, третье — идентификатор родительской папки.
Если файл или папка не имеет родительской папки, значением поля parent_directory_id является NULL.

Напишите запрос, извлекающий из предложенной базы данных идентификаторы всех файлов и папок, а также указывающий для каждого файла или папки путь до него в следующем формате:

.../<название родительской папки>/<название файла или папки>
Поле с путем до файла или папки должно иметь псевдоним path.

Результат запроса
+----+------------------------------------------------+
| id | path                                           |
+----+------------------------------------------------+
| 1  | desktop                                        |
| 2  | desktop/test                                   |
| 3  | desktop/test/Картинки                          |
| 10 | desktop/test/Неравенства.djvu                  |
| 11 | desktop/test/Программы                         |
| 14 | desktop/test/Разные файлы                      |
| 4  | desktop/test/Картинки/1.jpg                    |
| 5  | desktop/test/Картинки/avatar.png               |
| 6  | desktop/test/Картинки/certificate.png          |
| 7  | desktop/test/Картинки/py.png                   |
| 8  | desktop/test/Картинки/World_Time_Zones_Map.png |
| 9  | desktop/test/Картинки/Снимок экрана.png        |
| 12 | desktop/test/Программы/image_util.py           |
| 13 | desktop/test/Программы/sort.py                 |
| 15 | desktop/test/Разные файлы/astros.json          |
+----+------------------------------------------------+
Скрипт для создания таблицы Files
DROP TABLE IF EXISTS Files;
CREATE TABLE Files
(
    id                  INT PRIMARY KEY AUTO_INCREMENT,
    name                VARCHAR(40),
    parent_directory_id INT
);

TRUNCATE Files;
INSERT INTO Files (name, parent_directory_id)
VALUES ('desktop', NULL),
       ('test', 1),
       ('Картинки', 2),
       ('1.jpg', 3),
       ('avatar.png', 3),
       ('certificate.png', 3),
       ('py.png', 3),
       ('World_Time_Zones_Map.png', 3),
       ('Снимок экрана.png', 3),
       ('Неравенства.djvu', 2),
       ('Программы', 2),
       ('image_util.py', 11),
       ('sort.py', 11),
       ('Разные файлы', 2),
       ('astros.json', 14);
Тестовые данные
Примечание 1. Наглядное представление дерева каталогов из таблицы Files:

desktop
└── test
    ├── Картинки
    │   ├── 1.jpg 
    │   ├── avatar.png 
    │   ├── certificate.png 
    │   ├── py.png 
    │   ├── World_Time_Zones_Map.png 
    │   └── Снимок экрана.png 
    ├── Неравенства.djvu 
    ├── Программы
    │   ├── image_util.py 
    │   └── sort.py 
    └── Разные файлы
        └── astros.json 
Примечание 2. Записи в результирующей таблице могут быть расположены в произвольном порядке.

Примечание 3. При решении задачи используйте рекурсивное обобщенное табличное выражение.*/
WITH RECURSIVE FilesHierarchy AS (
    SELECT id, name,
           CONVERT(name, CHAR(100)) AS path
    FROM Files
    WHERE parent_directory_id IS NULL
    
    UNION ALL
    
    SELECT Files.id, Files.name,
           CONCAT(FilesHierarchy.path , '/', Files.name)
    FROM FilesHierarchy INNER JOIN Files ON FilesHierarchy.id = Files.parent_directory_id
)
    
SELECT id,path
FROM FilesHierarchy;
