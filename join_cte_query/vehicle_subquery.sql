/*Состоит база из четырех таблиц: vehicle, car, truck и motorcyclevehicle:
Содержит информацию о производителе, номере модели и типе транспортного средства ('Car', 'Truck', 'Motorcycle'). Предполагается, что номера моделей уникальны для всех производителей и типов транспортных средств.

maker: Производитель транспортного средства.
model: Номер модели транспортного средства (первичный ключ).
type: Тип транспортного средства ('Car', 'Truck', 'Motorcycle').
car: Содержит информацию о легковых автомобилях, включая уникальный код, модель (внешний ключ к таблице Vehicle), мощность двигателя, тип топлива, количество мест и цену.

code: Уникальный код автомобиля.
model: Номер модели (внешний ключ к таблице Vehicle).
engine_power: Мощность двигателя (в лошадиных силах).
fuel_type: Тип топлива (например, 'Gasoline', 'Diesel', 'Electric').
seats: Количество мест.
price: Цена автомобиля (в долларах).
truck: Содержит информацию о грузовиках, включая уникальный код, модель (внешний ключ к таблице Vehicle), мощность двигателя, грузоподъемность, тип топлива и цену.

code: Уникальный код грузовика.
model: Номер модели (внешний ключ к таблице Vehicle).
engine_power: Мощность двигателя (в лошадиных силах).
load_capacity: Грузоподъемность (в тоннах).
fuel_type: Тип топлива (например, 'Gasoline', 'Diesel').
price: Цена грузовика (в долларах).
motorcycle: Содержит информацию о мотоциклах, включая уникальный код, модель (внешний ключ к таблице Vehicle), мощность двигателя, тип топлива, вес и цену.

code: Уникальный код мотоцикла.
model: Номер модели (внешний ключ к таблице Vehicle).
engine_power: Мощность двигателя (в лошадиных силах).
fuel_type: Тип топлива (например, 'Gasoline', 'Electric').
weight: Вес (в килограммах).
price: Цена мотоцикла (в долларах).
Скрипт для создания таблиц:

CREATE TABLE vehicle (
    maker VARCHAR(50),
    model VARCHAR(50) PRIMARY KEY,
    type VARCHAR(10)
);

CREATE TABLE car (
    code INT PRIMARY KEY,
    model VARCHAR(50),
    engine_power INT,
    fuel_type VARCHAR(20),
    seats INT,
    price DECIMAL(10, 2),
    FOREIGN KEY (model) REFERENCES vehicle(model)
);

CREATE TABLE truck (
    code INT PRIMARY KEY,
    model VARCHAR(50),
    engine_power INT,
    load_capacity DECIMAL(10, 2),
    fuel_type VARCHAR(20),
    price DECIMAL(10, 2),
    FOREIGN KEY (model) REFERENCES vehicle(model)
);

CREATE TABLE motorcycle (
    code INT PRIMARY KEY,
    model VARCHAR(50),
    engine_power INT,
    fuel_type VARCHAR(20),
    weight DECIMAL(10, 2),
    price DECIMAL(10, 2),
    FOREIGN KEY (model) REFERENCES vehicle(model)
);
Скрипт для наполнения таблиц:

INSERT INTO vehicle (maker, model, type) VALUES
    ('Multi', 'MultiCar', 'Car'),
    ('Multi', 'MultiTruck', 'Truck'),
    ('Multi', 'MultiMoto', 'Motorcycle'),
    ('Duo2TC', 'Duo2Truck', 'Truck'),
    ('Duo2TC', 'Duo2Car', 'Car'),
    ('Duo4TM', 'Duo4Truck', 'Truck'),
    ('Duo4TM', 'Duo4Moto', 'Motorcycle'),
    ('Duo5CM', 'Duo5Car', 'Car'),
    ('Duo5CM', 'Duo5Moto', 'Motorcycle'),
    ('SoloC', 'SoloCar', 'Car'),
    ('SoloT', 'SoloTruck', 'Truck'),
    ('SoloM', 'SoloMoto', 'Motorcycle');

INSERT INTO truck (code, model, engine_power, load_capacity, fuel_type, price) VALUES
    (1, 'MultiTruck', 270, 1.00, 'Diesel', 1111.00),
    (2, 'Duo2Truck', 320, 2.00, 'Diesel', 2222.00),
    (3, 'Duo4Truck', 300, 4.00, 'Diesel', 3333.00),
    (4, 'SoloTruck', 310, 6.00, 'Diesel', 4444.00);

INSERT INTO car (code, model, engine_power, fuel_type, seats, price) VALUES
    (1, 'MultiCar', 180, 'Electric', 4, 1010.00),
    (2, 'Duo2Car', 350, 'Gasoline', 4, 2020.00),
    (3, 'Duo5Car', 280, 'Diesel', 6, 3030.00),
    (4, 'SoloCar', 777, 'Gasoline', 2, 4040.00);

INSERT INTO motorcycle (code, model, engine_power, fuel_type, weight, price) VALUES
    (1, 'MultiMoto', 33, 'Electric', 50.00, 101.00),
    (2, 'Duo4Moto', 33, 'Electric', 70.00, 102.00),
    (3, 'Duo5Moto', 66, 'Gasoline', 200.00, 103.00),
    (4, 'SoloMoto', 77, 'Gasoline', 210.00, 104.00);
ЗАДАНИЕ:
1)Найдите модели и цены всех имеющихся в продаже ТС (любого типа) производителя Multi.
2)Найдите производителя, выпускающего легковые автомобили, но не грузовики.
3)Найдите производителей легковых авто с мощностью двигателя не менее 700 лошадиных сил. Вывести: maker.
4)Найдите мощности двигателей, совпадающих у двух и более мотоциклов. Вывести: engine_power
5)Найдите производителей самых дешевых электрических (Electric) мотоциклов. Вывести: maker, price. 
6)Найдите производителей, которые производили бы как легковые автомобили с мощностью двигателя не менее 300 лошадиных сил, так и грузовики с мощностью двигателя не менее 300 лошадиных сил. Вывести: maker.
7)Найдите производителей мотоциклов, которые производят легковые автомобили, с наименьшей мощностью двигателя и с самым большим количеством мест среди всех легковых автомобилей. Вывести: maker*/
SELECT model, price FROM (
  SELECT m.model,maker,m.price FROM motorcycle AS m
  INNER JOIN vehicle AS v ON m.model=v.model
UNION 
  SELECT t.model,maker,t.price FROM truck AS t
  INNER JOIN vehicle AS v on t.model=v.model
UNION 
  SELECT c.model,maker,c.price FROM car AS c
  INNER JOIN vehicle AS v on c.model=v.model) AS big
