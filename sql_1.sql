--TASK 1
/*
Для каждого дня, рассчитаем следующие показатели:

1. Число новых пользователей.
2. Число новых курьеров.
3. Общее число пользователей на текущий день.
4. Общее число курьеров на текущий день.
*/

SELECT start_date as date,
       new_users,
       new_couriers,
       (sum(new_users) OVER (ORDER BY start_date))::int as total_users,
       (sum(new_couriers) OVER (ORDER BY start_date))::int as total_couriers
FROM   (SELECT start_date,
               count(courier_id) as new_couriers
        FROM   (SELECT courier_id,
                       min(time::date) as start_date
                FROM   courier_actions
                GROUP BY courier_id) t1
        GROUP BY start_date) t2
    LEFT JOIN (SELECT start_date,
                      count(user_id) as new_users
               FROM   (SELECT user_id,
                              min(time::date) as start_date
                       FROM   user_actions
                       GROUP BY user_id) t3
               GROUP BY start_date) t4 using (start_date)


--TASK 2
/*
Для каждого дня, рассчитаем следующие показатели:

1. Прирост числа новых пользователей.
2. Прирост числа новых курьеров.
3. Прирост общего числа пользователей.
4. Прирост общего числа курьеров.
*/

SELECT date,
       new_users,
       new_couriers,
       total_users,
       total_couriers,
       round(100 * (new_users - lag(new_users, 1) OVER (ORDER BY date)) / lag(new_users, 1) OVER (ORDER BY date)::decimal,
             2) as new_users_change,
       round(100 * (new_couriers - lag(new_couriers, 1) OVER (ORDER BY date)) / lag(new_couriers, 1) OVER (ORDER BY date)::decimal,
             2) as new_couriers_change,
       round(100 * new_users::decimal / lag(total_users, 1) OVER (ORDER BY date),
             2) as total_users_growth,
       round(100 * new_couriers::decimal / lag(total_couriers, 1) OVER (ORDER BY date),
             2) as total_couriers_growth
FROM   (SELECT start_date as date,
               new_users,
               new_couriers,
               (sum(new_users) OVER (ORDER BY start_date))::int as total_users,
               (sum(new_couriers) OVER (ORDER BY start_date))::int as total_couriers
        FROM   (SELECT start_date,
                       count(courier_id) as new_couriers
                FROM   (SELECT courier_id,
                               min(time::date) as start_date
                        FROM   courier_actions
                        GROUP BY courier_id) t1
                GROUP BY start_date) t2
            LEFT JOIN (SELECT start_date,
                              count(user_id) as new_users
                       FROM   (SELECT user_id,
                                      min(time::date) as start_date
                               FROM   user_actions
                               GROUP BY user_id) t3
                       GROUP BY start_date) t4 using (start_date)) t5


--TASK 3
/*
Для каждого дня, рассчитаем следующие показатели:

1. Число платящих пользователей.
2. Число активных курьеров.
3. Долю платящих пользователей в общем числе пользователей на текущий день.
4. Долю активных курьеров в общем числе курьеров на текущий день.

*/
SELECT date,
       paying_users,
       active_couriers,
       round(100 * paying_users::decimal / total_users, 2) as paying_users_share,
       round(100 * active_couriers::decimal / total_couriers, 2) as active_couriers_share
FROM   (SELECT start_date as date,
               new_users,
               new_couriers,
               (sum(new_users) OVER (ORDER BY start_date))::int as total_users,
               (sum(new_couriers) OVER (ORDER BY start_date))::int as total_couriers
        FROM   (SELECT start_date,
                       count(courier_id) as new_couriers
                FROM   (SELECT courier_id,
                               min(time::date) as start_date
                        FROM   courier_actions
                        GROUP BY courier_id) t1
                GROUP BY start_date) t2
            LEFT JOIN (SELECT start_date,
                              count(user_id) as new_users
                       FROM   (SELECT user_id,
                                      min(time::date) as start_date
                               FROM   user_actions
                               GROUP BY user_id) t3
                       GROUP BY start_date) t4 using (start_date)) t5
    LEFT JOIN (SELECT time::date as date,
                      count(distinct courier_id) as active_couriers
               FROM   courier_actions
               WHERE  order_id not in (SELECT order_id
                                       FROM   user_actions
                                       WHERE  action = 'cancel_order')
               GROUP BY date) t6 using (date)
    LEFT JOIN (SELECT time::date as date,
                      count(distinct user_id) as paying_users
               FROM   user_actions
               WHERE  order_id not in (SELECT order_id
                                       FROM   user_actions
                                       WHERE  action = 'cancel_order')
               GROUP BY date) t7 using (date)


--TASK 4
/*
Задание:

Для каждого дня, рассчитаем следующие показатели:

1. Долю пользователей, сделавших в этот день всего один заказ, в общем количестве платящих пользователей.
2. Долю пользователей, сделавших в этот день несколько заказов, в общем количестве платящих пользователей.
*/

SELECT date,
       round(100 * single_order_users::decimal / paying_users,
             2) as single_order_users_share,
       100 - round(100 * single_order_users::decimal / paying_users,
                   2) as several_orders_users_share
FROM   (SELECT time::date as date,
               count(distinct user_id) as paying_users
        FROM   user_actions
        WHERE  order_id not in (SELECT order_id
                                FROM   user_actions
                                WHERE  action = 'cancel_order')
        GROUP BY date) t1
    LEFT JOIN (SELECT date,
                      count(user_id) as single_order_users
               FROM   (SELECT time::date as date,
                              user_id,
                              count(distinct order_id) as user_orders
                       FROM   user_actions
                       WHERE  order_id not in (SELECT order_id
                                               FROM   user_actions
                                               WHERE  action = 'cancel_order')
                       GROUP BY date, user_id having count(distinct order_id) = 1) t2
               GROUP BY date) t3 using (date)
