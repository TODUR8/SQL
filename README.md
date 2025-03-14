### Сервис доставки продуктов.
Цель проекта обеспечить сервис доставки продуктов комплексными цифровыми метриками,
которые станут основой для принятия эффективных решений.

Стек технологий:
- PostgreSQL.
- Redash.
- PgAdmin.
  
Задачи:
- разработать структуру базы данных в PgAdmin для эффективного хранения и обработки
данных.
- Разработать базовый дашборд для визуализации ключевых показателей экономики продукта.
- разработать дашборд, отображающий ключевые показатели маркетинговых кампаний.

Результаты:
- Я разработал базу данных в PgAdmin, обеспечивающую надежное и эффективное хранение
данных. Были настроены ключевые таблицы, индексы и связи для оптимизации запросов.
- Я разработал дашборд, который наглядно отображает ключевые показатели экономики
продукта. Основные метрики, такие как доход, затраты и прибыль, представлены в удобной для
анализа форме. Дашборд позволяет оперативно отслеживать динамику показателей и
принимать решения на основе актуальных данных.
- Я разработал дашборд, который визуализирует ключевые показатели маркетинговых
кампаний, включая охват, конверсию и рентабельность инвестиций (ROI). Благодаря
дашборду, стало проще анализировать эффективность кампаний и принимать решения по их
оптимизации.


Описание данных. 
1. user_actions — действия пользователей с заказами. 

2. courier_actions — действия курьеров с заказами.

3. orders — информация о заказах.

4. users — информация о пользователях.

5. couriers — информация о курьерах.

6. products — информация о товарах, которые доставляет сервис.


Используя эти данные построим различные отчеты и графики, что бы выявить 
какие-то проблемы.


**Этап 1.** 
Построим базовый дашборд.
Шаг 1
Для каждого дня, рассчитаем следующие показатели:
1. Число новых пользователей.
2. Число новых курьеров.
3. Общее число пользователей на текущий день.
4. Общее число курьеров на текущий день.