WHERE maker = 'Multi';
/*==================2======================*/
SELECT maker FROM vehicle as v
INNER JOIN car on v.model=car.model 
WHERE v.maker not in 
    (
    SELECT maker FROM vehicle as v
    INNER JOIN truck as t on v.model=t.model 
    );
/*===================3=====================*/
SELECT maker FROM vehicle as v
INNER JOIN car on v.model=car.model
WHERE engine_power>=700;
/*===================4=====================*/
SELECT engine_power FROM motorcycle
GROUP BY engine_power
HAVING COUNT(*)=2;
/*===================5=====================*/
WITH t1 as (
    SELECT model,price FROM motorcycle 
    where price =
        (
        SELECT  min(price) FROM motorcycle
        )
)
SELECT maker, price FROM vehicle as v
INNER JOIN t1 on v.model=t1.model;
/*===================6======================*/
WITH t1 as(
    SELECT maker FROM vehicle 
    WHERE model in 
        (SELECT model FROM truck WHERE engine_power >= 300)
    ),
    t2 as (
    SELECT maker FROM vehicle 
        WHERE model in 
            (SELECT model FROM car WHERE engine_power >= 300)
    )
SELECT t1.maker FROM t1 
INNER JOIN t2 on t1.maker=t2.maker;     
/*====================7=====================*/
WITH t1 as (
    SELECT maker FROM vehicle as v 
    INNER JOIN car on v.model =car.model
    WHERE seats in (
                    select max(seats) FROM car 
                    )
    union
    SELECT maker from vehicle as v
    INNER JOIN motorcycle as m on m.model = v.model
    WHERE engine_power = (
                         SELECT min(engine_power) FROM motorcycle)
                         )
SELECT maker FROM t1 
WHERE maker not in (
    select maker FROM  vehicle as v 
    INNER JOIN truck as t on v.model=t.model
    ) ;