ORDER BY date


--TASK 5
/*
Задание:
Для каждого дня, рассчитаем следующие показатели:

1. Общее число заказов.
2. Число первых заказов (заказов, сделанных пользователями впервые).
3. Число заказов новых пользователей (заказов, сделанных пользователями в тот же день, когда они впервые воспользовались сервисом).
4. Долю первых заказов в общем числе заказов (долю п.2 в п.1).
5. Долю заказов новых пользователей в общем числе заказов (долю п.3 в п.1).
*/

SELECT date,
       orders,
       first_orders,
       new_users_orders::int,
       round(100 * first_orders::decimal / orders, 2) as first_orders_share,
       round(100 * new_users_orders::decimal / orders, 2) as new_users_orders_share
FROM   (SELECT creation_time::date as date,
               count(distinct order_id) as orders
        FROM   orders
        WHERE  order_id not in (SELECT order_id
                                FROM   user_actions
                                WHERE  action = 'cancel_order')
           and order_id in (SELECT order_id
                         FROM   courier_actions
                         WHERE  action = 'deliver_order')
        GROUP BY date) t5
    LEFT JOIN (SELECT first_order_date as date,
                      count(user_id) as first_orders
               FROM   (SELECT user_id,
                              min(time::date) as first_order_date
                       FROM   user_actions
                       WHERE  order_id not in (SELECT order_id
                                               FROM   user_actions
                                               WHERE  action = 'cancel_order')
                       GROUP BY user_id) t4
               GROUP BY first_order_date) t7 using (date)
    LEFT JOIN (SELECT start_date as date,
                      sum(orders) as new_users_orders
               FROM   (SELECT t1.user_id,
                              t1.start_date,
                              coalesce(t2.orders, 0) as orders
                       FROM   (SELECT user_id,
                                      min(time::date) as start_date
                               FROM   user_actions
                               GROUP BY user_id) t1
                           LEFT JOIN (SELECT user_id,
                                             time::date as date,
                                             count(distinct order_id) as orders
                                      FROM   user_actions
                                      WHERE  order_id not in (SELECT order_id
                                                              FROM   user_actions
                                                              WHERE  action = 'cancel_order')
                                      GROUP BY user_id, date) t2
                               ON t1.user_id = t2.user_id and
                                  t1.start_date = t2.date) t3
               GROUP BY start_date) t6 using (date)
ORDER BY date


--TASK 6
/*
Задание:

На основе данных для каждого дня рассчитайте следующие показатели:

1. Число платящих пользователей на одного активного курьера.
2. Число заказов на одного активного курьера.

*/
SELECT date,
       round(paying_users::decimal / couriers, 2) as users_per_courier,
       round(orders::decimal / couriers, 2) as orders_per_courier
FROM   (SELECT time::date as date,
               count(distinct courier_id) as couriers
        FROM   courier_actions
        WHERE  order_id not in (SELECT order_id
                                FROM   user_actions
                                WHERE  action = 'cancel_order')
        GROUP BY date) t1 join (SELECT creation_time::date as date,
                               count(distinct order_id) as orders
                        FROM   orders
                        WHERE  order_id not in (SELECT order_id
                                                FROM   user_actions
                                                WHERE  action = 'cancel_order')
                        GROUP BY date) t2 using (date) join (SELECT time::date as date,
                                            count(distinct user_id) as paying_users
                                     FROM   user_actions
                                     WHERE  order_id not in (SELECT order_id
                                                             FROM   user_actions
                                                             WHERE  action = 'cancel_order')
                                     GROUP BY date) t3 using (date)
ORDER BY date


--TASK 7
/*
Задание:

На основе данных для каждого дня рассчитайте, за сколько минут в среднем курьеры доставляли свои заказы.

*/
SELECT date,
       round(avg(delivery_time))::int as minutes_to_deliver
FROM   (SELECT order_id,
               max(time::date) as date,
               extract(epoch
        FROM   max(time) - min(time))/60 as delivery_time
        FROM   courier_actions
        WHERE  order_id not in (SELECT order_id
                                FROM   user_actions
                                WHERE  action = 'cancel_order')
        GROUP BY order_id) t
GROUP BY date
ORDER BY date


--TASK 8
/*
Задача:

На основе данных для каждого часа в сутках рассчитайте следующие показатели:

1. Число успешных (доставленных) заказов.
2. Число отменённых заказов.
3. Долю отменённых заказов в общем числе заказов (cancel rate).

*/
SELECT hour,
       successful_orders,
       canceled_orders,
       round(canceled_orders::decimal / (successful_orders + canceled_orders),
             3) as cancel_rate
FROM   (SELECT date_part('hour', creation_time)::int as hour,
               count(order_id) as successful_orders
        FROM   orders
        WHERE  order_id not in (SELECT order_id
                                FROM   user_actions
                                WHERE  action = 'cancel_order')
        GROUP BY hour) t1
    LEFT JOIN (SELECT date_part('hour', creation_time)::int as hour,
                      count(order_id) as canceled_orders
               FROM   orders
               WHERE  order_id in (SELECT order_id
                                   FROM   user_actions
                                   WHERE  action = 'cancel_order')
               GROUP BY hour) t2 using (hour)
ORDER BY hour