Динамика новых пользователей и курьеров
![1_1 Динамика новых пользователей и курьеров](https://github.com/TODUR8/SQL/assets/156222635/e63d5f1e-1945-4fb0-bcba-f744a62acae3)

Динамика общего числа пользователей
![1_1 Динамика общего числа пользователей](https://github.com/TODUR8/SQL/assets/156222635/8eba2712-a550-4151-8791-53971accc388)


Шаг 2
Для каждого дня, рассчитаем следующие показатели:
1. Прирост числа новых пользователей.
2. Прирост числа новых курьеров.
3. Прирост общего числа пользователей.
4. Прирост общего числа курьеров.

Динамика прироста общего числа пользователей и курьеров
![1_2 Динамика прироста общего числа пользователей и курьеров](https://github.com/TODUR8/SQL/assets/156222635/a9d39c79-7534-47c9-9db2-1126a06ba2c3)

Динамика прироста числа новых пользователей и курьеров
![1_2 Динамика прироста числа новых пользователей и курьеров](https://github.com/TODUR8/SQL/assets/156222635/ff168e63-1d95-4f22-a8ee-2890f12f2c13)


Шаг 3
Для каждого дня, рассчитаем следующие показатели:
1. Число платящих пользователей.
2. Число активных курьеров.
3. Долю платящих пользователей в общем числе пользователей на текущий день.
4. Долю активных курьеров в общем числе курьеров на текущий день.

Динамика долей платящих пользователей и активных курьеров
![1_3 Динамика долей платящих пользователей и активных курьеров](https://github.com/TODUR8/SQL/assets/156222635/091a0733-c01e-43a7-88da-26942e264d8f)

Динамика платящих пользователей и активных курьеров
![1_3 Динамика платящих пользователей и активных курьеров](https://github.com/TODUR8/SQL/assets/156222635/ec127d25-8b24-44c4-bd44-03acda99c4dc)


Шаг 4
Для каждого дня, рассчитаем следующие показатели:
1. Долю пользователей, сделавших в этот день всего один заказ, в общем количестве платящих пользователей.
2. Долю пользователей, сделавших в этот день несколько заказов, в общем количестве платящих пользователей.
   
Доли пользователей с одним и несколькими заказами
![1_4 Доли пользователей с одним и несколькими заказами](https://github.com/TODUR8/SQL/assets/156222635/f26f560e-5f02-4201-b320-540215616bf8)


Шаг 5
Для каждого дня, рассчитаем следующие показатели:
1. Общее число заказов.
2. Число первых заказов (заказов, сделанных пользователями впервые).
3. Число заказов новых пользователей (заказов, сделанных пользователями в тот же день, когда они впервые воспользовались сервисом).
4. Долю первых заказов в общем числе заказов (долю п.2 в п.1).
5. Долю заказов новых пользователей в общем числе заказов (долю п.3 в п.1).

Динамика доли первых заказов и доли заказов новых пользователей в общем числе заказов
![1_5 Динамика доли первых заказов и доли заказов новых пользователей в общем числе заказов](https://github.com/TODUR8/SQL/assets/156222635/15051a02-52cb-4801-9601-ee8d18ed6738)

Динамика общего числа заказов, числа первых заказов и числа заказов новых пользователей
![1_5 Динамика общего числа заказов, числа первых заказов и числа заказов новых пользователей](https://github.com/TODUR8/SQL/assets/156222635/a7d1021f-bde5-420b-a545-4d9cdddd749e)


Шаг 6
На основе данных для каждого дня рассчитайте следующие показатели:
1. Число платящих пользователей на одного активного курьера.
2. Число заказов на одного активного курьера.

Динамика числа пользователей и заказов на одного курьера
![1_6 Динамика числа пользователей и заказов на одного курьера](https://github.com/TODUR8/SQL/assets/156222635/4aca3eba-abe2-4b50-8f1b-b24a427fee95)

Шаг 7 
На основе данных для каждого часа в сутках рассчитайте следующие показатели:
1. Число успешных (доставленных) заказов.
2. Число отменённых заказов.
3. Долю отменённых заказов в общем числе заказов (cancel rate).

Динамика показателя cancel rate и числа успешныхотменённых заказов
![1_8 Динамика показателя cancel rate и числа успешныхотменённых заказов](https://github.com/TODUR8/SQL/assets/156222635/2a2ce7aa-0a4a-43bd-a458-e167ddaaacb3)


**Этап 2.** 
Экономика продукта.

Шаг 1
Для каждого дня рассчитаем следующие показатели:
1. Выручку, полученную в этот день.
2. Суммарную выручку на текущий день.
3. Прирост выручки, полученной в этот день, относительно значения выручки за предыдущий день.

Динамика ежедневной выручки
![2_1 Динамика ежедневной выручки](https://github.com/TODUR8/SQL/assets/156222635/d1a64c12-bc8c-4afe-9f87-3ca978a948ee)

Динамика общей выручки
![2_1 Динамика общей выручки](https://github.com/TODUR8/SQL/assets/156222635/09e0c276-6f9f-441e-b8c3-3ebc3f143c23)


Шаг 2
Рассчитаем сколько в среднем потребители готовы платить за услуги сервиса доставки. Несколько метрик:
1. ARPU (Average Revenue Per User) — средняя выручка на одного пользователя за определённый период.
2. ARPPU (Average Revenue Per Paying User) — средняя выручка на одного платящего пользователя 
    за определённый период.
3. AOV (Average Order Value) — средний чек, или отношение выручки за определённый период к 
    общему количеству заказов за это же время.

Динамика показателей ARPU, ARPPU, AOV
![2_2 динамика показателей ARPU, ARPPU, AOV](https://github.com/TODUR8/SQL/assets/156222635/49e3599f-0d1b-4f00-a603-a41a611eca56)


Шаг 3
Для каждого дня рассчитаем следующие показатели:
1. Накопленную выручку на пользователя (Running ARPU).
2. Накопленную выручку на платящего пользователя (Running ARPPU).
3. Накопленную выручку с заказа, или средний чек (Running AOV).

Динамика показателей Running ARPU, Running ARPPU, Running AOV
![2_3 динамика показателей Running ARPU, Running ARPPU, Running AOV](https://github.com/TODUR8/SQL/assets/156222635/a6e191a2-2e99-4ca0-aee8-0207f1fe69f4)


Шаг 4
Для каждого дня недели рассчитаем следующие показатели:
1. Выручку на пользователя (ARPU).
2. Выручку на платящего пользователя (ARPPU).
3. Выручку на заказ (AOV).

Динамика показателей ARPU, ARPPU, AOV
![2_4 динамика показателей ARPU, ARPPU, AOV](https://github.com/TODUR8/SQL/assets/156222635/b394690c-5bab-4245-95ea-1dc329f8ba82)


Шаг 5
Для каждого дня рассчитаем следующие показатели:
1. Выручку, полученную в этот день.
2. Выручку с заказов новых пользователей, полученную в этот день.
3. Долю выручки с заказов новых пользователей в общей выручке, полученной за этот день.
4. Долю выручки с заказов остальных пользователей в общей выручке, полученной за этот день.

Долю выручки с заказов от новых пользователей и старых пользователей
![2_5 Долю выручки с заказов от новых пользователей и старых пользователей](https://github.com/TODUR8/SQL/assets/156222635/a07b0176-e0a3-4675-93d5-8a704e1a7bd1)


Шаг 6
Для каждого товара, за весь период времени рассчитаем следующие показатели:
1. Суммарную выручку, полученную от продажи этого товара за весь период.
2. Долю выручки от продажи этого товара в общей выручке, полученной за весь период.

Долю выручки от продажи товара в общей выручке, полученной за весь период.
![2_6 Долю выручки от продажи товара в общей выручке, полученной за весь период](https://github.com/TODUR8/SQL/assets/156222635/c60a0ee2-11dc-4aec-a3f5-df50454085f0)


**Этап 3.** 
Маркетинговые метрики

Шаг 1
Рассчитаем метрику CAC для двух рекламных кампаний.
![3_1 Рассчитаем метрику CAC для двух рекламных кампаний](https://github.com/TODUR8/SQL/assets/156222635/f081f026-9706-4876-b1e3-9de17218ade6)


Шаг 2
Рассчитаем ROI для каждого рекламного канала.
![3_2 Рассчитаем ROI для каждого рекламного канала](https://github.com/TODUR8/SQL/assets/156222635/30b4061a-adf9-4eda-b30e-bf7b5d94b005)


Шаг 3
Для каждой рекламной кампании посчитаем среднюю стоимость заказа привлечённых пользователей
![3_3 Для каждой рекламной кампании посчитаем среднюю стоимость заказа привлечённых пользователей](https://github.com/TODUR8/SQL/assets/156222635/83417d1c-d27d-4051-afe4-c7c9827e2057)


Шаг 
Для каждой рекламной кампании для каждого дня посчитаем две метрики:
1. Накопительный ARPPU.
2. Затраты на привлечение одного покупателя (CAC).

![3_5 Для каждой рекламной кампании для каждого дня посчитаем метрики ARPPU CAC](https://github.com/TODUR8/SQL/assets/156222635/3d33b05a-d44d-4f79-acb0-953b1369c83a)
