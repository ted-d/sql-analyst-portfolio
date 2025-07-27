/*Покажите сотрудников с максимальной зарплатой в каждом отделе из таблицы salary.

id_employee	department	salary
10	sales	100000
11	sales	100000
12	sales	95000
13	sales	55000
14	IT	150000
15	IT	250000
16	IT	155000
17	HR	250000
18	HR	100000
 

Ожидаемый результат:

id_employee	department	salary
10	sales	100000
11	sales	100000
15	IT	250000
17	HR	250000
*/
WITH t1 AS (
  SELECT id_employee,department, salary, dense_rank() over( partition BY department ORDER BY salary desc ) dr FROM   salary 
  )
  SELECT id_employee,department, salary FROM t1
  WHERE dr = 1;
/*Напишите запрос, который добавит колонку cum_sum с накопительным итогом в таблице income.
Считаем, что в таблице нет строк с одинаковыми датами.

date_id	income
2025-01-01	150
2025-01-02	100
2025-01-03	150
2025-01-04	50
2025-01-05	70
Ожидаемый результат:

date_id	income	cum_sum
2025-01-01	150	150
2025-01-02	100	250
2025-01-03	150	400
2025-01-04	50	450
2025-01-05	70	520

*/
SELECT date_id , income, coalesce(sum(income) over(ORDER BY date_id ),0) FROM income

/*
Напишите запрос, который добавит колонку moving_average со скользящим средним в таблице income. Результат округлить до целых.

Скользящим средним в этом задаче будем считать сумму текущего, предыдщего и следующего дня деленную на 3, то есть:
- для 2025-01-02 скользящее среднее будет равняться сумме значений income за предыдущую дату (2025-01-01), за текущую дату (2025-01-02) и следующую за ней дату (2025-01-03),
- для 2025-01-03 скользящее среднее будет равняться сумме значений income за предыдущую дату (2025-01-02), за текущую дату (2025-01-03) и следующую за ней дату (2025-01-04) и т д

date_id	income
2025-01-01	150
2025-01-02	100
2025-01-03	150
2025-01-04	50
2025-01-05	70
Ожидаемый результат:

date_id	income	moving_average
2025-01-01	150	125
2025-01-02	100	133
2025-01-03	150	100
2025-01-04	50	90
2025-01-05	70	60

*/
SELECT date_id,income, sum(income) over(
    ORDER BY date_id 
    ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) / 
  COUNT(*) OVER(
  ORDER BY date_id
  ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING)
  AS moving_average 
  FROM income
/*
Напишите запрос, который покажет топ-3 продуктов по объему продаж и объем всех остальных продуктов не вошедших в топ-3 четвертой строкой в таблице sales. 
Обращение к таблице - не более 1 раза (не используйте UNION / UNION ALL).

date_id	product	quantity
2025-01-01	персик	15
2025-01-01	яблоко	23
2025-01-01	груша	17
2025-01-02	апельсин	50
2025-01-02	слива	11
2025-01-02	персик	15
2025-01-02	вишня	12
2025-01-02	яблоко	9
Ожидаемый результат:

product	quantity
яблоко	32
апельсин	50
персик	30
другие	40

*/
with t1 as (select product ,sum(quantity) suq from sales
group by product),
grade as (select product ,suq,dense_rank() over(order by suq desc) dr from t1)
select product,suq quantity from grade
where dr<=3
union
select 'другие',sum(suq) from grade
where dr>3
