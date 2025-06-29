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
2)Найдите производителя, выпускающего легковые автомобили, но не грузовики. */
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
/*===========================================*/
SELECT maker FROM vehicle as v
INNER JOIN car on v.model=car.model 
where v.maker not in 
    (
    SELECT maker FROM vehicle as v
    INNER JOIN truck as t on v.model=t.model 
    );
