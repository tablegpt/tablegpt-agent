SELECT count(*) FROM club	soccer_3
SELECT count(*) FROM club	soccer_3
SELECT Name FROM club ORDER BY Name ASC	soccer_3
SELECT Name FROM club ORDER BY Name ASC	soccer_3
SELECT Manager ,  Captain FROM club	soccer_3
SELECT Manager ,  Captain FROM club	soccer_3
SELECT Name FROM club WHERE Manufacturer != "Nike"	soccer_3
SELECT Name FROM club WHERE Manufacturer != "Nike"	soccer_3
SELECT Name FROM player ORDER BY Wins_count ASC	soccer_3
SELECT Name FROM player ORDER BY Wins_count ASC	soccer_3
SELECT Name FROM player ORDER BY Earnings DESC LIMIT 1	soccer_3
SELECT Name FROM player ORDER BY Earnings DESC LIMIT 1	soccer_3
SELECT DISTINCT Country FROM player WHERE Earnings  >  1200000	soccer_3
SELECT DISTINCT Country FROM player WHERE Earnings  >  1200000	soccer_3
SELECT Country FROM player WHERE Wins_count  >  2 ORDER BY Earnings DESC LIMIT 1	soccer_3
SELECT Country FROM player WHERE Wins_count  >  2 ORDER BY Earnings DESC LIMIT 1	soccer_3
SELECT T2.Name ,  T1.Name FROM club AS T1 JOIN player AS T2 ON T1.Club_ID  =  T2.Club_ID	soccer_3
SELECT T2.Name ,  T1.Name FROM club AS T1 JOIN player AS T2 ON T1.Club_ID  =  T2.Club_ID	soccer_3
SELECT T1.Name FROM club AS T1 JOIN player AS T2 ON T1.Club_ID  =  T2.Club_ID WHERE T2.Wins_count  >  2	soccer_3
SELECT T1.Name FROM club AS T1 JOIN player AS T2 ON T1.Club_ID  =  T2.Club_ID WHERE T2.Wins_count  >  2	soccer_3
SELECT T2.Name FROM club AS T1 JOIN player AS T2 ON T1.Club_ID  =  T2.Club_ID WHERE T1.Manager  =  "Sam Allardyce"	soccer_3
SELECT T2.Name FROM club AS T1 JOIN player AS T2 ON T1.Club_ID  =  T2.Club_ID WHERE T1.Manager  =  "Sam Allardyce"	soccer_3
SELECT T1.Name FROM club AS T1 JOIN player AS T2 ON T1.Club_ID  =  T2.Club_ID GROUP BY T1.Club_ID ORDER BY avg(T2.Earnings) DESC	soccer_3
SELECT T1.Name FROM club AS T1 JOIN player AS T2 ON T1.Club_ID  =  T2.Club_ID GROUP BY T1.Club_ID ORDER BY avg(T2.Earnings) DESC	soccer_3
SELECT Manufacturer ,  COUNT(*) FROM club GROUP BY Manufacturer	soccer_3
SELECT Manufacturer ,  COUNT(*) FROM club GROUP BY Manufacturer	soccer_3
SELECT Manufacturer FROM club GROUP BY Manufacturer ORDER BY COUNT(*) DESC LIMIT 1	soccer_3
SELECT Manufacturer FROM club GROUP BY Manufacturer ORDER BY COUNT(*) DESC LIMIT 1	soccer_3
SELECT Manufacturer FROM club GROUP BY Manufacturer HAVING COUNT(*)  >  1	soccer_3
SELECT Manufacturer FROM club GROUP BY Manufacturer HAVING COUNT(*)  >  1	soccer_3
SELECT Country FROM player GROUP BY Country HAVING COUNT(*)  >  1	soccer_3
SELECT Country FROM player GROUP BY Country HAVING COUNT(*)  >  1	soccer_3
SELECT Name FROM club WHERE Club_ID NOT IN (SELECT Club_ID FROM player)	soccer_3
SELECT Name FROM club WHERE Club_ID NOT IN (SELECT Club_ID FROM player)	soccer_3
SELECT Country FROM player WHERE Earnings  >  1400000 INTERSECT SELECT Country FROM player WHERE Earnings  <  1100000	soccer_3
SELECT Country FROM player WHERE Earnings  >  1400000 INTERSECT SELECT Country FROM player WHERE Earnings  <  1100000	soccer_3
SELECT COUNT (DISTINCT Country) FROM player	soccer_3
SELECT COUNT (DISTINCT Country) FROM player	soccer_3
SELECT Earnings FROM player WHERE Country  =  "Australia" OR Country  =  "Zimbabwe"	soccer_3
SELECT Earnings FROM player WHERE Country  =  "Australia" OR Country  =  "Zimbabwe"	soccer_3
SELECT T1.customer_id ,  T1.customer_first_name ,  T1.customer_last_name FROM Customers AS T1 JOIN Orders AS T2 ON T1.customer_id  =  T2.customer_id GROUP BY T1.customer_id HAVING count(*)  >  2 INTERSECT SELECT T1.customer_id ,  T1.customer_first_name ,  T1.customer_last_name FROM Customers AS T1 JOIN Orders AS T2 ON T1.customer_id  =  T2.customer_id JOIN Order_items AS T3 ON T2.order_id  =  T3.order_id GROUP BY T1.customer_id HAVING count(*)  >= 3	e_commerce
SELECT T1.customer_id ,  T1.customer_first_name ,  T1.customer_last_name FROM Customers AS T1 JOIN Orders AS T2 ON T1.customer_id  =  T2.customer_id GROUP BY T1.customer_id HAVING count(*)  >  2 INTERSECT SELECT T1.customer_id ,  T1.customer_first_name ,  T1.customer_last_name FROM Customers AS T1 JOIN Orders AS T2 ON T1.customer_id  =  T2.customer_id JOIN Order_items AS T3 ON T2.order_id  =  T3.order_id GROUP BY T1.customer_id HAVING count(*)  >= 3	e_commerce
SELECT T1.order_id ,  T1.order_status_code ,  count(*) FROM Orders AS T1 JOIN Order_items AS T2 ON T1.order_id  =  T2.order_id GROUP BY T1.order_id	e_commerce
SELECT T1.order_id ,  T1.order_status_code ,  count(*) FROM Orders AS T1 JOIN Order_items AS T2 ON T1.order_id  =  T2.order_id GROUP BY T1.order_id	e_commerce
SELECT min(date_order_placed) FROM Orders UNION SELECT T1.date_order_placed FROM Orders AS T1 JOIN Order_items AS T2 ON T1.order_id  =  T2.order_id GROUP BY T1.order_id HAVING count(*)  >  1	e_commerce
SELECT min(date_order_placed) FROM Orders UNION SELECT T1.date_order_placed FROM Orders AS T1 JOIN Order_items AS T2 ON T1.order_id  =  T2.order_id GROUP BY T1.order_id HAVING count(*)  >  1	e_commerce
SELECT customer_first_name ,  customer_middle_initial ,  customer_last_name FROM Customers EXCEPT SELECT T1.customer_first_name ,  T1.customer_middle_initial ,  T1.customer_last_name FROM Customers AS T1 JOIN Orders AS T2 ON T1.customer_id  =  T2.customer_id	e_commerce
SELECT customer_first_name ,  customer_middle_initial ,  customer_last_name FROM Customers EXCEPT SELECT T1.customer_first_name ,  T1.customer_middle_initial ,  T1.customer_last_name FROM Customers AS T1 JOIN Orders AS T2 ON T1.customer_id  =  T2.customer_id	e_commerce
SELECT product_id ,  product_name ,  product_price ,  product_color FROM Products EXCEPT SELECT T1.product_id ,  T1.product_name ,  T1.product_price ,  T1.product_color FROM Products AS T1 JOIN Order_items AS T2 ON T1.product_id  =  T2.product_id JOIN Orders AS T3 ON T2.order_id  =  T3.order_id GROUP BY T1.product_id HAVING count(*)  >=  2	e_commerce
select t1.product_id ,  t1.product_name ,  t1.product_price ,  t1.product_color from products as t1 join order_items as t2 on t1.product_id  =  t2.product_id join orders as t3 on t2.order_id  =  t3.order_id group by t1.product_id having count(*) < 2	e_commerce
SELECT T1.order_id ,  T1.date_order_placed FROM Orders AS T1 JOIN Order_items AS T2 ON T1.order_id  =  T2.order_id GROUP BY T1.order_id HAVING count(*)  >=  2	e_commerce
SELECT T1.order_id ,  T1.date_order_placed FROM Orders AS T1 JOIN Order_items AS T2 ON T1.order_id  =  T2.order_id GROUP BY T1.order_id HAVING count(*)  >=  2	e_commerce
SELECT T1.product_id ,  T1.product_name ,  T1.product_price FROM Products AS T1 JOIN Order_items AS T2 ON T1.product_id  =  T2.product_id GROUP BY T1.product_id ORDER BY count(*) DESC LIMIT 1	e_commerce
SELECT T1.product_id ,  T1.product_name ,  T1.product_price FROM Products AS T1 JOIN Order_items AS T2 ON T1.product_id  =  T2.product_id GROUP BY T1.product_id ORDER BY count(*) DESC LIMIT 1	e_commerce
SELECT T1.order_id ,  sum(T2.product_price) FROM Order_items AS T1 JOIN Products AS T2 ON T1.product_id  =  T2.product_id GROUP BY T1.order_id ORDER BY sum(T2.product_price) ASC LIMIT 1	e_commerce
select t1.order_id ,  sum(t2.product_price) from order_items as t1 join products as t2 on t1.product_id  =  t2.product_id group by t1.order_id order by sum(t2.product_price) asc limit 1	e_commerce
SELECT Payment_method_code FROM Customer_Payment_Methods GROUP BY Payment_method_code ORDER BY count(*) DESC LIMIT 1	e_commerce
SELECT Payment_method_code FROM Customer_Payment_Methods GROUP BY Payment_method_code ORDER BY count(*) DESC LIMIT 1	e_commerce
SELECT T1.gender_code ,  count(*) FROM Customers AS T1 JOIN Orders AS T2 ON T1.customer_id  =  T2.customer_id JOIN Order_items AS T3 ON T2.order_id  =  T3.order_id GROUP BY T1.gender_code	e_commerce
SELECT T1.gender_code ,  count(*) FROM Customers AS T1 JOIN Orders AS T2 ON T1.customer_id  =  T2.customer_id JOIN Order_items AS T3 ON T2.order_id  =  T3.order_id GROUP BY T1.gender_code	e_commerce
SELECT T1.gender_code ,  count(*) FROM Customers AS T1 JOIN Orders AS T2 ON T1.customer_id  =  T2.customer_id GROUP BY T1.gender_code	e_commerce
SELECT T1.gender_code ,  count(*) FROM Customers AS T1 JOIN Orders AS T2 ON T1.customer_id  =  T2.customer_id GROUP BY T1.gender_code	e_commerce
SELECT T1.customer_first_name ,  T1.customer_middle_initial ,  T1.customer_last_name ,  T2.Payment_method_code FROM Customers AS T1 JOIN Customer_Payment_Methods AS T2 ON T1.customer_id  =  T2.customer_id	e_commerce
SELECT T1.customer_first_name ,  T1.customer_middle_initial ,  T1.customer_last_name ,  T2.Payment_method_code FROM Customers AS T1 JOIN Customer_Payment_Methods AS T2 ON T1.customer_id  =  T2.customer_id	e_commerce
SELECT T1.invoice_status_code ,  T1.invoice_date ,  T2.shipment_date FROM Invoices AS T1 JOIN Shipments AS T2 ON T1.invoice_number  =  T2.invoice_number	e_commerce
SELECT T1.invoice_status_code ,  T1.invoice_date ,  T2.shipment_date FROM Invoices AS T1 JOIN Shipments AS T2 ON T1.invoice_number  =  T2.invoice_number	e_commerce
SELECT T1.product_name ,  T4.shipment_date FROM Products AS T1 JOIN Order_items AS T2 ON T1.product_id  =  T2.product_id JOIN Shipment_Items AS T3 ON T2.order_item_id  =  T3.order_item_id JOIN Shipments AS T4 ON T3.shipment_id  =  T4.shipment_id	e_commerce
SELECT T1.product_name ,  T4.shipment_date FROM Products AS T1 JOIN Order_items AS T2 ON T1.product_id  =  T2.product_id JOIN Shipment_Items AS T3 ON T2.order_item_id  =  T3.order_item_id JOIN Shipments AS T4 ON T3.shipment_id  =  T4.shipment_id	e_commerce
SELECT T1.order_item_status_code ,  T3.shipment_tracking_number FROM Order_items AS T1 JOIN Shipment_Items AS T2 ON T1.order_item_id  =  T2.order_item_id JOIN Shipments AS T3 ON T2.shipment_id  =  T3.shipment_id	e_commerce
SELECT T1.order_item_status_code ,  T3.shipment_tracking_number FROM Order_items AS T1 JOIN Shipment_Items AS T2 ON T1.order_item_id  =  T2.order_item_id JOIN Shipments AS T3 ON T2.shipment_id  =  T3.shipment_id	e_commerce
SELECT T1.product_name ,  T1.product_color FROM Products AS T1 JOIN Order_items AS T2 ON T1.product_id  =  T2.product_id JOIN Shipment_Items AS T3 ON T2.order_item_id  =  T3.order_item_id JOIN Shipments AS T4 ON T3.shipment_id  =  T4.shipment_id	e_commerce
SELECT T1.product_name ,  T1.product_color FROM Products AS T1 JOIN Order_items AS T2 ON T1.product_id  =  T2.product_id JOIN Shipment_Items AS T3 ON T2.order_item_id  =  T3.order_item_id JOIN Shipments AS T4 ON T3.shipment_id  =  T4.shipment_id	e_commerce
SELECT DISTINCT T1.product_name ,  T1.product_price ,  T1.product_description FROM Products AS T1 JOIN Order_items AS T2 ON T1.product_id  =  T2.product_id JOIN Orders AS T3 ON T2.order_id  =  T3.order_id JOIN Customers AS T4 ON T3.customer_id  =  T4.customer_id WHERE T4.gender_code  =  'Female'	e_commerce
SELECT DISTINCT T1.product_name ,  T1.product_price ,  T1.product_description FROM Products AS T1 JOIN Order_items AS T2 ON T1.product_id  =  T2.product_id JOIN Orders AS T3 ON T2.order_id  =  T3.order_id JOIN Customers AS T4 ON T3.customer_id  =  T4.customer_id WHERE T4.gender_code  =  'Female'	e_commerce
SELECT invoice_status_code FROM Invoices WHERE invoice_number NOT IN ( SELECT invoice_number FROM Shipments )	e_commerce
SELECT invoice_status_code FROM Invoices WHERE invoice_number NOT IN ( SELECT invoice_number FROM Shipments )	e_commerce
select t1.order_id ,  t1.date_order_placed ,  sum(t3.product_price) from orders as t1 join order_items as t2 on t1.order_id  =  t2.order_id join products as t3 on t2.product_id  =  t3.product_id group by t1.order_id	e_commerce
SELECT T1.order_id ,  T1.date_order_placed ,  sum(T3.product_price) FROM Orders AS T1 JOIN Order_items AS T2 ON T1.order_id  =  T2.order_id JOIN Products AS T3 ON T2.product_id  =  T3.product_id GROUP BY T1.order_id	e_commerce
SELECT count(DISTINCT customer_id) FROM Orders	e_commerce
SELECT count(DISTINCT customer_id) FROM Orders	e_commerce
SELECT count(DISTINCT order_item_status_code) FROM Order_items	e_commerce
SELECT count(DISTINCT order_item_status_code) FROM Order_items	e_commerce
SELECT count(DISTINCT Payment_method_code) FROM Customer_Payment_Methods	e_commerce
SELECT count(DISTINCT Payment_method_code) FROM Customer_Payment_Methods	e_commerce
SELECT login_name ,  login_password FROM Customers WHERE phone_number LIKE '+12%'	e_commerce
SELECT login_name ,  login_password FROM Customers WHERE phone_number LIKE '+12%'	e_commerce
SELECT product_size FROM Products WHERE product_name LIKE '%Dell%'	e_commerce
SELECT product_size FROM Products WHERE product_name LIKE '%Dell%'	e_commerce
SELECT product_price ,  product_size FROM Products WHERE product_price  >  ( SELECT avg(product_price) FROM Products )	e_commerce
SELECT product_price ,  product_size FROM Products WHERE product_price  >  ( SELECT avg(product_price) FROM Products )	e_commerce
SELECT count(*) FROM Products WHERE product_id NOT IN ( SELECT product_id FROM Order_items )	e_commerce
SELECT count(*) FROM Products WHERE product_id NOT IN ( SELECT product_id FROM Order_items )	e_commerce
SELECT count(*) FROM Customers WHERE customer_id NOT IN ( SELECT customer_id FROM Customer_Payment_Methods )	e_commerce
SELECT count(*) FROM Customers WHERE customer_id NOT IN ( SELECT customer_id FROM Customer_Payment_Methods )	e_commerce
SELECT order_status_code ,  date_order_placed FROM Orders	e_commerce
SELECT order_status_code ,  date_order_placed FROM Orders	e_commerce
SELECT address_line_1 ,  town_city ,  county FROM Customers WHERE Country  =  'USA'	e_commerce
SELECT address_line_1 ,  town_city ,  county FROM Customers WHERE Country  =  'USA'	e_commerce
SELECT T1.customer_first_name ,  T4.product_name FROM Customers AS T1 JOIN Orders AS T2 ON T1.customer_id  =  T2.customer_id JOIN Order_items AS T3 ON T2.order_id  =  T3.order_id JOIN Products AS T4 ON T3.product_id  =  T4.product_id	e_commerce
SELECT T1.customer_first_name ,  T4.product_name FROM Customers AS T1 JOIN Orders AS T2 ON T1.customer_id  =  T2.customer_id JOIN Order_items AS T3 ON T2.order_id  =  T3.order_id JOIN Products AS T4 ON T3.product_id  =  T4.product_id	e_commerce
SELECT count(*) FROM Shipment_Items	e_commerce
SELECT count(*) FROM Shipment_Items	e_commerce
SELECT avg(product_price) FROM Products	e_commerce
SELECT avg(product_price) FROM Products	e_commerce
SELECT avg(T1.product_price) FROM Products AS T1 JOIN Order_items AS T2 ON T1.product_id  =  T2.product_id	e_commerce
SELECT avg(T1.product_price) FROM Products AS T1 JOIN Order_items AS T2 ON T1.product_id  =  T2.product_id	e_commerce
SELECT email_address ,  town_city ,  county FROM Customers WHERE gender_code  =  ( SELECT gender_code FROM Customers GROUP BY gender_code ORDER BY count(*) ASC LIMIT 1 )	e_commerce
SELECT email_address ,  town_city ,  county FROM Customers WHERE gender_code  =  ( SELECT gender_code FROM Customers GROUP BY gender_code ORDER BY count(*) ASC LIMIT 1 )	e_commerce
SELECT date_order_placed FROM Orders WHERE customer_id IN ( SELECT T1.customer_id FROM Customers AS T1 JOIN Customer_Payment_Methods AS T2 ON T1.customer_id  =  T2.customer_id GROUP BY T1.customer_id HAVING count(*)  >=  2 )	e_commerce
SELECT date_order_placed FROM Orders WHERE customer_id IN ( SELECT T1.customer_id FROM Customers AS T1 JOIN Customer_Payment_Methods AS T2 ON T1.customer_id  =  T2.customer_id GROUP BY T1.customer_id HAVING count(*)  >=  2 )	e_commerce
SELECT order_status_code FROM Orders GROUP BY order_status_code ORDER BY count(*) LIMIT 1	e_commerce
SELECT order_status_code FROM Orders GROUP BY order_status_code ORDER BY count(*) LIMIT 1	e_commerce
SELECT T1.product_id ,  T1.product_description FROM Products AS T1 JOIN Order_items AS T2 ON T1.product_id  =  T2.product_id GROUP BY T1.product_id HAVING count(*)  >  3	e_commerce
SELECT T1.product_id ,  T1.product_description FROM Products AS T1 JOIN Order_items AS T2 ON T1.product_id  =  T2.product_id GROUP BY T1.product_id HAVING count(*)  >  3	e_commerce
SELECT T1.invoice_date ,  T1.invoice_number FROM Invoices AS T1 JOIN Shipments AS T2 ON T1.invoice_number  =  T2.invoice_number GROUP BY T1.invoice_number HAVING count(*)  >=  2	e_commerce
SELECT T1.invoice_date ,  T1.invoice_number FROM Invoices AS T1 JOIN Shipments AS T2 ON T1.invoice_number  =  T2.invoice_number GROUP BY T1.invoice_number HAVING count(*)  >=  2	e_commerce
SELECT shipment_tracking_number ,  shipment_date FROM Shipments	e_commerce
SELECT shipment_tracking_number ,  shipment_date FROM Shipments	e_commerce
SELECT product_color ,  product_description ,  product_size FROM Products WHERE product_price  <  ( SELECT max(product_price) FROM products )	e_commerce
select product_color ,  product_description ,  product_size from products where product_price  !=  ( select max(product_price) from products )	e_commerce
SELECT name FROM director WHERE age  >  (SELECT avg(age) FROM director)	bbc_channels
SELECT name FROM director ORDER BY age DESC LIMIT 1	bbc_channels
SELECT count(*) FROM channel WHERE internet LIKE "%bbc%"	bbc_channels
SELECT count(DISTINCT Digital_terrestrial_channel) FROM channel	bbc_channels
SELECT title FROM program ORDER BY start_year DESC	bbc_channels
SELECT t2.name FROM program AS t1 JOIN director AS t2 ON t1.director_id  =  t2.director_id GROUP BY t1.director_id ORDER BY count(*) DESC LIMIT 1	bbc_channels
SELECT t2.name ,  t2.age FROM program AS t1 JOIN director AS t2 ON t1.director_id  =  t2.director_id GROUP BY t1.director_id ORDER BY count(*) DESC LIMIT 1	bbc_channels
SELECT title FROM program ORDER BY start_year DESC LIMIT 1	bbc_channels
SELECT t1.name ,  t1.internet FROM channel AS t1 JOIN program AS t2 ON t1.channel_id  =  t2.channel_id GROUP BY t1.channel_id HAVING count(*)  >  1	bbc_channels
SELECT t1.name ,  count(*) FROM channel AS t1 JOIN program AS t2 ON t1.channel_id  =  t2.channel_id GROUP BY t1.channel_id	bbc_channels
SELECT count(*) FROM channel WHERE channel_id NOT IN (SELECT channel_id FROM program)	bbc_channels
SELECT t2.name FROM program AS t1 JOIN director AS t2 ON t1.director_id  =  t2.director_id WHERE t1.title  =  'Dracula'	bbc_channels
SELECT t1.name ,  t1.internet FROM channel AS t1 JOIN director_admin AS t2 ON t1.channel_id  =  t2.channel_id GROUP BY t1.channel_id ORDER BY count(*) DESC LIMIT 1	bbc_channels
SELECT name FROM director WHERE age BETWEEN 30 AND 60	bbc_channels
SELECT t1.name FROM channel AS t1 JOIN director_admin AS t2 ON t1.channel_id  =  t2.channel_id JOIN director AS t3 ON t2.director_id  =  t3.director_id WHERE t3.age  <  40 INTERSECT SELECT t1.name FROM channel AS t1 JOIN director_admin AS t2 ON t1.channel_id  =  t2.channel_id JOIN director AS t3 ON t2.director_id  =  t3.director_id WHERE t3.age  >  60	bbc_channels
SELECT t1.name ,  t1.channel_id FROM channel AS t1 JOIN director_admin AS t2 ON t1.channel_id  =  t2.channel_id JOIN director AS t3 ON t2.director_id  =  t3.director_id WHERE t3.name != "Hank Baskett"	bbc_channels
SELECT count(*) FROM radio	tv_shows
select transmitter from radio order by erp_kw asc	tv_shows
SELECT tv_show_name ,  Original_Airdate FROM tv_show	tv_shows
SELECT Station_name FROM city_channel WHERE Affiliation != "ABC"	tv_shows
SELECT Transmitter FROM radio WHERE ERP_kW  >  150 OR ERP_kW  <  30	tv_shows
SELECT Transmitter FROM radio ORDER BY ERP_kW DESC LIMIT 1	tv_shows
SELECT avg(ERP_kW) FROM radio	tv_shows
SELECT Affiliation ,  COUNT(*) FROM city_channel GROUP BY Affiliation	tv_shows
SELECT Affiliation FROM city_channel GROUP BY Affiliation ORDER BY COUNT(*) DESC LIMIT 1	tv_shows
SELECT Affiliation FROM city_channel GROUP BY Affiliation HAVING COUNT(*)  >  3	tv_shows
SELECT City ,  Station_name FROM city_channel ORDER BY Station_name ASC	tv_shows
SELECT T3.Transmitter ,  T2.City FROM city_channel_radio AS T1 JOIN city_channel AS T2 ON T1.City_channel_ID  =  T2.ID JOIN radio AS T3 ON T1.Radio_ID  =  T3.Radio_ID	tv_shows
SELECT T3.Transmitter ,  T2.Station_name FROM city_channel_radio AS T1 JOIN city_channel AS T2 ON T1.City_channel_ID  =  T2.ID JOIN radio AS T3 ON T1.Radio_ID  =  T3.Radio_ID ORDER BY T3.ERP_kW DESC	tv_shows
SELECT T2.Transmitter ,  COUNT(*) FROM city_channel_radio AS T1 JOIN radio AS T2 ON T1.Radio_ID  =  T2.Radio_ID GROUP BY T2.Transmitter	tv_shows
SELECT Transmitter FROM radio WHERE Radio_ID NOT IN (SELECT Radio_ID FROM city_channel_radio)	tv_shows
SELECT model FROM vehicle WHERE power  >  6000 ORDER BY top_speed DESC LIMIT 1	vehicle_driver
SELECT model FROM vehicle WHERE power  >  6000 ORDER BY top_speed DESC LIMIT 1	vehicle_driver
SELECT name FROM driver WHERE citizenship  =  'United States'	vehicle_driver
SELECT name FROM driver WHERE citizenship  =  'United States'	vehicle_driver
SELECT count(*) ,  driver_id FROM vehicle_driver GROUP BY driver_id ORDER BY count(*) DESC LIMIT 1	vehicle_driver
SELECT count(*) ,  driver_id FROM vehicle_driver GROUP BY driver_id ORDER BY count(*) DESC LIMIT 1	vehicle_driver
SELECT max(power) ,  avg(power) FROM vehicle WHERE builder  =  'Zhuzhou'	vehicle_driver
SELECT max(power) ,  avg(power) FROM vehicle WHERE builder  =  'Zhuzhou'	vehicle_driver
SELECT vehicle_id FROM vehicle_driver GROUP BY vehicle_id ORDER BY count(*) ASC LIMIT 1	vehicle_driver
SELECT vehicle_id FROM vehicle_driver GROUP BY vehicle_id ORDER BY count(*) ASC LIMIT 1	vehicle_driver
SELECT top_speed ,  power FROM vehicle WHERE build_year  =  1996	vehicle_driver
SELECT top_speed ,  power FROM vehicle WHERE build_year  =  1996	vehicle_driver
SELECT build_year ,  model ,  builder FROM vehicle	vehicle_driver
SELECT build_year ,  model ,  builder FROM vehicle	vehicle_driver
SELECT count(DISTINCT T1.driver_id) FROM vehicle_driver AS T1 JOIN vehicle AS T2 ON T1.vehicle_id  =  T2.vehicle_id WHERE T2.build_year  =  2012	vehicle_driver
SELECT count(DISTINCT T1.driver_id) FROM vehicle_driver AS T1 JOIN vehicle AS T2 ON T1.vehicle_id  =  T2.vehicle_id WHERE T2.build_year  =  2012	vehicle_driver
SELECT count(*) FROM driver WHERE Racing_Series  =  'NASCAR'	vehicle_driver
SELECT count(*) FROM driver WHERE Racing_Series  =  'NASCAR'	vehicle_driver
SELECT avg(top_speed) FROM vehicle	vehicle_driver
SELECT avg(top_speed) FROM vehicle	vehicle_driver
select distinct t1.name from driver as t1 join vehicle_driver as t2 on t1.driver_id  =  t2.driver_id join vehicle as t3 on t2.vehicle_id  =  t3.vehicle_id where t3.power  >  5000	vehicle_driver
SELECT DISTINCT T1.Name FROM driver AS T1 JOIN vehicle_driver AS T2 ON T1.driver_id  =  T2.driver_id JOIN vehicle AS T3 ON T2.vehicle_id  =  T3.vehicle_id WHERE T3.power  >  5000	vehicle_driver
SELECT model FROM vehicle WHERE total_production  >  100 OR top_speed  >  150	vehicle_driver
SELECT model FROM vehicle WHERE total_production  >  100 OR top_speed  >  150	vehicle_driver
SELECT model ,  build_year FROM vehicle WHERE model LIKE '%DJ%'	vehicle_driver
SELECT model ,  build_year FROM vehicle WHERE model LIKE '%DJ%'	vehicle_driver
SELECT model FROM vehicle EXCEPT SELECT T1.model FROM vehicle AS T1 JOIN vehicle_driver AS T2 ON T1.vehicle_id  =  T2.vehicle_id	vehicle_driver
SELECT model FROM vehicle EXCEPT SELECT T1.model FROM vehicle AS T1 JOIN vehicle_driver AS T2 ON T1.vehicle_id  =  T2.vehicle_id	vehicle_driver
SELECT T1.vehicle_id ,  T1.model FROM vehicle AS T1 JOIN vehicle_driver AS T2 ON T1.vehicle_id  =  T2.vehicle_id GROUP BY T2.vehicle_id HAVING count(*)  =  2 OR T1.builder  =  'Ziyang'	vehicle_driver
SELECT T1.vehicle_id ,  T1.model FROM vehicle AS T1 JOIN vehicle_driver AS T2 ON T1.vehicle_id  =  T2.vehicle_id GROUP BY T2.vehicle_id HAVING count(*)  =  2 OR T1.builder  =  'Ziyang'	vehicle_driver
SELECT T1.vehicle_id ,  T1.model FROM vehicle AS T1 JOIN vehicle_driver AS T2 ON T1.vehicle_id  =  T2.vehicle_id JOIN driver AS T3 ON T2.driver_id  =  T3.driver_id WHERE T3.name  =  'Jeff Gordon' UNION SELECT T1.vehicle_id ,  T1.model FROM vehicle AS T1 JOIN vehicle_driver AS T2 ON T1.vehicle_id  =  T2.vehicle_id GROUP BY T2.vehicle_id HAVING count(*)  >  2	vehicle_driver
SELECT T1.vehicle_id ,  T1.model FROM vehicle AS T1 JOIN vehicle_driver AS T2 ON T1.vehicle_id  =  T2.vehicle_id JOIN driver AS T3 ON T2.driver_id  =  T3.driver_id WHERE T3.name  =  'Jeff Gordon' UNION SELECT T1.vehicle_id ,  T1.model FROM vehicle AS T1 JOIN vehicle_driver AS T2 ON T1.vehicle_id  =  T2.vehicle_id GROUP BY T2.vehicle_id HAVING count(*)  >  2	vehicle_driver
SELECT count(*) FROM vehicle WHERE top_speed  =  (SELECT max(top_speed) FROM vehicle)	vehicle_driver
SELECT count(*) FROM vehicle WHERE top_speed  =  (SELECT max(top_speed) FROM vehicle)	vehicle_driver
SELECT name FROM driver ORDER BY name	vehicle_driver
SELECT name FROM driver ORDER BY name	vehicle_driver
SELECT count(*) ,  racing_series FROM driver GROUP BY racing_series	vehicle_driver
SELECT count(*) ,  racing_series FROM driver GROUP BY racing_series	vehicle_driver
SELECT T1.name ,  T1.citizenship FROM driver AS T1 JOIN vehicle_driver AS T2 ON T1.driver_id  =  T2.driver_id JOIN vehicle AS T3 ON T2.vehicle_id  =  T3.vehicle_id WHERE T3.model  =  'DJ1'	vehicle_driver
SELECT T1.name ,  T1.citizenship FROM driver AS T1 JOIN vehicle_driver AS T2 ON T1.driver_id  =  T2.driver_id JOIN vehicle AS T3 ON T2.vehicle_id  =  T3.vehicle_id WHERE T3.model  =  'DJ1'	vehicle_driver
SELECT count(*) FROM driver WHERE driver_id NOT IN ( SELECT driver_id FROM vehicle_driver )	vehicle_driver
SELECT count(*) FROM driver WHERE driver_id NOT IN ( SELECT driver_id FROM vehicle_driver )	vehicle_driver
SELECT count(*) FROM Exams	online_exams
SELECT count(*) FROM Exams	online_exams
select distinct subject_code from exams order by subject_code asc	online_exams
SELECT DISTINCT Subject_Code FROM Exams ORDER BY Subject_Code	online_exams
SELECT Exam_Date ,  Exam_Name FROM Exams WHERE Subject_Code != 'Database'	online_exams
SELECT Exam_Date ,  Exam_Name FROM Exams WHERE Subject_Code != 'Database'	online_exams
SELECT Exam_Date FROM Exams WHERE Subject_Code LIKE '%data%' ORDER BY Exam_Date DESC	online_exams
SELECT Exam_Date FROM Exams WHERE Subject_Code LIKE '%data%' ORDER BY Exam_Date DESC	online_exams
SELECT Type_of_Question_Code ,  COUNT(*) FROM Questions GROUP BY Type_of_Question_Code	online_exams
SELECT Type_of_Question_Code ,  COUNT(*) FROM Questions GROUP BY Type_of_Question_Code	online_exams
SELECT DISTINCT Student_Answer_Text FROM Student_Answers WHERE Comments  =  "Normal"	online_exams
SELECT DISTINCT Student_Answer_Text FROM Student_Answers WHERE Comments  =  "Normal"	online_exams
SELECT count(DISTINCT Comments) FROM Student_Answers	online_exams
SELECT count(DISTINCT Comments) FROM Student_Answers	online_exams
SELECT Student_Answer_Text FROM Student_Answers GROUP BY Student_Answer_Text ORDER BY COUNT(*) DESC	online_exams
SELECT Student_Answer_Text FROM Student_Answers GROUP BY Student_Answer_Text ORDER BY COUNT(*) DESC	online_exams
SELECT T2.First_Name ,  T1.Date_of_Answer FROM Student_Answers AS T1 JOIN Students AS T2 ON T1.Student_ID  =  T2.Student_ID	online_exams
SELECT T2.First_Name ,  T1.Date_of_Answer FROM Student_Answers AS T1 JOIN Students AS T2 ON T1.Student_ID  =  T2.Student_ID	online_exams
SELECT T2.Email_Adress ,  T1.Date_of_Answer FROM Student_Answers AS T1 JOIN Students AS T2 ON T1.Student_ID  =  T2.Student_ID ORDER BY T1.Date_of_Answer DESC	online_exams
SELECT T2.Email_Adress ,  T1.Date_of_Answer FROM Student_Answers AS T1 JOIN Students AS T2 ON T1.Student_ID  =  T2.Student_ID ORDER BY T1.Date_of_Answer DESC	online_exams
SELECT Assessment FROM Student_Assessments GROUP BY Assessment ORDER BY COUNT(*) ASC LIMIT 1	online_exams
SELECT Assessment FROM Student_Assessments GROUP BY Assessment ORDER BY COUNT(*) ASC LIMIT 1	online_exams
SELECT T2.First_Name FROM Student_Answers AS T1 JOIN Students AS T2 ON T1.Student_ID  =  T2.Student_ID GROUP BY T1.Student_ID HAVING COUNT(*)  >=  2	online_exams
SELECT T2.First_Name FROM Student_Answers AS T1 JOIN Students AS T2 ON T1.Student_ID  =  T2.Student_ID GROUP BY T1.Student_ID HAVING COUNT(*)  >=  2	online_exams
SELECT Valid_Answer_Text FROM Valid_Answers GROUP BY Valid_Answer_Text ORDER BY COUNT(*) DESC LIMIT 1	online_exams
SELECT Valid_Answer_Text FROM Valid_Answers GROUP BY Valid_Answer_Text ORDER BY COUNT(*) DESC LIMIT 1	online_exams
SELECT Last_Name FROM Students WHERE Gender_MFU != "M"	online_exams
SELECT Last_Name FROM Students WHERE Gender_MFU != "M"	online_exams
SELECT Gender_MFU ,  COUNT(*) FROM Students GROUP BY Gender_MFU	online_exams
SELECT Gender_MFU ,  COUNT(*) FROM Students GROUP BY Gender_MFU	online_exams
SELECT Last_Name FROM Students WHERE Gender_MFU  =  "F" OR Gender_MFU  =  "M"	online_exams
SELECT Last_Name FROM Students WHERE Gender_MFU  =  "F" OR Gender_MFU  =  "M"	online_exams
SELECT First_Name FROM Students WHERE Student_ID NOT IN (SELECT Student_ID FROM Student_Answers)	online_exams
SELECT First_Name FROM Students WHERE Student_ID NOT IN (SELECT Student_ID FROM Student_Answers)	online_exams
SELECT Student_Answer_Text FROM Student_Answers WHERE Comments  =  "Normal" INTERSECT SELECT Student_Answer_Text FROM Student_Answers WHERE Comments  =  "Absent"	online_exams
SELECT Student_Answer_Text FROM Student_Answers WHERE Comments  =  "Normal" INTERSECT SELECT Student_Answer_Text FROM Student_Answers WHERE Comments  =  "Absent"	online_exams
SELECT Type_of_Question_Code FROM Questions GROUP BY Type_of_Question_Code HAVING count(*)  >=  3	online_exams
SELECT Type_of_Question_Code FROM Questions GROUP BY Type_of_Question_Code HAVING count(*)  >=  3	online_exams
SELECT * FROM Students	online_exams
SELECT * FROM Students	online_exams
SELECT count(*) FROM Addresses	customers_and_orders
SELECT count(*) FROM Addresses	customers_and_orders
SELECT address_id ,  address_details FROM Addresses	customers_and_orders
SELECT address_id ,  address_details FROM Addresses	customers_and_orders
SELECT count(*) FROM Products	customers_and_orders
SELECT count(*) FROM Products	customers_and_orders
SELECT product_id ,  product_type_code ,  product_name FROM Products	customers_and_orders
SELECT product_id ,  product_type_code ,  product_name FROM Products	customers_and_orders
SELECT product_price FROM Products WHERE product_name  =  "Monitor"	customers_and_orders
SELECT product_price FROM Products WHERE product_name  =  "Monitor"	customers_and_orders
SELECT min(product_price) ,  avg(product_price) ,  max(product_price) FROM Products	customers_and_orders
SELECT min(product_price) ,  avg(product_price) ,  max(product_price) FROM Products	customers_and_orders
SELECT avg(product_price) FROM Products WHERE product_type_code  =  "Clothes"	customers_and_orders
SELECT avg(product_price) FROM Products WHERE product_type_code  =  "Clothes"	customers_and_orders
SELECT count(*) FROM Products WHERE product_type_code  =  "Hardware"	customers_and_orders
SELECT count(*) FROM Products WHERE product_type_code  =  "Hardware"	customers_and_orders
SELECT product_name FROM Products WHERE product_price  >  (SELECT avg(product_price) FROM Products)	customers_and_orders
SELECT product_name FROM Products WHERE product_price  >  (SELECT avg(product_price) FROM Products)	customers_and_orders
SELECT product_name FROM Products WHERE product_type_code  =  "Hardware" AND product_price  >  (SELECT avg(product_price) FROM Products WHERE product_type_code  =  "Hardware")	customers_and_orders
SELECT product_name FROM Products WHERE product_type_code  =  "Hardware" AND product_price  >  (SELECT avg(product_price) FROM Products WHERE product_type_code  =  "Hardware")	customers_and_orders
SELECT product_name FROM Products WHERE product_type_code  =  "Clothes" ORDER BY product_price DESC LIMIT 1	customers_and_orders
SELECT product_name FROM Products WHERE product_type_code  =  "Clothes" ORDER BY product_price DESC LIMIT 1	customers_and_orders
SELECT product_id ,  product_name FROM Products WHERE product_type_code  =  "Hardware" ORDER BY product_price ASC LIMIT 1	customers_and_orders
SELECT product_id ,  product_name FROM Products WHERE product_type_code  =  "Hardware" ORDER BY product_price ASC LIMIT 1	customers_and_orders
SELECT product_name FROM Products ORDER BY product_price DESC	customers_and_orders
SELECT product_name FROM Products ORDER BY product_price DESC	customers_and_orders
SELECT product_name FROM Products WHERE product_type_code  =  "Hardware" ORDER BY product_price ASC	customers_and_orders
SELECT product_name FROM Products WHERE product_type_code  =  "Hardware" ORDER BY product_price ASC	customers_and_orders
SELECT product_type_code ,  count(*) FROM Products GROUP BY product_type_code	customers_and_orders
SELECT product_type_code ,  count(*) FROM Products GROUP BY product_type_code	customers_and_orders
SELECT product_type_code ,  avg(product_price) FROM Products GROUP BY product_type_code	customers_and_orders
SELECT product_type_code ,  avg(product_price) FROM Products GROUP BY product_type_code	customers_and_orders
SELECT product_type_code FROM Products GROUP BY product_type_code HAVING count(*)  >=  2	customers_and_orders
SELECT product_type_code FROM Products GROUP BY product_type_code HAVING count(*)  >=  2	customers_and_orders
SELECT product_type_code FROM Products GROUP BY product_type_code ORDER BY count(*) DESC LIMIT 1	customers_and_orders
SELECT product_type_code FROM Products GROUP BY product_type_code ORDER BY count(*) DESC LIMIT 1	customers_and_orders
SELECT count(*) FROM Customers	customers_and_orders
SELECT count(*) FROM Customers	customers_and_orders
SELECT customer_id ,  customer_name FROM Customers	customers_and_orders
SELECT customer_id ,  customer_name FROM Customers	customers_and_orders
SELECT customer_address ,  customer_phone ,  customer_email FROM Customers WHERE customer_name  =  "Jeromy"	customers_and_orders
SELECT customer_address ,  customer_phone ,  customer_email FROM Customers WHERE customer_name  =  "Jeromy"	customers_and_orders
SELECT payment_method_code ,  count(*) FROM Customers GROUP BY payment_method_code	customers_and_orders
SELECT payment_method_code ,  count(*) FROM Customers GROUP BY payment_method_code	customers_and_orders
SELECT payment_method_code FROM Customers GROUP BY payment_method_code ORDER BY count(*) DESC LIMIT 1	customers_and_orders
SELECT payment_method_code FROM Customers GROUP BY payment_method_code ORDER BY count(*) DESC LIMIT 1	customers_and_orders
SELECT customer_name FROM Customers WHERE payment_method_code  =  ( SELECT payment_method_code FROM Customers GROUP BY payment_method_code ORDER BY count(*) ASC LIMIT 1)	customers_and_orders
SELECT customer_name FROM Customers WHERE payment_method_code  =  ( SELECT payment_method_code FROM Customers GROUP BY payment_method_code ORDER BY count(*) ASC LIMIT 1)	customers_and_orders
SELECT payment_method_code ,  customer_number FROM Customers WHERE customer_name  =  "Jeromy"	customers_and_orders
SELECT payment_method_code ,  customer_number FROM Customers WHERE customer_name  =  "Jeromy"	customers_and_orders
SELECT DISTINCT payment_method_code FROM Customers	customers_and_orders
SELECT DISTINCT payment_method_code FROM Customers	customers_and_orders
SELECT product_id ,  product_type_code FROM Products ORDER BY product_name	customers_and_orders
SELECT product_id ,  product_type_code FROM Products ORDER BY product_name	customers_and_orders
SELECT product_type_code FROM Products GROUP BY product_type_code ORDER BY count(*) ASC LIMIT 1	customers_and_orders
SELECT product_type_code FROM Products GROUP BY product_type_code ORDER BY count(*) ASC LIMIT 1	customers_and_orders
SELECT count(*) FROM Customer_orders	customers_and_orders
SELECT count(*) FROM Customer_orders	customers_and_orders
SELECT order_id ,  order_date ,  order_status_code FROM Customer_orders AS T1 JOIN Customers AS T2 ON T1.customer_id  =  T2.customer_id WHERE T2.customer_name  =  "Jeromy"	customers_and_orders
SELECT order_id ,  order_date ,  order_status_code FROM Customer_orders AS T1 JOIN Customers AS T2 ON T1.customer_id  =  T2.customer_id WHERE T2.customer_name  =  "Jeromy"	customers_and_orders
SELECT T2.customer_name ,  T1.customer_id ,  count(*) FROM Customer_orders AS T1 JOIN Customers AS T2 ON T1.customer_id  =  T2.customer_id GROUP BY T1.customer_id	customers_and_orders
SELECT T2.customer_name ,  T1.customer_id ,  count(*) FROM Customer_orders AS T1 JOIN Customers AS T2 ON T1.customer_id  =  T2.customer_id GROUP BY T1.customer_id	customers_and_orders
SELECT T1.customer_id ,  T2.customer_name ,  T2.customer_phone ,  T2.customer_email FROM Customer_orders AS T1 JOIN Customers AS T2 ON T1.customer_id  =  T2.customer_id GROUP BY T1.customer_id ORDER BY count(*) DESC LIMIT 1	customers_and_orders
SELECT T1.customer_id ,  T2.customer_name ,  T2.customer_phone ,  T2.customer_email FROM Customer_orders AS T1 JOIN Customers AS T2 ON T1.customer_id  =  T2.customer_id GROUP BY T1.customer_id ORDER BY count(*) DESC LIMIT 1	customers_and_orders
SELECT order_status_code ,  count(*) FROM Customer_orders GROUP BY order_status_code	customers_and_orders
SELECT order_status_code ,  count(*) FROM Customer_orders GROUP BY order_status_code	customers_and_orders
SELECT order_status_code FROM Customer_orders GROUP BY order_status_code ORDER BY count(*) DESC LIMIT 1	customers_and_orders
SELECT order_status_code FROM Customer_orders GROUP BY order_status_code ORDER BY count(*) DESC LIMIT 1	customers_and_orders
SELECT count(*) FROM Customers WHERE customer_id NOT IN  ( SELECT customer_id FROM Customer_orders)	customers_and_orders
SELECT count(*) FROM Customers WHERE customer_id NOT IN  ( SELECT customer_id FROM Customer_orders)	customers_and_orders
SELECT product_name FROM Products EXCEPT SELECT T1.product_name FROM Products AS t1 JOIN Order_items AS T2 ON T1.product_id  =  T2.product_id	customers_and_orders
SELECT product_name FROM Products EXCEPT SELECT T1.product_name FROM Products AS t1 JOIN Order_items AS T2 ON T1.product_id  =  T2.product_id	customers_and_orders
SELECT sum(order_quantity) FROM Order_items AS T1 JOIN Products AS T2 ON T1.product_id  =  T2.product_id WHERE T2.product_name  =  "Monitor"	customers_and_orders
SELECT sum(order_quantity) FROM Order_items AS T1 JOIN Products AS T2 ON T1.product_id  =  T2.product_id WHERE T2.product_name  =  "Monitor"	customers_and_orders
SELECT count(DISTINCT T3.customer_id) FROM Order_items AS T1 JOIN Products AS T2 ON T1.product_id  =  T2.product_id JOIN Customer_orders AS T3 ON T3.order_id  =  T1.order_id WHERE T2.product_name  =  "Monitor"	customers_and_orders
SELECT count(DISTINCT T3.customer_id) FROM Order_items AS T1 JOIN Products AS T2 ON T1.product_id  =  T2.product_id JOIN Customer_orders AS T3 ON T3.order_id  =  T1.order_id WHERE T2.product_name  =  "Monitor"	customers_and_orders
SELECT count(DISTINCT customer_id) FROM Customer_orders	customers_and_orders
SELECT count(DISTINCT customer_id) FROM Customer_orders	customers_and_orders
SELECT customer_id FROM Customers EXCEPT SELECT customer_id FROM Customer_orders	customers_and_orders
SELECT customer_id FROM Customers EXCEPT SELECT customer_id FROM Customer_orders	customers_and_orders
SELECT T1.order_date ,  T1.order_id FROM Customer_Orders AS T1 JOIN Order_items AS T2 ON T1.order_id  =  T2.order_id WHERE T2.order_quantity  >  6 UNION SELECT T1.order_date ,  T1.order_id FROM Customer_Orders AS T1 JOIN Order_items AS T2 ON T1.order_id  =  T2.order_id GROUP BY T1.order_id HAVING count(*)  >  3;	customers_and_orders
SELECT T1.order_date ,  T1.order_id FROM Customer_Orders AS T1 JOIN Order_items AS T2 ON T1.order_id  =  T2.order_id WHERE T2.order_quantity  >  6 UNION SELECT T1.order_date ,  T1.order_id FROM Customer_Orders AS T1 JOIN Order_items AS T2 ON T1.order_id  =  T2.order_id GROUP BY T1.order_id HAVING count(*)  >  3;	customers_and_orders
SELECT count(*) FROM building	region_building
SELECT count(*) FROM building	region_building
SELECT Name FROM building ORDER BY Number_of_Stories ASC	region_building
SELECT Name FROM building ORDER BY Number_of_Stories ASC	region_building
SELECT Address FROM building ORDER BY Completed_Year DESC	region_building
SELECT Address FROM building ORDER BY Completed_Year DESC	region_building
SELECT max(Number_of_Stories) FROM building WHERE Completed_Year != "1980"	region_building
SELECT max(Number_of_Stories) FROM building WHERE Completed_Year != "1980"	region_building
SELECT avg(Population) FROM region	region_building
SELECT avg(Population) FROM region	region_building
SELECT Name FROM region ORDER BY Name ASC	region_building
SELECT Name FROM region ORDER BY Name ASC	region_building
SELECT Capital FROM region WHERE Area  >  10000	region_building
SELECT Capital FROM region WHERE Area  >  10000	region_building
SELECT Capital FROM region ORDER BY Population DESC LIMIT 1	region_building
SELECT Capital FROM region ORDER BY Population DESC LIMIT 1	region_building
SELECT Name FROM region ORDER BY Area DESC LIMIT 5	region_building
SELECT Name FROM region ORDER BY Area DESC LIMIT 5	region_building
SELECT T1.Name ,  T2.Name FROM building AS T1 JOIN region AS T2 ON T1.Region_ID  =  T2.Region_ID	region_building
SELECT T1.Name ,  T2.Name FROM building AS T1 JOIN region AS T2 ON T1.Region_ID  =  T2.Region_ID	region_building
SELECT T2.Name FROM building AS T1 JOIN region AS T2 ON T1.Region_ID  =  T2.Region_ID GROUP BY T1.Region_ID HAVING COUNT(*)  >  1	region_building
SELECT T2.Name FROM building AS T1 JOIN region AS T2 ON T1.Region_ID  =  T2.Region_ID GROUP BY T1.Region_ID HAVING COUNT(*)  >  1	region_building
SELECT T2.capital FROM building AS T1 JOIN region AS T2 ON T1.Region_ID  =  T2.Region_ID GROUP BY T1.Region_ID ORDER BY COUNT(*) DESC LIMIT 1	region_building
SELECT T2.capital FROM building AS T1 JOIN region AS T2 ON T1.Region_ID  =  T2.Region_ID GROUP BY T1.Region_ID ORDER BY COUNT(*) DESC LIMIT 1	region_building
SELECT T1.Address ,  T2.Capital FROM building AS T1 JOIN region AS T2 ON T1.Region_ID  =  T2.Region_ID	region_building
SELECT T1.Address ,  T2.Capital FROM building AS T1 JOIN region AS T2 ON T1.Region_ID  =  T2.Region_ID	region_building
SELECT T1.Number_of_Stories FROM building AS T1 JOIN region AS T2 ON T1.Region_ID  =  T2.Region_ID WHERE T2.Name  =  "Abruzzo"	region_building
SELECT T1.Number_of_Stories FROM building AS T1 JOIN region AS T2 ON T1.Region_ID  =  T2.Region_ID WHERE T2.Name  =  "Abruzzo"	region_building
SELECT Completed_Year ,  COUNT(*) FROM building GROUP BY Completed_Year	region_building
SELECT Completed_Year ,  COUNT(*) FROM building GROUP BY Completed_Year	region_building
SELECT Completed_Year FROM building GROUP BY Completed_Year ORDER BY COUNT(*) DESC LIMIT 1	region_building
SELECT Completed_Year FROM building GROUP BY Completed_Year ORDER BY COUNT(*) DESC LIMIT 1	region_building
SELECT Name FROM region WHERE Region_ID NOT IN (SELECT Region_ID FROM building)	region_building
SELECT Name FROM region WHERE Region_ID NOT IN (SELECT Region_ID FROM building)	region_building
SELECT Completed_Year FROM building WHERE Number_of_Stories  >  20 INTERSECT SELECT Completed_Year FROM building WHERE Number_of_Stories  <  15	region_building
SELECT Completed_Year FROM building WHERE Number_of_Stories  >  20 INTERSECT SELECT Completed_Year FROM building WHERE Number_of_Stories  <  15	region_building
SELECT DISTINCT Address FROM building	region_building
SELECT DISTINCT Address FROM building	region_building
SELECT Completed_Year FROM building ORDER BY Number_of_Stories DESC	region_building
SELECT Completed_Year FROM building ORDER BY Number_of_Stories DESC	region_building
select channel_details from channels order by channel_details	government_shift
select channel_details from channels order by channel_details	government_shift
SELECT count(*) FROM services	government_shift
SELECT count(*) FROM services	government_shift
SELECT analytical_layer_type_code FROM analytical_layer GROUP BY analytical_layer_type_code ORDER BY count(*) DESC LIMIT 1	government_shift
SELECT analytical_layer_type_code FROM analytical_layer GROUP BY analytical_layer_type_code ORDER BY count(*) DESC LIMIT 1	government_shift
SELECT t3.service_details FROM customers AS t1 JOIN customers_and_services AS t2 ON t1.customer_id  =  t2.customer_id JOIN services AS t3 ON t2.service_id  =  t3.service_id WHERE t1.customer_details  =  "Hardy Kutch"	government_shift
SELECT t3.service_details FROM customers AS t1 JOIN customers_and_services AS t2 ON t1.customer_id  =  t2.customer_id JOIN services AS t3 ON t2.service_id  =  t3.service_id WHERE t1.customer_details  =  "Hardy Kutch"	government_shift
select t1.service_details from services as t1 join customers_and_services as t2 on t1.service_id  =  t2.service_id group by t1.service_details having count(*)  >  3	government_shift
SELECT t1.service_details FROM services AS t1 JOIN customers_and_services AS t2 ON t1.service_id  =  t2.service_id GROUP BY t1.service_details HAVING count(*)  >  3	government_shift
SELECT t1.customer_details FROM customers AS t1 JOIN customers_and_services AS t2 ON t1.customer_id  =  t2.customer_id GROUP BY t1.customer_details ORDER BY count(*) DESC LIMIT 1	government_shift
select t1.customer_details from customers as t1 join customers_and_services as t2 on t1.customer_id  =  t2.customer_id group by t1.customer_details order by count(*) desc limit 1	government_shift
select t1.customer_details from customers as t1 join customers_and_services as t2 on t1.customer_id  =  t2.customer_id group by t1.customer_details order by count(*) desc limit 1	government_shift
select t1.customer_details from customers as t1 join customers_and_services as t2 on t1.customer_id  =  t2.customer_id group by t1.customer_details order by count(*) desc limit 1	government_shift
select customer_details from customers where customer_id not in (select customer_id from customers_and_services)	government_shift
select customer_details from customers where customer_id not in (select customer_id from customers_and_services)	government_shift
select distinct t1.customer_details from customers as t1 join customers_and_services as t2 on t1.customer_id  =  t2.customer_id where t2.service_id  =  (select service_id from services group by service_id order by count(*) asc limit 1)	government_shift
select distinct t1.customer_details from customers as t1 join customers_and_services as t2 on t1.customer_id  =  t2.customer_id where t2.service_id  =  (select service_id from services group by service_id order by count(*) asc limit 1)	government_shift
SELECT count(DISTINCT customers_and_services_details) FROM customers_and_services	government_shift
SELECT count(DISTINCT customers_and_services_details) FROM customers_and_services	government_shift
SELECT customer_details FROM customers WHERE customer_details LIKE "%Kutch%"	government_shift
SELECT customer_details FROM customers WHERE customer_details LIKE "%Kutch%"	government_shift
SELECT DISTINCT t3.service_details FROM customers AS t1 JOIN customers_and_services AS t2 ON t1.customer_id  =  t2.customer_id JOIN services AS t3 ON t2.service_id  =  t3.service_id JOIN customer_interactions AS t4 ON t3.service_id  =  t4.service_id WHERE t1.customer_details  =  "Hardy Kutch" OR t4.services_and_channels_details  =  "good"	government_shift
SELECT DISTINCT t3.service_details FROM customers AS t1 JOIN customers_and_services AS t2 ON t1.customer_id  =  t2.customer_id JOIN services AS t3 ON t2.service_id  =  t3.service_id JOIN customer_interactions AS t4 ON t3.service_id  =  t4.service_id WHERE t1.customer_details  =  "Hardy Kutch" OR t4.services_and_channels_details  =  "good"	government_shift
SELECT DISTINCT t3.service_details FROM customers AS t1 JOIN customers_and_services AS t2 ON t1.customer_id  =  t2.customer_id JOIN services AS t3 ON t2.service_id  =  t3.service_id JOIN customer_interactions AS t4 ON t3.service_id  =  t4.service_id WHERE t1.customer_details  =  "Hardy Kutch" AND t4.services_and_channels_details  =  "bad"	government_shift
SELECT DISTINCT t3.service_details FROM customers AS t1 JOIN customers_and_services AS t2 ON t1.customer_id  =  t2.customer_id JOIN services AS t3 ON t2.service_id  =  t3.service_id JOIN customer_interactions AS t4 ON t3.service_id  =  t4.service_id WHERE t1.customer_details  =  "Hardy Kutch" AND t4.services_and_channels_details  =  "bad"	government_shift
select distinct t1.service_details from services as t1 join customer_interactions as t2 on t1.service_id  =  t2.service_id join channels as t3 on t2.channel_id  =  t3.channel_id where t3.channel_details  =  "15 ij"	government_shift
SELECT DISTINCT t1.service_details FROM services AS t1 JOIN customer_interactions AS t2 ON t1.service_id  =  t2.service_id JOIN channels AS t3 ON t2.channel_id  =  t3.channel_id WHERE t3.channel_details  =  "15 ij"	government_shift
select t1.customer_details from customers as t1 join customer_interactions as t2 on t1.customer_id  =  t2.customer_id where t2.status_code  =  "stuck" and services_and_channels_details  =  "bad"	government_shift
SELECT t1.customer_details FROM customers AS t1 JOIN customer_interactions AS t2 ON t1.customer_id  =  t2.customer_id WHERE t2.status_code  =  "Stuck" AND services_and_channels_details  =  "bad"	government_shift
SELECT count(*) FROM integration_platform WHERE integration_platform_details  =  "Success"	government_shift
SELECT count(*) FROM integration_platform WHERE integration_platform_details  =  "Success"	government_shift
select distinct t1.customer_details from customers as t1 join customer_interactions as t2 on t1.customer_id  =  t2.customer_id join integration_platform as t3 where t3.integration_platform_details  =  "fail"	government_shift
SELECT DISTINCT t1.customer_details FROM customers AS t1 JOIN customer_interactions AS t2 ON t1.customer_id  =  t2.customer_id JOIN integration_platform AS t3 WHERE t3.integration_platform_details  =  "Fail"	government_shift
select service_details from services except select t2.service_details from customers_and_services as t1 join services as t2 on t1.service_id  =  t2.service_id	government_shift
select service_details from services except select t2.service_details from customers_and_services as t1 join services as t2 on t1.service_id  =  t2.service_id	government_shift
SELECT analytical_layer_type_code ,  count(*) FROM analytical_layer GROUP BY analytical_layer_type_code	government_shift
SELECT analytical_layer_type_code ,  count(*) FROM analytical_layer GROUP BY analytical_layer_type_code	government_shift
select distinct t1.service_details from services as t1 join customers_and_services as t2 on t1.service_id  =  t2.service_id where t2.customers_and_services_details  =  "unsatisfied"	government_shift
SELECT DISTINCT t1.service_details FROM services AS t1 JOIN customers_and_services AS t2 ON t1.service_id  =  t2.service_id WHERE t2.customers_and_services_details  =  "Unsatisfied"	government_shift
SELECT count(*) FROM vehicles	vehicle_rent
SELECT count(*) FROM vehicles	vehicle_rent
SELECT name FROM vehicles ORDER BY model_year DESC	vehicle_rent
SELECT name FROM vehicles ORDER BY model_year DESC	vehicle_rent
SELECT DISTINCT type_of_powertrain FROM vehicles	vehicle_rent
SELECT DISTINCT type_of_powertrain FROM vehicles	vehicle_rent
SELECT name ,  type_of_powertrain ,  annual_fuel_cost FROM vehicles WHERE model_year  =  2013 OR model_year  =  2014	vehicle_rent
SELECT name ,  type_of_powertrain ,  annual_fuel_cost FROM vehicles WHERE model_year  =  2013 OR model_year  =  2014	vehicle_rent
SELECT type_of_powertrain FROM vehicles WHERE model_year  =  2014 INTERSECT SELECT type_of_powertrain FROM vehicles WHERE model_year  =  2013	vehicle_rent
SELECT type_of_powertrain FROM vehicles WHERE model_year  =  2014 INTERSECT SELECT type_of_powertrain FROM vehicles WHERE model_year  =  2013	vehicle_rent
SELECT type_of_powertrain ,  count(*) FROM vehicles GROUP BY type_of_powertrain	vehicle_rent
SELECT type_of_powertrain ,  count(*) FROM vehicles GROUP BY type_of_powertrain	vehicle_rent
SELECT type_of_powertrain FROM vehicles GROUP BY type_of_powertrain ORDER BY count(*) DESC LIMIT 1	vehicle_rent
SELECT type_of_powertrain FROM vehicles GROUP BY type_of_powertrain ORDER BY count(*) DESC LIMIT 1	vehicle_rent
SELECT min(annual_fuel_cost) ,  max(annual_fuel_cost) ,  avg(annual_fuel_cost) FROM vehicles	vehicle_rent
SELECT min(annual_fuel_cost) ,  max(annual_fuel_cost) ,  avg(annual_fuel_cost) FROM vehicles	vehicle_rent
SELECT name ,  model_year FROM vehicles WHERE city_fuel_economy_rate  <=  highway_fuel_economy_rate	vehicle_rent
SELECT name ,  model_year FROM vehicles WHERE city_fuel_economy_rate  <=  highway_fuel_economy_rate	vehicle_rent
SELECT type_of_powertrain ,  avg(annual_fuel_cost) FROM vehicles GROUP BY type_of_powertrain HAVING count(*)  >=  2	vehicle_rent
SELECT type_of_powertrain ,  avg(annual_fuel_cost) FROM vehicles GROUP BY type_of_powertrain HAVING count(*)  >=  2	vehicle_rent
SELECT name ,  age ,  membership_credit FROM customers	vehicle_rent
SELECT name ,  age ,  membership_credit FROM customers	vehicle_rent
SELECT name ,  age FROM customers ORDER BY membership_credit DESC LIMIT 1	vehicle_rent
SELECT name ,  age FROM customers ORDER BY membership_credit DESC LIMIT 1	vehicle_rent
SELECT avg(age) FROM customers WHERE membership_credit  >  (SELECT avg(membership_credit) FROM customers)	vehicle_rent
SELECT avg(age) FROM customers WHERE membership_credit  >  (SELECT avg(membership_credit) FROM customers)	vehicle_rent
SELECT * FROM discount	vehicle_rent
SELECT * FROM discount	vehicle_rent
SELECT T2.name ,  sum(T1.total_hours) FROM renting_history AS T1 JOIN vehicles AS T2 ON T1.vehicles_id  =  T2.id GROUP BY T2.id	vehicle_rent
SELECT T2.name ,  sum(T1.total_hours) FROM renting_history AS T1 JOIN vehicles AS T2 ON T1.vehicles_id  =  T2.id GROUP BY T2.id	vehicle_rent
SELECT name FROM vehicles WHERE id NOT IN (SELECT vehicles_id FROM renting_history)	vehicle_rent
SELECT name FROM vehicles WHERE id NOT IN (SELECT vehicles_id FROM renting_history)	vehicle_rent
SELECT T2.name FROM renting_history AS T1 JOIN customers AS T2 ON T1.customer_id  =  T2.id GROUP BY T2.id HAVING count(*)  >=  2	vehicle_rent
SELECT T2.name FROM renting_history AS T1 JOIN customers AS T2 ON T1.customer_id  =  T2.id GROUP BY T2.id HAVING count(*)  >=  2	vehicle_rent
SELECT T2.name ,  T2.model_year FROM renting_history AS T1 JOIN vehicles AS T2 ON T1.vehicles_id  =  T2.id GROUP BY T2.id ORDER BY count(*) DESC LIMIT 1	vehicle_rent
SELECT T2.name ,  T2.model_year FROM renting_history AS T1 JOIN vehicles AS T2 ON T1.vehicles_id  =  T2.id GROUP BY T2.id ORDER BY count(*) DESC LIMIT 1	vehicle_rent
SELECT T2.name FROM renting_history AS T1 JOIN vehicles AS T2 ON T1.vehicles_id  =  T2.id GROUP BY T2.id ORDER BY sum(T1.total_hours) DESC	vehicle_rent
SELECT T2.name FROM renting_history AS T1 JOIN vehicles AS T2 ON T1.vehicles_id  =  T2.id GROUP BY T2.id ORDER BY sum(T1.total_hours) DESC	vehicle_rent
SELECT T2.name FROM renting_history AS T1 JOIN discount AS T2 ON T1.discount_id  =  T2.id GROUP BY T2.id ORDER BY count(*) DESC LIMIT 1	vehicle_rent
SELECT T2.name FROM renting_history AS T1 JOIN discount AS T2 ON T1.discount_id  =  T2.id GROUP BY T2.id ORDER BY count(*) DESC LIMIT 1	vehicle_rent
SELECT T2.name ,  T2.Type_of_powertrain FROM renting_history AS T1 JOIN vehicles AS T2 ON T1.vehicles_id  =  T2.id GROUP BY T1.vehicles_id HAVING sum(T1.total_hours)  >  30	vehicle_rent
SELECT T2.name ,  T2.Type_of_powertrain FROM renting_history AS T1 JOIN vehicles AS T2 ON T1.vehicles_id  =  T2.id GROUP BY T1.vehicles_id HAVING sum(T1.total_hours)  >  30	vehicle_rent
SELECT avg(City_fuel_economy_rate) ,  avg(Highway_fuel_economy_rate) , Type_of_powertrain FROM vehicles GROUP BY Type_of_powertrain	vehicle_rent
SELECT avg(City_fuel_economy_rate) ,  avg(Highway_fuel_economy_rate) , Type_of_powertrain FROM vehicles GROUP BY Type_of_powertrain	vehicle_rent
SELECT avg(amount_of_loan) FROM Student_Loans	cre_Students_Information_Systems
SELECT avg(amount_of_loan) FROM Student_Loans	cre_Students_Information_Systems
SELECT T1.bio_data ,  T1.student_id FROM Students AS T1 JOIN Classes AS T2 ON T1.student_id  =  T2.student_id GROUP BY T1.student_id HAVING count(*)  >=  2 UNION SELECT T1.bio_data ,  T1.student_id FROM Students AS T1 JOIN Detention AS T2 ON T1.student_id  =  T2.student_id GROUP BY T1.student_id HAVING count(*)  <  2	cre_Students_Information_Systems
SELECT T1.bio_data ,  T1.student_id FROM Students AS T1 JOIN Classes AS T2 ON T1.student_id  =  T2.student_id GROUP BY T1.student_id HAVING count(*)  >=  2 UNION SELECT T1.bio_data ,  T1.student_id FROM Students AS T1 JOIN Detention AS T2 ON T1.student_id  =  T2.student_id GROUP BY T1.student_id HAVING count(*)  <  2	cre_Students_Information_Systems
SELECT T1.teacher_details FROM Teachers AS T1 JOIN Classes AS T2 ON T1.teacher_id  =  T2.teacher_id WHERE T2.class_details LIKE '%data%' EXCEPT SELECT T1.teacher_details FROM Teachers AS T1 JOIN Classes AS T2 ON T1.teacher_id  =  T2.teacher_id WHERE T2.class_details LIKE 'net%'	cre_Students_Information_Systems
SELECT T1.teacher_details FROM Teachers AS T1 JOIN Classes AS T2 ON T1.teacher_id  =  T2.teacher_id WHERE T2.class_details LIKE '%data%' EXCEPT SELECT T1.teacher_details FROM Teachers AS T1 JOIN Classes AS T2 ON T1.teacher_id  =  T2.teacher_id WHERE T2.class_details LIKE 'net%'	cre_Students_Information_Systems
select bio_data from students where student_id not in (select t1.student_id from students as t1 join detention as t2 on t1.student_id  =  t2.student_id union select t1.student_id from students as t1 join student_loans as t2 on t1.student_id  =  t2.student_id)	cre_Students_Information_Systems
select bio_data from students where student_id not in (select t1.student_id from students as t1 join detention as t2 on t1.student_id  =  t2.student_id union select t1.student_id from students as t1 join student_loans as t2 on t1.student_id  =  t2.student_id)	cre_Students_Information_Systems
SELECT amount_of_loan ,  date_of_loan FROM Student_Loans WHERE student_id IN ( SELECT student_id FROM Achievements GROUP BY student_id HAVING count(*)  >=  2 )	cre_Students_Information_Systems
SELECT amount_of_loan ,  date_of_loan FROM Student_Loans WHERE student_id IN ( SELECT student_id FROM Achievements GROUP BY student_id HAVING count(*)  >=  2 )	cre_Students_Information_Systems
SELECT T1.teacher_details ,  T1.teacher_id FROM Teachers AS T1 JOIN Classes AS T2 ON T1.teacher_id  =  T2.teacher_id GROUP BY T1.teacher_id ORDER BY count(*) DESC LIMIT 1	cre_Students_Information_Systems
SELECT T1.teacher_details ,  T1.teacher_id FROM Teachers AS T1 JOIN Classes AS T2 ON T1.teacher_id  =  T2.teacher_id GROUP BY T1.teacher_id ORDER BY count(*) DESC LIMIT 1	cre_Students_Information_Systems
SELECT distinct(T1.detention_type_description) FROM Ref_Detention_Type AS T1 JOIN Detention AS T2 ON T1.detention_type_code  =  T2.detention_type_code	cre_Students_Information_Systems
SELECT distinct(T1.detention_type_description) FROM Ref_Detention_Type AS T1 JOIN Detention AS T2 ON T1.detention_type_code  =  T2.detention_type_code	cre_Students_Information_Systems
SELECT DISTINCT T1.student_details ,  T3.address_type_description FROM Students AS T1 JOIN Students_Addresses AS T2 ON T1.student_id  =  T2.student_id JOIN Ref_Address_Types AS T3 ON T2.address_type_code  =  T3.address_type_code	cre_Students_Information_Systems
SELECT DISTINCT T1.student_details ,  T3.address_type_description FROM Students AS T1 JOIN Students_Addresses AS T2 ON T1.student_id  =  T2.student_id JOIN Ref_Address_Types AS T3 ON T2.address_type_code  =  T3.address_type_code	cre_Students_Information_Systems
SELECT T1.address_details ,  T3.bio_data FROM Addresses AS T1 JOIN Students_Addresses AS T2 ON T1.address_id  =  T2.address_id JOIN Students AS T3 ON T2.student_id  =  T3.student_id	cre_Students_Information_Systems
SELECT T1.address_details ,  T3.bio_data FROM Addresses AS T1 JOIN Students_Addresses AS T2 ON T1.address_id  =  T2.address_id JOIN Students AS T3 ON T2.student_id  =  T3.student_id	cre_Students_Information_Systems
SELECT T1.bio_data ,  T2.date_of_transcript FROM Students AS T1 JOIN Transcripts AS T2 ON T1.student_id  =  T2.student_id	cre_Students_Information_Systems
SELECT T1.bio_data ,  T2.date_of_transcript FROM Students AS T1 JOIN Transcripts AS T2 ON T1.student_id  =  T2.student_id	cre_Students_Information_Systems
SELECT count(DISTINCT student_id) ,  behaviour_monitoring_details FROM Behaviour_Monitoring GROUP BY behaviour_monitoring_details ORDER BY count(*) DESC LIMIT 1	cre_Students_Information_Systems
SELECT count(DISTINCT student_id) ,  behaviour_monitoring_details FROM Behaviour_Monitoring GROUP BY behaviour_monitoring_details ORDER BY count(*) DESC LIMIT 1	cre_Students_Information_Systems
SELECT T1.bio_data ,  T1.student_details FROM Students AS T1 JOIN Behaviour_Monitoring AS T2 ON T1.student_id  =  T2.student_id WHERE T2.behaviour_monitoring_details IN ( SELECT behaviour_monitoring_details FROM Behaviour_Monitoring GROUP BY behaviour_monitoring_details ORDER BY count(*) DESC LIMIT 1 ) INTERSECT SELECT T1.bio_data ,  T1.student_details FROM Students AS T1 JOIN Behaviour_Monitoring AS T2 ON T1.student_id  =  T2.student_id WHERE T2.behaviour_monitoring_details IN ( SELECT behaviour_monitoring_details FROM Behaviour_Monitoring GROUP BY behaviour_monitoring_details HAVING count(*)  =  3 )	cre_Students_Information_Systems
SELECT T1.bio_data ,  T1.student_details FROM Students AS T1 JOIN Behaviour_Monitoring AS T2 ON T1.student_id  =  T2.student_id WHERE T2.behaviour_monitoring_details IN ( SELECT behaviour_monitoring_details FROM Behaviour_Monitoring GROUP BY behaviour_monitoring_details ORDER BY count(*) DESC LIMIT 1 ) INTERSECT SELECT T1.bio_data ,  T1.student_details FROM Students AS T1 JOIN Behaviour_Monitoring AS T2 ON T1.student_id  =  T2.student_id WHERE T2.behaviour_monitoring_details IN ( SELECT behaviour_monitoring_details FROM Behaviour_Monitoring GROUP BY behaviour_monitoring_details HAVING count(*)  =  3 )	cre_Students_Information_Systems
SELECT T1.bio_data FROM Students AS T1 JOIN Behaviour_Monitoring AS T2 ON T1.student_id  =  T2.student_id WHERE T2.behaviour_monitoring_details IN ( SELECT behaviour_monitoring_details FROM Behaviour_Monitoring GROUP BY behaviour_monitoring_details ORDER BY count(*) DESC LIMIT 1 ) EXCEPT SELECT T1.bio_data FROM Students AS T1 JOIN Behaviour_Monitoring AS T2 ON T1.student_id  =  T2.student_id WHERE T2.behaviour_monitoring_details NOT IN ( SELECT behaviour_monitoring_details FROM Behaviour_Monitoring GROUP BY behaviour_monitoring_details ORDER BY count(*) DESC LIMIT 1 )	cre_Students_Information_Systems
select t1.bio_data from students as t1 join behaviour_monitoring as t2 on t1.student_id  =  t2.student_id where t2.behaviour_monitoring_details in ( select behaviour_monitoring_details from behaviour_monitoring group by behaviour_monitoring_details order by count(*) desc limit 1 ) except select t1.bio_data from students as t1 join behaviour_monitoring as t2 on t1.student_id  =  t2.student_id where t2.behaviour_monitoring_details not in ( select behaviour_monitoring_details from behaviour_monitoring group by behaviour_monitoring_details order by count(*) desc limit 1 )	cre_Students_Information_Systems
SELECT T1.bio_data ,  T2.event_date FROM Students AS T1 JOIN Student_Events AS T2 ON T1.student_id  =  T2.student_id	cre_Students_Information_Systems
SELECT T1.bio_data ,  T2.event_date FROM Students AS T1 JOIN Student_Events AS T2 ON T1.student_id  =  T2.student_id	cre_Students_Information_Systems
SELECT count(*) ,  T2.event_type_code ,  T3.event_type_description FROM Students AS T1 JOIN Student_Events AS T2 ON T1.student_id  =  T2.student_id JOIN Ref_Event_Types AS T3 ON T2.event_type_code  =  T3.event_type_code GROUP BY T2.event_type_code ORDER BY count(*) DESC LIMIT 1	cre_Students_Information_Systems
SELECT count(*) ,  T2.event_type_code ,  T3.event_type_description FROM Students AS T1 JOIN Student_Events AS T2 ON T1.student_id  =  T2.student_id JOIN Ref_Event_Types AS T3 ON T2.event_type_code  =  T3.event_type_code GROUP BY T2.event_type_code ORDER BY count(*) DESC LIMIT 1	cre_Students_Information_Systems
SELECT T1.achievement_details ,  T2.achievement_type_description FROM Achievements AS T1 JOIN Ref_Achievement_Type AS T2 ON T1.achievement_type_code  =  T2.achievement_type_code	cre_Students_Information_Systems
SELECT T1.achievement_details ,  T2.achievement_type_description FROM Achievements AS T1 JOIN Ref_Achievement_Type AS T2 ON T1.achievement_type_code  =  T2.achievement_type_code	cre_Students_Information_Systems
SELECT count(DISTINCT T1.teacher_id) FROM Teachers AS T1 JOIN Classes AS T2 ON T1.teacher_id  =  T2.teacher_id WHERE T2.student_id NOT IN ( SELECT student_id FROM Achievements )	cre_Students_Information_Systems
SELECT count(DISTINCT T1.teacher_id) FROM Teachers AS T1 JOIN Classes AS T2 ON T1.teacher_id  =  T2.teacher_id WHERE T2.student_id NOT IN ( SELECT student_id FROM Achievements )	cre_Students_Information_Systems
SELECT date_of_transcript ,  transcript_details FROM Transcripts	cre_Students_Information_Systems
SELECT date_of_transcript ,  transcript_details FROM Transcripts	cre_Students_Information_Systems
SELECT achievement_type_code ,  achievement_details ,  date_achievement FROM Achievements	cre_Students_Information_Systems
SELECT achievement_type_code ,  achievement_details ,  date_achievement FROM Achievements	cre_Students_Information_Systems
SELECT datetime_detention_start ,  datetime_detention_end FROM Detention	cre_Students_Information_Systems
SELECT datetime_detention_start ,  datetime_detention_end FROM Detention	cre_Students_Information_Systems
SELECT bio_data FROM Students WHERE student_details LIKE '%Suite%'	cre_Students_Information_Systems
SELECT bio_data FROM Students WHERE student_details LIKE '%Suite%'	cre_Students_Information_Systems
SELECT T1.teacher_details ,  T3.student_details FROM Teachers AS T1 JOIN Classes AS T2 ON T1.teacher_id  =  T2.teacher_id JOIN Students AS T3 ON T2.student_id  =  T3.student_id	cre_Students_Information_Systems
SELECT T1.teacher_details ,  T3.student_details FROM Teachers AS T1 JOIN Classes AS T2 ON T1.teacher_id  =  T2.teacher_id JOIN Students AS T3 ON T2.student_id  =  T3.student_id	cre_Students_Information_Systems
SELECT count(*) ,  teacher_id FROM Classes GROUP BY teacher_id ORDER BY count(*) DESC LIMIT 1	cre_Students_Information_Systems
SELECT count(*) ,  teacher_id FROM Classes GROUP BY teacher_id ORDER BY count(*) DESC LIMIT 1	cre_Students_Information_Systems
SELECT count(*) ,  student_id FROM Classes GROUP BY student_id ORDER BY count(*) DESC LIMIT 1	cre_Students_Information_Systems
SELECT count(*) ,  student_id FROM Classes GROUP BY student_id ORDER BY count(*) DESC LIMIT 1	cre_Students_Information_Systems
SELECT T1.student_id ,  T1.student_details FROM Students AS T1 JOIN Classes AS T2 ON T1.student_id  =  T2.student_id GROUP BY T1.student_id HAVING count(*)  =  2	cre_Students_Information_Systems
SELECT T1.student_id ,  T1.student_details FROM Students AS T1 JOIN Classes AS T2 ON T1.student_id  =  T2.student_id GROUP BY T1.student_id HAVING count(*)  =  2	cre_Students_Information_Systems
SELECT T1.detention_type_code ,  T2.detention_type_description FROM Detention AS T1 JOIN Ref_Detention_Type AS T2 ON T1.detention_type_code  =  T2.detention_type_code GROUP BY T1.detention_type_code ORDER BY count(*) ASC LIMIT 1	cre_Students_Information_Systems
SELECT T1.detention_type_code ,  T2.detention_type_description FROM Detention AS T1 JOIN Ref_Detention_Type AS T2 ON T1.detention_type_code  =  T2.detention_type_code GROUP BY T1.detention_type_code ORDER BY count(*) ASC LIMIT 1	cre_Students_Information_Systems
SELECT T1.bio_data ,  T1.student_details FROM Students AS T1 JOIN Student_Loans AS T2 ON T1.student_id  =  T2.student_id WHERE T2.amount_of_loan  >  ( SELECT avg(amount_of_loan) FROM Student_Loans )	cre_Students_Information_Systems
SELECT T1.bio_data ,  T1.student_details FROM Students AS T1 JOIN Student_Loans AS T2 ON T1.student_id  =  T2.student_id WHERE T2.amount_of_loan  >  ( SELECT avg(amount_of_loan) FROM Student_Loans )	cre_Students_Information_Systems
SELECT date_of_loan FROM Student_Loans ORDER BY date_of_loan ASC LIMIT 1	cre_Students_Information_Systems
SELECT date_of_loan FROM Student_Loans ORDER BY date_of_loan ASC LIMIT 1	cre_Students_Information_Systems
SELECT T1.bio_data FROM Students AS T1 JOIN Student_Loans AS T2 ON T1.student_id  =  T2.student_id ORDER BY T2.amount_of_loan ASC LIMIT 1	cre_Students_Information_Systems
SELECT T1.bio_data FROM Students AS T1 JOIN Student_Loans AS T2 ON T1.student_id  =  T2.student_id ORDER BY T2.amount_of_loan ASC LIMIT 1	cre_Students_Information_Systems
SELECT T1.date_of_transcript FROM Transcripts AS T1 JOIN Student_Loans AS T2 ON T1.student_id  =  T2.student_id ORDER BY T2.amount_of_loan DESC LIMIT 1	cre_Students_Information_Systems
SELECT T1.date_of_transcript FROM Transcripts AS T1 JOIN Student_Loans AS T2 ON T1.student_id  =  T2.student_id ORDER BY T2.amount_of_loan DESC LIMIT 1	cre_Students_Information_Systems
SELECT T1.teacher_details FROM Teachers AS T1 JOIN Classes AS T2 ON T1.teacher_id  =  T2.teacher_id JOIN Transcripts AS T3 ON T2.student_id  =  T3.student_id ORDER BY T3.date_of_transcript ASC LIMIT 1	cre_Students_Information_Systems
SELECT T1.teacher_details FROM Teachers AS T1 JOIN Classes AS T2 ON T1.teacher_id  =  T2.teacher_id JOIN Transcripts AS T3 ON T2.student_id  =  T3.student_id ORDER BY T3.date_of_transcript ASC LIMIT 1	cre_Students_Information_Systems
select student_id ,  sum(amount_of_loan) from student_loans group by student_id	cre_Students_Information_Systems
SELECT student_id ,  sum(amount_of_loan) FROM Student_Loans GROUP BY student_id	cre_Students_Information_Systems
SELECT T1.student_id ,  T1.bio_data ,  count(*) FROM Students AS T1 JOIN Classes AS T2 ON T1.student_id  =  T2.student_id GROUP BY T1.student_id	cre_Students_Information_Systems
SELECT T1.student_id ,  T1.bio_data ,  count(*) FROM Students AS T1 JOIN Classes AS T2 ON T1.student_id  =  T2.student_id GROUP BY T1.student_id	cre_Students_Information_Systems
SELECT count(DISTINCT student_id) FROM Detention	cre_Students_Information_Systems
SELECT count(DISTINCT student_id) FROM Detention	cre_Students_Information_Systems
SELECT T1.address_type_code ,  T2.address_type_description FROM Students_Addresses AS T1 JOIN Ref_Address_Types AS T2 WHERE T1.address_type_code  =  T2.address_type_code GROUP BY T1.address_type_code ORDER BY count(*) DESC LIMIT 1	cre_Students_Information_Systems
SELECT T1.address_type_code ,  T2.address_type_description FROM Students_Addresses AS T1 JOIN Ref_Address_Types AS T2 WHERE T1.address_type_code  =  T2.address_type_code GROUP BY T1.address_type_code ORDER BY count(*) DESC LIMIT 1	cre_Students_Information_Systems
SELECT T1.bio_data FROM Students AS T1 JOIN Student_Events AS T2 WHERE T1.student_id  =  T2.student_id EXCEPT SELECT T1.bio_data FROM Students AS T1 JOIN Student_Loans AS T2 WHERE T1.student_id  =  T2.student_id	cre_Students_Information_Systems
SELECT T1.bio_data FROM Students AS T1 JOIN Student_Events AS T2 WHERE T1.student_id  =  T2.student_id EXCEPT SELECT T1.bio_data FROM Students AS T1 JOIN Student_Loans AS T2 WHERE T1.student_id  =  T2.student_id	cre_Students_Information_Systems
SELECT date_from ,  date_to FROM Students_Addresses WHERE student_id IN ( SELECT student_id FROM Transcripts GROUP BY student_id HAVING count(*)  =  2 )	cre_Students_Information_Systems
SELECT date_from ,  date_to FROM Students_Addresses WHERE student_id IN ( SELECT student_id FROM Transcripts GROUP BY student_id HAVING count(*)  =  2 )	cre_Students_Information_Systems
SELECT datetime_detention_start FROM Detention	cre_Students_Information_Systems
SELECT datetime_detention_start FROM Detention	cre_Students_Information_Systems
SELECT name FROM Author	book_1
SELECT name FROM Author	book_1
SELECT name ,  address FROM Client	book_1
SELECT name ,  address FROM Client	book_1
SELECT title ,  isbn ,  SalePrice FROM Book	book_1
SELECT title ,  isbn ,  SalePrice FROM Book	book_1
SELECT count(*) FROM Book	book_1
SELECT count(*) FROM Book	book_1
SELECT count(*) FROM Author	book_1
SELECT count(*) FROM Author	book_1
SELECT count(*) FROM Client	book_1
SELECT count(*) FROM Client	book_1
SELECT name ,  address FROM Client ORDER BY name	book_1
SELECT name ,  address FROM Client ORDER BY name	book_1
SELECT T3.title ,  T1.name FROM Author AS T1 JOIN Author_Book AS T2 ON T2.Author  =  T1.idAuthor JOIN Book AS T3 ON T2.isbn  =  T3.isbn	book_1
SELECT T3.title ,  T1.name FROM Author AS T1 JOIN Author_Book AS T2 ON T2.Author  =  T1.idAuthor JOIN Book AS T3 ON T2.isbn  =  T3.isbn	book_1
SELECT T1.idOrder ,  T2.name FROM Orders AS T1 JOIN Client AS T2 ON T1.idClient  =  T2.idClient	book_1
SELECT T1.idOrder ,  T2.name FROM Orders AS T1 JOIN Client AS T2 ON T1.idClient  =  T2.idClient	book_1
SELECT T1.name ,  count(*) FROM Author AS T1 JOIN Author_Book AS T2 ON T1.idAuthor  =  T2.Author GROUP BY T1.idAuthor	book_1
SELECT T1.name ,  count(*) FROM Author AS T1 JOIN Author_Book AS T2 ON T1.idAuthor  =  T2.Author GROUP BY T1.idAuthor	book_1
SELECT isbn ,  count(*) FROM Books_Order GROUP BY isbn	book_1
SELECT isbn ,  count(*) FROM Books_Order GROUP BY isbn	book_1
SELECT isbn ,  sum(amount) FROM Books_Order GROUP BY isbn	book_1
SELECT isbn ,  sum(amount) FROM Books_Order GROUP BY isbn	book_1
SELECT T2.title FROM Books_Order AS T1 JOIN Book AS T2 ON T1.isbn  =  T2.isbn GROUP BY T1.isbn ORDER BY count(*) DESC LIMIT 1	book_1
SELECT T2.title FROM Books_Order AS T1 JOIN Book AS T2 ON T1.isbn  =  T2.isbn GROUP BY T1.isbn ORDER BY count(*) DESC LIMIT 1	book_1
SELECT T2.title ,  T2.PurchasePrice FROM Books_Order AS T1 JOIN BOOk AS T2 ON T1.isbn  =  T2.isbn GROUP BY T1.isbn ORDER BY sum(amount) DESC LIMIT 1	book_1
SELECT T2.title ,  T2.PurchasePrice FROM Books_Order AS T1 JOIN BOOk AS T2 ON T1.isbn  =  T2.isbn GROUP BY T1.isbn ORDER BY sum(amount) DESC LIMIT 1	book_1
SELECT DISTINCT T1.title FROM book AS T1 JOIN books_order AS T2 ON T1.isbn  =  T2.isbn	book_1
SELECT DISTINCT T1.title FROM book AS T1 JOIN books_order AS T2 ON T1.isbn  =  T2.isbn	book_1
SELECT DISTINCT T1.name FROM Client AS T1 JOIN Orders AS T2 ON T1.idClient  =  T2.idClient	book_1
SELECT DISTINCT T1.name FROM Client AS T1 JOIN Orders AS T2 ON T1.idClient  =  T2.idClient	book_1
SELECT T2.name ,  count(*) FROM Orders AS T1 JOIN Client AS T2 ON T1.idClient  =  T2.idClient GROUP BY T1.idClient	book_1
SELECT T2.name ,  count(*) FROM Orders AS T1 JOIN Client AS T2 ON T1.idClient  =  T2.idClient GROUP BY T1.idClient	book_1
SELECT T2.name FROM Orders AS T1 JOIN Client AS T2 ON T1.idClient  =  T2.idClient GROUP BY T1.idClient ORDER BY count(*) DESC LIMIT 1	book_1
SELECT T2.name FROM Orders AS T1 JOIN Client AS T2 ON T1.idClient  =  T2.idClient GROUP BY T1.idClient ORDER BY count(*) DESC LIMIT 1	book_1
SELECT T2.name ,  sum(T3.amount) FROM Orders AS T1 JOIN Client AS T2 ON T1.idClient  =  T2.idClient JOIN Books_Order AS T3 ON T3.idOrder  =  T1.idOrder GROUP BY T1.idClient	book_1
SELECT T2.name ,  sum(T3.amount) FROM Orders AS T1 JOIN Client AS T2 ON T1.idClient  =  T2.idClient JOIN Books_Order AS T3 ON T3.idOrder  =  T1.idOrder GROUP BY T1.idClient	book_1
SELECT T2.name FROM Orders AS T1 JOIN Client AS T2 ON T1.idClient  =  T2.idClient JOIN Books_Order AS T3 ON T3.idOrder  =  T1.idOrder GROUP BY T1.idClient ORDER BY sum(T3.amount) DESC LIMIT 1	book_1
SELECT T2.name FROM Orders AS T1 JOIN Client AS T2 ON T1.idClient  =  T2.idClient JOIN Books_Order AS T3 ON T3.idOrder  =  T1.idOrder GROUP BY T1.idClient ORDER BY sum(T3.amount) DESC LIMIT 1	book_1
SELECT title FROM book EXCEPT SELECT T1.title FROM book AS T1 JOIN books_order AS T2 ON T1.isbn  =  T2.isbn	book_1
SELECT title FROM book EXCEPT SELECT T1.title FROM book AS T1 JOIN books_order AS T2 ON T1.isbn  =  T2.isbn	book_1
SELECT name FROM Client EXCEPT SELECT T1.name FROM Client AS T1 JOIN Orders AS T2 ON T1.idClient  =  T2.idClient	book_1
SELECT name FROM Client EXCEPT SELECT T1.name FROM Client AS T1 JOIN Orders AS T2 ON T1.idClient  =  T2.idClient	book_1
SELECT max(saleprice) ,  min(saleprice) FROM Book	book_1
SELECT max(saleprice) ,  min(saleprice) FROM Book	book_1
SELECT avg(purchaseprice) ,  avg(saleprice) FROM Book	book_1
SELECT avg(purchaseprice) ,  avg(saleprice) FROM Book	book_1
SELECT max(saleprice - purchaseprice) FROM Book	book_1
SELECT max(saleprice - purchaseprice) FROM Book	book_1
SELECT title FROM book WHERE saleprice  >  (SELECT avg(saleprice) FROM book)	book_1
SELECT title FROM book WHERE saleprice  >  (SELECT avg(saleprice) FROM book)	book_1
select title from book order by saleprice asc limit 1	book_1
select title from book order by saleprice asc limit 1	book_1
select title from book order by purchaseprice  desc limit 1	book_1
select title from book order by purchaseprice  desc limit 1	book_1
SELECT avg(saleprice) FROM Book AS T1 JOIN Author_book AS T2 ON T1.isbn  =  T2.isbn JOIN Author AS T3 ON T2.Author  =  T3.idAuthor WHERE T3.name  =  "George Orwell"	book_1
SELECT avg(saleprice) FROM Book AS T1 JOIN Author_book AS T2 ON T1.isbn  =  T2.isbn JOIN Author AS T3 ON T2.Author  =  T3.idAuthor WHERE T3.name  =  "George Orwell"	book_1
SELECT saleprice FROM Book AS T1 JOIN Author_book AS T2 ON T1.isbn  =  T2.isbn JOIN Author AS T3 ON T2.Author  =  T3.idAuthor WHERE T3.name  =  "Plato"	book_1
SELECT saleprice FROM Book AS T1 JOIN Author_book AS T2 ON T1.isbn  =  T2.isbn JOIN Author AS T3 ON T2.Author  =  T3.idAuthor WHERE T3.name  =  "Plato"	book_1
SELECT T1.title FROM Book AS T1 JOIN Author_book AS T2 ON T1.isbn  =  T2.isbn JOIN Author AS T3 ON T2.Author  =  T3.idAuthor WHERE T3.name  =  "George Orwell" ORDER BY T1.saleprice LIMIT 1	book_1
SELECT T1.title FROM Book AS T1 JOIN Author_book AS T2 ON T1.isbn  =  T2.isbn JOIN Author AS T3 ON T2.Author  =  T3.idAuthor WHERE T3.name  =  "George Orwell" ORDER BY T1.saleprice LIMIT 1	book_1
SELECT T1.title FROM Book AS T1 JOIN Author_book AS T2 ON T1.isbn  =  T2.isbn JOIN Author AS T3 ON T2.Author  =  T3.idAuthor WHERE T3.name  =  "Plato" AND T1.saleprice  <  (SELECT avg(saleprice) FROM Book)	book_1
SELECT T1.title FROM Book AS T1 JOIN Author_book AS T2 ON T1.isbn  =  T2.isbn JOIN Author AS T3 ON T2.Author  =  T3.idAuthor WHERE T3.name  =  "Plato" AND T1.saleprice  <  (SELECT avg(saleprice) FROM Book)	book_1
SELECT T3.name FROM Book AS T1 JOIN Author_book AS T2 ON T1.isbn  =  T2.isbn JOIN Author AS T3 ON T2.Author  =  T3.idAuthor WHERE T1.title  =  "Pride and Prejudice"	book_1
SELECT T3.name FROM Book AS T1 JOIN Author_book AS T2 ON T1.isbn  =  T2.isbn JOIN Author AS T3 ON T2.Author  =  T3.idAuthor WHERE T1.title  =  "Pride and Prejudice"	book_1
SELECT T1.title FROM Book AS T1 JOIN Author_book AS T2 ON T1.isbn  =  T2.isbn JOIN Author AS T3 ON T2.Author  =  T3.idAuthor WHERE T3.name LIKE "%Plato%"	book_1
SELECT T1.title FROM Book AS T1 JOIN Author_book AS T2 ON T1.isbn  =  T2.isbn JOIN Author AS T3 ON T2.Author  =  T3.idAuthor WHERE T3.name LIKE "%Plato%"	book_1
SELECT count(*) FROM Book AS T1 JOIN Books_Order AS T2 ON T1.isbn  =  T2.isbn WHERE T1.title  =  "Pride and Prejudice"	book_1
SELECT count(*) FROM Book AS T1 JOIN Books_Order AS T2 ON T1.isbn  =  T2.isbn WHERE T1.title  =  "Pride and Prejudice"	book_1
SELECT idOrder FROM Book AS T1 JOIN Books_Order AS T2 ON T1.isbn  =  T2.isbn WHERE T1.title  =  "Pride and Prejudice" INTERSECT SELECT idOrder FROM Book AS T1 JOIN Books_Order AS T2 ON T1.isbn  =  T2.isbn WHERE T1.title  =  "The Little Prince"	book_1
SELECT idOrder FROM Book AS T1 JOIN Books_Order AS T2 ON T1.isbn  =  T2.isbn WHERE T1.title  =  "Pride and Prejudice" INTERSECT SELECT idOrder FROM Book AS T1 JOIN Books_Order AS T2 ON T1.isbn  =  T2.isbn WHERE T1.title  =  "The Little Prince"	book_1
SELECT T2.isbn FROM Orders AS T1 JOIN Books_Order AS T2 ON T1.idOrder  =  T2.idOrder JOIN Client AS T3 ON T1.idClient  =  T3.idClient WHERE T3.name  =  "Peter Doe" INTERSECT SELECT T2.isbn FROM Orders AS T1 JOIN Books_Order AS T2 ON T1.idOrder  =  T2.idOrder JOIN Client AS T3 ON T1.idClient  =  T3.idClient WHERE T3.name  =  "James Smith"	book_1
SELECT T2.isbn FROM Orders AS T1 JOIN Books_Order AS T2 ON T1.idOrder  =  T2.idOrder JOIN Client AS T3 ON T1.idClient  =  T3.idClient WHERE T3.name  =  "Peter Doe" INTERSECT SELECT T2.isbn FROM Orders AS T1 JOIN Books_Order AS T2 ON T1.idOrder  =  T2.idOrder JOIN Client AS T3 ON T1.idClient  =  T3.idClient WHERE T3.name  =  "James Smith"	book_1
SELECT T4.title FROM Orders AS T1 JOIN Books_Order AS T2 ON T1.idOrder  =  T2.idOrder JOIN Client AS T3 ON T1.idClient  =  T3.idClient JOIN book AS T4 ON T2.ISBN  =  T4.isbn WHERE T3.name  =  "Peter Doe" EXCEPT SELECT T4.title FROM Orders AS T1 JOIN Books_Order AS T2 ON T1.idOrder  =  T2.idOrder JOIN Client AS T3 ON T1.idClient  =  T3.idClient JOIN book AS T4 ON T2.ISBN  =  T4.isbn WHERE T3.name  =  "James Smith"	book_1
SELECT T4.title FROM Orders AS T1 JOIN Books_Order AS T2 ON T1.idOrder  =  T2.idOrder JOIN Client AS T3 ON T1.idClient  =  T3.idClient JOIN book AS T4 ON T2.ISBN  =  T4.isbn WHERE T3.name  =  "Peter Doe" EXCEPT SELECT T4.title FROM Orders AS T1 JOIN Books_Order AS T2 ON T1.idOrder  =  T2.idOrder JOIN Client AS T3 ON T1.idClient  =  T3.idClient JOIN book AS T4 ON T2.ISBN  =  T4.isbn WHERE T3.name  =  "James Smith"	book_1
SELECT T3.name FROM Orders AS T1 JOIN Books_Order AS T2 ON T1.idOrder  =  T2.idOrder JOIN Client AS T3 ON T1.idClient  =  T3.idClient JOIN Book AS T4 ON T4.isbn  =  T2.isbn WHERE T4.title  =  "Pride and Prejudice"	book_1
SELECT T3.name FROM Orders AS T1 JOIN Books_Order AS T2 ON T1.idOrder  =  T2.idOrder JOIN Client AS T3 ON T1.idClient  =  T3.idClient JOIN Book AS T4 ON T4.isbn  =  T2.isbn WHERE T4.title  =  "Pride and Prejudice"	book_1
SELECT count(*) FROM book	book_review
SELECT Title FROM book ORDER BY Title ASC	book_review
SELECT Title FROM book ORDER BY Pages DESC	book_review
SELECT TYPE ,  Release FROM book	book_review
SELECT max(Chapters) ,  min(Chapters) FROM book	book_review
SELECT Title FROM book WHERE TYPE != "Poet"	book_review
SELECT avg(Rating) FROM review	book_review
SELECT T1.Title ,  T2.Rating FROM book AS T1 JOIN review AS T2 ON T1.Book_ID  =  T2.Book_ID	book_review
SELECT T2.Rating FROM book AS T1 JOIN review AS T2 ON T1.Book_ID  =  T2.Book_ID ORDER BY T1.Chapters DESC LIMIT 1	book_review
SELECT T2.Rank FROM book AS T1 JOIN review AS T2 ON T1.Book_ID  =  T2.Book_ID ORDER BY T1.Pages ASC LIMIT 1	book_review
SELECT T1.Title FROM book AS T1 JOIN review AS T2 ON T1.Book_ID  =  T2.Book_ID ORDER BY T2.Rank LIMIT 1	book_review
SELECT avg(T2.Readers_in_Million) FROM book AS T1 JOIN review AS T2 ON T1.Book_ID  =  T2.Book_ID WHERE T1.Type  =  "Novel"	book_review
SELECT TYPE ,  COUNT(*) FROM book GROUP BY TYPE	book_review
SELECT TYPE FROM book GROUP BY TYPE ORDER BY COUNT(*) DESC LIMIT 1	book_review
SELECT TYPE FROM book GROUP BY TYPE HAVING COUNT(*)  >=  3	book_review
SELECT T1.Title FROM book AS T1 JOIN review AS T2 ON T1.Book_ID  =  T2.Book_ID ORDER BY T2.Rating ASC	book_review
SELECT T1.Title ,  T1.audio FROM book AS T1 JOIN review AS T2 ON T1.Book_ID  =  T2.Book_ID ORDER BY T2.Readers_in_Million DESC	book_review
SELECT count(*) FROM book WHERE Book_ID NOT IN (SELECT Book_ID FROM review)	book_review
SELECT TYPE FROM book WHERE Chapters  >  75 INTERSECT SELECT TYPE FROM book WHERE Chapters  <  50	book_review
SELECT count(DISTINCT TYPE) FROM book	book_review
SELECT TYPE ,  title FROM book EXCEPT SELECT T1.type ,  T1.title FROM book AS T1 JOIN review AS T2 ON T1.Book_ID  =  T2.Book_ID;	book_review
SELECT count(*) FROM customer	restaurant_bills
SELECT count(*) FROM customer	restaurant_bills
SELECT Name FROM customer ORDER BY Level_of_Membership ASC	restaurant_bills
SELECT Name FROM customer ORDER BY Level_of_Membership ASC	restaurant_bills
SELECT Nationality ,  Card_Credit FROM customer	restaurant_bills
SELECT Nationality ,  Card_Credit FROM customer	restaurant_bills
SELECT Name FROM customer WHERE Nationality  =  "England" OR Nationality  =  "Australia"	restaurant_bills
SELECT Name FROM customer WHERE Nationality  =  "England" OR Nationality  =  "Australia"	restaurant_bills
SELECT avg(Card_Credit) FROM customer WHERE Level_of_Membership  >  1	restaurant_bills
SELECT avg(Card_Credit) FROM customer WHERE Level_of_Membership  >  1	restaurant_bills
SELECT Card_Credit FROM customer ORDER BY Level_of_Membership DESC LIMIT 1	restaurant_bills
SELECT Card_Credit FROM customer ORDER BY Level_of_Membership DESC LIMIT 1	restaurant_bills
SELECT Nationality ,  COUNT(*) FROM customer GROUP BY Nationality	restaurant_bills
SELECT Nationality ,  COUNT(*) FROM customer GROUP BY Nationality	restaurant_bills
SELECT Nationality FROM customer GROUP BY Nationality ORDER BY COUNT(*) DESC LIMIT 1	restaurant_bills
SELECT Nationality FROM customer GROUP BY Nationality ORDER BY COUNT(*) DESC LIMIT 1	restaurant_bills
SELECT Nationality FROM customer WHERE Card_Credit  <  50 INTERSECT SELECT Nationality FROM customer WHERE Card_Credit  >  75	restaurant_bills
SELECT Nationality FROM customer WHERE Card_Credit  <  50 INTERSECT SELECT Nationality FROM customer WHERE Card_Credit  >  75	restaurant_bills
SELECT T1.Name ,  T2.Dish_Name FROM customer AS T1 JOIN customer_order AS T2 ON T1.Customer_ID  =  T2.Customer_ID	restaurant_bills
SELECT T1.Name ,  T2.Dish_Name FROM customer AS T1 JOIN customer_order AS T2 ON T1.Customer_ID  =  T2.Customer_ID	restaurant_bills
SELECT T1.Name ,  T2.Dish_Name FROM customer AS T1 JOIN customer_order AS T2 ON T1.Customer_ID  =  T2.Customer_ID ORDER BY T2.Quantity DESC	restaurant_bills
SELECT T1.Name ,  T2.Dish_Name FROM customer AS T1 JOIN customer_order AS T2 ON T1.Customer_ID  =  T2.Customer_ID ORDER BY T2.Quantity DESC	restaurant_bills
SELECT T1.Name ,  sum(T2.Quantity) FROM customer AS T1 JOIN customer_order AS T2 ON T1.Customer_ID  =  T2.Customer_ID GROUP BY T1.Name	restaurant_bills
select t1.name ,  sum(t2.quantity) from customer as t1 join customer_order as t2 on t1.customer_id  =  t2.customer_id group by t1.name	restaurant_bills
SELECT T1.Name FROM customer AS T1 JOIN customer_order AS T2 ON T1.Customer_ID  =  T2.Customer_ID GROUP BY T1.Name HAVING sum(T2.Quantity)  >  1	restaurant_bills
SELECT T1.Name FROM customer AS T1 JOIN customer_order AS T2 ON T1.Customer_ID  =  T2.Customer_ID GROUP BY T1.Name HAVING sum(T2.Quantity)  >  1	restaurant_bills
SELECT DISTINCT Manager FROM branch	restaurant_bills
SELECT DISTINCT Manager FROM branch	restaurant_bills
SELECT name FROM customer WHERE Customer_ID NOT IN (SELECT Customer_ID FROM customer_order)	restaurant_bills
SELECT name FROM customer WHERE Customer_ID NOT IN (SELECT Customer_ID FROM customer_order)	restaurant_bills
SELECT count(*) FROM member	club_leader
SELECT Name FROM member ORDER BY Age ASC	club_leader
SELECT Name ,  Nationality FROM member	club_leader
select name from member where nationality != "england"	club_leader
SELECT Name FROM member WHERE Age  =  19 OR Age  =  20	club_leader
SELECT Name FROM member ORDER BY Age DESC LIMIT 1	club_leader
SELECT Nationality ,  COUNT(*) FROM member GROUP BY Nationality	club_leader
SELECT Nationality ,  COUNT(*) FROM member GROUP BY Nationality ORDER BY COUNT(*) DESC LIMIT 1	club_leader
SELECT Nationality FROM member GROUP BY Nationality HAVING COUNT(*)  >=  2	club_leader
SELECT T3.Name ,  T2.Club_Name FROM club_leader AS T1 JOIN club AS T2 ON T1.Club_ID  =  T2.Club_ID JOIN member AS T3 ON T1.Member_ID  =  T3.Member_ID	club_leader
SELECT T3.Name ,  T2.Club_Name FROM club_leader AS T1 JOIN club AS T2 ON T1.Club_ID  =  T2.Club_ID JOIN member AS T3 ON T1.Member_ID  =  T3.Member_ID WHERE T2.Overall_Ranking  <  100	club_leader
SELECT T3.Name ,  T2.Club_Name FROM club_leader AS T1 JOIN club AS T2 ON T1.Club_ID  =  T2.Club_ID JOIN member AS T3 ON T1.Member_ID  =  T3.Member_ID WHERE T1.Year_Join  <  2018	club_leader
SELECT T3.Name FROM club_leader AS T1 JOIN club AS T2 ON T1.Club_ID  =  T2.Club_ID JOIN member AS T3 ON T1.Member_ID  =  T3.Member_ID WHERE T2.Club_Name  =  "Houston"	club_leader
SELECT Name FROM member WHERE Member_ID NOT IN (SELECT Member_ID FROM club_leader)	club_leader
SELECT Nationality FROM member WHERE Age  >  22 INTERSECT SELECT Nationality FROM member WHERE Age  <  19	club_leader
SELECT avg(T2.age) FROM club_leader AS T1 JOIN member AS T2 ON T1.member_id  =  T2.member_id	club_leader
SELECT club_name FROM club WHERE club_name LIKE '%state%'	club_leader
SELECT Collection_Subset_Name FROM Collection_Subsets;	cre_Doc_and_collections
SELECT Collection_Subset_Name FROM Collection_Subsets;	cre_Doc_and_collections
SELECT Collecrtion_Subset_Details FROM Collection_Subsets WHERE Collection_Subset_Name = "Top collection";	cre_Doc_and_collections
SELECT Collecrtion_Subset_Details FROM Collection_Subsets WHERE Collection_Subset_Name = "Top collection";	cre_Doc_and_collections
SELECT Document_Subset_Name FROM Document_Subsets;	cre_Doc_and_collections
SELECT Document_Subset_Name FROM Document_Subsets;	cre_Doc_and_collections
SELECT Document_Subset_Details FROM Document_Subsets WHERE Document_Subset_Name = "Best for 2000";	cre_Doc_and_collections
SELECT Document_Subset_Details FROM Document_Subsets WHERE Document_Subset_Name = "Best for 2000";	cre_Doc_and_collections
SELECT Document_Object_ID FROM Document_Objects;	cre_Doc_and_collections
SELECT Document_Object_ID FROM Document_Objects;	cre_Doc_and_collections
SELECT Parent_Document_Object_ID FROM Document_Objects WHERE OWNER  =  'Marlin'	cre_Doc_and_collections
SELECT Parent_Document_Object_ID FROM Document_Objects WHERE OWNER  =  'Marlin'	cre_Doc_and_collections
SELECT OWNER FROM Document_Objects WHERE Description  =  'Braeden Collection'	cre_Doc_and_collections
SELECT OWNER FROM Document_Objects WHERE Description  =  'Braeden Collection'	cre_Doc_and_collections
SELECT T2.Owner FROM Document_Objects AS T1 JOIN Document_Objects AS T2 ON T1.Parent_Document_Object_ID = T2.Document_Object_ID WHERE T1.Owner  =  'Marlin'	cre_Doc_and_collections
SELECT T2.Owner FROM Document_Objects AS T1 JOIN Document_Objects AS T2 ON T1.Parent_Document_Object_ID = T2.Document_Object_ID WHERE T1.Owner  =  'Marlin'	cre_Doc_and_collections
SELECT DISTINCT T2.Description FROM Document_Objects AS T1 JOIN Document_Objects AS T2 ON T1.Parent_Document_Object_ID = T2.Document_Object_ID	cre_Doc_and_collections
SELECT DISTINCT T2.Description FROM Document_Objects AS T1 JOIN Document_Objects AS T2 ON T1.Parent_Document_Object_ID = T2.Document_Object_ID	cre_Doc_and_collections
SELECT count(*) FROM Document_Objects WHERE OWNER = "Marlin";	cre_Doc_and_collections
SELECT count(*) FROM Document_Objects WHERE OWNER = "Marlin";	cre_Doc_and_collections
SELECT Document_Object_ID FROM Document_Objects EXCEPT SELECT Parent_Document_Object_ID FROM Document_Objects	cre_Doc_and_collections
SELECT Document_Object_ID FROM Document_Objects EXCEPT SELECT Parent_Document_Object_ID FROM Document_Objects	cre_Doc_and_collections
SELECT T2.Document_Object_ID ,  count(*) FROM Document_Objects AS T1 JOIN Document_Objects AS T2 ON T1.Parent_Document_Object_ID = T2.Document_Object_ID GROUP BY T2.Document_Object_ID;	cre_Doc_and_collections
SELECT T2.Document_Object_ID ,  count(*) FROM Document_Objects AS T1 JOIN Document_Objects AS T2 ON T1.Parent_Document_Object_ID = T2.Document_Object_ID GROUP BY T2.Document_Object_ID;	cre_Doc_and_collections
SELECT Collection_Name FROM Collections;	cre_Doc_and_collections
SELECT Collection_Name FROM Collections;	cre_Doc_and_collections
SELECT Collection_Description FROM Collections WHERE Collection_Name = "Best";	cre_Doc_and_collections
SELECT Collection_Description FROM Collections WHERE Collection_Name = "Best";	cre_Doc_and_collections
SELECT T2.Collection_Name FROM Collections AS T1 JOIN Collections AS T2 ON T1.Parent_Collection_ID = T2.Collection_ID WHERE T1.Collection_Name = "Nice";	cre_Doc_and_collections
SELECT T2.Collection_Name FROM Collections AS T1 JOIN Collections AS T2 ON T1.Parent_Collection_ID = T2.Collection_ID WHERE T1.Collection_Name = "Nice";	cre_Doc_and_collections
SELECT Collection_Name FROM Collections EXCEPT SELECT T2.Collection_Name FROM Collections AS T1 JOIN Collections AS T2 ON T1.Parent_Collection_ID = T2.Collection_ID;	cre_Doc_and_collections
SELECT Collection_Name FROM Collections EXCEPT SELECT T2.Collection_Name FROM Collections AS T1 JOIN Collections AS T2 ON T1.Parent_Collection_ID = T2.Collection_ID;	cre_Doc_and_collections
SELECT T2.Document_Object_ID FROM Document_Objects AS T1 JOIN Document_Objects AS T2 ON T1.Parent_Document_Object_ID = T2.Document_Object_ID GROUP BY T2.Document_Object_ID HAVING count(*)  >  1;	cre_Doc_and_collections
SELECT T2.Document_Object_ID FROM Document_Objects AS T1 JOIN Document_Objects AS T2 ON T1.Parent_Document_Object_ID = T2.Document_Object_ID GROUP BY T2.Document_Object_ID HAVING count(*)  >  1;	cre_Doc_and_collections
SELECT count(*) FROM Collections AS T1 JOIN Collections AS T2 ON T1.Parent_Collection_ID = T2.Collection_ID WHERE T2.Collection_Name = "Best";	cre_Doc_and_collections
SELECT count(*) FROM Collections AS T1 JOIN Collections AS T2 ON T1.Parent_Collection_ID = T2.Collection_ID WHERE T2.Collection_Name = "Best";	cre_Doc_and_collections
select t1.document_object_id from document_subset_members as t1 join document_objects as t2 on t1.document_object_id  =  t2.document_object_id where t2.owner  =  'ransom'	cre_Doc_and_collections
select t1.document_object_id from document_subset_members as t1 join document_objects as t2 on t1.document_object_id  =  t2.document_object_id where t2.owner  =  'ransom'	cre_Doc_and_collections
SELECT T2.Collection_Subset_ID ,  T1.Collection_Subset_Name ,  count(*) FROM Collection_Subsets AS T1 JOIN Collection_Subset_Members AS T2 ON T1.Collection_Subset_ID =  T2.Collection_Subset_ID GROUP BY T2.Collection_Subset_ID;	cre_Doc_and_collections
SELECT T2.Collection_Subset_ID ,  T1.Collection_Subset_Name ,  count(*) FROM Collection_Subsets AS T1 JOIN Collection_Subset_Members AS T2 ON T1.Collection_Subset_ID =  T2.Collection_Subset_ID GROUP BY T2.Collection_Subset_ID;	cre_Doc_and_collections
SELECT T2.Document_Object_ID ,  count(*) FROM Document_Objects AS T1 JOIN Document_Objects AS T2 ON T1.Parent_Document_Object_ID = T2.Document_Object_ID GROUP BY T2.Document_Object_ID ORDER BY count(*) DESC LIMIT 1;	cre_Doc_and_collections
SELECT T2.Document_Object_ID ,  count(*) FROM Document_Objects AS T1 JOIN Document_Objects AS T2 ON T1.Parent_Document_Object_ID = T2.Document_Object_ID GROUP BY T2.Document_Object_ID ORDER BY count(*) DESC LIMIT 1;	cre_Doc_and_collections
SELECT Document_Object_ID , count(*) FROM Document_Subset_Members GROUP BY Document_Object_ID ORDER BY count(*) ASC LIMIT 1;	cre_Doc_and_collections
select document_object_id , count(*) from document_subset_members group by document_object_id order by count(*) asc limit 1;	cre_Doc_and_collections
select document_object_id , count(*) from document_subset_members group by document_object_id having count(*) between 2 and 4;	cre_Doc_and_collections
SELECT Document_Object_ID , count(*) FROM Document_Subset_Members GROUP BY Document_Object_ID HAVING count(*) BETWEEN 2 AND 4;	cre_Doc_and_collections
SELECT DISTINCT OWNER FROM Document_Subset_Members AS T1 JOIN Document_Objects AS T2 ON T1.Related_Document_Object_ID  =  T2.Document_Object_ID WHERE T2.Owner  =  'Braeden';	cre_Doc_and_collections
SELECT DISTINCT OWNER FROM Document_Subset_Members AS T1 JOIN Document_Objects AS T2 ON T1.Related_Document_Object_ID  =  T2.Document_Object_ID WHERE T2.Owner  =  'Braeden';	cre_Doc_and_collections
SELECT DISTINCT T1.Document_Subset_Name FROM Document_Subsets AS T1 JOIN Document_Subset_Members AS T2 ON T1.Document_Subset_ID =  T2.Document_Subset_ID JOIN Document_Objects AS T3 ON T2.Document_Object_ID  =  T3.Document_Object_ID WHERE T3.owner  =  'Braeden'	cre_Doc_and_collections
SELECT DISTINCT T1.Document_Subset_Name FROM Document_Subsets AS T1 JOIN Document_Subset_Members AS T2 ON T1.Document_Subset_ID =  T2.Document_Subset_ID JOIN Document_Objects AS T3 ON T2.Document_Object_ID  =  T3.Document_Object_ID WHERE T3.owner  =  'Braeden'	cre_Doc_and_collections
SELECT T1.Document_Subset_ID ,  T2.Document_Subset_Name , count(DISTINCT T1.Document_Object_ID) FROM Document_Subset_Members AS T1 JOIN Document_Subsets AS T2 ON T1.Document_Subset_ID =  T2.Document_Subset_ID GROUP BY T1.Document_Subset_ID;	cre_Doc_and_collections
SELECT T1.Document_Subset_ID ,  T2.Document_Subset_Name , count(DISTINCT T1.Document_Object_ID) FROM Document_Subset_Members AS T1 JOIN Document_Subsets AS T2 ON T1.Document_Subset_ID =  T2.Document_Subset_ID GROUP BY T1.Document_Subset_ID;	cre_Doc_and_collections
select t1.document_subset_id ,  t2.document_subset_name , count(distinct t1.document_object_id) from document_subset_members as t1 join document_subsets as t2 on t1.document_subset_id =  t2.document_subset_id group by t1.document_subset_id order by count(*) desc limit 1;	cre_Doc_and_collections
select t1.document_subset_id ,  t2.document_subset_name , count(distinct t1.document_object_id) from document_subset_members as t1 join document_subsets as t2 on t1.document_subset_id =  t2.document_subset_id group by t1.document_subset_id order by count(*) desc limit 1;	cre_Doc_and_collections
SELECT DISTINCT T1.Document_Object_ID FROM Document_Subset_Members AS T1 JOIN Document_Subsets AS T2 ON T1.Document_Subset_ID =  T2.Document_Subset_ID WHERE T2.Document_Subset_Name = "Best for 2000";	cre_Doc_and_collections
SELECT DISTINCT T1.Document_Object_ID FROM Document_Subset_Members AS T1 JOIN Document_Subsets AS T2 ON T1.Document_Subset_ID =  T2.Document_Subset_ID WHERE T2.Document_Subset_Name = "Best for 2000";	cre_Doc_and_collections
SELECT DISTINCT T3.Document_Subset_Name ,  T1.Document_Object_ID FROM Document_Subset_Members AS T1 JOIN Document_Subset_Members  AS T2 ON T1.Related_Document_Object_ID = T2.Document_Object_ID JOIN Document_Subsets AS T3 ON T2.Document_Subset_ID =  T3.Document_Subset_ID	cre_Doc_and_collections
select distinct t3.document_subset_name ,  t1.document_object_id from document_subset_members as t1 join document_subset_members  as t2 on t1.related_document_object_id = t2.document_object_id join document_subsets as t3 on t2.document_subset_id =  t3.document_subset_id	cre_Doc_and_collections
select t1.collection_name from collections as t1 join documents_in_collections as t2 on t1.collection_id = t2.collection_id join document_objects as t3 on t2.document_object_id  =  t3.document_object_id where t3.owner  =  'ransom'	cre_Doc_and_collections
SELECT T1.Collection_Name FROM Collections AS T1 JOIN Documents_in_Collections AS T2 ON T1.Collection_ID = T2.Collection_ID JOIN Document_Objects AS T3 ON T2.Document_object_id  =  T3.Document_object_id WHERE T3.owner  =  'Ransom'	cre_Doc_and_collections
SELECT count(*) ,  T2.Document_Object_ID FROM Collections AS T1 JOIN Documents_in_Collections AS T2 ON T1.Collection_ID = T2.Collection_ID GROUP BY T2.Document_Object_ID	cre_Doc_and_collections
SELECT count(*) ,  T2.Document_Object_ID FROM Collections AS T1 JOIN Documents_in_Collections AS T2 ON T1.Collection_ID = T2.Collection_ID GROUP BY T2.Document_Object_ID	cre_Doc_and_collections
SELECT count(*) FROM Collections AS T1 JOIN Documents_in_Collections AS T2 ON T1.Collection_ID = T2.Collection_ID WHERE T1.Collection_Name = "Best";	cre_Doc_and_collections
SELECT count(*) FROM Collections AS T1 JOIN Documents_in_Collections AS T2 ON T1.Collection_ID = T2.Collection_ID WHERE T1.Collection_Name = "Best";	cre_Doc_and_collections
SELECT T2.Document_Object_ID FROM Collections AS T1 JOIN Documents_in_Collections AS T2 ON T1.Collection_ID = T2.Collection_ID WHERE T1.Collection_Name = "Best";	cre_Doc_and_collections
SELECT T2.Document_Object_ID FROM Collections AS T1 JOIN Documents_in_Collections AS T2 ON T1.Collection_ID = T2.Collection_ID WHERE T1.Collection_Name = "Best";	cre_Doc_and_collections
SELECT T1.Collection_Name ,  T1.Collection_ID ,  count(*) FROM Collections AS T1 JOIN Documents_in_Collections AS T2 ON T1.Collection_ID = T2.Collection_ID WHERE T1.Collection_Name = "Best" GROUP BY T1.Collection_ID ORDER BY count(*) DESC LIMIT 1;	cre_Doc_and_collections
SELECT T1.Collection_Name ,  T1.Collection_ID ,  count(*) FROM Collections AS T1 JOIN Documents_in_Collections AS T2 ON T1.Collection_ID = T2.Collection_ID WHERE T1.Collection_Name = "Best" GROUP BY T1.Collection_ID ORDER BY count(*) DESC LIMIT 1;	cre_Doc_and_collections
SELECT DISTINCT T1.Document_Object_ID FROM Document_Subset_Members AS T1 JOIN Document_Subsets AS T2 ON T1.Document_Subset_ID =  T2.Document_Subset_ID JOIN Documents_in_Collections AS T3 ON T1.Document_Object_ID  =  T3.Document_Object_ID JOIN Collections AS T4 ON T3.Collection_ID  =  T4.Collection_ID WHERE T2.Document_Subset_Name = "Best for 2000" AND T4.Collection_Name = "Best";	cre_Doc_and_collections
SELECT DISTINCT T1.Document_Object_ID FROM Document_Subset_Members AS T1 JOIN Document_Subsets AS T2 ON T1.Document_Subset_ID =  T2.Document_Subset_ID JOIN Documents_in_Collections AS T3 ON T1.Document_Object_ID  =  T3.Document_Object_ID JOIN Collections AS T4 ON T3.Collection_ID  =  T4.Collection_ID WHERE T2.Document_Subset_Name = "Best for 2000" AND T4.Collection_Name = "Best";	cre_Doc_and_collections
SELECT DISTINCT T2.Document_Object_ID FROM Collections AS T1 JOIN Documents_in_Collections AS T2 ON T1.Collection_ID = T2.Collection_ID WHERE T1.Collection_Name = "Best" EXCEPT SELECT DISTINCT T3.Document_Object_ID FROM Document_Subset_Members AS T3 JOIN Document_Subsets AS T4 ON T3.Document_Subset_ID =  T4.Document_Subset_ID WHERE T4.Document_Subset_Name = "Best for 2000"	cre_Doc_and_collections
SELECT DISTINCT T2.Document_Object_ID FROM Collections AS T1 JOIN Documents_in_Collections AS T2 ON T1.Collection_ID = T2.Collection_ID WHERE T1.Collection_Name = "Best" EXCEPT SELECT DISTINCT T3.Document_Object_ID FROM Document_Subset_Members AS T3 JOIN Document_Subsets AS T4 ON T3.Document_Subset_ID =  T4.Document_Subset_ID WHERE T4.Document_Subset_Name = "Best for 2000"	cre_Doc_and_collections
SELECT DISTINCT T1.Document_Object_ID FROM Document_Subset_Members AS T1 JOIN Document_Subsets AS T2 ON T1.Document_Subset_ID =  T2.Document_Subset_ID JOIN Documents_in_Collections AS T3 ON T1.Document_Object_ID  =  T3.Document_Object_ID JOIN Collections AS T4 ON T3.Collection_ID  =  T4.Collection_ID WHERE T2.Document_Subset_Name = "Best for 2000" OR T4.Collection_Name = "Best";	cre_Doc_and_collections
SELECT DISTINCT T1.Document_Object_ID FROM Document_Subset_Members AS T1 JOIN Document_Subsets AS T2 ON T1.Document_Subset_ID =  T2.Document_Subset_ID JOIN Documents_in_Collections AS T3 ON T1.Document_Object_ID  =  T3.Document_Object_ID JOIN Collections AS T4 ON T3.Collection_ID  =  T4.Collection_ID WHERE T2.Document_Subset_Name = "Best for 2000" OR T4.Collection_Name = "Best";	cre_Doc_and_collections
SELECT DISTINCT T4.Collection_Name FROM Collection_Subset_Members AS T1 JOIN Collection_Subset_Members AS T2 ON T1.Related_Collection_ID = T2.Collection_ID JOIN Collections AS T3 ON T1.Collection_ID = T3.Collection_ID JOIN Collections AS T4 ON T2.Collection_ID = T4.Collection_ID WHERE T3.Collection_Name = "Best";	cre_Doc_and_collections
SELECT DISTINCT T4.Collection_Name FROM Collection_Subset_Members AS T1 JOIN Collection_Subset_Members AS T2 ON T1.Related_Collection_ID = T2.Collection_ID JOIN Collections AS T3 ON T1.Collection_ID = T3.Collection_ID JOIN Collections AS T4 ON T2.Collection_ID = T4.Collection_ID WHERE T3.Collection_Name = "Best";	cre_Doc_and_collections
SELECT count(DISTINCT T1.Related_Collection_ID) FROM Collection_Subset_Members AS T1 JOIN Collections AS T2 ON T1.Collection_ID  =  T2.Collection_ID WHERE T2.Collection_Name = "Best";	cre_Doc_and_collections
SELECT count(DISTINCT T1.Related_Collection_ID) FROM Collection_Subset_Members AS T1 JOIN Collections AS T2 ON T1.Collection_ID  =  T2.Collection_ID WHERE T2.Collection_Name = "Best";	cre_Doc_and_collections
SELECT DISTINCT T1.Collection_Subset_Name FROM Collection_Subsets AS T1 JOIN Collection_Subset_Members AS T2 ON T1.Collection_Subset_ID =  T2.Collection_Subset_ID JOIN Collections AS T3 ON T2.Collection_ID =  T3.Collection_ID WHERE T3.Collection_Name = "Best";	cre_Doc_and_collections
SELECT DISTINCT T1.Collection_Subset_Name FROM Collection_Subsets AS T1 JOIN Collection_Subset_Members AS T2 ON T1.Collection_Subset_ID =  T2.Collection_Subset_ID JOIN Collections AS T3 ON T2.Collection_ID =  T3.Collection_ID WHERE T3.Collection_Name = "Best";	cre_Doc_and_collections
SELECT count(*) FROM songs WHERE name LIKE "%Love%"	sing_contest
SELECT name FROM songs ORDER BY name	sing_contest
select name , language from songs	sing_contest
SELECT max(voice_sound_quality) ,  min(voice_sound_quality) FROM performance_score	sing_contest
SELECT T1.voice_sound_quality ,  T1.rhythm_tempo ,  T1.stage_presence FROM performance_score AS T1 JOIN participants AS T2 ON T1.participant_id  =  T2.id WHERE T2.name  =  'Freeway'	sing_contest
SELECT id ,  LANGUAGE ,  original_artist FROM songs WHERE name != 'Love'	sing_contest
SELECT name ,  original_artist FROM songs WHERE english_translation  =  'All the streets of love'	sing_contest
SELECT DISTINCT T2.stage_presence FROM songs AS T1 JOIN performance_score AS T2 ON T1.id  =  T2.songs_id WHERE T1.language  =  'English'	sing_contest
SELECT T1.id ,  T1.Name FROM participants AS T1 JOIN performance_score AS T2 ON T2.participant_id  =  T1.id GROUP BY T1.id HAVING count(*)  >=  2	sing_contest
SELECT T1.id ,  T1.Name ,  T1.popularity FROM participants AS T1 JOIN performance_score AS T2 ON T2.participant_id  =  T1.id GROUP BY T1.id ORDER BY count(*)	sing_contest
SELECT T1.id ,  T1.name FROM participants AS T1 JOIN performance_score AS T2 ON T2.participant_id  =  T1.id WHERE T2.voice_sound_quality  =  5 OR T2.rhythm_tempo  =  5	sing_contest
SELECT T1.voice_sound_quality FROM performance_score AS T1 JOIN songs AS T2 ON T1.songs_id  =  T2.id WHERE T2.name  =  ' The Balkan Girls ' AND T2.language  =  'English'	sing_contest
SELECT T1.id ,  T1.name FROM songs AS T1 JOIN performance_score AS T2 ON T1.id  =  T2.songs_id GROUP BY T1.id ORDER BY count(*) DESC LIMIT 1	sing_contest
SELECT count(*) FROM performance_score WHERE stage_presence  <  7 OR stage_presence  >  9	sing_contest
SELECT count(*) FROM songs WHERE id NOT IN ( SELECT songs_id FROM performance_score );	sing_contest
SELECT avg(T2.rhythm_tempo) ,  T1.language FROM songs AS T1 JOIN performance_score AS T2 ON T2.songs_id  =  T1.id GROUP BY T1.language	sing_contest
SELECT DISTINCT T1.name FROM participants AS T1 JOIN performance_score AS T2 ON T2.participant_id  =  T1.id JOIN songs AS T3 ON T3.id  =  T2.songs_id WHERE T3.language  =  'English'	sing_contest
SELECT T1.name ,  T1.popularity FROM participants AS T1 JOIN performance_score AS T2 ON T2.participant_id  =  T1.id JOIN songs AS T3 ON T3.id  =  T2.songs_id WHERE T3.language  =  'Croatian' INTERSECT SELECT T1.name ,  T1.popularity FROM participants AS T1 JOIN performance_score AS T2 ON T2.participant_id  =  T1.id JOIN songs AS T3 ON T3.id  =  T2.songs_id WHERE T3.language  =  'English'	sing_contest
SELECT name FROM songs WHERE name LIKE "%Is%"	sing_contest
select t2.original_artist from performance_score as t1 join songs as t2 on t2.id  =  t1.songs_id where t1.rhythm_tempo  >  5 order by t1.voice_sound_quality desc	sing_contest
SELECT count(*) FROM City	address_1
SELECT count(*) FROM City	address_1
select distinct state from city	address_1
SELECT DISTINCT state FROM City	address_1
SELECT count(DISTINCT country) FROM City	address_1
SELECT count(DISTINCT country) FROM City	address_1
SELECT city_name ,  city_code ,  state ,  country FROM City	address_1
SELECT city_name ,  city_code ,  state ,  country FROM City	address_1
SELECT latitude ,  longitude FROM City WHERE city_name  =  "Baltimore"	address_1
SELECT latitude ,  longitude FROM City WHERE city_name  =  "Baltimore"	address_1
SELECT city_name FROM City WHERE state  =  "PA"	address_1
SELECT city_name FROM City WHERE state  =  "PA"	address_1
SELECT count(*) FROM City WHERE country  =  "CANADA"	address_1
SELECT count(*) FROM City WHERE country  =  "CANADA"	address_1
SELECT city_name FROM City WHERE country  =  "USA" ORDER BY latitude	address_1
SELECT city_name FROM City WHERE country  =  "USA" ORDER BY latitude	address_1
SELECT state ,  count(*) FROM City GROUP BY state	address_1
SELECT state ,  count(*) FROM City GROUP BY state	address_1
select country ,  count(*) from city group by country	address_1
SELECT country ,  count(*) FROM City GROUP BY country	address_1
SELECT state FROM City GROUP BY state HAVING count(*)  >=  2	address_1
SELECT state FROM City GROUP BY state HAVING count(*)  >=  2	address_1
SELECT state FROM City GROUP BY state ORDER BY count(*) DESC LIMIT 1	address_1
SELECT state FROM City GROUP BY state ORDER BY count(*) DESC LIMIT 1	address_1
SELECT country FROM City GROUP BY country ORDER BY count(*) ASC LIMIT 1	address_1
SELECT country FROM City GROUP BY country ORDER BY count(*) ASC LIMIT 1	address_1
SELECT T2.Fname ,  T2.Lname FROM City AS T1 JOIN Student AS T2 ON T1.city_code  =  T2.city_code WHERE T1.state  =  "MD"	address_1
SELECT T2.Fname ,  T2.Lname FROM City AS T1 JOIN Student AS T2 ON T1.city_code  =  T2.city_code WHERE T1.state  =  "MD"	address_1
SELECT count(*) FROM City AS T1 JOIN Student AS T2 ON T1.city_code  =  T2.city_code WHERE T1.country  =  "CHINA"	address_1
SELECT count(*) FROM City AS T1 JOIN Student AS T2 ON T1.city_code  =  T2.city_code WHERE T1.country  =  "CHINA"	address_1
SELECT T2.Fname ,  T2.Major FROM City AS T1 JOIN Student AS T2 ON T1.city_code  =  T2.city_code WHERE T1.city_name  =  "Baltimore"	address_1
SELECT T2.Fname ,  T2.Major FROM City AS T1 JOIN Student AS T2 ON T1.city_code  =  T2.city_code WHERE T1.city_name  =  "Baltimore"	address_1
SELECT T1.country ,  count(*) FROM City AS T1 JOIN Student AS T2 ON T1.city_code  =  T2.city_code GROUP BY T1.country	address_1
SELECT T1.country ,  count(*) FROM City AS T1 JOIN Student AS T2 ON T1.city_code  =  T2.city_code GROUP BY T1.country	address_1
SELECT T1.city_name ,  count(*) FROM City AS T1 JOIN Student AS T2 ON T1.city_code  =  T2.city_code GROUP BY T1.city_code	address_1
SELECT T1.city_name ,  count(*) FROM City AS T1 JOIN Student AS T2 ON T1.city_code  =  T2.city_code GROUP BY T1.city_code	address_1
SELECT T1.state FROM City AS T1 JOIN Student AS T2 ON T1.city_code  =  T2.city_code GROUP BY T1.state ORDER BY count(*) DESC LIMIT 1	address_1
SELECT T1.state FROM City AS T1 JOIN Student AS T2 ON T1.city_code  =  T2.city_code GROUP BY T1.state ORDER BY count(*) DESC LIMIT 1	address_1
SELECT T1.country FROM City AS T1 JOIN Student AS T2 ON T1.city_code  =  T2.city_code GROUP BY T1.country ORDER BY count(*) LIMIT 1	address_1
SELECT T1.country FROM City AS T1 JOIN Student AS T2 ON T1.city_code  =  T2.city_code GROUP BY T1.country ORDER BY count(*) LIMIT 1	address_1
SELECT T1.city_name FROM City AS T1 JOIN Student AS T2 ON T1.city_code  =  T2.city_code GROUP BY T1.city_code HAVING count(*)  >=  3	address_1
SELECT T1.city_name FROM City AS T1 JOIN Student AS T2 ON T1.city_code  =  T2.city_code GROUP BY T1.city_code HAVING count(*)  >=  3	address_1
SELECT T1.state FROM City AS T1 JOIN Student AS T2 ON T1.city_code  =  T2.city_code GROUP BY T1.state HAVING count(*)  >  5	address_1
SELECT T1.state FROM City AS T1 JOIN Student AS T2 ON T1.city_code  =  T2.city_code GROUP BY T1.state HAVING count(*)  >  5	address_1
SELECT StuID FROM Student EXCEPT SELECT StuID FROM City AS T1 JOIN Student AS T2 ON T1.city_code  =  T2.city_code WHERE country  =  "USA"	address_1
SELECT StuID FROM Student EXCEPT SELECT StuID FROM City AS T1 JOIN Student AS T2 ON T1.city_code  =  T2.city_code WHERE country  =  "USA"	address_1
SELECT StuID FROM City AS T1 JOIN Student AS T2 ON T1.city_code  =  T2.city_code WHERE T1.state  =  "PA"  AND T2.sex  =  'F'	address_1
SELECT StuID FROM City AS T1 JOIN Student AS T2 ON T1.city_code  =  T2.city_code WHERE T1.state  =  "PA"  AND T2.sex  =  'F'	address_1
SELECT StuID FROM City AS T1 JOIN Student AS T2 ON T1.city_code  =  T2.city_code WHERE T2.sex  =  'M' AND T1.country != "USA"	address_1
SELECT StuID FROM City AS T1 JOIN Student AS T2 ON T1.city_code  =  T2.city_code WHERE T2.sex  =  'M' AND T1.country != "USA"	address_1
SELECT distance FROM Direct_distance WHERE city1_code  =  "BAL" AND city2_code  =  "CHI"	address_1
SELECT distance FROM Direct_distance WHERE city1_code  =  "BAL" AND city2_code  =  "CHI"	address_1
SELECT distance FROM Direct_distance AS T1 JOIN City AS T2 ON T1.city1_code  =  T2.city_code JOIN City AS T3 ON T1.city2_code  =  T3.city_code WHERE T2.city_name  =  "Boston" AND T3.city_name  =  "Newark"	address_1
SELECT distance FROM Direct_distance AS T1 JOIN City AS T2 ON T1.city1_code  =  T2.city_code JOIN City AS T3 ON T1.city2_code  =  T3.city_code WHERE T2.city_name  =  "Boston" AND T3.city_name  =  "Newark"	address_1
SELECT avg(distance) ,  min(distance) ,  max(distance) FROM Direct_distance	address_1
SELECT avg(distance) ,  min(distance) ,  max(distance) FROM Direct_distance	address_1
SELECT city1_code ,  city2_code FROM Direct_distance ORDER BY distance DESC LIMIT 1	address_1
SELECT city1_code ,  city2_code FROM Direct_distance ORDER BY distance DESC LIMIT 1	address_1
SELECT city1_code ,  city2_code FROM Direct_distance WHERE distance  >  (SELECT avg(distance) FROM Direct_distance)	address_1
SELECT city1_code ,  city2_code FROM Direct_distance WHERE distance  >  (SELECT avg(distance) FROM Direct_distance)	address_1
SELECT city1_code ,  city2_code FROM Direct_distance WHERE distance  <  1000	address_1
SELECT city1_code ,  city2_code FROM Direct_distance WHERE distance  <  1000	address_1
SELECT sum(distance) FROM Direct_distance WHERE city1_code  =  "BAL"	address_1
SELECT sum(distance) FROM Direct_distance WHERE city1_code  =  "BAL"	address_1
SELECT avg(distance) FROM Direct_distance AS T1 JOIN City AS T2 ON T1.city1_code  =  T2.city_code WHERE T2.city_name  =  "Boston"	address_1
SELECT avg(distance) FROM Direct_distance AS T1 JOIN City AS T2 ON T1.city1_code  =  T2.city_code WHERE T2.city_name  =  "Boston"	address_1
SELECT T3.city_name FROM Direct_distance AS T1 JOIN City AS T2 ON T1.city1_code  =  T2.city_code JOIN City AS T3 ON T1.city2_code  =  T3.city_code WHERE T2.city_name  =  "Chicago" ORDER BY distance LIMIT 1	address_1
SELECT T3.city_name FROM Direct_distance AS T1 JOIN City AS T2 ON T1.city1_code  =  T2.city_code JOIN City AS T3 ON T1.city2_code  =  T3.city_code WHERE T2.city_name  =  "Chicago" ORDER BY distance LIMIT 1	address_1
SELECT T3.city_name FROM Direct_distance AS T1 JOIN City AS T2 ON T1.city1_code  =  T2.city_code JOIN City AS T3 ON T1.city2_code  =  T3.city_code WHERE T2.city_name  =  "Boston" ORDER BY distance DESC LIMIT 1	address_1
SELECT T3.city_name FROM Direct_distance AS T1 JOIN City AS T2 ON T1.city1_code  =  T2.city_code JOIN City AS T3 ON T1.city2_code  =  T3.city_code WHERE T2.city_name  =  "Boston" ORDER BY distance DESC LIMIT 1	address_1
SELECT city1_code ,  sum(distance) FROM Direct_distance GROUP BY city1_code	address_1
SELECT city1_code ,  sum(distance) FROM Direct_distance GROUP BY city1_code	address_1
SELECT T2.city_name ,  avg(distance) FROM Direct_distance AS T1 JOIN City AS T2 ON T1.city1_code  =  T2.city_code GROUP BY T1.city1_code	address_1
SELECT T2.city_name ,  avg(distance) FROM Direct_distance AS T1 JOIN City AS T2 ON T1.city1_code  =  T2.city_code GROUP BY T1.city1_code	address_1
SELECT distance FROM Direct_distance AS T1 JOIN Student AS T2 ON T1.city1_code  =  T2.city_code JOIN Student AS T3 ON T1.city2_code  =  T3.city_code WHERE T2.Fname  =  "Linda" AND T2.Lname  =  "Smith" AND T3.Fname  =  "Tracy" AND T3.Lname  =  "Kim"	address_1
SELECT distance FROM Direct_distance AS T1 JOIN Student AS T2 ON T1.city1_code  =  T2.city_code JOIN Student AS T3 ON T1.city2_code  =  T3.city_code WHERE T2.Fname  =  "Linda" AND T2.Lname  =  "Smith" AND T3.Fname  =  "Tracy" AND T3.Lname  =  "Kim"	address_1
SELECT T3.Fname ,  T3.Lname FROM Direct_distance AS T1 JOIN Student AS T2 ON T1.city1_code  =  T2.city_code JOIN Student AS T3 ON T1.city2_code  =  T3.city_code WHERE T2.Fname  =  "Linda" AND T2.Lname  =  "Smith" ORDER BY distance DESC LIMIT 1	address_1
SELECT T3.Fname ,  T3.Lname FROM Direct_distance AS T1 JOIN Student AS T2 ON T1.city1_code  =  T2.city_code JOIN Student AS T3 ON T1.city2_code  =  T3.city_code WHERE T2.Fname  =  "Linda" AND T2.Lname  =  "Smith" ORDER BY distance DESC LIMIT 1	address_1
SELECT state FROM Student AS T1 JOIN City AS T2 ON T1.city_code  =  T2.city_code WHERE T1.Fname  =  "Linda"	address_1
SELECT state FROM Student AS T1 JOIN City AS T2 ON T1.city_code  =  T2.city_code WHERE T1.Fname  =  "Linda"	address_1
SELECT * FROM Sailors WHERE age  >  30	boat_1
SELECT * FROM Sailors WHERE age  >  30	boat_1
SELECT name ,  age FROM Sailors WHERE age  <  30	boat_1
SELECT name ,  age FROM Sailors WHERE age  <  30	boat_1
SELECT DISTINCT bid FROM Reserves WHERE sid = 1	boat_1
SELECT DISTINCT bid FROM Reserves WHERE sid = 1	boat_1
SELECT T1.name FROM Sailors AS T1 JOIN Reserves AS T2 ON T1.sid  =  T2.sid WHERE T2.bid  =  102	boat_1
SELECT T1.name FROM Sailors AS T1 JOIN Reserves AS T2 ON T1.sid  =  T2.sid WHERE T2.bid  =  102	boat_1
SELECT DISTINCT bid FROM Reserves	boat_1
SELECT DISTINCT bid FROM Reserves	boat_1
SELECT name FROM Sailors WHERE name LIKE '%e%'	boat_1
SELECT name FROM Sailors WHERE name LIKE '%e%'	boat_1
SELECT DISTINCT sid FROM Sailors WHERE age  >  (SELECT min(age) FROM Sailors);	boat_1
SELECT DISTINCT sid FROM Sailors WHERE age  >  (SELECT min(age) FROM Sailors);	boat_1
SELECT DISTINCT name FROM Sailors WHERE age  >  (SELECT min(age) FROM Sailors WHERE rating  >  7);	boat_1
SELECT DISTINCT name FROM Sailors WHERE age  >  (SELECT min(age) FROM Sailors WHERE rating  >  7);	boat_1
SELECT DISTINCT T1.name ,  T1.sid FROM Sailors AS T1 JOIN Reserves AS T2 ON T1.sid  =  T2.sid	boat_1
SELECT DISTINCT T1.name ,  T1.sid FROM Sailors AS T1 JOIN Reserves AS T2 ON T1.sid  =  T2.sid	boat_1
SELECT DISTINCT T1.name ,  T1.sid FROM Sailors AS T1 JOIN Reserves AS T2 ON T1.sid  =  T2.sid GROUP BY T2.sid HAVING COUNT(*)  >  1	boat_1
select distinct t1.name ,  t1.sid from sailors as t1 join reserves as t2 on t1.sid  =  t2.sid group by t2.sid having count(*)  >=  2	boat_1
SELECT DISTINCT T2.sid FROM Boats AS T1 JOIN Reserves AS T2 ON  T1.bid  =  T2.bid WHERE T1.color  =  'red' OR T1.color  =  "blue"	boat_1
SELECT DISTINCT T2.sid FROM Boats AS T1 JOIN Reserves AS T2 ON  T1.bid  =  T2.bid WHERE T1.color  =  'red' OR T1.color  =  "blue"	boat_1
SELECT DISTINCT T2.sid ,  T3.name FROM Boats AS T1 JOIN Reserves AS T2 ON  T1.bid  =  T2.bid JOIN Sailors AS T3 ON T2.sid  =  T3.sid WHERE T1.color  =  'red' OR T1.color  =  "blue"	boat_1
SELECT DISTINCT T2.sid ,  T3.name FROM Boats AS T1 JOIN Reserves AS T2 ON  T1.bid  =  T2.bid JOIN Sailors AS T3 ON T2.sid  =  T3.sid WHERE T1.color  =  'red' OR T1.color  =  "blue"	boat_1
SELECT DISTINCT T2.sid FROM Boats AS T1 JOIN Reserves AS T2 ON  T1.bid  =  T2.bid WHERE T1.color  =  'red' INTERSECT SELECT DISTINCT T2.sid FROM Boats AS T1 JOIN Reserves AS T2 ON  T1.bid  =  T2.bid WHERE T1.color  =  "blue"	boat_1
SELECT DISTINCT T2.sid FROM Boats AS T1 JOIN Reserves AS T2 ON  T1.bid  =  T2.bid WHERE T1.color  =  'red' INTERSECT SELECT DISTINCT T2.sid FROM Boats AS T1 JOIN Reserves AS T2 ON  T1.bid  =  T2.bid WHERE T1.color  =  "blue"	boat_1
SELECT DISTINCT T2.sid ,  T3.name FROM Boats AS T1 JOIN Reserves AS T2 ON  T1.bid  =  T2.bid JOIN Sailors AS T3 ON T2.sid  =  T3.sid WHERE T1.color  =  'red' INTERSECT SELECT DISTINCT T2.sid ,  T3.name FROM Boats AS T1 JOIN Reserves AS T2 ON  T1.bid  =  T2.bid JOIN Sailors AS T3 ON T2.sid  =  T3.sid WHERE T1.color  =  "blue"	boat_1
SELECT DISTINCT T2.sid ,  T3.name FROM Boats AS T1 JOIN Reserves AS T2 ON  T1.bid  =  T2.bid JOIN Sailors AS T3 ON T2.sid  =  T3.sid WHERE T1.color  =  'red' INTERSECT SELECT DISTINCT T2.sid ,  T3.name FROM Boats AS T1 JOIN Reserves AS T2 ON  T1.bid  =  T2.bid JOIN Sailors AS T3 ON T2.sid  =  T3.sid WHERE T1.color  =  "blue"	boat_1
SELECT sid FROM Sailors EXCEPT SELECT sid FROM Reserves	boat_1
SELECT sid FROM Sailors EXCEPT SELECT sid FROM Reserves	boat_1
SELECT sid ,  name FROM Sailors EXCEPT SELECT T1.sid ,  T1.name FROM Sailors AS T1 JOIN Reserves AS T2 ON T1.sid  =  T2.sid	boat_1
SELECT sid ,  name FROM Sailors EXCEPT SELECT T1.sid ,  T1.name FROM Sailors AS T1 JOIN Reserves AS T2 ON T1.sid  =  T2.sid	boat_1
SELECT sid FROM Sailors EXCEPT SELECT T1.sid FROM Sailors AS T1 JOIN Reserves AS T2 ON T1.sid  =  T2.sid	boat_1
SELECT sid FROM Sailors EXCEPT SELECT T1.sid FROM Sailors AS T1 JOIN Reserves AS T2 ON T1.sid  =  T2.sid	boat_1
SELECT DISTINCT T1.name FROM Sailors AS T1 JOIN Reserves AS T2 ON T1.sid  =  T2.sid WHERE  T2.bid  =  103	boat_1
SELECT DISTINCT T1.name FROM Sailors AS T1 JOIN Reserves AS T2 ON T1.sid  =  T2.sid WHERE  T2.bid  =  103	boat_1
SELECT name FROM Sailors WHERE rating  >  (SELECT min(rating) FROM Sailors WHERE name  =  'Luis')	boat_1
SELECT name FROM Sailors WHERE rating  >  (SELECT min(rating) FROM Sailors WHERE name  =  'Luis')	boat_1
SELECT name FROM Sailors WHERE rating  >  (SELECT max(rating) FROM Sailors WHERE name  =  'Luis')	boat_1
SELECT name FROM Sailors WHERE rating  >  (SELECT max(rating) FROM Sailors WHERE name  =  'Luis')	boat_1
SELECT DISTINCT T1.name ,  T1.sid FROM Sailors AS T1 JOIN Reserves AS T2 ON T1.sid  =  T2.sid WHERE  T1.rating  >  2	boat_1
SELECT DISTINCT T1.name ,  T1.sid FROM Sailors AS T1 JOIN Reserves AS T2 ON T1.sid  =  T2.sid WHERE  T1.rating  >  2	boat_1
SELECT name ,  age FROM Sailors WHERE age  =  ( SELECT max(age) FROM Sailors )	boat_1
SELECT name ,  age FROM Sailors WHERE age  =  ( SELECT max(age) FROM Sailors )	boat_1
SELECT COUNT(*) FROM Sailors	boat_1
SELECT COUNT(*) FROM Sailors	boat_1
SELECT AVG(age) FROM Sailors WHERE rating  =  7	boat_1
SELECT AVG(age) FROM Sailors WHERE rating  =  7	boat_1
select count(*) from sailors where name like 'd%'	boat_1
select count(*) from sailors where name like 'd%'	boat_1
SELECT AVG(rating) ,  MAX(age) FROM Sailors	boat_1
SELECT AVG(rating) ,  MAX(age) FROM Sailors	boat_1
SELECT bid ,  count(*) FROM Reserves GROUP BY bid	boat_1
SELECT bid ,  count(*) FROM Reserves GROUP BY bid	boat_1
SELECT bid ,  count(*) FROM Reserves GROUP BY bid HAVING bid  >  50	boat_1
SELECT bid ,  count(*) FROM Reserves GROUP BY bid HAVING bid  >  50	boat_1
SELECT bid ,  count(*) FROM Reserves GROUP BY bid HAVING count(*)  >  1	boat_1
SELECT bid ,  count(*) FROM Reserves GROUP BY bid HAVING count(*)  >  1	boat_1
SELECT bid ,  count(*) FROM Reserves WHERE sid  >  1 GROUP BY bid	boat_1
SELECT bid ,  count(*) FROM Reserves WHERE sid  >  1 GROUP BY bid	boat_1
SELECT T1.rating ,  avg(T1.age) FROM Sailors AS T1 JOIN Reserves AS T2 ON T1.sid  =  T2.sid JOIN Boats AS T3 ON T3.bid  =  T2.bid WHERE T3.color  =  'red' GROUP BY T1.rating	boat_1
SELECT T1.rating ,  avg(T1.age) FROM Sailors AS T1 JOIN Reserves AS T2 ON T1.sid  =  T2.sid JOIN Boats AS T3 ON T3.bid  =  T2.bid WHERE T3.color  =  'red' GROUP BY T1.rating	boat_1
SELECT name ,  rating ,  age FROM Sailors ORDER BY rating ,  age	boat_1
SELECT name ,  rating ,  age FROM Sailors ORDER BY rating ,  age	boat_1
SELECT count(*) FROM Boats	boat_1
SELECT count(*) FROM Boats	boat_1
SELECT count(*) FROM Boats WHERE color  =  'red'	boat_1
SELECT count(*) FROM Boats WHERE color  =  'red'	boat_1
SELECT T3.name FROM Sailors AS T1 JOIN Reserves AS T2 ON T1.sid  =  T2.sid JOIN Boats AS T3 ON T3.bid  =  T2.bid WHERE T1.age BETWEEN 20 AND 30	boat_1
SELECT T3.name FROM Sailors AS T1 JOIN Reserves AS T2 ON T1.sid  =  T2.sid JOIN Boats AS T3 ON T3.bid  =  T2.bid WHERE T1.age BETWEEN 20 AND 30	boat_1
SELECT name FROM Sailors WHERE rating  >  (SELECT max(T1.rating) FROM Sailors AS T1 JOIN Reserves AS T2 ON T1.sid  =  T2.sid JOIN Boats AS T3 ON T3.bid  =  T2.bid WHERE T3.color  =  'red')	boat_1
SELECT name FROM Sailors WHERE rating  >  (SELECT max(T1.rating) FROM Sailors AS T1 JOIN Reserves AS T2 ON T1.sid  =  T2.sid JOIN Boats AS T3 ON T3.bid  =  T2.bid WHERE T3.color  =  'red')	boat_1
SELECT max(rating) FROM Sailors	boat_1
SELECT max(rating) FROM Sailors	boat_1
SELECT T1.name FROM Sailors AS T1 JOIN Reserves AS T2 ON T1.sid  =  T2.sid JOIN Boats AS T3 ON T3.bid  =  T2.bid WHERE T3.name  =  'Melon'	boat_1
SELECT T1.name FROM Sailors AS T1 JOIN Reserves AS T2 ON T1.sid  =  T2.sid JOIN Boats AS T3 ON T3.bid  =  T2.bid WHERE T3.name  =  'Melon'	boat_1
SELECT name ,  age FROM Sailors ORDER BY rating DESC	boat_1
SELECT name ,  age FROM Sailors ORDER BY rating DESC	boat_1
SELECT model FROM headphone ORDER BY price DESC LIMIT 1	headphone_store
SELECT model FROM headphone ORDER BY price DESC LIMIT 1	headphone_store
SELECT DISTINCT model FROM headphone ORDER BY model	headphone_store
SELECT DISTINCT model FROM headphone ORDER BY model	headphone_store
SELECT CLASS FROM headphone GROUP BY CLASS ORDER BY count(*) DESC LIMIT 1	headphone_store
SELECT CLASS FROM headphone GROUP BY CLASS ORDER BY count(*) DESC LIMIT 1	headphone_store
SELECT CLASS FROM headphone GROUP BY CLASS HAVING count(*)  >  2	headphone_store
SELECT CLASS FROM headphone GROUP BY CLASS HAVING count(*)  >  2	headphone_store
SELECT count(*) ,  CLASS FROM headphone WHERE price  >  200 GROUP BY CLASS	headphone_store
SELECT count(*) ,  CLASS FROM headphone WHERE price  >  200 GROUP BY CLASS	headphone_store
SELECT count(DISTINCT earpads) FROM headphone	headphone_store
SELECT count(DISTINCT earpads) FROM headphone	headphone_store
SELECT earpads FROM headphone GROUP BY earpads ORDER BY count(*) DESC LIMIT 2	headphone_store
SELECT earpads FROM headphone GROUP BY earpads ORDER BY count(*) DESC LIMIT 2	headphone_store
SELECT model ,  CLASS ,  construction FROM headphone ORDER BY price LIMIT 1	headphone_store
SELECT model ,  CLASS ,  construction FROM headphone ORDER BY price LIMIT 1	headphone_store
SELECT construction ,  avg(price) FROM headphone GROUP BY construction	headphone_store
SELECT construction ,  avg(price) FROM headphone GROUP BY construction	headphone_store
SELECT CLASS FROM headphone WHERE earpads  =  'Bowls' INTERSECT SELECT CLASS FROM headphone WHERE earpads  =  'Comfort Pads'	headphone_store
SELECT CLASS FROM headphone WHERE earpads  =  'Bowls' INTERSECT SELECT CLASS FROM headphone WHERE earpads  =  'Comfort Pads'	headphone_store
SELECT earpads FROM headphone EXCEPT SELECT earpads FROM headphone WHERE construction  =  'Plastic'	headphone_store
SELECT earpads FROM headphone EXCEPT SELECT earpads FROM headphone WHERE construction  =  'Plastic'	headphone_store
SELECT model FROM headphone WHERE price  <  (SELECT avg(price) FROM headphone)	headphone_store
SELECT model FROM headphone WHERE price  <  (SELECT avg(price) FROM headphone)	headphone_store
SELECT name FROM store ORDER BY date_opened	headphone_store
SELECT name FROM store ORDER BY date_opened	headphone_store
SELECT name ,  parking FROM store WHERE neighborhood  =  'Tarzana'	headphone_store
SELECT name ,  parking FROM store WHERE neighborhood  =  'Tarzana'	headphone_store
SELECT count(DISTINCT neighborhood) FROM store	headphone_store
SELECT count(DISTINCT neighborhood) FROM store	headphone_store
SELECT count(*) ,  neighborhood FROM store GROUP BY neighborhood	headphone_store
SELECT count(*) ,  neighborhood FROM store GROUP BY neighborhood	headphone_store
SELECT t1.name ,  sum(t2.quantity) FROM store AS t1 JOIN stock AS t2 ON t1.store_id  =  t2.store_id GROUP BY t2.store_id ORDER BY sum(t2.quantity) DESC LIMIT 1	headphone_store
SELECT t1.name ,  sum(t2.quantity) FROM store AS t1 JOIN stock AS t2 ON t1.store_id  =  t2.store_id GROUP BY t2.store_id ORDER BY sum(t2.quantity) DESC LIMIT 1	headphone_store
SELECT name FROM store WHERE store_id NOT IN (SELECT store_id FROM stock)	headphone_store
SELECT name FROM store WHERE store_id NOT IN (SELECT store_id FROM stock)	headphone_store
SELECT model FROM headphone WHERE headphone_id NOT IN (SELECT headphone_id FROM stock)	headphone_store
SELECT model FROM headphone WHERE headphone_id NOT IN (SELECT headphone_id FROM stock)	headphone_store
SELECT t1.model FROM headphone AS t1 JOIN stock AS t2 ON t1.headphone_id  =  t2.headphone_id GROUP BY t1.model ORDER BY sum(t2.quantity) DESC LIMIT 1	headphone_store
SELECT t1.model FROM headphone AS t1 JOIN stock AS t2 ON t1.headphone_id  =  t2.headphone_id GROUP BY t1.model ORDER BY sum(t2.quantity) DESC LIMIT 1	headphone_store
SELECT sum(t2.quantity) FROM store AS t1 JOIN stock AS t2 ON t1.store_id  =  t2.store_id WHERE t1.name  =  'Woodman'	headphone_store
SELECT sum(t2.quantity) FROM store AS t1 JOIN stock AS t2 ON t1.store_id  =  t2.store_id WHERE t1.name  =  'Woodman'	headphone_store
SELECT Neighborhood FROM store EXCEPT SELECT t1.Neighborhood FROM store AS t1 JOIN stock AS t2 ON t1.store_id  =  t2.store_id	headphone_store
SELECT Neighborhood FROM store EXCEPT SELECT t1.Neighborhood FROM store AS t1 JOIN stock AS t2 ON t1.store_id  =  t2.store_id	headphone_store
SELECT count(*) FROM Author	aan_1
SELECT count(*) FROM Author	aan_1
SELECT count(*) FROM Paper	aan_1
SELECT count(*) FROM Paper	aan_1
SELECT count(*) FROM Affiliation	aan_1
SELECT count(*) FROM Affiliation	aan_1
SELECT count(*) FROM Paper WHERE venue  =  "NAACL" AND YEAR  =  2000	aan_1
SELECT count(*) FROM Paper WHERE venue  =  "NAACL" AND YEAR  =  2000	aan_1
SELECT count(DISTINCT T1.paper_id) FROM Paper AS T1 JOIN Author_list AS T2 ON T1.paper_id  =  T2.paper_id JOIN Affiliation AS T3 ON T2.affiliation_id  =  T3.affiliation_id WHERE T3.name LIKE "Columbia University" AND T1.year  =  2009	aan_1
SELECT count(DISTINCT T1.paper_id) FROM Paper AS T1 JOIN Author_list AS T2 ON T1.paper_id  =  T2.paper_id JOIN Affiliation AS T3 ON T2.affiliation_id  =  T3.affiliation_id WHERE T3.name LIKE "Columbia University" AND T1.year  =  2009	aan_1
SELECT DISTINCT name ,  address FROM Affiliation	aan_1
SELECT DISTINCT name ,  address FROM Affiliation	aan_1
SELECT DISTINCT venue ,  YEAR FROM paper ORDER BY YEAR	aan_1
SELECT DISTINCT venue ,  YEAR FROM paper ORDER BY YEAR	aan_1
SELECT DISTINCT T1.title ,  T1.paper_id FROM Paper AS T1 JOIN Author_list AS T2 ON T1.paper_id  =  T2.paper_id JOIN Affiliation AS T3 ON T2.affiliation_id  =  T3.affiliation_id WHERE T3.name  =  "Harvard University"	aan_1
SELECT DISTINCT T1.title ,  T1.paper_id FROM Paper AS T1 JOIN Author_list AS T2 ON T1.paper_id  =  T2.paper_id JOIN Affiliation AS T3 ON T2.affiliation_id  =  T3.affiliation_id WHERE T3.name  =  "Harvard University"	aan_1
SELECT T1.title ,  T1.paper_id FROM Paper AS T1 JOIN Author_list AS T2 ON T1.paper_id  =  T2.paper_id JOIN Author AS T3 ON T3.author_id  =  T2.author_id WHERE T3.name LIKE "%Mckeown%"	aan_1
SELECT T1.title ,  T1.paper_id FROM Paper AS T1 JOIN Author_list AS T2 ON T1.paper_id  =  T2.paper_id JOIN Author AS T3 ON T3.author_id  =  T2.author_id WHERE T3.name LIKE "%Mckeown%"	aan_1
SELECT T1.title ,  T1.paper_id FROM Paper AS T1 JOIN Author_list AS T2 ON T1.paper_id  =  T2.paper_id JOIN Affiliation AS T3 ON T2.affiliation_id  =  T3.affiliation_id WHERE T3.name LIKE "Stanford University" INTERSECT SELECT T1.title ,  T1.paper_id FROM Paper AS T1 JOIN Author_list AS T2 ON T1.paper_id  =  T2.paper_id JOIN Affiliation AS T3 ON T2.affiliation_id  =  T3.affiliation_id WHERE T3.name LIKE "Columbia University"	aan_1
SELECT T1.title ,  T1.paper_id FROM Paper AS T1 JOIN Author_list AS T2 ON T1.paper_id  =  T2.paper_id JOIN Affiliation AS T3 ON T2.affiliation_id  =  T3.affiliation_id WHERE T3.name LIKE "Stanford University" INTERSECT SELECT T1.title ,  T1.paper_id FROM Paper AS T1 JOIN Author_list AS T2 ON T1.paper_id  =  T2.paper_id JOIN Affiliation AS T3 ON T2.affiliation_id  =  T3.affiliation_id WHERE T3.name LIKE "Columbia University"	aan_1
SELECT T1.title ,  T1.paper_id FROM Paper AS T1 JOIN Author_list AS T2 ON T1.paper_id  =  T2.paper_id JOIN Author AS T3 ON T2.author_id  =  T3.author_id WHERE T3.name LIKE "%Mckeown ,  Kathleen%" INTERSECT SELECT T1.title ,  T1.paper_id FROM Paper AS T1 JOIN Author_list AS T2 ON T1.paper_id  =  T2.paper_id JOIN Author AS T3 ON T2.author_id  =  T3.author_id WHERE T3.name LIKE "%Rambow ,  Owen%"	aan_1
SELECT T1.title ,  T1.paper_id FROM Paper AS T1 JOIN Author_list AS T2 ON T1.paper_id  =  T2.paper_id JOIN Author AS T3 ON T2.author_id  =  T3.author_id WHERE T3.name LIKE "%Mckeown ,  Kathleen%" INTERSECT SELECT T1.title ,  T1.paper_id FROM Paper AS T1 JOIN Author_list AS T2 ON T1.paper_id  =  T2.paper_id JOIN Author AS T3 ON T2.author_id  =  T3.author_id WHERE T3.name LIKE "%Rambow ,  Owen%"	aan_1
SELECT T1.title ,  T1.paper_id FROM Paper AS T1 JOIN Author_list AS T2 ON T1.paper_id  =  T2.paper_id JOIN Author AS T3 ON T2.author_id  =  T3.author_id WHERE T3.name LIKE "%Mckeown%" EXCEPT SELECT T1.title ,  T1.paper_id FROM Paper AS T1 JOIN Author_list AS T2 ON T1.paper_id  =  T2.paper_id JOIN Author AS T3 ON T2.author_id  =  T3.author_id WHERE T3.name LIKE "%Rambow%"	aan_1
SELECT T1.title ,  T1.paper_id FROM Paper AS T1 JOIN Author_list AS T2 ON T1.paper_id  =  T2.paper_id JOIN Author AS T3 ON T2.author_id  =  T3.author_id WHERE T3.name LIKE "%Mckeown%" EXCEPT SELECT T1.title ,  T1.paper_id FROM Paper AS T1 JOIN Author_list AS T2 ON T1.paper_id  =  T2.paper_id JOIN Author AS T3 ON T2.author_id  =  T3.author_id WHERE T3.name LIKE "%Rambow%"	aan_1
SELECT DISTINCT T1.title ,  T1.paper_id FROM Paper AS T1 JOIN Author_list AS T2 ON T1.paper_id  =  T2.paper_id JOIN Author AS T3 ON T2.author_id  =  T3.author_id WHERE  T3.name LIKE "%Mckeown ,  Kathleen%" OR T3.name LIKE "%Rambow ,  Owen%"	aan_1
SELECT DISTINCT T1.title ,  T1.paper_id FROM Paper AS T1 JOIN Author_list AS T2 ON T1.paper_id  =  T2.paper_id JOIN Author AS T3 ON T2.author_id  =  T3.author_id WHERE  T3.name LIKE "%Mckeown ,  Kathleen%" OR T3.name LIKE "%Rambow ,  Owen%"	aan_1
SELECT T1.name ,  count(*) FROM Author AS T1 JOIN Author_list AS T2 ON T1.author_id  =  T2.author_id GROUP BY T1.author_id ORDER BY count(*) DESC	aan_1
SELECT T1.name ,  count(*) FROM Author AS T1 JOIN Author_list AS T2 ON T1.author_id  =  T2.author_id GROUP BY T1.author_id ORDER BY count(*) DESC	aan_1
SELECT T1.name FROM Affiliation AS T1 JOIN Author_list AS T2 ON T1.affiliation_id  =  T2.affiliation_id GROUP BY T1.affiliation_id ORDER BY count(*) DESC	aan_1
SELECT T1.name FROM Affiliation AS T1 JOIN Author_list AS T2 ON T1.affiliation_id  =  T2.affiliation_id GROUP BY T1.affiliation_id ORDER BY count(*) DESC	aan_1
SELECT T1.name FROM Author AS T1 JOIN Author_list AS T2 ON T1.author_id  =  T2.author_id GROUP BY T1.author_id HAVING count(*)  >  50	aan_1
SELECT T1.name FROM Author AS T1 JOIN Author_list AS T2 ON T1.author_id  =  T2.author_id GROUP BY T1.author_id HAVING count(*)  >  50	aan_1
SELECT T1.name FROM Author AS T1 JOIN Author_list AS T2 ON T1.author_id  =  T2.author_id GROUP BY T1.author_id HAVING count(*)  =  1	aan_1
SELECT T1.name FROM Author AS T1 JOIN Author_list AS T2 ON T1.author_id  =  T2.author_id GROUP BY T1.author_id HAVING count(*)  =  1	aan_1
SELECT venue ,  YEAR FROM paper GROUP BY venue ,  YEAR ORDER BY count(*) DESC LIMIT 1	aan_1
SELECT venue ,  YEAR FROM paper GROUP BY venue ,  YEAR ORDER BY count(*) DESC LIMIT 1	aan_1
SELECT venue FROM paper GROUP BY venue ORDER BY count(*) LIMIT 1	aan_1
SELECT venue FROM paper GROUP BY venue ORDER BY count(*) LIMIT 1	aan_1
SELECT count(*) FROM Citation WHERE cited_paper_id  =  "A00-1002"	aan_1
SELECT count(*) FROM Citation WHERE cited_paper_id  =  "A00-1002"	aan_1
SELECT count(*) FROM Citation WHERE paper_id  =  "D12-1027"	aan_1
SELECT count(*) FROM Citation WHERE paper_id  =  "D12-1027"	aan_1
SELECT paper_id ,  count(*) FROM Citation GROUP BY cited_paper_id ORDER BY count(*) DESC LIMIT 1	aan_1
SELECT paper_id ,  count(*) FROM Citation GROUP BY cited_paper_id ORDER BY count(*) DESC LIMIT 1	aan_1
SELECT T2.title FROM Citation AS T1 JOIN Paper AS T2 ON T2.paper_id  =  T1.paper_id GROUP BY T1.paper_id ORDER BY count(*) DESC LIMIT 1	aan_1
SELECT T2.title FROM Citation AS T1 JOIN Paper AS T2 ON T2.paper_id  =  T1.paper_id GROUP BY T1.paper_id ORDER BY count(*) DESC LIMIT 1	aan_1
SELECT paper_id ,  count(*) FROM Citation GROUP BY cited_paper_id ORDER BY count(*) DESC LIMIT 10	aan_1
SELECT paper_id ,  count(*) FROM Citation GROUP BY cited_paper_id ORDER BY count(*) DESC LIMIT 10	aan_1
select count(*) from citation as t1 join author_list as t2 on t1.cited_paper_id  =  t2.paper_id join author as t3 on t2.author_id  =  t3.author_id where t3.name = "mckeown ,  kathleen"	aan_1
select count(*) from citation as t1 join author_list as t2 on t1.cited_paper_id  =  t2.paper_id join author as t3 on t2.author_id  =  t3.author_id where t3.name = "mckeown ,  kathleen"	aan_1
select count(*) from citation as t1 join author_list as t2 on t1.paper_id  =  t2.paper_id join author as t3 on t2.author_id  =  t3.author_id where t3.name = "mckeown ,  kathleen"	aan_1
select count(*) from citation as t1 join author_list as t2 on t1.paper_id  =  t2.paper_id join author as t3 on t2.author_id  =  t3.author_id where t3.name = "mckeown ,  kathleen"	aan_1
SELECT T3.name ,  count(*) FROM Citation AS T1 JOIN Author_list AS T2 ON T1.cited_paper_id  =  T2.paper_id JOIN Author AS T3 ON T2.author_id  =  T3.author_id GROUP BY T2.author_id ORDER BY count(*) DESC LIMIT 1	aan_1
SELECT T3.name ,  count(*) FROM Citation AS T1 JOIN Author_list AS T2 ON T1.cited_paper_id  =  T2.paper_id JOIN Author AS T3 ON T2.author_id  =  T3.author_id GROUP BY T2.author_id ORDER BY count(*) DESC LIMIT 1	aan_1
select distinct t1.venue ,  t1.year from paper as t1 join author_list as t2 on t1.paper_id  =  t2.paper_id join author as t3 on t2.author_id  =  t3.author_id where t3.name = "mckeown ,  kathleen"	aan_1
select distinct t1.venue ,  t1.year from paper as t1 join author_list as t2 on t1.paper_id  =  t2.paper_id join author as t3 on t2.author_id  =  t3.author_id where t3.name = "mckeown ,  kathleen"	aan_1
select distinct t1.venue ,  t1.year from paper as t1 join author_list as t2 on t1.paper_id  =  t2.paper_id join affiliation as t3 on t2.affiliation_id  =  t3.affiliation_id where t3.name = "columbia university"	aan_1
select distinct t1.venue ,  t1.year from paper as t1 join author_list as t2 on t1.paper_id  =  t2.paper_id join affiliation as t3 on t2.affiliation_id  =  t3.affiliation_id where t3.name = "columbia university"	aan_1
SELECT T3.name FROM Paper AS T1 JOIN Author_list AS T2 ON T1.paper_id  =  T2.paper_id JOIN Author AS T3 ON T3.author_id  =  T2.author_id WHERE T1.year  =  2009 GROUP BY T2.author_id ORDER BY count(*) DESC LIMIT 1	aan_1
SELECT T3.name FROM Paper AS T1 JOIN Author_list AS T2 ON T1.paper_id  =  T2.paper_id JOIN Author AS T3 ON T3.author_id  =  T2.author_id WHERE T1.year  =  2009 GROUP BY T2.author_id ORDER BY count(*) DESC LIMIT 1	aan_1
SELECT T3.name FROM Paper AS T1 JOIN Author_list AS T2 ON T1.paper_id  =  T2.paper_id JOIN Affiliation AS T3 ON T2.affiliation_id  =  T3.affiliation_id WHERE T1.year  =  2009 GROUP BY T2.affiliation_id ORDER BY count(*) DESC LIMIT 3	aan_1
SELECT T3.name FROM Paper AS T1 JOIN Author_list AS T2 ON T1.paper_id  =  T2.paper_id JOIN Affiliation AS T3 ON T2.affiliation_id  =  T3.affiliation_id WHERE T1.year  =  2009 GROUP BY T2.affiliation_id ORDER BY count(*) DESC LIMIT 3	aan_1
select count(distinct t1.paper_id) from paper as t1 join author_list as t2 on t1.paper_id  =  t2.paper_id join affiliation as t3 on t2.affiliation_id  =  t3.affiliation_id where t1.year  <=  2009 and t3.name = "columbia university"	aan_1
select count(distinct t1.paper_id) from paper as t1 join author_list as t2 on t1.paper_id  =  t2.paper_id join affiliation as t3 on t2.affiliation_id  =  t3.affiliation_id where t1.year  <=  2009 and t3.name = "columbia university"	aan_1
SELECT count(DISTINCT T1.paper_id) FROM Paper AS T1 JOIN Author_list AS T2 ON T1.paper_id  =  T2.paper_id JOIN Affiliation AS T3 ON T2.affiliation_id  =  T3.affiliation_id WHERE T1.year  >=  2000 AND T1.year  <=  2009 AND T3.name LIKE "Stanford University"	aan_1
SELECT count(DISTINCT T1.paper_id) FROM Paper AS T1 JOIN Author_list AS T2 ON T1.paper_id  =  T2.paper_id JOIN Affiliation AS T3 ON T2.affiliation_id  =  T3.affiliation_id WHERE T1.year  >=  2000 AND T1.year  <=  2009 AND T3.name LIKE "Stanford University"	aan_1
SELECT T2.title FROM Author_list AS T1 JOIN Paper AS T2 ON T1.paper_id  =  T2.paper_id GROUP BY T2.paper_id ORDER BY count(*) DESC LIMIT 1	aan_1
SELECT T2.title FROM Author_list AS T1 JOIN Paper AS T2 ON T1.paper_id  =  T2.paper_id GROUP BY T2.paper_id ORDER BY count(*) DESC LIMIT 1	aan_1
select count (distinct t2.author_id) from author_list as t1 join author_list as t2 on t1.paper_id  =  t2.paper_id and t1.author_id != t2.author_id join author as t3 on t1.author_id  =  t3.author_id where t3.name = "mckeown ,  kathleen"	aan_1
select count (distinct t2.author_id) from author_list as t1 join author_list as t2 on t1.paper_id  =  t2.paper_id and t1.author_id != t2.author_id join author as t3 on t1.author_id  =  t3.author_id where t3.name = "mckeown ,  kathleen"	aan_1
select t4.name from author_list as t1 join author_list as t2 on t1.paper_id  =  t2.paper_id and t1.author_id != t2.author_id join author as t3 on t1.author_id  =  t3.author_id join author as t4 on t2.author_id  =  t4.author_id where t3.name = "mckeown ,  kathleen" group by t2.author_id order by count(*) desc limit 1	aan_1
select t4.name from author_list as t1 join author_list as t2 on t1.paper_id  =  t2.paper_id and t1.author_id != t2.author_id join author as t3 on t1.author_id  =  t3.author_id join author as t4 on t2.author_id  =  t4.author_id where t3.name = "mckeown ,  kathleen" group by t2.author_id order by count(*) desc limit 1	aan_1
SELECT paper_id FROM Paper WHERE title LIKE "%translation%"	aan_1
SELECT paper_id FROM Paper WHERE title LIKE "%translation%"	aan_1
SELECT paper_id ,  title FROM Paper WHERE paper_id NOT IN (SELECT cited_paper_id FROM Citation)	aan_1
SELECT paper_id ,  title FROM Paper WHERE paper_id NOT IN (SELECT cited_paper_id FROM Citation)	aan_1
SELECT T1.name FROM Affiliation AS T1 JOIN Author_list AS T2 ON T1.affiliation_id  =  T2.affiliation_id WHERE T1.address LIKE "%China%" GROUP BY T1.affiliation_id ORDER BY count(*) DESC LIMIT 1	aan_1
SELECT T1.name FROM Affiliation AS T1 JOIN Author_list AS T2 ON T1.affiliation_id  =  T2.affiliation_id WHERE T1.address LIKE "%China%" GROUP BY T1.affiliation_id ORDER BY count(*) DESC LIMIT 1	aan_1
SELECT count(*) ,  venue ,  YEAR FROM Paper GROUP BY venue ,  YEAR	aan_1
SELECT count(*) ,  venue ,  YEAR FROM Paper GROUP BY venue ,  YEAR	aan_1
SELECT count(DISTINCT T2.paper_id) ,  T1.name FROM Affiliation AS T1 JOIN Author_list AS T2 ON T1.affiliation_id  =  T2.affiliation_id GROUP BY T1.affiliation_id	aan_1
SELECT count(DISTINCT T2.paper_id) ,  T1.name FROM Affiliation AS T1 JOIN Author_list AS T2 ON T1.affiliation_id  =  T2.affiliation_id GROUP BY T1.affiliation_id	aan_1
SELECT T2.title FROM Citation AS T1 JOIN Paper AS T2 ON T1.cited_paper_id  =  T2.paper_id GROUP BY T1.cited_paper_id HAVING count(*)  >  50	aan_1
SELECT T2.title FROM Citation AS T1 JOIN Paper AS T2 ON T1.cited_paper_id  =  T2.paper_id GROUP BY T1.cited_paper_id HAVING count(*)  >  50	aan_1
SELECT count(*) FROM Author WHERE Author_id NOT IN ( SELECT T2.author_id FROM Citation AS T1 JOIN Author_list AS T2 ON T1.cited_paper_id  =  T2.paper_id GROUP BY T1.cited_paper_id HAVING count(DISTINCT T1.paper_id)  >  50)	aan_1
SELECT count(*) FROM Author WHERE Author_id NOT IN ( SELECT T2.author_id FROM Citation AS T1 JOIN Author_list AS T2 ON T1.cited_paper_id  =  T2.paper_id GROUP BY T1.cited_paper_id HAVING count(DISTINCT T1.paper_id)  >  50)	aan_1
SELECT name FROM Author WHERE author_id IN (SELECT T1.author_id FROM Author_list AS T1 JOIN Paper AS T2 ON T1.paper_id  =  T2.paper_id WHERE T2.venue  =  "ACL" AND T2.year  =  2009 INTERSECT SELECT T1.author_id FROM Author_list AS T1 JOIN Paper AS T2 ON T1.paper_id  =  T2.paper_id WHERE T2.venue  =  "NAACL" AND T2.year  =  2009)	aan_1
SELECT name FROM Author WHERE author_id IN (SELECT T1.author_id FROM Author_list AS T1 JOIN Paper AS T2 ON T1.paper_id  =  T2.paper_id WHERE T2.venue  =  "ACL" AND T2.year  =  2009 INTERSECT SELECT T1.author_id FROM Author_list AS T1 JOIN Paper AS T2 ON T1.paper_id  =  T2.paper_id WHERE T2.venue  =  "NAACL" AND T2.year  =  2009)	aan_1
SELECT name FROM Author WHERE author_id NOT IN (SELECT T1.author_id FROM Author_list AS T1 JOIN Paper AS T2 ON T1.paper_id  =  T2.paper_id WHERE T2.venue  =  "ACL")	aan_1
SELECT name FROM Author WHERE author_id NOT IN (SELECT T1.author_id FROM Author_list AS T1 JOIN Paper AS T2 ON T1.paper_id  =  T2.paper_id WHERE T2.venue  =  "ACL")	aan_1
SELECT count(*) FROM conference	conference
SELECT count(*) FROM conference	conference
SELECT DISTINCT conference_name FROM conference	conference
SELECT DISTINCT conference_name FROM conference	conference
SELECT conference_name ,  YEAR ,  LOCATION FROM conference	conference
SELECT conference_name ,  YEAR ,  LOCATION FROM conference	conference
SELECT conference_name ,  count(*) FROM conference GROUP BY conference_name	conference
SELECT conference_name ,  count(*) FROM conference GROUP BY conference_name	conference
SELECT YEAR ,  count(*) FROM conference GROUP BY YEAR	conference
SELECT YEAR ,  count(*) FROM conference GROUP BY YEAR	conference
SELECT YEAR FROM conference GROUP BY YEAR ORDER BY count(*) LIMIT 1	conference
SELECT YEAR FROM conference GROUP BY YEAR ORDER BY count(*) LIMIT 1	conference
SELECT LOCATION FROM conference GROUP BY LOCATION HAVING count(*)  >=  2	conference
SELECT LOCATION FROM conference GROUP BY LOCATION HAVING count(*)  >=  2	conference
SELECT institution_name ,  LOCATION ,  founded FROM institution	conference
SELECT institution_name ,  LOCATION ,  founded FROM institution	conference
SELECT count(*) FROM institution WHERE founded BETWEEN 1850 AND 1900	conference
SELECT count(*) FROM institution WHERE founded BETWEEN 1850 AND 1900	conference
SELECT institution_name ,  LOCATION FROM institution ORDER BY founded DESC LIMIT 1	conference
SELECT institution_name ,  LOCATION FROM institution ORDER BY founded DESC LIMIT 1	conference
SELECT T1.institution_name ,  count(*) FROM institution AS T1 JOIN staff AS T2 ON T1.institution_id  =  T2.institution_id WHERE T1.founded  >  1800 GROUP BY T2.institution_id	conference
select t1.institution_name ,  count(*) from institution as t1 join staff as t2 on t1.institution_id  =  t2.institution_id where t1.founded  >  1800 group by t2.institution_id	conference
SELECT institution_name FROM institution WHERE institution_id NOT IN (SELECT institution_id FROM staff)	conference
SELECT institution_name FROM institution WHERE institution_id NOT IN (SELECT institution_id FROM staff)	conference
SELECT name FROM staff WHERE age  >  (SELECT avg(age) FROM staff)	conference
SELECT name FROM staff WHERE age  >  (SELECT avg(age) FROM staff)	conference
SELECT max(age) ,  min(age) FROM staff	conference
SELECT max(age) ,  min(age) FROM staff	conference
SELECT T1.conference_name FROM conference AS T1 JOIN conference_participation AS T2 ON T1.conference_id = T2.conference_id JOIN staff AS T3 ON T2.staff_id  =  T3.staff_id WHERE T3.nationality  =  "Canada"	conference
SELECT T1.conference_name FROM conference AS T1 JOIN conference_participation AS T2 ON T1.conference_id = T2.conference_id JOIN staff AS T3 ON T2.staff_id  =  T3.staff_id WHERE T3.nationality  =  "Canada"	conference
SELECT T1.name FROM staff AS T1 JOIN conference_participation AS T2 ON T1.staff_id  =  T2.staff_id WHERE T2.role  =  'Speaker' INTERSECT SELECT T1.name FROM staff AS T1 JOIN conference_participation AS T2 ON T1.staff_id  =  T2.staff_id WHERE T2.role  =  'Sponsor'	conference
SELECT T1.name FROM staff AS T1 JOIN conference_participation AS T2 ON T1.staff_id  =  T2.staff_id WHERE T2.role  =  'Speaker' INTERSECT SELECT T1.name FROM staff AS T1 JOIN conference_participation AS T2 ON T1.staff_id  =  T2.staff_id WHERE T2.role  =  'Sponsor'	conference
SELECT T1.name FROM staff AS T1 JOIN conference_participation AS T2 JOIN Conference AS T3 ON T1.staff_id  =  T2.staff_id AND T2.conference_id  =  T3.conference_id WHERE T3.Conference_name  =  'ACL' INTERSECT SELECT T1.name FROM staff AS T1 JOIN conference_participation AS T2 JOIN conference AS T3 ON T1.staff_id  =  T2.staff_id AND T2.conference_id  =  T3.conference_id WHERE T3.Conference_name  =  'Naccl'	conference
SELECT T1.name FROM staff AS T1 JOIN conference_participation AS T2 JOIN Conference AS T3 ON T1.staff_id  =  T2.staff_id AND T2.conference_id  =  T3.conference_id WHERE T3.Conference_name  =  'ACL' INTERSECT SELECT T1.name FROM staff AS T1 JOIN conference_participation AS T2 JOIN conference AS T3 ON T1.staff_id  =  T2.staff_id AND T2.conference_id  =  T3.conference_id WHERE T3.Conference_name  =  'Naccl'	conference
SELECT DISTINCT T1.name FROM staff AS T1 JOIN conference_participation AS T2 JOIN Conference AS T3 ON T1.staff_id  =  T2.staff_id AND T2.conference_id  =  T3.conference_id WHERE T3.year  =  2003 OR T3.year  =  2004	conference
SELECT DISTINCT T1.name FROM staff AS T1 JOIN conference_participation AS T2 JOIN Conference AS T3 ON T1.staff_id  =  T2.staff_id AND T2.conference_id  =  T3.conference_id WHERE T3.year  =  2003 OR T3.year  =  2004	conference
SELECT T1.conference_name ,  T1.year ,  count(*) FROM Conference AS T1 JOIN Conference_participation AS T2 ON T1.conference_id  =  T2.conference_id GROUP BY T2.conference_id	conference
SELECT T1.conference_name ,  T1.year ,  count(*) FROM Conference AS T1 JOIN Conference_participation AS T2 ON T1.conference_id  =  T2.conference_id GROUP BY T2.conference_id	conference
SELECT T1.conference_name FROM Conference AS T1 JOIN Conference_participation AS T2 ON T1.conference_id  =  T2.conference_id GROUP BY T2.conference_id ORDER BY count(*) DESC LIMIT 2	conference
SELECT T1.conference_name FROM Conference AS T1 JOIN Conference_participation AS T2 ON T1.conference_id  =  T2.conference_id GROUP BY T2.conference_id ORDER BY count(*) DESC LIMIT 2	conference
SELECT name ,  nationality FROM staff WHERE staff_id NOT IN (SELECT T2.staff_id FROM Conference AS T1 JOIN Conference_participation AS T2 ON T1.conference_id  =  T2.conference_id WHERE T1.Conference_Name  =  "ACL")	conference
SELECT name ,  nationality FROM staff WHERE staff_id NOT IN (SELECT T2.staff_id FROM Conference AS T1 JOIN Conference_participation AS T2 ON T1.conference_id  =  T2.conference_id WHERE T1.Conference_Name  =  "ACL")	conference
SELECT T1.Institution_Name ,  T1.location FROM institution AS T1 JOIN staff AS T2 ON T1.institution_id  =  T2.institution_id WHERE T2.staff_id NOT IN (SELECT T4.staff_id FROM Conference AS T3 JOIN Conference_participation AS T4 ON T3.conference_id  =  T4.conference_id WHERE T3.year  =  2004)	conference
SELECT T1.Institution_Name ,  T1.location FROM institution AS T1 JOIN staff AS T2 ON T1.institution_id  =  T2.institution_id WHERE T2.staff_id NOT IN (SELECT T4.staff_id FROM Conference AS T3 JOIN Conference_participation AS T4 ON T3.conference_id  =  T4.conference_id WHERE T3.year  =  2004)	conference
SELECT pilot_name FROM PilotSkills ORDER BY age DESC LIMIT 1	pilot_1
SELECT pilot_name FROM PilotSkills ORDER BY age DESC LIMIT 1	pilot_1
SELECT pilot_name FROM PilotSkills WHERE age  <  (SELECT avg(age) FROM PilotSkills) ORDER BY age	pilot_1
SELECT pilot_name FROM PilotSkills WHERE age  <  (SELECT avg(age) FROM PilotSkills) ORDER BY age	pilot_1
SELECT * FROM PilotSkills WHERE age  <  30	pilot_1
select * from pilotskills where age  <  30	pilot_1
SELECT pilot_name FROM PilotSkills WHERE age  <  35 AND plane_name  =  'Piper Cub'	pilot_1
SELECT pilot_name FROM PilotSkills WHERE age  <  35 AND plane_name  =  'Piper Cub'	pilot_1
SELECT LOCATION FROM hangar WHERE plane_name  =  'F-14 Fighter'	pilot_1
SELECT LOCATION FROM hangar WHERE plane_name  =  'F-14 Fighter'	pilot_1
SELECT count(DISTINCT LOCATION) FROM hangar	pilot_1
SELECT count(DISTINCT LOCATION) FROM hangar	pilot_1
SELECT plane_name FROM pilotskills WHERE pilot_name  =  'Jones'  AND age  =  32	pilot_1
SELECT plane_name FROM pilotskills WHERE pilot_name  =  'Jones'  AND age  =  32	pilot_1
SELECT count(*) FROM pilotskills WHERE age  >  40	pilot_1
SELECT count(*) FROM pilotskills WHERE age  >  40	pilot_1
SELECT count(*) FROM pilotskills WHERE age  <  35 AND plane_name  =  'B-52 Bomber'	pilot_1
SELECT count(*) FROM pilotskills WHERE age  <  35 AND plane_name  =  'B-52 Bomber'	pilot_1
SELECT pilot_name FROM pilotskills WHERE plane_name  =  'Piper Cub' ORDER BY age LIMIT 1	pilot_1
SELECT pilot_name FROM pilotskills WHERE plane_name  =  'Piper Cub' ORDER BY age LIMIT 1	pilot_1
SELECT plane_name FROM pilotskills GROUP BY plane_name ORDER BY count(*) DESC LIMIT 1	pilot_1
SELECT plane_name FROM pilotskills GROUP BY plane_name ORDER BY count(*) DESC LIMIT 1	pilot_1
SELECT plane_name FROM pilotskills GROUP BY plane_name ORDER BY count(*) LIMIT 1	pilot_1
SELECT plane_name FROM pilotskills GROUP BY plane_name ORDER BY count(*) LIMIT 1	pilot_1
SELECT count(DISTINCT T1.pilot_name) FROM pilotskills AS T1 JOIN hangar AS T2 ON T1.plane_name  =  T2.plane_name WHERE T2.location  =  'Chicago'	pilot_1
SELECT count(DISTINCT T1.pilot_name) FROM pilotskills AS T1 JOIN hangar AS T2 ON T1.plane_name  =  T2.plane_name WHERE T2.location  =  'Chicago'	pilot_1
SELECT plane_name FROM pilotskills WHERE pilot_name  =  'Smith' AND age  =  41	pilot_1
SELECT plane_name FROM pilotskills WHERE pilot_name  =  'Smith' AND age  =  41	pilot_1
SELECT count(DISTINCT plane_name) FROM pilotskills	pilot_1
SELECT count(DISTINCT plane_name) FROM pilotskills	pilot_1
SELECT count(plane_name) FROM pilotskills WHERE pilot_name  =  'Smith'	pilot_1
SELECT count(plane_name) FROM pilotskills WHERE pilot_name  =  'Smith'	pilot_1
SELECT count(plane_name) FROM pilotskills WHERE age  >  40	pilot_1
SELECT count(plane_name) FROM pilotskills WHERE age  >  40	pilot_1
SELECT pilot_name FROM pilotskills WHERE age BETWEEN 30 AND 40 ORDER BY age	pilot_1
SELECT pilot_name FROM pilotskills WHERE age BETWEEN 30 AND 40 ORDER BY age	pilot_1
SELECT pilot_name FROM pilotskills ORDER BY age DESC	pilot_1
SELECT pilot_name FROM pilotskills ORDER BY age DESC	pilot_1
SELECT LOCATION FROM hangar ORDER BY plane_name	pilot_1
SELECT LOCATION FROM hangar ORDER BY plane_name	pilot_1
SELECT DISTINCT plane_name FROM pilotskills ORDER BY plane_name	pilot_1
SELECT DISTINCT plane_name FROM pilotskills ORDER BY plane_name	pilot_1
SELECT count(pilot_name) FROM pilotskills ORDER BY age  >  40 OR age  <  30	pilot_1
SELECT count(pilot_name) FROM pilotskills ORDER BY age  >  40 OR age  <  30	pilot_1
SELECT pilot_name ,  age FROM pilotskills WHERE plane_name  =  'Piper Cub' AND age  >  35 UNION SELECT pilot_name ,  age FROM pilotskills WHERE plane_name  =  'F-14 Fighter' AND age  <  30	pilot_1
SELECT pilot_name ,  age FROM pilotskills WHERE plane_name  =  'Piper Cub' AND age  >  35 UNION SELECT pilot_name ,  age FROM pilotskills WHERE plane_name  =  'F-14 Fighter' AND age  <  30	pilot_1
SELECT pilot_name FROM pilotskills WHERE plane_name  =  'Piper Cub' EXCEPT SELECT pilot_name FROM pilotskills WHERE plane_name  =  'B-52 Bomber'	pilot_1
SELECT pilot_name FROM pilotskills WHERE plane_name  =  'Piper Cub' EXCEPT SELECT pilot_name FROM pilotskills WHERE plane_name  =  'B-52 Bomber'	pilot_1
SELECT pilot_name FROM pilotskills WHERE plane_name  =  'Piper Cub' INTERSECT SELECT pilot_name FROM pilotskills WHERE plane_name  =  'B-52 Bomber'	pilot_1
SELECT pilot_name FROM pilotskills WHERE plane_name  =  'Piper Cub' INTERSECT SELECT pilot_name FROM pilotskills WHERE plane_name  =  'B-52 Bomber'	pilot_1
SELECT avg(age) ,  min(age) FROM pilotskills	pilot_1
SELECT avg(age) ,  min(age) FROM pilotskills	pilot_1
SELECT T1.pilot_name FROM pilotskills AS T1 JOIN hangar AS T2 ON T1.plane_name  =  T2.plane_name WHERE T2.location  =  "Austin" INTERSECT SELECT T1.pilot_name FROM pilotskills AS T1 JOIN hangar AS T2 ON T1.plane_name  =  T2.plane_name WHERE T2.LOCATION  =  "Boston"	pilot_1
SELECT T1.pilot_name FROM pilotskills AS T1 JOIN hangar AS T2 ON T1.plane_name  =  T2.plane_name WHERE T2.location  =  "Austin" INTERSECT SELECT T1.pilot_name FROM pilotskills AS T1 JOIN hangar AS T2 ON T1.plane_name  =  T2.plane_name WHERE T2.LOCATION  =  "Boston"	pilot_1
SELECT pilot_name FROM pilotskills WHERE plane_name  =  'Piper Cub' OR plane_name  =  'F-14 Fighter'	pilot_1
SELECT pilot_name FROM pilotskills WHERE plane_name  =  'Piper Cub' OR plane_name  =  'F-14 Fighter'	pilot_1
SELECT avg(age) ,  plane_name FROM pilotskills GROUP BY plane_name	pilot_1
SELECT avg(age) ,  plane_name FROM pilotskills GROUP BY plane_name	pilot_1
SELECT count(*) ,  plane_name FROM pilotskills GROUP BY plane_name	pilot_1
SELECT count(*) ,  plane_name FROM pilotskills GROUP BY plane_name	pilot_1
SELECT pilot_name ,  plane_name ,  max(age) FROM pilotskills GROUP BY plane_name ORDER BY plane_name	pilot_1
SELECT pilot_name ,  plane_name ,  max(age) FROM pilotskills GROUP BY plane_name ORDER BY plane_name	pilot_1
SELECT pilot_name ,  plane_name ,  max(age) FROM pilotskills GROUP BY plane_name	pilot_1
SELECT pilot_name ,  plane_name ,  max(age) FROM pilotskills GROUP BY plane_name	pilot_1
SELECT max(age) ,  pilot_name FROM pilotskills GROUP BY pilot_name	pilot_1
SELECT max(age) ,  pilot_name FROM pilotskills GROUP BY pilot_name	pilot_1
SELECT count(T1.pilot_name) ,  avg(T1.age) ,  T2.location FROM pilotskills AS T1 JOIN hangar AS T2 ON T1.plane_name  =  T2.plane_name GROUP BY T2.location	pilot_1
SELECT count(T1.pilot_name) ,  avg(T1.age) ,  T2.location FROM pilotskills AS T1 JOIN hangar AS T2 ON T1.plane_name  =  T2.plane_name GROUP BY T2.location	pilot_1
SELECT count(*) ,  plane_name FROM pilotskills GROUP BY plane_name HAVING avg(age)  <  35	pilot_1
SELECT count(*) ,  plane_name FROM pilotskills GROUP BY plane_name HAVING avg(age)  <  35	pilot_1
SELECT T2.location FROM pilotskills AS T1 JOIN hangar AS T2 ON T1.plane_name  =  T2.plane_name WHERE T1.age  =  (SELECT min(age) FROM pilotskills)	pilot_1
SELECT T2.location FROM pilotskills AS T1 JOIN hangar AS T2 ON T1.plane_name  =  T2.plane_name WHERE T1.age  =  (SELECT min(age) FROM pilotskills)	pilot_1
SELECT T1.pilot_name ,  T1.age FROM pilotskills AS T1 JOIN hangar AS T2 ON T1.plane_name  =  T2.plane_name WHERE T2.location  =  "Austin"	pilot_1
SELECT T1.pilot_name ,  T1.age FROM pilotskills AS T1 JOIN hangar AS T2 ON T1.plane_name  =  T2.plane_name WHERE T2.location  =  "Austin"	pilot_1
SELECT pilot_name FROM pilotskills WHERE age  >  (SELECT min(age) FROM pilotskills WHERE plane_name  =  'Piper Cub') ORDER BY pilot_name	pilot_1
SELECT pilot_name FROM pilotskills WHERE age  >  (SELECT min(age) FROM pilotskills WHERE plane_name  =  'Piper Cub') ORDER BY pilot_name	pilot_1
SELECT count(*) FROM pilotskills WHERE age  <  (SELECT min(age) FROM pilotskills WHERE plane_name  =  'F-14 Fighter')	pilot_1
SELECT count(*) FROM pilotskills WHERE age  <  (SELECT min(age) FROM pilotskills WHERE plane_name  =  'F-14 Fighter')	pilot_1
SELECT DISTINCT plane_name FROM pilotskills WHERE plane_name LIKE '%Bomber%'	pilot_1
SELECT DISTINCT plane_name FROM pilotskills WHERE plane_name LIKE '%Bomber%'	pilot_1
SELECT count(pilot_name) FROM pilotskills WHERE age  >  (SELECT min(age) FROM pilotskills WHERE plane_name  =  'Piper Cub')	pilot_1
SELECT count(pilot_name) FROM pilotskills WHERE age  >  (SELECT min(age) FROM pilotskills WHERE plane_name  =  'Piper Cub')	pilot_1
SELECT name FROM district ORDER BY Area_km DESC LIMIT 1	district_spokesman
SELECT area_km ,  Government_website FROM district ORDER BY Population LIMIT 1	district_spokesman
SELECT name ,  population FROM district WHERE area_km  >  (SELECT avg(area_km) FROM district)	district_spokesman
SELECT max(area_km) ,  avg(area_km) FROM district	district_spokesman
SELECT sum(population) FROM district ORDER BY area_km DESC LIMIT 3	district_spokesman
SELECT name ,  Government_website ,  district_id FROM district ORDER BY Population	district_spokesman
SELECT name FROM district WHERE Government_website LIKE "%gov%"	district_spokesman
SELECT district_id ,  name FROM district WHERE area_km  >  3000 OR population  >  4000	district_spokesman
SELECT name ,  speach_title FROM spokesman	district_spokesman
SELECT avg(points) ,  avg(age) FROM spokesman WHERE rank_position  =  1	district_spokesman
SELECT name ,  points FROM spokesman WHERE age  <  40	district_spokesman
SELECT name FROM spokesman ORDER BY age DESC LIMIT 1	district_spokesman
SELECT name FROM spokesman WHERE points  <  (SELECT avg(points) FROM spokesman)	district_spokesman
SELECT t1.name FROM district AS t1 JOIN spokesman_district AS t2 ON t1.District_ID  =  t2.District_ID GROUP BY t2.District_ID ORDER BY count(*) DESC LIMIT 1	district_spokesman
SELECT t1.name FROM spokesman AS t1 JOIN spokesman_district AS t2 ON t1.Spokesman_ID  =  t2.Spokesman_ID WHERE t2.start_year  <  2004	district_spokesman
SELECT t1.name ,  count(*) FROM district AS t1 JOIN spokesman_district AS t2 ON t1.District_ID  =  t2.District_ID GROUP BY t2.District_ID	district_spokesman
SELECT t3.name FROM spokesman AS t1 JOIN spokesman_district AS t2 ON t1.Spokesman_ID  =  t2.Spokesman_ID JOIN district AS t3 ON t3.district_id  =  t2.district_id WHERE t1.rank_position  =  1 INTERSECT SELECT t3.name FROM spokesman AS t1 JOIN spokesman_district AS t2 ON t1.Spokesman_ID  =  t2.Spokesman_ID JOIN district AS t3 ON t3.district_id  =  t2.district_id WHERE t1.rank_position  =  2	district_spokesman
SELECT t1.name FROM district AS t1 JOIN spokesman_district AS t2 ON t1.District_ID  =  t2.District_ID GROUP BY t2.District_ID HAVING count(*)  >  1	district_spokesman
SELECT count(*) FROM district WHERE district_id NOT IN (SELECT district_id FROM spokesman_district)	district_spokesman
SELECT name FROM spokesman WHERE Spokesman_ID NOT IN (SELECT Spokesman_ID FROM spokesman_district)	district_spokesman
SELECT sum(population) ,  avg(population) FROM district WHERE district_id IN (SELECT district_id FROM spokesman_district)	district_spokesman
select title from sculptures order by year desc limit 1	art_1
select title from sculptures order by year desc limit 1	art_1
select title ,  location from paintings order by year limit 1	art_1
SELECT title ,  LOCATION ,  YEAR FROM paintings ORDER BY YEAR LIMIT 1	art_1
SELECT title FROM sculptures WHERE LOCATION  =  "Gallery 226"	art_1
SELECT title FROM sculptures WHERE LOCATION  =  "Gallery 226"	art_1
SELECT title ,  LOCATION FROM paintings	art_1
SELECT title ,  LOCATION FROM paintings	art_1
SELECT title ,  LOCATION FROM sculptures	art_1
SELECT title ,  LOCATION FROM sculptures	art_1
SELECT medium FROM paintings WHERE paintingID  =  80	art_1
select medium from paintings where paintingid  =  80	art_1
SELECT lname ,  fname FROM artists WHERE birthYear  >  1850	art_1
SELECT lname ,  fname FROM artists WHERE birthYear  >  1850	art_1
SELECT title ,  YEAR FROM sculptures WHERE LOCATION != "Gallery 226"	art_1
SELECT title ,  YEAR FROM sculptures WHERE LOCATION != "Gallery 226"	art_1
SELECT DISTINCT T1.lname ,  T1.fname FROM artists AS T1 JOIN sculptures AS T2 ON T1.artistID  =  T2.sculptorID WHERE T2.year  <  1900	art_1
SELECT DISTINCT T1.lname ,  T1.fname FROM artists AS T1 JOIN sculptures AS T2 ON T1.artistID  =  T2.sculptorID WHERE T2.year  <  1900	art_1
SELECT DISTINCT T1.birthYear FROM artists AS T1 JOIN sculptures AS T2 ON T1.artistID  =  T2.sculptorID WHERE T2.year  >  1920	art_1
SELECT DISTINCT T1.birthYear FROM artists AS T1 JOIN sculptures AS T2 ON T1.artistID  =  T2.sculptorID WHERE T2.year  >  1920	art_1
SELECT lname ,  fname FROM artists ORDER BY deathYear - birthYear DESC LIMIT 1	art_1
SELECT lname ,  fname FROM artists ORDER BY deathYear - birthYear DESC LIMIT 1	art_1
SELECT deathYear - birthYear FROM artists ORDER BY deathYear - birthYear LIMIT 1	art_1
SELECT deathYear - birthYear FROM artists ORDER BY deathYear - birthYear LIMIT 1	art_1
SELECT fname  ,  deathYear - birthYear FROM artists ORDER BY deathYear - birthYear DESC LIMIT 1	art_1
SELECT fname  ,  deathYear - birthYear FROM artists ORDER BY deathYear - birthYear DESC LIMIT 1	art_1
SELECT count(*) FROM paintings WHERE LOCATION  =  "Gallery 240"	art_1
SELECT count(*) FROM paintings WHERE LOCATION  =  "Gallery 240"	art_1
select count(*) from artists as t1 join paintings as t2 on t1.artistid  =  t2.painterid group by t2.painterid order by t1.deathyear - t1.birthyear desc limit 1	art_1
select count(*) from artists as t1 join paintings as t2 on t1.artistid  =  t2.painterid group by t2.painterid order by t1.deathyear - t1.birthyear desc limit 1	art_1
SELECT T2.title ,   T2.year FROM artists AS T1 JOIN paintings AS T2 ON T1.artistID  =  T2.painterID WHERE T1.fname  =  "Mary"	art_1
SELECT T2.title ,   T2.year FROM artists AS T1 JOIN paintings AS T2 ON T1.artistID  =  T2.painterID WHERE T1.fname  =  "Mary"	art_1
SELECT T2.width_mm FROM artists AS T1 JOIN paintings AS T2 ON T1.artistID  =  T2.painterID WHERE T1.birthYear  <  1850	art_1
SELECT T2.width_mm FROM artists AS T1 JOIN paintings AS T2 ON T1.artistID  =  T2.painterID WHERE T1.birthYear  <  1850	art_1
SELECT T2.location ,   T2.medium FROM artists AS T1 JOIN paintings AS T2 ON T1.artistID  =  T2.painterID WHERE T1.fname  =  "Pablo"	art_1
SELECT T2.location ,   T2.medium FROM artists AS T1 JOIN paintings AS T2 ON T1.artistID  =  T2.painterID WHERE T1.fname  =  "Pablo"	art_1
SELECT T1.lname ,  T1.fname FROM artists AS T1 JOIN sculptures AS T2 ON T1.artistID  =  T2.sculptorID INTERSECT SELECT T3.lname ,  T3.fname FROM artists AS T3 JOIN paintings AS T4 ON T3.artistID  =  T4.painterID	art_1
SELECT T1.lname ,  T1.fname FROM artists AS T1 JOIN sculptures AS T2 ON T1.artistID  =  T2.sculptorID INTERSECT SELECT T3.lname ,  T3.fname FROM artists AS T3 JOIN paintings AS T4 ON T3.artistID  =  T4.painterID	art_1
SELECT T1.lname ,  T1.fname FROM artists AS T1 JOIN paintings AS T2 ON T1.artistID  =  T2.painterID WHERE T2.medium  =  "oil" INTERSECT SELECT T3.lname ,  T3.fname FROM artists AS T3 JOIN paintings AS T4 ON T3.artistID  =  T4.painterID WHERE T4.medium  =  "lithograph"	art_1
SELECT T1.lname ,  T1.fname FROM artists AS T1 JOIN paintings AS T2 ON T1.artistID  =  T2.painterID WHERE T2.medium  =  "oil" INTERSECT SELECT T3.lname ,  T3.fname FROM artists AS T3 JOIN paintings AS T4 ON T3.artistID  =  T4.painterID WHERE T4.medium  =  "lithograph"	art_1
SELECT T1.birthYear FROM artists AS T1 JOIN paintings AS T2 ON T1.artistID  =  T2.painterID WHERE T2.year  =  1884 AND mediumOn  =  "canvas"	art_1
SELECT T1.birthYear FROM artists AS T1 JOIN paintings AS T2 ON T1.artistID  =  T2.painterID WHERE T2.year  =  1884 AND mediumOn  =  "canvas"	art_1
SELECT DISTINCT T1.fname FROM artists AS T1 JOIN paintings AS T2 ON T1.artistID  =  T2.painterID WHERE T2.medium  =  "oil" AND LOCATION  =  "Gallery 241"	art_1
SELECT DISTINCT T1.fname FROM artists AS T1 JOIN paintings AS T2 ON T1.artistID  =  T2.painterID WHERE T2.medium  =  "oil" AND LOCATION  =  "Gallery 241"	art_1
SELECT count(*) ,  medium FROM paintings GROUP BY medium	art_1
SELECT count(*) ,  medium FROM paintings GROUP BY medium	art_1
SELECT avg(height_mm) ,  medium FROM paintings GROUP BY medium	art_1
SELECT avg(height_mm) ,  medium FROM paintings GROUP BY medium	art_1
SELECT count(*) ,  LOCATION FROM paintings WHERE YEAR  <  1900 GROUP BY LOCATION	art_1
SELECT count(*) ,  LOCATION FROM paintings WHERE YEAR  <  1900 GROUP BY LOCATION	art_1
SELECT title FROM paintings WHERE YEAR  >  1910 AND medium  =  "oil"	art_1
SELECT title FROM paintings WHERE YEAR  >  1910 AND medium  =  "oil"	art_1
SELECT DISTINCT painterID FROM paintings WHERE medium  =  "oil" AND LOCATION  =  "Gallery 240"	art_1
SELECT DISTINCT painterID FROM paintings WHERE medium  =  "oil" AND LOCATION  =  "Gallery 240"	art_1
SELECT DISTINCT title FROM paintings WHERE height_mm  >  (SELECT min(height_mm) FROM paintings WHERE mediumOn  =  "canvas")	art_1
SELECT DISTINCT title FROM paintings WHERE height_mm  >  (SELECT min(height_mm) FROM paintings WHERE mediumOn  =  "canvas")	art_1
SELECT paintingID FROM paintings WHERE YEAR  <  (SELECT max(YEAR) FROM paintings WHERE LOCATION  =  "Gallery 240")	art_1
SELECT paintingID FROM paintings WHERE YEAR  <  (SELECT max(YEAR) FROM paintings WHERE LOCATION  =  "Gallery 240")	art_1
SELECT paintingID FROM paintings ORDER BY YEAR LIMIT 1	art_1
SELECT paintingID FROM paintings ORDER BY YEAR LIMIT 1	art_1
SELECT T1.lname ,  T1.fname FROM artists AS T1 JOIN sculptures AS T2 ON T1.artistID  =  T2.sculptorID WHERE T2.title LIKE "%female%"	art_1
SELECT T1.lname ,  T1.fname FROM artists AS T1 JOIN sculptures AS T2 ON T1.artistID  =  T2.sculptorID WHERE T2.title LIKE "%female%"	art_1
SELECT DISTINCT title FROM paintings ORDER BY title	art_1
SELECT DISTINCT title FROM paintings ORDER BY title	art_1
SELECT DISTINCT title FROM paintings ORDER BY height_mm	art_1
SELECT DISTINCT title FROM paintings ORDER BY height_mm	art_1
SELECT title FROM paintings WHERE YEAR BETWEEN 1900 AND 1950 UNION SELECT title FROM sculptures WHERE YEAR BETWEEN 1900 AND 1950	art_1
SELECT title FROM paintings WHERE YEAR BETWEEN 1900 AND 1950 UNION SELECT title FROM sculptures WHERE YEAR BETWEEN 1900 AND 1950	art_1
SELECT T2.title FROM artists AS T1 JOIN paintings AS T2 ON T1.artistID  =  T2.painterID WHERE T1.artistID  =  222 UNION SELECT T4.title FROM artists AS T3 JOIN sculptures AS T4 ON T3.artistID  =  T4.sculptorID WHERE T3.artistID  =  222	art_1
SELECT T2.title FROM artists AS T1 JOIN paintings AS T2 ON T1.artistID  =  T2.painterID WHERE T1.artistID  =  222 UNION SELECT T4.title FROM artists AS T3 JOIN sculptures AS T4 ON T3.artistID  =  T4.sculptorID WHERE T3.artistID  =  222	art_1
SELECT T1.artistID FROM artists AS T1 JOIN paintings AS T2 ON T1.artistID  =  T2.painterID WHERE T2.year  <  1900 GROUP BY T1.artistID ORDER BY count(*) DESC LIMIT 1	art_1
SELECT T1.artistID FROM artists AS T1 JOIN paintings AS T2 ON T1.artistID  =  T2.painterID WHERE T2.year  <  1900 GROUP BY T1.artistID ORDER BY count(*) DESC LIMIT 1	art_1
SELECT T1.fname FROM artists AS T1 JOIN sculptures AS T2 ON T1.artistID  =  T2.sculptorID GROUP BY T2.sculptorID ORDER BY count(*) DESC LIMIT 1	art_1
SELECT T1.fname FROM artists AS T1 JOIN sculptures AS T2 ON T1.artistID  =  T2.sculptorID GROUP BY T2.sculptorID ORDER BY count(*) DESC LIMIT 1	art_1
SELECT title FROM paintings WHERE width_mm  <  600 OR height_mm  >  800	art_1
SELECT title FROM paintings WHERE width_mm  <  600 OR height_mm  >  800	art_1
SELECT DISTINCT LOCATION FROM paintings WHERE YEAR  < 1885 OR YEAR  >  1930	art_1
SELECT DISTINCT LOCATION FROM paintings WHERE YEAR  < 1885 OR YEAR  >  1930	art_1
SELECT paintingID FROM paintings WHERE height_mm  >  500 AND height_mm  <  2000	art_1
SELECT paintingID FROM paintings WHERE height_mm  >  500 AND height_mm  <  2000	art_1
SELECT DISTINCT LOCATION FROM paintings WHERE mediumOn  =  "panel" INTERSECT SELECT DISTINCT LOCATION FROM paintings WHERE mediumOn  =  "canvas"	art_1
SELECT DISTINCT LOCATION FROM paintings WHERE mediumOn  =  "panel" INTERSECT SELECT DISTINCT LOCATION FROM paintings WHERE mediumOn  =  "canvas"	art_1
SELECT DISTINCT LOCATION FROM paintings WHERE YEAR  <  1885 INTERSECT SELECT DISTINCT LOCATION FROM paintings WHERE YEAR  >  1930	art_1
SELECT DISTINCT LOCATION FROM paintings WHERE YEAR  <  1885 INTERSECT SELECT DISTINCT LOCATION FROM paintings WHERE YEAR  >  1930	art_1
SELECT avg(height_mm) ,  avg(width_mm) FROM paintings WHERE medium  =  "oil" AND LOCATION  =  "Gallery 241"	art_1
SELECT avg(height_mm) ,  avg(width_mm) FROM paintings WHERE medium  =  "oil" AND LOCATION  =  "Gallery 241"	art_1
SELECT max(height_mm) ,  paintingID FROM paintings WHERE YEAR  <  1900	art_1
SELECT max(height_mm) ,  paintingID FROM paintings WHERE YEAR  <  1900	art_1
SELECT max(height_mm) ,  max(width_mm) ,  YEAR FROM paintings GROUP BY YEAR ORDER BY YEAR	art_1
SELECT max(height_mm) ,  max(width_mm) ,  YEAR FROM paintings GROUP BY YEAR ORDER BY YEAR	art_1
SELECT avg(height_mm) ,  avg(width_mm) ,  painterID FROM paintings GROUP BY painterID ORDER BY title	art_1
SELECT avg(height_mm) ,  avg(width_mm) ,  painterID FROM paintings GROUP BY painterID ORDER BY title	art_1
SELECT T1.fname ,  count(*) FROM artists AS T1 JOIN paintings AS T2 ON T1.artistID  =  T2.painterID GROUP BY T2.painterID HAVING count(*)  >=  2	art_1
SELECT T1.fname ,  count(*) FROM artists AS T1 JOIN paintings AS T2 ON T1.artistID  =  T2.painterID GROUP BY T2.painterID HAVING count(*)  >=  2	art_1
SELECT T1.deathYear FROM artists AS T1 JOIN paintings AS T2 ON T1.artistID  =  T2.painterID GROUP BY T2.painterID HAVING count(*)  <=  3	art_1
select t1.deathyear from artists as t1 join paintings as t2 on t1.artistid  =  t2.painterid group by t2.painterid having count(*)  <  4	art_1
SELECT T1.deathYear FROM artists AS T1 JOIN sculptures AS T2 ON T1.artistID  =  T2.sculptorID GROUP BY T2.sculptorID ORDER BY count(*) LIMIT 1	art_1
SELECT T1.deathYear FROM artists AS T1 JOIN sculptures AS T2 ON T1.artistID  =  T2.sculptorID GROUP BY T2.sculptorID ORDER BY count(*) LIMIT 1	art_1
SELECT paintingID ,  height_mm FROM paintings WHERE LOCATION  =  'Gallery 240' ORDER BY width_mm DESC LIMIT 1	art_1
SELECT paintingID ,  height_mm FROM paintings WHERE LOCATION  =  'Gallery 240' ORDER BY width_mm DESC LIMIT 1	art_1
SELECT paintingID FROM paintings WHERE YEAR  <   (SELECT min(YEAR) FROM paintings WHERE LOCATION  =  'Gallery 240')	art_1
SELECT paintingID FROM paintings WHERE YEAR  <   (SELECT min(YEAR) FROM paintings WHERE LOCATION  =  'Gallery 240')	art_1
SELECT paintingID FROM paintings WHERE height_mm  >   (SELECT max(height_mm) FROM paintings WHERE YEAR  >  1900)	art_1
SELECT paintingID FROM paintings WHERE height_mm  >   (SELECT max(height_mm) FROM paintings WHERE YEAR  >  1900)	art_1
SELECT T1.lname ,  T1.fname FROM artists AS T1 JOIN paintings AS T2 ON T1.artistID  =  T2.painterID WHERE T2.medium  =  "oil" GROUP BY T2.painterID ORDER BY count(*) DESC LIMIT 3	art_1
SELECT T1.lname ,  T1.fname FROM artists AS T1 JOIN paintings AS T2 ON T1.artistID  =  T2.painterID WHERE T2.medium  =  "oil" GROUP BY T2.painterID ORDER BY count(*) DESC LIMIT 3	art_1
SELECT paintingID ,  title ,  LOCATION FROM paintings WHERE medium  =  "oil" ORDER BY YEAR	art_1
SELECT paintingID ,  title ,  LOCATION FROM paintings WHERE medium  =  "oil" ORDER BY YEAR	art_1
SELECT title ,  LOCATION ,  YEAR FROM paintings WHERE height_mm  >  1000 ORDER BY title	art_1
SELECT title ,  LOCATION ,  YEAR FROM paintings WHERE height_mm  >  1000 ORDER BY title	art_1
SELECT T1.lname ,  T1.fname FROM artists AS T1 JOIN paintings AS T2 ON T1.artistID  =  T2.painterID EXCEPT SELECT T3.lname ,  T3.fname FROM artists AS T3 JOIN sculptures AS T4 ON T3.artistID  =  T4.sculptorID	art_1
SELECT T1.lname ,  T1.fname FROM artists AS T1 JOIN paintings AS T2 ON T1.artistID  =  T2.painterID EXCEPT SELECT T3.lname ,  T3.fname FROM artists AS T3 JOIN sculptures AS T4 ON T3.artistID  =  T4.sculptorID	art_1
SELECT DISTINCT LOCATION FROM paintings WHERE YEAR  <  1885 AND mediumOn != "canvas"	art_1
SELECT DISTINCT LOCATION FROM paintings WHERE YEAR  <  1885 AND mediumOn != "canvas"	art_1
SELECT count(*) FROM race	car_road_race
SELECT count(*) FROM race	car_road_race
SELECT Winning_driver ,  Winning_team FROM race ORDER BY Winning_team ASC	car_road_race
SELECT Winning_driver ,  Winning_team FROM race ORDER BY Winning_team ASC	car_road_race
SELECT Winning_driver FROM race WHERE Pole_Position != 'Junior Strous'	car_road_race
SELECT Winning_driver FROM race WHERE Pole_Position != 'Junior Strous'	car_road_race
SELECT DISTINCT CONSTRUCTOR FROM driver ORDER BY Age ASC	car_road_race
SELECT DISTINCT CONSTRUCTOR FROM driver ORDER BY Age ASC	car_road_race
SELECT DISTINCT Entrant FROM driver WHERE Age  >=  20	car_road_race
SELECT DISTINCT Entrant FROM driver WHERE Age  >=  20	car_road_race
SELECT max(Age) ,  min(Age) FROM driver	car_road_race
SELECT max(Age) ,  min(Age) FROM driver	car_road_race
SELECT count(DISTINCT Engine) FROM driver WHERE Age  >  30 OR Age  <  20	car_road_race
SELECT count(DISTINCT Engine) FROM driver WHERE Age  >  30 OR Age  <  20	car_road_race
SELECT Driver_Name FROM driver ORDER BY Driver_Name DESC	car_road_race
SELECT Driver_Name FROM driver ORDER BY Driver_Name DESC	car_road_race
SELECT T1.Driver_Name ,  T2.Race_Name FROM driver AS T1 JOIN race AS T2 ON T1.Driver_ID  =  T2.Driver_ID	car_road_race
SELECT T1.Driver_Name ,  T2.Race_Name FROM driver AS T1 JOIN race AS T2 ON T1.Driver_ID  =  T2.Driver_ID	car_road_race
SELECT T1.Driver_Name ,  COUNT(*) FROM driver AS T1 JOIN race AS T2 ON T1.Driver_ID  =  T2.Driver_ID GROUP BY T1.Driver_ID	car_road_race
SELECT T1.Driver_Name ,  COUNT(*) FROM driver AS T1 JOIN race AS T2 ON T1.Driver_ID  =  T2.Driver_ID GROUP BY T1.Driver_ID	car_road_race
SELECT T1.Age FROM driver AS T1 JOIN race AS T2 ON T1.Driver_ID  =  T2.Driver_ID GROUP BY T1.Driver_ID ORDER BY COUNT(*) DESC LIMIT 1	car_road_race
SELECT T1.Age FROM driver AS T1 JOIN race AS T2 ON T1.Driver_ID  =  T2.Driver_ID GROUP BY T1.Driver_ID ORDER BY COUNT(*) DESC LIMIT 1	car_road_race
SELECT T1.Driver_Name ,  T1.Age FROM driver AS T1 JOIN race AS T2 ON T1.Driver_ID  =  T2.Driver_ID GROUP BY T1.Driver_ID HAVING COUNT(*)  >=  2	car_road_race
SELECT T1.Driver_Name ,  T1.Age FROM driver AS T1 JOIN race AS T2 ON T1.Driver_ID  =  T2.Driver_ID GROUP BY T1.Driver_ID HAVING COUNT(*)  >=  2	car_road_race
SELECT T2.Race_Name FROM driver AS T1 JOIN race AS T2 ON T1.Driver_ID  =  T2.Driver_ID WHERE T1.Age  >=  26	car_road_race
SELECT T2.Race_Name FROM driver AS T1 JOIN race AS T2 ON T1.Driver_ID  =  T2.Driver_ID WHERE T1.Age  >=  26	car_road_race
SELECT Driver_Name FROM driver WHERE CONSTRUCTOR != "Bugatti"	car_road_race
SELECT Driver_Name FROM driver WHERE CONSTRUCTOR != "Bugatti"	car_road_race
SELECT CONSTRUCTOR ,  COUNT(*) FROM driver GROUP BY CONSTRUCTOR	car_road_race
SELECT CONSTRUCTOR ,  COUNT(*) FROM driver GROUP BY CONSTRUCTOR	car_road_race
SELECT Engine FROM driver GROUP BY Engine ORDER BY COUNT(*) DESC LIMIT 1	car_road_race
SELECT Engine FROM driver GROUP BY Engine ORDER BY COUNT(*) DESC LIMIT 1	car_road_race
SELECT Engine FROM driver GROUP BY Engine HAVING COUNT(*)  >=  2	car_road_race
SELECT Engine FROM driver GROUP BY Engine HAVING COUNT(*)  >=  2	car_road_race
SELECT Driver_Name FROM driver WHERE Driver_ID NOT IN (SELECT Driver_ID FROM race)	car_road_race
SELECT Driver_Name FROM driver WHERE Driver_ID NOT IN (SELECT Driver_ID FROM race)	car_road_race
SELECT CONSTRUCTOR FROM driver WHERE Age  <  20 INTERSECT SELECT CONSTRUCTOR FROM driver WHERE Age  >  30	car_road_race
SELECT CONSTRUCTOR FROM driver WHERE Age  <  20 INTERSECT SELECT CONSTRUCTOR FROM driver WHERE Age  >  30	car_road_race
SELECT Winning_team FROM race GROUP BY Winning_team HAVING count(*)  >  1	car_road_race
SELECT Winning_team FROM race GROUP BY Winning_team HAVING count(*)  >  1	car_road_race
SELECT T1.Driver_Name FROM driver AS T1 JOIN race AS T2 ON T1.Driver_ID  =  T2.Driver_ID WHERE Pole_Position  =  "Carl Skerlong" INTERSECT SELECT T1.Driver_Name FROM driver AS T1 JOIN race AS T2 ON T1.Driver_ID  =  T2.Driver_ID WHERE Pole_Position  =  "James Hinchcliffe"	car_road_race
SELECT T1.Driver_Name FROM driver AS T1 JOIN race AS T2 ON T1.Driver_ID  =  T2.Driver_ID WHERE Pole_Position  =  "Carl Skerlong" INTERSECT SELECT T1.Driver_Name FROM driver AS T1 JOIN race AS T2 ON T1.Driver_ID  =  T2.Driver_ID WHERE Pole_Position  =  "James Hinchcliffe"	car_road_race
SELECT Driver_Name FROM driver EXCEPT SELECT T1.Driver_Name FROM driver AS T1 JOIN race AS T2 ON T1.Driver_ID  =  T2.Driver_ID WHERE Pole_Position  =  "James Hinchcliffe"	car_road_race
SELECT Driver_Name FROM driver EXCEPT SELECT T1.Driver_Name FROM driver AS T1 JOIN race AS T2 ON T1.Driver_ID  =  T2.Driver_ID WHERE Pole_Position  =  "James Hinchcliffe"	car_road_race
SELECT count(*) FROM languages	country_language
SELECT count(*) FROM languages	country_language
SELECT name FROM languages ORDER BY name ASC	country_language
SELECT name FROM languages ORDER BY name ASC	country_language
SELECT name FROM languages WHERE name LIKE "%ish%"	country_language
SELECT name FROM languages WHERE name LIKE "%ish%"	country_language
SELECT name FROM countries ORDER BY overall_score DESC	country_language
SELECT name FROM countries ORDER BY overall_score DESC	country_language
SELECT avg(justice_score) FROM countries	country_language
SELECT avg(justice_score) FROM countries	country_language
SELECT max(health_score) ,  min(health_score) FROM countries WHERE name != "Norway"	country_language
SELECT max(health_score) ,  min(health_score) FROM countries WHERE name != "Norway"	country_language
SELECT count(DISTINCT language_id) FROM official_languages	country_language
SELECT count(DISTINCT language_id) FROM official_languages	country_language
SELECT name FROM countries ORDER BY education_score DESC	country_language
SELECT name FROM countries ORDER BY education_score DESC	country_language
SELECT name FROM countries ORDER BY politics_score DESC LIMIT 1	country_language
SELECT name FROM countries ORDER BY politics_score DESC LIMIT 1	country_language
SELECT T1.name ,  T3.name FROM countries AS T1 JOIN official_languages AS T2 ON T1.id  =  T2.country_id JOIN languages AS T3 ON T2.language_id  =  T3.id	country_language
SELECT T1.name ,  T3.name FROM countries AS T1 JOIN official_languages AS T2 ON T1.id  =  T2.country_id JOIN languages AS T3 ON T2.language_id  =  T3.id	country_language
SELECT T2.name ,  COUNT(*) FROM official_languages AS T1 JOIN languages AS T2 ON T1.language_id  =  T2.id GROUP BY T2.name	country_language
SELECT T2.name ,  COUNT(*) FROM official_languages AS T1 JOIN languages AS T2 ON T1.language_id  =  T2.id GROUP BY T2.name	country_language
SELECT T2.name FROM official_languages AS T1 JOIN languages AS T2 ON T1.language_id  =  T2.id GROUP BY T2.id ORDER BY COUNT(*) DESC LIMIT 1	country_language
SELECT T2.name FROM official_languages AS T1 JOIN languages AS T2 ON T1.language_id  =  T2.id GROUP BY T2.id ORDER BY COUNT(*) DESC LIMIT 1	country_language
SELECT T2.name FROM official_languages AS T1 JOIN languages AS T2 ON T1.language_id  =  T2.id GROUP BY T2.id HAVING COUNT(*)  >=  2	country_language
SELECT T2.name FROM official_languages AS T1 JOIN languages AS T2 ON T1.language_id  =  T2.id GROUP BY T2.id HAVING COUNT(*)  >=  2	country_language
SELECT avg(T1.overall_score) FROM countries AS T1 JOIN official_languages AS T2 ON T1.id  =  T2.country_id JOIN languages AS T3 ON T2.language_id  =  T3.id WHERE T3.name  =  "English"	country_language
SELECT avg(T1.overall_score) FROM countries AS T1 JOIN official_languages AS T2 ON T1.id  =  T2.country_id JOIN languages AS T3 ON T2.language_id  =  T3.id WHERE T3.name  =  "English"	country_language
SELECT T2.name FROM official_languages AS T1 JOIN languages AS T2 ON T1.language_id  =  T2.id GROUP BY T2.id ORDER BY COUNT(*) DESC LIMIT 3	country_language
SELECT T2.name FROM official_languages AS T1 JOIN languages AS T2 ON T1.language_id  =  T2.id GROUP BY T2.id ORDER BY COUNT(*) DESC LIMIT 3	country_language
SELECT T3.name FROM countries AS T1 JOIN official_languages AS T2 ON T1.id  =  T2.country_id JOIN languages AS T3 ON T2.language_id  =  T3.id GROUP BY T3.id ORDER BY avg(T1.overall_score) DESC	country_language
SELECT T3.name FROM countries AS T1 JOIN official_languages AS T2 ON T1.id  =  T2.country_id JOIN languages AS T3 ON T2.language_id  =  T3.id GROUP BY T3.id ORDER BY avg(T1.overall_score) DESC	country_language
SELECT T1.Name FROM countries AS T1 JOIN official_languages AS T2 ON T1.id  =  T2.country_id GROUP BY T1.id ORDER BY COUNT(*) DESC LIMIT 1	country_language
SELECT T1.Name FROM countries AS T1 JOIN official_languages AS T2 ON T1.id  =  T2.country_id GROUP BY T1.id ORDER BY COUNT(*) DESC LIMIT 1	country_language
SELECT name FROM languages WHERE id NOT IN (SELECT language_id FROM official_languages)	country_language
SELECT name FROM languages WHERE id NOT IN (SELECT language_id FROM official_languages)	country_language
SELECT name FROM countries WHERE id NOT IN (SELECT country_id FROM official_languages)	country_language
SELECT name FROM countries WHERE id NOT IN (SELECT country_id FROM official_languages)	country_language
SELECT T3.name FROM countries AS T1 JOIN official_languages AS T2 ON T1.id  =  T2.country_id JOIN languages AS T3 ON T2.language_id  =  T3.id WHERE T1.overall_score  >  95 INTERSECT SELECT T3.name FROM countries AS T1 JOIN official_languages AS T2 ON T1.id  =  T2.country_id JOIN languages AS T3 ON T2.language_id  =  T3.id WHERE T1.overall_score  <  90	country_language
SELECT T3.name FROM countries AS T1 JOIN official_languages AS T2 ON T1.id  =  T2.country_id JOIN languages AS T3 ON T2.language_id  =  T3.id WHERE T1.overall_score  >  95 INTERSECT SELECT T3.name FROM countries AS T1 JOIN official_languages AS T2 ON T1.id  =  T2.country_id JOIN languages AS T3 ON T2.language_id  =  T3.id WHERE T1.overall_score  <  90	country_language
SELECT country ,  town_city FROM Addresses;	real_estate_rentals
SELECT country ,  town_city FROM Addresses;	real_estate_rentals
SELECT DISTINCT T1.county_state_province FROM Addresses AS T1 JOIN Properties AS T2 ON T1.address_id  =  T2.property_address_id;	real_estate_rentals
SELECT DISTINCT T1.county_state_province FROM Addresses AS T1 JOIN Properties AS T2 ON T1.address_id  =  T2.property_address_id;	real_estate_rentals
SELECT feature_description FROM Features WHERE feature_name  =  'rooftop';	real_estate_rentals
SELECT feature_description FROM Features WHERE feature_name  =  'rooftop';	real_estate_rentals
SELECT T1.feature_name ,  T1.feature_description FROM Features AS T1 JOIN Property_Features AS T2 ON T1.feature_id  =  T2.feature_id GROUP BY T1.feature_name ORDER BY count(*) DESC LIMIT 1;	real_estate_rentals
SELECT T1.feature_name ,  T1.feature_description FROM Features AS T1 JOIN Property_Features AS T2 ON T1.feature_id  =  T2.feature_id GROUP BY T1.feature_name ORDER BY count(*) DESC LIMIT 1;	real_estate_rentals
SELECT min(room_count) FROM Properties;	real_estate_rentals
SELECT min(room_count) FROM Properties;	real_estate_rentals
SELECT count(*) FROM Properties WHERE parking_lots  =  1 OR garage_yn  =  1;	real_estate_rentals
SELECT count(*) FROM Properties WHERE parking_lots  =  1 OR garage_yn  =  1;	real_estate_rentals
SELECT T2.age_category_code FROM Ref_User_Categories AS T1 JOIN Users AS T2 ON T1.user_category_code  =  T2.user_category_code WHERE T1.User_category_description LIKE "%Mother";	real_estate_rentals
SELECT T2.age_category_code FROM Ref_User_Categories AS T1 JOIN Users AS T2 ON T1.user_category_code  =  T2.user_category_code WHERE T1.User_category_description LIKE "%Mother";	real_estate_rentals
SELECT T1.first_name FROM Users AS T1 JOIN Properties AS T2 ON T2.owner_user_id  =  T1.User_id GROUP BY T1.User_id ORDER BY count(*) DESC LIMIT 1;	real_estate_rentals
SELECT T1.first_name FROM Users AS T1 JOIN Properties AS T2 ON T2.owner_user_id  =  T1.User_id GROUP BY T1.User_id ORDER BY count(*) DESC LIMIT 1;	real_estate_rentals
SELECT avg(T3.room_count) FROM Property_Features AS T1 JOIN Features AS T2 ON T1.feature_id  =  T2.feature_id JOIN Properties AS T3 ON T1.property_id  =  T3.property_id WHERE T2.feature_name  =  'garden';	real_estate_rentals
SELECT avg(T3.room_count) FROM Property_Features AS T1 JOIN Features AS T2 ON T1.feature_id  =  T2.feature_id JOIN Properties AS T3 ON T1.property_id  =  T3.property_id WHERE T2.feature_name  =  'garden';	real_estate_rentals
SELECT T2.town_city FROM Properties AS T1 JOIN Addresses AS T2 ON T1.property_address_id  =  T2.address_id JOIN Property_Features AS T3 ON T1.property_id  =  T3.property_id JOIN Features AS T4 ON T4.feature_id  =  T3.feature_id WHERE T4.feature_name  =  'swimming pool';	real_estate_rentals
SELECT T2.town_city FROM Properties AS T1 JOIN Addresses AS T2 ON T1.property_address_id  =  T2.address_id JOIN Property_Features AS T3 ON T1.property_id  =  T3.property_id JOIN Features AS T4 ON T4.feature_id  =  T3.feature_id WHERE T4.feature_name  =  'swimming pool';	real_estate_rentals
SELECT property_id ,  vendor_requested_price FROM Properties ORDER BY vendor_requested_price LIMIT 1;	real_estate_rentals
SELECT property_id ,  vendor_requested_price FROM Properties ORDER BY vendor_requested_price LIMIT 1;	real_estate_rentals
SELECT avg(room_count) FROM Properties;	real_estate_rentals
SELECT avg(room_count) FROM Properties;	real_estate_rentals
SELECT count(DISTINCT room_size) FROM Rooms;	real_estate_rentals
SELECT count(DISTINCT room_size) FROM Rooms;	real_estate_rentals
SELECT search_seq ,  user_id FROM User_Searches GROUP BY user_id HAVING count(*) >= 2;	real_estate_rentals
SELECT search_seq ,  user_id FROM User_Searches GROUP BY user_id HAVING count(*) >= 2;	real_estate_rentals
SELECT max(search_datetime) FROM User_Searches;	real_estate_rentals
SELECT max(search_datetime) FROM User_Searches;	real_estate_rentals
SELECT search_datetime ,  search_string FROM User_Searches ORDER BY search_string DESC;	real_estate_rentals
SELECT search_datetime ,  search_string FROM User_Searches ORDER BY search_string DESC;	real_estate_rentals
SELECT T1.zip_postcode FROM Addresses AS T1 JOIN Properties AS T2 ON T1.address_id  =  T2.property_address_id WHERE T2.owner_user_id NOT IN ( SELECT owner_user_id FROM Properties GROUP BY owner_user_id HAVING count(*)  <=  2 );	real_estate_rentals
SELECT T1.zip_postcode FROM Addresses AS T1 JOIN Properties AS T2 ON T1.address_id  =  T2.property_address_id WHERE T2.owner_user_id NOT IN ( SELECT owner_user_id FROM Properties GROUP BY owner_user_id HAVING count(*)  <=  2 );	real_estate_rentals
SELECT T1.user_category_code ,  T1.user_id FROM Users AS T1 JOIN User_Searches AS T2 ON T1.user_id  =  T2.user_id GROUP BY T1.user_id HAVING count(*)  =  1;	real_estate_rentals
SELECT T1.user_category_code ,  T1.user_id FROM Users AS T1 JOIN User_Searches AS T2 ON T1.user_id  =  T2.user_id GROUP BY T1.user_id HAVING count(*)  =  1;	real_estate_rentals
SELECT T1.age_category_code FROM Users AS T1 JOIN User_Searches AS T2 ON T1.user_id  =  T2.user_id ORDER BY T2.search_datetime LIMIT 1;	real_estate_rentals
SELECT T1.age_category_code FROM Users AS T1 JOIN User_Searches AS T2 ON T1.user_id  =  T2.user_id ORDER BY T2.search_datetime LIMIT 1;	real_estate_rentals
SELECT login_name FROM Users WHERE user_category_code  =  'Senior Citizen' ORDER BY first_name	real_estate_rentals
SELECT login_name FROM Users WHERE user_category_code  =  'Senior Citizen' ORDER BY first_name	real_estate_rentals
SELECT count(*) FROM Users AS T1 JOIN User_Searches AS T2 ON T1.user_id  =  T2.user_id WHERE T1.is_buyer  =  1;	real_estate_rentals
SELECT count(*) FROM Users AS T1 JOIN User_Searches AS T2 ON T1.user_id  =  T2.user_id WHERE T1.is_buyer  =  1;	real_estate_rentals
SELECT date_registered FROM Users WHERE login_name  =  'ratione';	real_estate_rentals
SELECT date_registered FROM Users WHERE login_name  =  'ratione';	real_estate_rentals
SELECT first_name ,  middle_name ,  last_name ,  login_name FROM Users WHERE is_seller  =  1;	real_estate_rentals
SELECT first_name ,  middle_name ,  last_name ,  login_name FROM Users WHERE is_seller  =  1;	real_estate_rentals
SELECT T1.line_1_number_building ,  T1.line_2_number_street ,  T1.town_city FROM Addresses AS T1 JOIN Users AS T2 ON T1.address_id  =  T2.user_address_id WHERE T2.user_category_code  =  'Senior Citizen';	real_estate_rentals
SELECT T1.line_1_number_building ,  T1.line_2_number_street ,  T1.town_city FROM Addresses AS T1 JOIN Users AS T2 ON T1.address_id  =  T2.user_address_id WHERE T2.user_category_code  =  'Senior Citizen';	real_estate_rentals
SELECT count(*) FROM Properties GROUP BY property_id HAVING count(*)  >= 2;	real_estate_rentals
SELECT count(*) FROM Properties GROUP BY property_id HAVING count(*)  >= 2;	real_estate_rentals
SELECT count(*) ,  property_id FROM Property_Photos GROUP BY property_id;	real_estate_rentals
SELECT count(*) ,  property_id FROM Property_Photos GROUP BY property_id;	real_estate_rentals
SELECT T1.owner_user_id ,  count(*) FROM Properties AS T1 JOIN Property_Photos AS T2 ON T1.property_id  =  T2.property_id GROUP BY T1.owner_user_id;	real_estate_rentals
SELECT T1.owner_user_id ,  count(*) FROM Properties AS T1 JOIN Property_Photos AS T2 ON T1.property_id  =  T2.property_id GROUP BY T1.owner_user_id;	real_estate_rentals
SELECT sum(T1.price_max) FROM Properties AS T1 JOIN Users AS T2 ON T1.owner_user_id  =  T2.user_id WHERE T2.user_category_code  =  'Single Mother' OR T2.user_category_code  =  'Student';	real_estate_rentals
SELECT sum(T1.price_max) FROM Properties AS T1 JOIN Users AS T2 ON T1.owner_user_id  =  T2.user_id WHERE T2.user_category_code  =  'Single Mother' OR T2.user_category_code  =  'Student';	real_estate_rentals
SELECT T1.datestamp ,  T2.property_name FROM User_Property_History AS T1 JOIN Properties AS T2 ON T1.property_id  =  T2.property_id ORDER BY datestamp;	real_estate_rentals
SELECT T1.datestamp ,  T2.property_name FROM User_Property_History AS T1 JOIN Properties AS T2 ON T1.property_id  =  T2.property_id ORDER BY datestamp;	real_estate_rentals
SELECT T1.property_type_description ,  T1.property_type_code FROM Ref_Property_Types AS T1 JOIN Properties AS T2 ON T1.property_type_code  =  T2.property_type_code GROUP BY T1.property_type_code ORDER BY count(*) DESC LIMIT 1;	real_estate_rentals
SELECT T1.property_type_description ,  T1.property_type_code FROM Ref_Property_Types AS T1 JOIN Properties AS T2 ON T1.property_type_code  =  T2.property_type_code GROUP BY T1.property_type_code ORDER BY count(*) DESC LIMIT 1;	real_estate_rentals
SELECT age_category_description FROM Ref_Age_Categories WHERE age_category_code  =  'Over 60';	real_estate_rentals
SELECT age_category_description FROM Ref_Age_Categories WHERE age_category_code  =  'Over 60';	real_estate_rentals
SELECT room_size ,  count(*) FROM Rooms GROUP BY room_size	real_estate_rentals
SELECT room_size ,  count(*) FROM Rooms GROUP BY room_size	real_estate_rentals
SELECT T1.country FROM Addresses AS T1 JOIN Users AS T2 ON T1.address_id  =  T2.user_address_id WHERE T2.first_name  =  'Robbie';	real_estate_rentals
SELECT T1.country FROM Addresses AS T1 JOIN Users AS T2 ON T1.address_id  =  T2.user_address_id WHERE T2.first_name  =  'Robbie';	real_estate_rentals
SELECT first_name ,  middle_name ,  last_name FROM Properties AS T1 JOIN Users AS T2 ON T1.owner_user_id  =  T2.user_id WHERE T1.property_address_id  =  T2.user_address_id;	real_estate_rentals
SELECT first_name ,  middle_name ,  last_name FROM Properties AS T1 JOIN Users AS T2 ON T1.owner_user_id  =  T2.user_id WHERE T1.property_address_id  =  T2.user_address_id;	real_estate_rentals
SELECT search_string FROM User_Searches EXCEPT SELECT T1.search_string FROM User_Searches AS T1 JOIN Properties AS T2 ON T1.user_id  =  T2.owner_user_id;	real_estate_rentals
SELECT search_string FROM User_Searches EXCEPT SELECT T1.search_string FROM User_Searches AS T1 JOIN Properties AS T2 ON T1.user_id  =  T2.owner_user_id;	real_estate_rentals
SELECT T1.last_name ,  T1.user_id FROM Users AS T1 JOIN User_Searches AS T2 ON T1.user_id  =  T2.user_id GROUP BY T1.user_id HAVING count(*)  <=  2 INTERSECT SELECT T3.last_name ,  T3.user_id FROM Users AS T3 JOIN Properties AS T4 ON T3.user_id  =  T4.owner_user_id GROUP BY T3.user_id HAVING count(*)  >=  2;	real_estate_rentals
SELECT T1.last_name ,  T1.user_id FROM Users AS T1 JOIN User_Searches AS T2 ON T1.user_id  =  T2.user_id GROUP BY T1.user_id HAVING count(*)  <=  2 INTERSECT SELECT T3.last_name ,  T3.user_id FROM Users AS T3 JOIN Properties AS T4 ON T3.user_id  =  T4.owner_user_id GROUP BY T3.user_id HAVING count(*)  >=  2;	real_estate_rentals
SELECT count(*) FROM bike WHERE weight  >  780	bike_racing
SELECT product_name ,  weight FROM bike ORDER BY price ASC	bike_racing
SELECT heat ,  name ,  nation FROM cyclist	bike_racing
SELECT max(weight) ,  min(weight) FROM bike	bike_racing
SELECT avg(price) FROM bike WHERE material  =  'Carbon CC'	bike_racing
SELECT name ,  RESULT FROM cyclist WHERE nation != 'Russia'	bike_racing
SELECT DISTINCT T1.id ,  T1.product_name FROM bike AS T1 JOIN cyclists_own_bikes AS T2 ON T1.id  =  T2.bike_id WHERE T2.purchase_year  >  2015	bike_racing
SELECT T1.id ,  T1.product_name FROM bike AS T1 JOIN cyclists_own_bikes AS T2 ON T1.id  =  T2.bike_id GROUP BY T1.id HAVING count(*)  >=  4	bike_racing
SELECT T1.id ,  T1.name FROM cyclist AS T1 JOIN cyclists_own_bikes AS T2 ON T1.id  =  T2.cyclist_id GROUP BY T1.id ORDER BY count(*) DESC LIMIT 1	bike_racing
SELECT DISTINCT T3.product_name FROM cyclist AS T1 JOIN cyclists_own_bikes AS T2 ON T1.id  =  T2.cyclist_id JOIN bike AS T3 ON T2.bike_id  =  T3.id WHERE T1.nation  =  'Russia' OR T1.nation  =  'Great Britain'	bike_racing
SELECT count(DISTINCT heat) FROM cyclist	bike_racing
SELECT count(*) FROM cyclist WHERE id NOT IN ( SELECT cyclist_id FROM cyclists_own_bikes WHERE purchase_year  >  2015 )	bike_racing
SELECT DISTINCT T3.product_name FROM cyclist AS T1 JOIN cyclists_own_bikes AS T2 ON T1.id  =  T2.cyclist_id JOIN bike AS T3 ON T2.bike_id  =  T3.id WHERE T1.result  <  '4:21.558'	bike_racing
SELECT T3.product_name ,  T3.price FROM cyclist AS T1 JOIN cyclists_own_bikes AS T2 ON T1.id  =  T2.cyclist_id JOIN bike AS T3 ON T2.bike_id  =  T3.id WHERE T1.name  =  'Bradley Wiggins' INTERSECT SELECT T3.product_name ,  T3.price FROM cyclist AS T1 JOIN cyclists_own_bikes AS T2 ON T1.id  =  T2.cyclist_id JOIN bike AS T3 ON T2.bike_id  =  T3.id WHERE T1.name  =  'Antonio Tauler'	bike_racing
SELECT name ,  nation ,  RESULT FROM cyclist EXCEPT SELECT T1.name ,  T1.nation ,  T1.result FROM cyclist AS T1 JOIN cyclists_own_bikes AS T2 ON T1.id  =  T2.cyclist_id	bike_racing
SELECT product_name FROM bike WHERE material LIKE "%fiber%"	bike_racing
SELECT cyclist_id ,  count(*) FROM cyclists_own_bikes GROUP BY cyclist_id ORDER BY cyclist_id	bike_racing
SELECT id ,  flavor FROM goods WHERE food  =  "Cake" ORDER BY price DESC LIMIT 1	bakery_1
SELECT id ,  flavor FROM goods WHERE food  =  "Cake" ORDER BY price DESC LIMIT 1	bakery_1
SELECT id ,  flavor FROM goods WHERE food  =  "Cookie" ORDER BY price LIMIT 1	bakery_1
SELECT id ,  flavor FROM goods WHERE food  =  "Cookie" ORDER BY price LIMIT 1	bakery_1
SELECT id FROM goods WHERE flavor  =  "Apple"	bakery_1
SELECT id FROM goods WHERE flavor  =  "Apple"	bakery_1
SELECT id FROM goods WHERE price  <  3	bakery_1
SELECT id FROM goods WHERE price  <  3	bakery_1
SELECT DISTINCT T3.CustomerId FROM goods AS T1 JOIN items AS T2 ON T1.Id  =  T2.Item JOIN receipts AS T3 ON T2.Receipt  =  T3.ReceiptNumber WHERE T1.Flavor  =  "Lemon" AND T1.Food  =  "Cake"	bakery_1
SELECT DISTINCT T3.CustomerId FROM goods AS T1 JOIN items AS T2 ON T1.Id  =  T2.Item JOIN receipts AS T3 ON T2.Receipt  =  T3.ReceiptNumber WHERE T1.Flavor  =  "Lemon" AND T1.Food  =  "Cake"	bakery_1
SELECT T1.food ,  count(DISTINCT T3.CustomerId) FROM goods AS T1 JOIN items AS T2 ON T1.Id  =  T2.Item JOIN receipts AS T3 ON T2.Receipt  =  T3.ReceiptNumber GROUP BY T1.food	bakery_1
SELECT T1.food ,  count(DISTINCT T3.CustomerId) FROM goods AS T1 JOIN items AS T2 ON T1.Id  =  T2.Item JOIN receipts AS T3 ON T2.Receipt  =  T3.ReceiptNumber GROUP BY T1.food	bakery_1
SELECT CustomerId FROM receipts GROUP BY CustomerId HAVING count(*)  >=  15	bakery_1
SELECT CustomerId FROM receipts GROUP BY CustomerId HAVING count(*)  >=  15	bakery_1
SELECT T2.LastName FROM receipts AS T1 JOIN customers AS T2 ON T1.CustomerId  =  T2.id GROUP BY T2.id HAVING count(*)  >  10	bakery_1
SELECT T2.LastName FROM receipts AS T1 JOIN customers AS T2 ON T1.CustomerId  =  T2.id GROUP BY T2.id HAVING count(*)  >  10	bakery_1
SELECT count(*) FROM goods WHERE food  =  "Cake"	bakery_1
SELECT count(*) FROM goods WHERE food  =  "Cake"	bakery_1
SELECT flavor FROM goods WHERE food  =  "Croissant"	bakery_1
SELECT flavor FROM goods WHERE food  =  "Croissant"	bakery_1
SELECT DISTINCT T1.item FROM items AS T1 JOIN receipts AS T2 ON T1.receipt  =  T2.ReceiptNumber WHERE T2.CustomerId  =  15	bakery_1
SELECT DISTINCT T1.item FROM items AS T1 JOIN receipts AS T2 ON T1.receipt  =  T2.ReceiptNumber WHERE T2.CustomerId  =  15	bakery_1
SELECT food ,  avg(price) ,  max(price) ,  min(price) FROM goods GROUP BY food	bakery_1
SELECT food ,  avg(price) ,  max(price) ,  min(price) FROM goods GROUP BY food	bakery_1
SELECT T1.receipt FROM items AS T1 JOIN goods AS T2 ON T1.item  =  T2.id WHERE T2.food  =  "Cake" INTERSECT SELECT T1.receipt FROM items AS T1 JOIN goods AS T2 ON T1.item  =  T2.id WHERE T2.food  =  "Cookie"	bakery_1
SELECT T1.receipt FROM items AS T1 JOIN goods AS T2 ON T1.item  =  T2.id WHERE T2.food  =  "Cake" INTERSECT SELECT T1.receipt FROM items AS T1 JOIN goods AS T2 ON T1.item  =  T2.id WHERE T2.food  =  "Cookie"	bakery_1
SELECT T1.ReceiptNumber FROM receipts AS T1 JOIN items AS T2 ON T1.ReceiptNumber  =  T2.receipt JOIN goods AS T3 ON T2.item  =  T3.id JOIN customers AS T4 ON T4.Id  =  T1.CustomerId WHERE T3.food  =  "Croissant" AND T4.LastName  =  'LOGAN'	bakery_1
SELECT T1.ReceiptNumber FROM receipts AS T1 JOIN items AS T2 ON T1.ReceiptNumber  =  T2.receipt JOIN goods AS T3 ON T2.item  =  T3.id JOIN customers AS T4 ON T4.Id  =  T1.CustomerId WHERE T3.food  =  "Croissant" AND T4.LastName  =  'LOGAN'	bakery_1
SELECT T1.ReceiptNumber ,  T1.Date FROM receipts AS T1 JOIN items AS T2 ON T1.ReceiptNumber  =  T2.receipt JOIN goods AS T3 ON T2.item  =  T3.id ORDER BY T3.price DESC LIMIT 1	bakery_1
SELECT T1.ReceiptNumber ,  T1.Date FROM receipts AS T1 JOIN items AS T2 ON T1.ReceiptNumber  =  T2.receipt JOIN goods AS T3 ON T2.item  =  T3.id ORDER BY T3.price DESC LIMIT 1	bakery_1
SELECT item FROM items GROUP BY item ORDER BY count(*) LIMIT 1	bakery_1
SELECT item FROM items GROUP BY item ORDER BY count(*) LIMIT 1	bakery_1
SELECT count(*) ,  food FROM goods GROUP BY food	bakery_1
SELECT count(*) ,  food FROM goods GROUP BY food	bakery_1
SELECT avg(price) ,  food FROM goods GROUP BY food	bakery_1
SELECT avg(price) ,  food FROM goods GROUP BY food	bakery_1
SELECT id FROM goods WHERE flavor  =  "Apricot" AND price  <  5	bakery_1
SELECT id FROM goods WHERE flavor  =  "Apricot" AND price  <  5	bakery_1
SELECT flavor FROM goods WHERE food  =  "Cake" AND price  >  10	bakery_1
SELECT flavor FROM goods WHERE food  =  "Cake" AND price  >  10	bakery_1
SELECT DISTINCT id ,  price FROM goods WHERE price  <  (SELECT avg(price) FROM goods)	bakery_1
SELECT DISTINCT id ,  price FROM goods WHERE price  <  (SELECT avg(price) FROM goods)	bakery_1
SELECT DISTINCT id FROM goods WHERE price  <  (SELECT max(price) FROM goods WHERE food  =  "Tart")	bakery_1
SELECT DISTINCT id FROM goods WHERE price  <  (SELECT max(price) FROM goods WHERE food  =  "Tart")	bakery_1
SELECT DISTINCT T1.ReceiptNumber FROM receipts AS T1 JOIN items AS T2 ON T1.ReceiptNumber  =  T2.receipt JOIN goods AS T3 ON T2.item  =  T3.id WHERE T3.price  >  13	bakery_1
SELECT DISTINCT T1.ReceiptNumber FROM receipts AS T1 JOIN items AS T2 ON T1.ReceiptNumber  =  T2.receipt JOIN goods AS T3 ON T2.item  =  T3.id WHERE T3.price  >  13	bakery_1
SELECT DISTINCT T1.date FROM receipts AS T1 JOIN items AS T2 ON T1.ReceiptNumber  =  T2.receipt JOIN goods AS T3 ON T2.item  =  T3.id WHERE T3.price  >  15	bakery_1
SELECT DISTINCT T1.date FROM receipts AS T1 JOIN items AS T2 ON T1.ReceiptNumber  =  T2.receipt JOIN goods AS T3 ON T2.item  =  T3.id WHERE T3.price  >  15	bakery_1
SELECT id FROM goods WHERE id LIKE "%APP%"	bakery_1
SELECT id FROM goods WHERE id LIKE "%APP%"	bakery_1
SELECT id ,  price FROM goods WHERE id LIKE "%70%"	bakery_1
SELECT id ,  price FROM goods WHERE id LIKE "%70%"	bakery_1
SELECT DISTINCT LastName FROM customers ORDER BY LastName	bakery_1
SELECT DISTINCT LastName FROM customers ORDER BY LastName	bakery_1
SELECT DISTINCT id FROM goods ORDER BY id	bakery_1
SELECT DISTINCT id FROM goods ORDER BY id	bakery_1
SELECT T1.receipt FROM items AS T1 JOIN goods AS T2 ON T1.item  =  T2.id WHERE T2.flavor  =  "Apple" AND T2.food  =  "Pie" UNION SELECT ReceiptNumber FROM receipts WHERE CustomerId  =  12	bakery_1
SELECT T1.receipt FROM items AS T1 JOIN goods AS T2 ON T1.item  =  T2.id WHERE T2.flavor  =  "Apple" AND T2.food  =  "Pie" UNION SELECT ReceiptNumber FROM receipts WHERE CustomerId  =  12	bakery_1
SELECT ReceiptNumber ,  date FROM receipts WHERE date  =  (SELECT date FROM receipts ORDER BY date DESC LIMIT 1)	bakery_1
SELECT ReceiptNumber ,  date FROM receipts WHERE date  =  (SELECT date FROM receipts ORDER BY date DESC LIMIT 1)	bakery_1
SELECT T1.Receipt FROM items AS T1 JOIN goods AS T2 ON T1.item  =  T2.id WHERE T2.price  >  10 UNION SELECT ReceiptNumber FROM receipts WHERE date  =  (SELECT date FROM receipts ORDER BY date LIMIT 1)	bakery_1
SELECT T1.Receipt FROM items AS T1 JOIN goods AS T2 ON T1.item  =  T2.id WHERE T2.price  >  10 UNION SELECT ReceiptNumber FROM receipts WHERE date  =  (SELECT date FROM receipts ORDER BY date LIMIT 1)	bakery_1
SELECT id FROM goods WHERE food  =  "Cookie" OR food  =  "Cake" AND price BETWEEN 3 AND 7	bakery_1
SELECT id FROM goods WHERE food  =  "Cookie" OR food  =  "Cake" AND price BETWEEN 3 AND 7	bakery_1
SELECT T1.FirstName ,  T1.LastName FROM customers AS T1 JOIN receipts AS T2 ON T1.id  =  T2.CustomerId ORDER BY T2.date LIMIT 1	bakery_1
SELECT T1.FirstName ,  T1.LastName FROM customers AS T1 JOIN receipts AS T2 ON T1.id  =  T2.CustomerId ORDER BY T2.date LIMIT 1	bakery_1
SELECT avg(price) FROM goods WHERE flavor  =  "Blackberry" OR flavor  =  "Blueberry"	bakery_1
SELECT avg(price) FROM goods WHERE flavor  =  "Blackberry" OR flavor  =  "Blueberry"	bakery_1
SELECT min(price) FROM goods WHERE flavor  =  "Cheese"	bakery_1
SELECT min(price) FROM goods WHERE flavor  =  "Cheese"	bakery_1
SELECT max(price) ,  min(price) ,  avg(price) ,  flavor FROM goods GROUP BY flavor ORDER BY flavor	bakery_1
SELECT max(price) ,  min(price) ,  avg(price) ,  flavor FROM goods GROUP BY flavor ORDER BY flavor	bakery_1
SELECT min(price) ,  max(price) ,  food FROM goods GROUP BY food ORDER BY food	bakery_1
SELECT min(price) ,  max(price) ,  food FROM goods GROUP BY food ORDER BY food	bakery_1
SELECT date FROM receipts GROUP BY date ORDER BY count(*) DESC LIMIT 3	bakery_1
SELECT date FROM receipts GROUP BY date ORDER BY count(*) DESC LIMIT 3	bakery_1
SELECT CustomerId ,  count(*) FROM receipts GROUP BY CustomerId ORDER BY count(*) DESC LIMIT 1	bakery_1
SELECT CustomerId ,  count(*) FROM receipts GROUP BY CustomerId ORDER BY count(*) DESC LIMIT 1	bakery_1
SELECT date ,  COUNT (DISTINCT CustomerId) FROM receipts GROUP BY date	bakery_1
SELECT date ,  COUNT (DISTINCT CustomerId) FROM receipts GROUP BY date	bakery_1
SELECT DISTINCT T4.FirstName ,  T4.LastName FROM goods AS T1 JOIN items AS T2 ON T1.id  =  T2.item JOIN receipts AS T3 ON T2.receipt  =  T3.ReceiptNumber JOIN customers AS T4 ON T3.CustomerId  =  T4.id WHERE T1.flavor  =  "Apple" AND T1.food  =  "Tart"	bakery_1
SELECT DISTINCT T4.FirstName ,  T4.LastName FROM goods AS T1 JOIN items AS T2 ON T1.id  =  T2.item JOIN receipts AS T3 ON T2.receipt  =  T3.ReceiptNumber JOIN customers AS T4 ON T3.CustomerId  =  T4.id WHERE T1.flavor  =  "Apple" AND T1.food  =  "Tart"	bakery_1
SELECT id FROM goods WHERE food  =  "Cookie" AND price  <  (SELECT min(price) FROM goods WHERE food  =  'Croissant')	bakery_1
SELECT id FROM goods WHERE food  =  "Cookie" AND price  <  (SELECT min(price) FROM goods WHERE food  =  'Croissant')	bakery_1
SELECT id FROM goods WHERE food  =  "Cake" AND price  >=  (SELECT avg(price) FROM goods WHERE food  =  "Tart")	bakery_1
SELECT id FROM goods WHERE food  =  "Cake" AND price  >=  (SELECT avg(price) FROM goods WHERE food  =  "Tart")	bakery_1
SELECT id FROM goods WHERE price  >  (SELECT avg(price) FROM goods)	bakery_1
SELECT id FROM goods WHERE price  >  (SELECT avg(price) FROM goods)	bakery_1
SELECT id ,  flavor ,  food FROM goods ORDER BY price	bakery_1
SELECT id ,  flavor ,  food FROM goods ORDER BY price	bakery_1
SELECT id ,  flavor FROM goods WHERE food  =  "Cake" ORDER BY flavor	bakery_1
SELECT id ,  flavor FROM goods WHERE food  =  "Cake" ORDER BY flavor	bakery_1
SELECT DISTINCT T1.item FROM items AS T1 JOIN goods AS T2 ON T1.item  =  T2.id WHERE T2.flavor  =  "Chocolate" GROUP BY item HAVING count(*)  <=  10	bakery_1
SELECT DISTINCT T1.item FROM items AS T1 JOIN goods AS T2 ON T1.item  =  T2.id WHERE T2.flavor  =  "Chocolate" GROUP BY item HAVING count(*)  <=  10	bakery_1
SELECT DISTINCT flavor FROM goods WHERE food  =  "Cake" EXCEPT SELECT DISTINCT flavor FROM goods WHERE food  =  "Tart"	bakery_1
SELECT DISTINCT flavor FROM goods WHERE food  =  "Cake" EXCEPT SELECT DISTINCT flavor FROM goods WHERE food  =  "Tart"	bakery_1
SELECT item FROM items GROUP BY item ORDER BY COUNT (*) DESC LIMIT 3	bakery_1
SELECT item FROM items GROUP BY item ORDER BY COUNT (*) DESC LIMIT 3	bakery_1
SELECT T3.CustomerId FROM goods AS T1 JOIN items AS T2 ON T1.id  =  T2.item JOIN receipts AS T3 ON T2.receipt  =  T3.ReceiptNumber GROUP BY T3.CustomerId HAVING sum(T1.price)  >  150	bakery_1
SELECT T3.CustomerId FROM goods AS T1 JOIN items AS T2 ON T1.id  =  T2.item JOIN receipts AS T3 ON T2.receipt  =  T3.ReceiptNumber GROUP BY T3.CustomerId HAVING sum(T1.price)  >  150	bakery_1
SELECT T3.CustomerId FROM goods AS T1 JOIN items AS T2 ON T1.id  =  T2.item JOIN receipts AS T3 ON T2.receipt  =  T3.ReceiptNumber GROUP BY T3.CustomerId HAVING avg(T1.price)  >  5	bakery_1
SELECT T3.CustomerId FROM goods AS T1 JOIN items AS T2 ON T1.id  =  T2.item JOIN receipts AS T3 ON T2.receipt  =  T3.ReceiptNumber GROUP BY T3.CustomerId HAVING avg(T1.price)  >  5	bakery_1
SELECT T3.date FROM goods AS T1 JOIN items AS T2 ON T1.id  =  T2.item JOIN receipts AS T3 ON T2.receipt  =  T3.ReceiptNumber GROUP BY T3.date HAVING sum(T1.price)  >  100	bakery_1
SELECT T3.date FROM goods AS T1 JOIN items AS T2 ON T1.id  =  T2.item JOIN receipts AS T3 ON T2.receipt  =  T3.ReceiptNumber GROUP BY T3.date HAVING sum(T1.price)  >  100	bakery_1
SELECT count(*) FROM driver	car_racing
SELECT count(*) FROM driver	car_racing
SELECT make ,  count(*) FROM driver WHERE points  >  150 GROUP BY make	car_racing
SELECT make ,  count(*) FROM driver WHERE points  >  150 GROUP BY make	car_racing
SELECT avg(age) ,  Make FROM driver GROUP BY make	car_racing
SELECT avg(age) ,  Make FROM driver GROUP BY make	car_racing
SELECT avg(Laps) FROM driver WHERE age  <  20	car_racing
SELECT avg(Laps) FROM driver WHERE age  <  20	car_racing
SELECT Manager ,  Sponsor FROM team ORDER BY Car_Owner	car_racing
SELECT Manager ,  Sponsor FROM team ORDER BY Car_Owner	car_racing
SELECT make FROM team GROUP BY team HAVING count(*)  >  1	car_racing
SELECT make FROM team GROUP BY team HAVING count(*)  >  1	car_racing
SELECT Make FROM team WHERE Car_Owner  =  "Buddy Arrington"	car_racing
SELECT Make FROM team WHERE Car_Owner  =  "Buddy Arrington"	car_racing
SELECT max(Points) ,  min(Points) FROM driver	car_racing
SELECT max(Points) ,  min(Points) FROM driver	car_racing
SELECT count(*) FROM driver WHERE Points  <  150	car_racing
SELECT count(*) FROM driver WHERE Points  <  150	car_racing
SELECT Driver FROM driver ORDER BY Age ASC	car_racing
SELECT Driver FROM driver ORDER BY Age ASC	car_racing
SELECT Driver FROM driver ORDER BY Points DESC	car_racing
SELECT Driver FROM driver ORDER BY Points DESC	car_racing
SELECT T2.Driver ,  T1.Country FROM country AS T1 JOIN driver AS T2 ON T1.Country_ID  =  T2.Country	car_racing
SELECT T2.Driver ,  T1.Country FROM country AS T1 JOIN driver AS T2 ON T1.Country_ID  =  T2.Country	car_racing
SELECT max(T2.Points) FROM country AS T1 JOIN driver AS T2 ON T1.Country_ID  =  T2.Country WHERE T1.Capital  =  "Dublin"	car_racing
SELECT max(T2.Points) FROM country AS T1 JOIN driver AS T2 ON T1.Country_ID  =  T2.Country WHERE T1.Capital  =  "Dublin"	car_racing
SELECT avg(T2.age) FROM country AS T1 JOIN driver AS T2 ON T1.Country_ID  =  T2.Country WHERE T1.Official_native_language  =  "English"	car_racing
SELECT avg(T2.age) FROM country AS T1 JOIN driver AS T2 ON T1.Country_ID  =  T2.Country WHERE T1.Official_native_language  =  "English"	car_racing
SELECT T1.Country FROM country AS T1 JOIN driver AS T2 ON T1.Country_ID  =  T2.Country WHERE T2.Points  >  150	car_racing
SELECT T1.Country FROM country AS T1 JOIN driver AS T2 ON T1.Country_ID  =  T2.Country WHERE T2.Points  >  150	car_racing
SELECT T1.Capital FROM country AS T1 JOIN driver AS T2 ON T1.Country_ID  =  T2.Country ORDER BY T2.Points DESC LIMIT 1	car_racing
SELECT T1.Capital FROM country AS T1 JOIN driver AS T2 ON T1.Country_ID  =  T2.Country ORDER BY T2.Points DESC LIMIT 1	car_racing
SELECT Make ,  COUNT(*) FROM driver GROUP BY Make	car_racing
SELECT Make ,  COUNT(*) FROM driver GROUP BY Make	car_racing
SELECT Make FROM driver GROUP BY Make ORDER BY COUNT(*) DESC LIMIT 1	car_racing
SELECT Make FROM driver GROUP BY Make ORDER BY COUNT(*) DESC LIMIT 1	car_racing
SELECT Make FROM driver GROUP BY Make HAVING COUNT(*)  >=  3	car_racing
SELECT Make FROM driver GROUP BY Make HAVING COUNT(*)  >=  3	car_racing
SELECT Team FROM team WHERE Team_ID NOT IN (SELECT Team_ID FROM team_driver)	car_racing
SELECT Team FROM team WHERE Team_ID NOT IN (SELECT Team_ID FROM team_driver)	car_racing
SELECT t2.country FROM driver AS t1 JOIN country AS t2 ON t1.country  =  t2.country_id WHERE t1.Make  =  "Dodge" INTERSECT SELECT t2.country FROM driver AS t1 JOIN country AS t2 ON t1.country  =  t2.country_id WHERE t1.Make  =  "Chevrolet"	car_racing
SELECT t2.country FROM driver AS t1 JOIN country AS t2 ON t1.country  =  t2.country_id WHERE t1.Make  =  "Dodge" INTERSECT SELECT t2.country FROM driver AS t1 JOIN country AS t2 ON t1.country  =  t2.country_id WHERE t1.Make  =  "Chevrolet"	car_racing
SELECT sum(Points) ,  avg(Points) FROM driver	car_racing
SELECT sum(Points) ,  avg(Points) FROM driver	car_racing
SELECT country FROM country WHERE country_id NOT IN (SELECT country FROM driver)	car_racing
SELECT country FROM country WHERE country_id NOT IN (SELECT country FROM driver)	car_racing
SELECT t1.manager ,  t1.sponsor FROM team AS t1 JOIN team_driver AS t2 ON t1.team_id  =  t2.team_id GROUP BY t2.team_id ORDER BY count(*) DESC LIMIT 1	car_racing
SELECT t1.manager ,  t1.sponsor FROM team AS t1 JOIN team_driver AS t2 ON t1.team_id  =  t2.team_id GROUP BY t2.team_id ORDER BY count(*) DESC LIMIT 1	car_racing
SELECT t1.manager ,  t1.car_owner FROM team AS t1 JOIN team_driver AS t2 ON t1.team_id  =  t2.team_id GROUP BY t2.team_id HAVING count(*)  >=  2	car_racing
SELECT t1.manager ,  t1.car_owner FROM team AS t1 JOIN team_driver AS t2 ON t1.team_id  =  t2.team_id GROUP BY t2.team_id HAVING count(*)  >=  2	car_racing
SELECT count(*) FROM institution	institution_sports
SELECT count(*) FROM institution	institution_sports
SELECT Name FROM institution ORDER BY Name ASC	institution_sports
SELECT Name FROM institution ORDER BY Name ASC	institution_sports
SELECT Name FROM institution ORDER BY Founded ASC	institution_sports
SELECT Name FROM institution ORDER BY Founded ASC	institution_sports
SELECT City ,  Province FROM institution	institution_sports
SELECT City ,  Province FROM institution	institution_sports
SELECT max(Enrollment) ,  min(Enrollment) FROM institution	institution_sports
SELECT max(Enrollment) ,  min(Enrollment) FROM institution	institution_sports
SELECT Affiliation FROM institution WHERE City != "Vancouver"	institution_sports
SELECT Affiliation FROM institution WHERE City != "Vancouver"	institution_sports
SELECT Stadium FROM institution ORDER BY Capacity DESC	institution_sports
SELECT Stadium FROM institution ORDER BY Capacity DESC	institution_sports
SELECT Stadium FROM institution ORDER BY Enrollment DESC LIMIT 1	institution_sports
SELECT Stadium FROM institution ORDER BY Enrollment DESC LIMIT 1	institution_sports
SELECT T2.Name ,  T1.Nickname FROM championship AS T1 JOIN institution AS T2 ON T1.Institution_ID  =  T2.Institution_ID	institution_sports
SELECT T2.Name ,  T1.Nickname FROM championship AS T1 JOIN institution AS T2 ON T1.Institution_ID  =  T2.Institution_ID	institution_sports
SELECT T1.Nickname FROM championship AS T1 JOIN institution AS T2 ON T1.Institution_ID  =  T2.Institution_ID ORDER BY T2.Enrollment ASC LIMIT 1	institution_sports
SELECT T1.Nickname FROM championship AS T1 JOIN institution AS T2 ON T1.Institution_ID  =  T2.Institution_ID ORDER BY T2.Enrollment ASC LIMIT 1	institution_sports
SELECT T2.Name FROM championship AS T1 JOIN institution AS T2 ON T1.Institution_ID  =  T2.Institution_ID ORDER BY T1.Number_of_Championships DESC	institution_sports
SELECT T2.Name FROM championship AS T1 JOIN institution AS T2 ON T1.Institution_ID  =  T2.Institution_ID ORDER BY T1.Number_of_Championships DESC	institution_sports
SELECT T2.Name FROM championship AS T1 JOIN institution AS T2 ON T1.Institution_ID  =  T2.Institution_ID WHERE T1.Number_of_Championships  >=  1	institution_sports
SELECT T2.Name FROM championship AS T1 JOIN institution AS T2 ON T1.Institution_ID  =  T2.Institution_ID WHERE T1.Number_of_Championships  >=  1	institution_sports
SELECT sum(T1.Number_of_Championships) FROM championship AS T1 JOIN institution AS T2 ON T1.Institution_ID  =  T2.Institution_ID WHERE T2.Affiliation  =  "Public"	institution_sports
SELECT sum(T1.Number_of_Championships) FROM championship AS T1 JOIN institution AS T2 ON T1.Institution_ID  =  T2.Institution_ID WHERE T2.Affiliation  =  "Public"	institution_sports
SELECT Affiliation ,  COUNT(*) FROM institution GROUP BY Affiliation	institution_sports
SELECT Affiliation ,  COUNT(*) FROM institution GROUP BY Affiliation	institution_sports
SELECT Affiliation FROM institution GROUP BY Affiliation ORDER BY COUNT(*) DESC LIMIT 1	institution_sports
SELECT Affiliation FROM institution GROUP BY Affiliation ORDER BY COUNT(*) DESC LIMIT 1	institution_sports
SELECT Founded ,  COUNT(*) FROM institution GROUP BY Founded HAVING COUNT(*)  >  1	institution_sports
SELECT Founded ,  COUNT(*) FROM institution GROUP BY Founded HAVING COUNT(*)  >  1	institution_sports
SELECT T1.Nickname FROM championship AS T1 JOIN institution AS T2 ON T1.Institution_ID  =  T2.Institution_ID ORDER BY T2.Capacity DESC	institution_sports
SELECT T1.Nickname FROM championship AS T1 JOIN institution AS T2 ON T1.Institution_ID  =  T2.Institution_ID ORDER BY T2.Capacity DESC	institution_sports
select sum(enrollment) from institution where city  =  "vancouver" or city  =  "calgary"	institution_sports
select sum(enrollment) from institution where city  =  "vancouver" or city  =  "calgary"	institution_sports
SELECT Province FROM institution WHERE Founded  <  1920 INTERSECT SELECT Province FROM institution WHERE Founded  >  1950	institution_sports
SELECT Province FROM institution WHERE Founded  <  1920 INTERSECT SELECT Province FROM institution WHERE Founded  >  1950	institution_sports
SELECT count(DISTINCT Province) FROM institution	institution_sports
SELECT count(DISTINCT Province) FROM institution	institution_sports
SELECT * FROM warehouses	warehouse_1
SELECT * FROM warehouses	warehouse_1
SELECT DISTINCT T1.contents FROM boxes AS T1 JOIN warehouses AS T2 ON T1.warehouse  =  T2.code WHERE LOCATION  =  'New York'	warehouse_1
SELECT DISTINCT T1.contents FROM boxes AS T1 JOIN warehouses AS T2 ON T1.warehouse  =  T2.code WHERE LOCATION  =  'New York'	warehouse_1
SELECT CONTENTS FROM boxes WHERE Value  >  150	warehouse_1
SELECT CONTENTS FROM boxes WHERE Value  >  150	warehouse_1
SELECT warehouse ,  avg(value) FROM boxes GROUP BY warehouse	warehouse_1
SELECT warehouse ,  avg(value) FROM boxes GROUP BY warehouse	warehouse_1
SELECT avg(value) ,  sum(value) FROM boxes	warehouse_1
SELECT avg(value) ,  sum(value) FROM boxes	warehouse_1
SELECT avg(capacity) ,  sum(capacity) FROM warehouses	warehouse_1
SELECT avg(capacity) ,  sum(capacity) FROM warehouses	warehouse_1
SELECT avg(value) ,  max(value) ,  CONTENTS FROM boxes GROUP BY CONTENTS	warehouse_1
SELECT avg(value) ,  max(value) ,  CONTENTS FROM boxes GROUP BY CONTENTS	warehouse_1
SELECT CONTENTS FROM boxes ORDER BY value DESC LIMIT 1	warehouse_1
SELECT CONTENTS FROM boxes ORDER BY value DESC LIMIT 1	warehouse_1
SELECT avg(value) FROM boxes	warehouse_1
SELECT avg(value) FROM boxes	warehouse_1
SELECT DISTINCT CONTENTS FROM boxes	warehouse_1
SELECT DISTINCT CONTENTS FROM boxes	warehouse_1
SELECT count(DISTINCT CONTENTS) FROM boxes	warehouse_1
SELECT count(DISTINCT CONTENTS) FROM boxes	warehouse_1
SELECT count(DISTINCT LOCATION) FROM warehouses	warehouse_1
SELECT count(DISTINCT LOCATION) FROM warehouses	warehouse_1
SELECT T1.code FROM boxes AS T1 JOIN warehouses AS T2 ON T1.warehouse  =  T2.code WHERE T2.location  =  'Chicago' OR T2.location  =  'New York'	warehouse_1
SELECT T1.code FROM boxes AS T1 JOIN warehouses AS T2 ON T1.warehouse  =  T2.code WHERE T2.location  =  'Chicago' OR T2.location  =  'New York'	warehouse_1
SELECT sum(T1.value) FROM boxes AS T1 JOIN warehouses AS T2 ON T1.warehouse  =  T2.code WHERE T2.location  =  'Chicago' OR T2.location  =  'New York'	warehouse_1
SELECT sum(T1.value) FROM boxes AS T1 JOIN warehouses AS T2 ON T1.warehouse  =  T2.code WHERE T2.location  =  'Chicago' OR T2.location  =  'New York'	warehouse_1
SELECT T1.contents FROM boxes AS T1 JOIN warehouses AS T2 ON T1.warehouse  =  T2.code WHERE T2.location  =  'Chicago' INTERSECT SELECT T1.contents FROM boxes AS T1 JOIN warehouses AS T2 ON T1.warehouse  =  T2.code WHERE T2.location  =  'New York'	warehouse_1
SELECT T1.contents FROM boxes AS T1 JOIN warehouses AS T2 ON T1.warehouse  =  T2.code WHERE T2.location  =  'Chicago' INTERSECT SELECT T1.contents FROM boxes AS T1 JOIN warehouses AS T2 ON T1.warehouse  =  T2.code WHERE T2.location  =  'New York'	warehouse_1
SELECT CONTENTS FROM boxes EXCEPT SELECT T1.contents FROM boxes AS T1 JOIN warehouses AS T2 ON T1.warehouse  =  T2.code WHERE T2.location  =  'New York'	warehouse_1
SELECT CONTENTS FROM boxes EXCEPT SELECT T1.contents FROM boxes AS T1 JOIN warehouses AS T2 ON T1.warehouse  =  T2.code WHERE T2.location  =  'New York'	warehouse_1
SELECT T2.location FROM boxes AS T1 JOIN warehouses AS T2 ON T1.warehouse  =  T2.code WHERE T1.contents  =  'Rocks' EXCEPT SELECT T2.location FROM boxes AS T1 JOIN warehouses AS T2 ON T1.warehouse  =  T2.code WHERE T1.contents  =  'Scissors'	warehouse_1
SELECT T2.location FROM boxes AS T1 JOIN warehouses AS T2 ON T1.warehouse  =  T2.code WHERE T1.contents  =  'Rocks' EXCEPT SELECT T2.location FROM boxes AS T1 JOIN warehouses AS T2 ON T1.warehouse  =  T2.code WHERE T1.contents  =  'Scissors'	warehouse_1
SELECT DISTINCT warehouse FROM boxes WHERE CONTENTS  =  'Rocks' OR CONTENTS  =  'Scissors'	warehouse_1
SELECT DISTINCT warehouse FROM boxes WHERE CONTENTS  =  'Rocks' OR CONTENTS  =  'Scissors'	warehouse_1
SELECT T2.location FROM boxes AS T1 JOIN warehouses AS T2 ON T1.warehouse  =  T2.code WHERE T1.contents  =  'Rocks' INTERSECT SELECT T2.location FROM boxes AS T1 JOIN warehouses AS T2 ON T1.warehouse  =  T2.code WHERE T1.contents  =  'Scissors'	warehouse_1
SELECT T2.location FROM boxes AS T1 JOIN warehouses AS T2 ON T1.warehouse  =  T2.code WHERE T1.contents  =  'Rocks' INTERSECT SELECT T2.location FROM boxes AS T1 JOIN warehouses AS T2 ON T1.warehouse  =  T2.code WHERE T1.contents  =  'Scissors'	warehouse_1
SELECT code ,  CONTENTS FROM boxes ORDER BY value	warehouse_1
SELECT code ,  CONTENTS FROM boxes ORDER BY value	warehouse_1
SELECT code ,  CONTENTS FROM boxes ORDER BY value LIMIT 1	warehouse_1
SELECT code ,  CONTENTS FROM boxes ORDER BY value LIMIT 1	warehouse_1
SELECT DISTINCT CONTENTS FROM boxes WHERE value  >  (SELECT avg(value) FROM boxes)	warehouse_1
SELECT DISTINCT CONTENTS FROM boxes WHERE value  >  (SELECT avg(value) FROM boxes)	warehouse_1
SELECT DISTINCT CONTENTS FROM boxes ORDER BY CONTENTS	warehouse_1
SELECT DISTINCT CONTENTS FROM boxes ORDER BY CONTENTS	warehouse_1
SELECT code FROM boxes WHERE value  >  (SELECT min(value) FROM boxes WHERE CONTENTS  =  'Rocks')	warehouse_1
SELECT code FROM boxes WHERE value  >  (SELECT min(value) FROM boxes WHERE CONTENTS  =  'Rocks')	warehouse_1
SELECT code ,  CONTENTS FROM boxes WHERE value  >  (SELECT max(value) FROM boxes WHERE CONTENTS  =  'Scissors')	warehouse_1
SELECT code ,  CONTENTS FROM boxes WHERE value  >  (SELECT max(value) FROM boxes WHERE CONTENTS  =  'Scissors')	warehouse_1
SELECT sum(T1.value) FROM boxes AS T1 JOIN warehouses AS T2 ON T1.warehouse  =  T2.code ORDER BY T2.capacity DESC LIMIT 1	warehouse_1
SELECT sum(T1.value) FROM boxes AS T1 JOIN warehouses AS T2 ON T1.warehouse  =  T2.code ORDER BY T2.capacity DESC LIMIT 1	warehouse_1
SELECT warehouse ,  avg(value) FROM boxes GROUP BY warehouse HAVING avg(value)  >  150	warehouse_1
SELECT warehouse ,  avg(value) FROM boxes GROUP BY warehouse HAVING avg(value)  >  150	warehouse_1
SELECT sum(value) ,  count(*) ,  CONTENTS FROM boxes GROUP BY CONTENTS	warehouse_1
SELECT sum(value) ,  count(*) ,  CONTENTS FROM boxes GROUP BY CONTENTS	warehouse_1
SELECT sum(capacity) ,  avg(capacity) ,  max(capacity) ,  LOCATION FROM warehouses GROUP BY LOCATION	warehouse_1
SELECT sum(capacity) ,  avg(capacity) ,  max(capacity) ,  LOCATION FROM warehouses GROUP BY LOCATION	warehouse_1
SELECT sum(capacity) FROM warehouses	warehouse_1
SELECT sum(capacity) FROM warehouses	warehouse_1
SELECT max(T1.value) ,  T2.location FROM boxes AS T1 JOIN warehouses AS T2 ON T1.warehouse  =  T2.code GROUP BY T2.location	warehouse_1
SELECT max(T1.value) ,  T2.location FROM boxes AS T1 JOIN warehouses AS T2 ON T1.warehouse  =  T2.code GROUP BY T2.location	warehouse_1
SELECT Warehouse ,  count(*) FROM boxes GROUP BY warehouse	warehouse_1
select warehouse ,  count(*) from boxes group by warehouse	warehouse_1
SELECT count(DISTINCT LOCATION) FROM boxes AS T1 JOIN warehouses AS T2 ON T1.warehouse  =  T2.code WHERE T1.contents  =  'Rocks'	warehouse_1
SELECT count(DISTINCT LOCATION) FROM boxes AS T1 JOIN warehouses AS T2 ON T1.warehouse  =  T2.code WHERE T1.contents  =  'Rocks'	warehouse_1
SELECT T1.code ,  T2.location FROM boxes AS T1 JOIN warehouses AS T2 ON T1.Warehouse  =  T2.Code	warehouse_1
SELECT T1.code ,  T2.location FROM boxes AS T1 JOIN warehouses AS T2 ON T1.Warehouse  =  T2.Code	warehouse_1
SELECT T1.code FROM boxes AS T1 JOIN Warehouses AS T2 ON T1.warehouse  =  T2.code WHERE T2.location  =  'Chicago'	warehouse_1
SELECT T1.code FROM boxes AS T1 JOIN Warehouses AS T2 ON T1.warehouse  =  T2.code WHERE T2.location  =  'Chicago'	warehouse_1
SELECT count(*) ,  warehouse FROM boxes GROUP BY warehouse	warehouse_1
SELECT count(*) ,  warehouse FROM boxes GROUP BY warehouse	warehouse_1
SELECT count(DISTINCT CONTENTS) ,  warehouse FROM boxes GROUP BY warehouse	warehouse_1
SELECT count(DISTINCT CONTENTS) ,  warehouse FROM boxes GROUP BY warehouse	warehouse_1
SELECT T2.code FROM boxes AS T1 JOIN Warehouses AS T2 ON T1.warehouse  =  T2.code GROUP BY T2.code HAVING count(*)  >  T2.capacity	warehouse_1
SELECT T2.code FROM boxes AS T1 JOIN Warehouses AS T2 ON T1.warehouse  =  T2.code GROUP BY T2.code HAVING count(*)  >  T2.capacity	warehouse_1
SELECT sum(T1.value) FROM boxes AS T1 JOIN Warehouses AS T2 ON T1.warehouse  =  T2.code WHERE T2.location != 'Chicago'	warehouse_1
SELECT sum(T1.value) FROM boxes AS T1 JOIN Warehouses AS T2 ON T1.warehouse  =  T2.code WHERE T2.location != 'Chicago'	warehouse_1
SELECT university_name ,  city ,  state FROM University ORDER BY university_name	university_rank
SELECT university_name ,  city ,  state FROM University ORDER BY university_name	university_rank
SELECT count(*) FROM University WHERE state  =  'Illinois' OR state  =  'Ohio'	university_rank
SELECT count(*) FROM University WHERE state  =  'Illinois' OR state  =  'Ohio'	university_rank
SELECT max(enrollment) ,  avg(enrollment) ,  min(enrollment) FROM University	university_rank
SELECT max(enrollment) ,  avg(enrollment) ,  min(enrollment) FROM University	university_rank
SELECT team_name FROM University WHERE enrollment  >  (SELECT avg(enrollment) FROM University)	university_rank
select team_name from university where enrollment  >  (select avg(enrollment) from university)	university_rank
SELECT DISTINCT home_conference FROM University	university_rank
SELECT DISTINCT home_conference FROM University	university_rank
SELECT home_conference ,  count(*) FROM University GROUP BY home_conference	university_rank
SELECT home_conference ,  count(*) FROM University GROUP BY home_conference	university_rank
SELECT state FROM University GROUP BY state ORDER BY count(*) DESC LIMIT 1	university_rank
SELECT state FROM University GROUP BY state ORDER BY count(*) DESC LIMIT 1	university_rank
SELECT home_conference FROM University GROUP BY home_conference HAVING avg(enrollment)  >  2000	university_rank
SELECT home_conference FROM University GROUP BY home_conference HAVING avg(enrollment)  >  2000	university_rank
SELECT home_conference FROM University GROUP BY home_conference ORDER BY sum(enrollment) LIMIT 1	university_rank
SELECT home_conference FROM University GROUP BY home_conference ORDER BY sum(enrollment) LIMIT 1	university_rank
SELECT major_name ,  major_code FROM Major ORDER BY major_code	university_rank
SELECT major_name ,  major_code FROM Major ORDER BY major_code	university_rank
SELECT T1.rank ,  T3.major_name FROM Major_Ranking AS T1 JOIN University AS T2 JOIN Major AS T3 ON T1.university_id  =  T2.university_id AND T1.major_id  =  T3.major_id WHERE T2.university_name  =  'Augustana College'	university_rank
SELECT T1.rank ,  T3.major_name FROM Major_Ranking AS T1 JOIN University AS T2 JOIN Major AS T3 ON T1.university_id  =  T2.university_id AND T1.major_id  =  T3.major_id WHERE T2.university_name  =  'Augustana College'	university_rank
SELECT T2.university_name ,  T2.city ,  T2.state FROM Major_Ranking AS T1 JOIN University AS T2 JOIN Major AS T3 ON T1.university_id  =  T2.university_id AND T1.major_id  =  T3.major_id WHERE T1.rank  =  1 AND T3.major_name  =  'Accounting'	university_rank
SELECT T2.university_name ,  T2.city ,  T2.state FROM Major_Ranking AS T1 JOIN University AS T2 JOIN Major AS T3 ON T1.university_id  =  T2.university_id AND T1.major_id  =  T3.major_id WHERE T1.rank  =  1 AND T3.major_name  =  'Accounting'	university_rank
SELECT T2.university_name FROM Major_Ranking AS T1 JOIN University AS T2 ON T1.university_id  =  T2.university_id WHERE T1.rank  =  1 GROUP BY T2.university_name ORDER BY count(*) DESC LIMIT 1	university_rank
SELECT T2.university_name FROM Major_Ranking AS T1 JOIN University AS T2 ON T1.university_id  =  T2.university_id WHERE T1.rank  =  1 GROUP BY T2.university_name ORDER BY count(*) DESC LIMIT 1	university_rank
SELECT university_name FROM University EXCEPT SELECT T2.university_name FROM Major_Ranking AS T1 JOIN University AS T2 ON T1.university_id  =  T2.university_id WHERE T1.rank  =  1	university_rank
SELECT university_name FROM University EXCEPT SELECT T2.university_name FROM Major_Ranking AS T1 JOIN University AS T2 ON T1.university_id  =  T2.university_id WHERE T1.rank  =  1	university_rank
SELECT T2.university_name FROM Major_Ranking AS T1 JOIN University AS T2 JOIN Major AS T3 ON T1.university_id  =  T2.university_id AND T1.major_id  =  T3.major_id WHERE T3.major_name  =  'Accounting' INTERSECT SELECT T2.university_name FROM Major_Ranking AS T1 JOIN University AS T2 JOIN Major AS T3 ON T1.university_id  =  T2.university_id AND T1.major_id  =  T3.major_id WHERE T3.major_name  =  'Urban Education'	university_rank
SELECT T2.university_name FROM Major_Ranking AS T1 JOIN University AS T2 JOIN Major AS T3 ON T1.university_id  =  T2.university_id AND T1.major_id  =  T3.major_id WHERE T3.major_name  =  'Accounting' INTERSECT SELECT T2.university_name FROM Major_Ranking AS T1 JOIN University AS T2 JOIN Major AS T3 ON T1.university_id  =  T2.university_id AND T1.major_id  =  T3.major_id WHERE T3.major_name  =  'Urban Education'	university_rank
SELECT T1.university_name ,  T2.rank FROM University AS T1 JOIN Overall_ranking AS T2 ON T1.university_id  =  T2.university_id WHERE T1.state  =  'Wisconsin'	university_rank
SELECT T1.university_name ,  T2.rank FROM University AS T1 JOIN Overall_ranking AS T2 ON T1.university_id  =  T2.university_id WHERE T1.state  =  'Wisconsin'	university_rank
SELECT T1.university_name FROM University AS T1 JOIN Overall_ranking AS T2 ON T1.university_id  =  T2.university_id ORDER BY T2.research_point DESC LIMIT 1	university_rank
SELECT T1.university_name FROM University AS T1 JOIN Overall_ranking AS T2 ON T1.university_id  =  T2.university_id ORDER BY T2.research_point DESC LIMIT 1	university_rank
SELECT T1.university_name FROM University AS T1 JOIN Overall_ranking AS T2 ON T1.university_id  =  T2.university_id ORDER BY T2.reputation_point	university_rank
SELECT T1.university_name FROM University AS T1 JOIN Overall_ranking AS T2 ON T1.university_id  =  T2.university_id ORDER BY T2.reputation_point	university_rank
SELECT T2.university_name FROM Major_Ranking AS T1 JOIN University AS T2 JOIN Major AS T3 ON T1.university_id  =  T2.university_id AND T1.major_id  =  T3.major_id WHERE T1.rank  <=  3 AND T3.major_name  =  "Accounting"	university_rank
SELECT T2.university_name FROM Major_Ranking AS T1 JOIN University AS T2 JOIN Major AS T3 ON T1.university_id  =  T2.university_id AND T1.major_id  =  T3.major_id WHERE T1.rank  <=  3 AND T3.major_name  =  "Accounting"	university_rank
SELECT sum(enrollment) FROM University AS T1 JOIN Overall_ranking AS T2 ON T1.university_id  =  T2.university_id WHERE T2.rank  >=  5	university_rank
SELECT sum(enrollment) FROM University AS T1 JOIN Overall_ranking AS T2 ON T1.university_id  =  T2.university_id WHERE T2.rank  >=  5	university_rank
SELECT T1.University_Name ,  T2.Citation_point FROM University AS T1 JOIN Overall_ranking AS T2 ON T1.university_id  =  T2.university_id ORDER BY T2.Reputation_point DESC LIMIT 3	university_rank
SELECT T1.University_Name ,  T2.Citation_point FROM University AS T1 JOIN Overall_ranking AS T2 ON T1.university_id  =  T2.university_id ORDER BY T2.Reputation_point DESC LIMIT 3	university_rank
SELECT state FROM university WHERE enrollment  <  3000 GROUP BY state HAVING count(*)  >  2	university_rank
SELECT state FROM university WHERE enrollment  <  3000 GROUP BY state HAVING count(*)  >  2	university_rank
SELECT title FROM movies WHERE rating  =  'null'	movie_2
SELECT title FROM movies WHERE rating  =  'null'	movie_2
SELECT title FROM movies WHERE rating  =  'G'	movie_2
SELECT title FROM movies WHERE rating  =  'G'	movie_2
SELECT T1.title FROM movies AS T1 JOIN movietheaters AS T2 ON T1.code  =  T2.movie WHERE T2.name  =  'Odeon'	movie_2
SELECT T1.title FROM movies AS T1 JOIN movietheaters AS T2 ON T1.code  =  T2.movie WHERE T2.name  =  'Odeon'	movie_2
SELECT T1.title ,  T2.name FROM movies AS T1 JOIN movietheaters AS T2 ON T1.code  =  T2.movie	movie_2
SELECT T1.title ,  T2.name FROM movies AS T1 JOIN movietheaters AS T2 ON T1.code  =  T2.movie	movie_2
SELECT count(*) FROM movies WHERE rating  =  'G'	movie_2
SELECT count(*) FROM movies WHERE rating  =  'G'	movie_2
SELECT count(*) FROM movies AS T1 JOIN movietheaters AS T2 ON T1.code  =  T2.movie	movie_2
SELECT count(*) FROM movies AS T1 JOIN movietheaters AS T2 ON T1.code  =  T2.movie	movie_2
SELECT count(DISTINCT T1.code) FROM movies AS T1 JOIN movietheaters AS T2 ON T1.code  =  T2.movie	movie_2
SELECT count(DISTINCT T1.code) FROM movies AS T1 JOIN movietheaters AS T2 ON T1.code  =  T2.movie	movie_2
SELECT count(DISTINCT name) FROM movietheaters	movie_2
SELECT count(DISTINCT name) FROM movietheaters	movie_2
SELECT rating FROM movies WHERE title LIKE '%Citizen%'	movie_2
SELECT rating FROM movies WHERE title LIKE '%Citizen%'	movie_2
SELECT title FROM movies WHERE rating  =  'G' OR rating  =  'PG'	movie_2
SELECT title FROM movies WHERE rating  =  'G' OR rating  =  'PG'	movie_2
SELECT T1.title FROM movies AS T1 JOIN movietheaters AS T2 ON T1.code  =  T2.movie WHERE T2.name  =  'Odeon' OR T2.name  =  'Imperial'	movie_2
SELECT T1.title FROM movies AS T1 JOIN movietheaters AS T2 ON T1.code  =  T2.movie WHERE T2.name  =  'Odeon' OR T2.name  =  'Imperial'	movie_2
SELECT T1.title FROM movies AS T1 JOIN movietheaters AS T2 ON T1.code  =  T2.movie WHERE T2.name  =  'Odeon' INTERSECT SELECT T1.title FROM movies AS T1 JOIN movietheaters AS T2 ON T1.code  =  T2.movie WHERE T2.name  =  'Imperial'	movie_2
SELECT T1.title FROM movies AS T1 JOIN movietheaters AS T2 ON T1.code  =  T2.movie WHERE T2.name  =  'Odeon' INTERSECT SELECT T1.title FROM movies AS T1 JOIN movietheaters AS T2 ON T1.code  =  T2.movie WHERE T2.name  =  'Imperial'	movie_2
SELECT title FROM movies EXCEPT SELECT T1.title FROM movies AS T1 JOIN movietheaters AS T2 ON T1.code  =  T2.movie WHERE T2.name  =  'Odeon'	movie_2
SELECT title FROM movies EXCEPT SELECT T1.title FROM movies AS T1 JOIN movietheaters AS T2 ON T1.code  =  T2.movie WHERE T2.name  =  'Odeon'	movie_2
SELECT title FROM movies ORDER BY title	movie_2
SELECT title FROM movies ORDER BY title	movie_2
SELECT title FROM movies ORDER BY rating	movie_2
SELECT title FROM movies ORDER BY rating	movie_2
SELECT name FROM movietheaters GROUP BY name ORDER BY count(*) DESC LIMIT 1	movie_2
SELECT name FROM movietheaters GROUP BY name ORDER BY count(*) DESC LIMIT 1	movie_2
SELECT T1.title FROM movies AS T1 JOIN movietheaters AS T2 ON T1.code  =  T2.movie GROUP BY T1.title ORDER BY count(*) DESC LIMIT 1	movie_2
SELECT T1.title FROM movies AS T1 JOIN movietheaters AS T2 ON T1.code  =  T2.movie GROUP BY T1.title ORDER BY count(*) DESC LIMIT 1	movie_2
SELECT count(*) ,  rating FROM movies GROUP BY rating	movie_2
SELECT count(*) ,  rating FROM movies GROUP BY rating	movie_2
SELECT count(*) ,  rating FROM movies WHERE rating != 'null' GROUP BY rating	movie_2
SELECT count(*) ,  rating FROM movies WHERE rating != 'null' GROUP BY rating	movie_2
SELECT name FROM movietheaters GROUP BY name HAVING count(*)  >=  1	movie_2
SELECT name FROM movietheaters GROUP BY name HAVING count(*)  >=  1	movie_2
SELECT DISTINCT name FROM MovieTheaters WHERE Movie  =  'null'	movie_2
SELECT DISTINCT name FROM MovieTheaters WHERE Movie  =  'null'	movie_2
SELECT T2.name FROM movies AS T1 JOIN movietheaters AS T2 ON T1.code  =  T2.movie WHERE T1.rating  =  'G'	movie_2
SELECT T2.name FROM movies AS T1 JOIN movietheaters AS T2 ON T1.code  =  T2.movie WHERE T1.rating  =  'G'	movie_2
SELECT title FROM movies	movie_2
SELECT title FROM movies	movie_2
SELECT DISTINCT rating FROM movies	movie_2
SELECT DISTINCT rating FROM movies	movie_2
SELECT * FROM movies WHERE rating  =  'null'	movie_2
SELECT * FROM movies WHERE rating  =  'null'	movie_2
SELECT Title FROM Movies WHERE Code NOT IN (SELECT Movie FROM MovieTheaters WHERE Movie != 'null')	movie_2
SELECT Title FROM Movies WHERE Code NOT IN (SELECT Movie FROM MovieTheaters WHERE Movie != 'null')	movie_2
SELECT T2.Name FROM PACKAGE AS T1 JOIN Client AS T2 ON T1.Recipient  =  T2.AccountNumber ORDER BY T1.Weight DESC LIMIT 1	planet_1
SELECT T2.Name FROM PACKAGE AS T1 JOIN Client AS T2 ON T1.Recipient  =  T2.AccountNumber ORDER BY T1.Weight DESC LIMIT 1	planet_1
SELECT sum(T1.Weight) FROM PACKAGE AS T1 JOIN Client AS T2 ON T1.Sender  =  T2.AccountNumber WHERE T2.Name  =  "Leo Wong";	planet_1
SELECT sum(T1.Weight) FROM PACKAGE AS T1 JOIN Client AS T2 ON T1.Sender  =  T2.AccountNumber WHERE T2.Name  =  "Leo Wong";	planet_1
SELECT POSITION FROM Employee WHERE Name  =  "Amy Wong";	planet_1
SELECT POSITION FROM Employee WHERE Name  =  "Amy Wong";	planet_1
SELECT Salary ,  POSITION FROM Employee WHERE Name  =  "Turanga Leela";	planet_1
SELECT Salary ,  POSITION FROM Employee WHERE Name  =  "Turanga Leela";	planet_1
SELECT avg(Salary) FROM Employee WHERE POSITION  =  "Intern";	planet_1
SELECT avg(Salary) FROM Employee WHERE POSITION  =  "Intern";	planet_1
SELECT T1.Level FROM Has_Clearance AS T1 JOIN Employee AS T2 ON T1.Employee = T2.EmployeeID WHERE T2.position  =  "Physician";	planet_1
SELECT T1.Level FROM Has_Clearance AS T1 JOIN Employee AS T2 ON T1.Employee = T2.EmployeeID WHERE T2.position  =  "Physician";	planet_1
SELECT T1.PackageNumber FROM PACKAGE AS T1 JOIN Client AS T2 ON T1.Sender  =  T2.AccountNumber WHERE T2.Name  =  "Leo Wong";	planet_1
SELECT T1.PackageNumber FROM PACKAGE AS T1 JOIN Client AS T2 ON T1.Sender  =  T2.AccountNumber WHERE T2.Name  =  "Leo Wong";	planet_1
select t1.packagenumber from package as t1 join client as t2 on t1.recipient  =  t2.accountnumber where t2.name = "leo wong";	planet_1
SELECT T1.PackageNumber FROM PACKAGE AS T1 JOIN Client AS T2 ON T1.Recipient  =  T2.AccountNumber WHERE T2.Name = "Leo Wong";	planet_1
SELECT DISTINCT T1.PackageNumber FROM PACKAGE AS T1 JOIN Client AS T2 ON T1.Sender  =  T2.AccountNumber OR T1.Recipient  =  T2.AccountNumber WHERE T2.Name = "Leo Wong"	planet_1
SELECT DISTINCT T1.PackageNumber FROM PACKAGE AS T1 JOIN Client AS T2 ON T1.Sender  =  T2.AccountNumber OR T1.Recipient  =  T2.AccountNumber WHERE T2.Name = "Leo Wong"	planet_1
SELECT T1.PackageNumber FROM PACKAGE AS T1 JOIN Client AS T2 ON T1.Sender  =  T2.AccountNumber WHERE T2.Name = "Ogden Wernstrom" INTERSECT SELECT T1.PackageNumber FROM PACKAGE AS T1 JOIN Client AS T2 ON T1.Recipient  =  T2.AccountNumber WHERE T2.Name = "Leo Wong"	planet_1
SELECT T1.PackageNumber FROM PACKAGE AS T1 JOIN Client AS T2 ON T1.Sender  =  T2.AccountNumber WHERE T2.Name = "Ogden Wernstrom" INTERSECT SELECT T1.PackageNumber FROM PACKAGE AS T1 JOIN Client AS T2 ON T1.Recipient  =  T2.AccountNumber WHERE T2.Name = "Leo Wong"	planet_1
SELECT T1.Contents FROM PACKAGE AS T1 JOIN Client AS T2 ON T1.Sender  =  T2.AccountNumber WHERE T2.Name  =  "John Zoidfarb";	planet_1
SELECT T1.Contents FROM PACKAGE AS T1 JOIN Client AS T2 ON T1.Sender  =  T2.AccountNumber WHERE T2.Name  =  "John Zoidfarb";	planet_1
SELECT T1.PackageNumber ,  max(T1.Weight) FROM PACKAGE AS T1 JOIN Client AS T2 ON T1.Sender  =  T2.AccountNumber WHERE T2.Name LIKE "John";	planet_1
SELECT T1.PackageNumber ,  max(T1.Weight) FROM PACKAGE AS T1 JOIN Client AS T2 ON T1.Sender  =  T2.AccountNumber WHERE T2.Name LIKE "John";	planet_1
SELECT PackageNumber ,  Weight FROM PACKAGE ORDER BY Weight ASC LIMIT 3;	planet_1
SELECT PackageNumber ,  Weight FROM PACKAGE ORDER BY Weight ASC LIMIT 3;	planet_1
SELECT T2.Name ,  count(*) FROM PACKAGE AS T1 JOIN Client AS T2 ON T1.Sender  =  T2.AccountNumber GROUP BY T1.Sender ORDER BY count(*) DESC LIMIT 1;	planet_1
SELECT T2.Name ,  count(*) FROM PACKAGE AS T1 JOIN Client AS T2 ON T1.Sender  =  T2.AccountNumber GROUP BY T1.Sender ORDER BY count(*) DESC LIMIT 1;	planet_1
select t2.name ,  count(*) from package as t1 join client as t2 on t1.recipient  =  t2.accountnumber group by t1.recipient order by count(*) limit 1;	planet_1
select t2.name ,  count(*) from package as t1 join client as t2 on t1.recipient  =  t2.accountnumber group by t1.recipient order by count(*) limit 1;	planet_1
SELECT T2.Name ,  count(*) FROM PACKAGE AS T1 JOIN Client AS T2 ON T1.Sender  =  T2.AccountNumber GROUP BY T1.Sender HAVING count(*)  >  1;	planet_1
SELECT T2.Name ,  count(*) FROM PACKAGE AS T1 JOIN Client AS T2 ON T1.Sender  =  T2.AccountNumber GROUP BY T1.Sender HAVING count(*)  >  1;	planet_1
SELECT Coordinates FROM Planet WHERE Name  =  "Mars";	planet_1
SELECT Coordinates FROM Planet WHERE Name  =  "Mars";	planet_1
SELECT Name ,  Coordinates FROM Planet ORDER BY Name	planet_1
SELECT Name ,  Coordinates FROM Planet ORDER BY Name	planet_1
SELECT T1.ShipmentID FROM Shipment AS T1 JOIN Employee AS T2 ON T1.Manager = T2.EmployeeID WHERE T2.Name = "Phillip J. Fry";	planet_1
SELECT T1.ShipmentID FROM Shipment AS T1 JOIN Employee AS T2 ON T1.Manager = T2.EmployeeID WHERE T2.Name = "Phillip J. Fry";	planet_1
SELECT Date FROM Shipment;	planet_1
SELECT Date FROM Shipment;	planet_1
SELECT T1.ShipmentID FROM Shipment AS T1 JOIN Planet AS T2 ON T1.Planet = T2.PlanetID WHERE T2.Name  =  "Mars";	planet_1
SELECT T1.ShipmentID FROM Shipment AS T1 JOIN Planet AS T2 ON T1.Planet = T2.PlanetID WHERE T2.Name  =  "Mars";	planet_1
SELECT T1.ShipmentID FROM Shipment AS T1 JOIN Planet AS T2 ON T1.Planet = T2.PlanetID JOIN Employee AS T3 ON T3.EmployeeID = T1.Manager WHERE T2.Name = "Mars" AND T3.Name = "Turanga Leela";	planet_1
SELECT T1.ShipmentID FROM Shipment AS T1 JOIN Planet AS T2 ON T1.Planet = T2.PlanetID JOIN Employee AS T3 ON T3.EmployeeID = T1.Manager WHERE T2.Name = "Mars" AND T3.Name = "Turanga Leela";	planet_1
SELECT T1.ShipmentID FROM Shipment AS T1 JOIN Planet AS T2 ON T1.Planet = T2.PlanetID JOIN Employee AS T3 ON T3.EmployeeID = T1.Manager WHERE T2.Name = "Mars" OR T3.Name = "Turanga Leela";	planet_1
SELECT T1.ShipmentID FROM Shipment AS T1 JOIN Planet AS T2 ON T1.Planet = T2.PlanetID JOIN Employee AS T3 ON T3.EmployeeID = T1.Manager WHERE T2.Name = "Mars" OR T3.Name = "Turanga Leela";	planet_1
SELECT T2.Name ,  count(*) FROM Shipment AS T1 JOIN Planet AS T2 ON T1.Planet = T2.PlanetID GROUP BY T1.Planet;	planet_1
SELECT T2.Name ,  count(*) FROM Shipment AS T1 JOIN Planet AS T2 ON T1.Planet = T2.PlanetID GROUP BY T1.Planet;	planet_1
SELECT T2.Name FROM Shipment AS T1 JOIN Planet AS T2 ON T1.Planet = T2.PlanetID GROUP BY T1.Planet ORDER BY count(*) DESC LIMIT 1;	planet_1
SELECT T2.Name FROM Shipment AS T1 JOIN Planet AS T2 ON T1.Planet = T2.PlanetID GROUP BY T1.Planet ORDER BY count(*) DESC LIMIT 1;	planet_1
SELECT T2.Name ,  count(*) FROM Shipment AS T1 JOIN Employee AS T2 ON T1.Manager = T2.EmployeeID GROUP BY T1.Manager;	planet_1
SELECT T2.Name ,  count(*) FROM Shipment AS T1 JOIN Employee AS T2 ON T1.Manager = T2.EmployeeID GROUP BY T1.Manager;	planet_1
SELECT sum(T1.Weight) FROM PACKAGE AS T1 JOIN Shipment AS T2 ON T1.Shipment = T2.ShipmentID JOIN Planet AS T3 ON T2.Planet = T3.PlanetID WHERE T3.Name = "Mars";	planet_1
SELECT sum(T1.Weight) FROM PACKAGE AS T1 JOIN Shipment AS T2 ON T1.Shipment = T2.ShipmentID JOIN Planet AS T3 ON T2.Planet = T3.PlanetID WHERE T3.Name = "Mars";	planet_1
select t3.name ,  sum(t1.weight) from package as t1 join shipment as t2 on t1.shipment = t2.shipmentid join planet as t3 on t2.planet = t3.planetid group by t2.planet;	planet_1
select t3.name ,  sum(t1.weight) from package as t1 join shipment as t2 on t1.shipment = t2.shipmentid join planet as t3 on t2.planet = t3.planetid group by t2.planet;	planet_1
SELECT T3.Name FROM PACKAGE AS T1 JOIN Shipment AS T2 ON T1.Shipment = T2.ShipmentID JOIN Planet AS T3 ON T2.Planet = T3.PlanetID GROUP BY T2.Planet HAVING sum(T1.Weight)  >  30;	planet_1
SELECT T3.Name FROM PACKAGE AS T1 JOIN Shipment AS T2 ON T1.Shipment = T2.ShipmentID JOIN Planet AS T3 ON T2.Planet = T3.PlanetID GROUP BY T2.Planet HAVING sum(T1.Weight)  >  30;	planet_1
SELECT T1.PackageNumber FROM PACKAGE AS T1 JOIN Client AS T2 ON  T1.Sender = T2.AccountNumber JOIN Shipment AS T3 ON T1.Shipment = T3.ShipmentID JOIN Planet AS T4 ON T3.Planet = T4.PlanetID WHERE T2.Name = "Zapp Brannigan" AND T4.Name = "Omicron Persei 8";	planet_1
SELECT T1.PackageNumber FROM PACKAGE AS T1 JOIN Client AS T2 ON  T1.Sender = T2.AccountNumber JOIN Shipment AS T3 ON T1.Shipment = T3.ShipmentID JOIN Planet AS T4 ON T3.Planet = T4.PlanetID WHERE T2.Name = "Zapp Brannigan" AND T4.Name = "Omicron Persei 8";	planet_1
SELECT T1.PackageNumber FROM PACKAGE AS T1 JOIN Client AS T2 ON  T1.Sender = T2.AccountNumber JOIN Shipment AS T3 ON T1.Shipment = T3.ShipmentID JOIN Planet AS T4 ON T3.Planet = T4.PlanetID WHERE T2.Name  =  "Zapp Brannigan" OR T4.Name  =  "Omicron Persei 8";	planet_1
SELECT T1.PackageNumber FROM PACKAGE AS T1 JOIN Client AS T2 ON  T1.Sender = T2.AccountNumber JOIN Shipment AS T3 ON T1.Shipment = T3.ShipmentID JOIN Planet AS T4 ON T3.Planet = T4.PlanetID WHERE T2.Name  =  "Zapp Brannigan" OR T4.Name  =  "Omicron Persei 8";	planet_1
SELECT PackageNumber ,  Weight FROM PACKAGE WHERE Weight BETWEEN 10 AND 30;	planet_1
SELECT PackageNumber ,  Weight FROM PACKAGE WHERE Weight BETWEEN 10 AND 30;	planet_1
SELECT Name FROM Employee EXCEPT SELECT T2.Name FROM Has_Clearance AS T1 JOIN Employee AS T2 ON T1.Employee = T2.EmployeeID JOIN Planet AS T3 ON T1.Planet = T3.PlanetID WHERE T3.Name = "Mars";	planet_1
SELECT Name FROM Employee EXCEPT SELECT T2.Name FROM Has_Clearance AS T1 JOIN Employee AS T2 ON T1.Employee = T2.EmployeeID JOIN Planet AS T3 ON T1.Planet = T3.PlanetID WHERE T3.Name = "Mars";	planet_1
SELECT T2.Name FROM Has_Clearance AS T1 JOIN Employee AS T2 ON T1.Employee = T2.EmployeeID JOIN Planet AS T3 ON T1.Planet = T3.PlanetID WHERE T3.Name  =  "Omega III";	planet_1
SELECT T2.Name FROM Has_Clearance AS T1 JOIN Employee AS T2 ON T1.Employee = T2.EmployeeID JOIN Planet AS T3 ON T1.Planet = T3.PlanetID WHERE T3.Name  =  "Omega III";	planet_1
SELECT T3.Name FROM Has_Clearance AS T1 JOIN Employee AS T2 ON T1.Employee = T2.EmployeeID JOIN Planet AS T3 ON T1.Planet = T3.PlanetID GROUP BY T1.Planet HAVING count(*)  =  1;	planet_1
SELECT T3.Name FROM Has_Clearance AS T1 JOIN Employee AS T2 ON T1.Employee = T2.EmployeeID JOIN Planet AS T3 ON T1.Planet = T3.PlanetID GROUP BY T1.Planet HAVING count(*)  =  1;	planet_1
SELECT Name FROM Employee WHERE Salary BETWEEN 5000 AND 10000	planet_1
SELECT Name FROM Employee WHERE Salary BETWEEN 5000 AND 10000	planet_1
SELECT Name FROM Employee WHERE Salary  >  5000 OR Salary  >  (SELECT avg(salary) FROM employee)	planet_1
SELECT Name FROM Employee WHERE Salary  >  5000 OR Salary  >  (SELECT avg(salary) FROM employee)	planet_1
select count(*) from employee where employeeid not in ( select t2.employeeid from has_clearance as t1 join employee as t2 on t1.employee = t2.employeeid join planet as t3 on t1.planet = t3.planetid where t3.name = "mars" );	planet_1
select count(*) from employee where employeeid not in ( select t2.employeeid from has_clearance as t1 join employee as t2 on t1.employee = t2.employeeid join planet as t3 on t1.planet = t3.planetid where t3.name = "mars" );	planet_1
SELECT count(*) FROM game	video_game
SELECT count(*) FROM game	video_game
SELECT Title ,  Developers FROM game ORDER BY Units_sold_Millions DESC	video_game
SELECT Title ,  Developers FROM game ORDER BY Units_sold_Millions DESC	video_game
SELECT avg(Units_sold_Millions) FROM game WHERE developers != 'Nintendo'	video_game
SELECT avg(Units_sold_Millions) FROM game WHERE developers != 'Nintendo'	video_game
SELECT Platform_name ,  Market_district FROM platform	video_game
SELECT Platform_name ,  Market_district FROM platform	video_game
SELECT Platform_name ,  Platform_ID FROM platform WHERE Download_rank  =  1	video_game
SELECT Platform_name ,  Platform_ID FROM platform WHERE Download_rank  =  1	video_game
SELECT max(Rank_of_the_year) ,  min(Rank_of_the_year) FROM player	video_game
SELECT max(Rank_of_the_year) ,  min(Rank_of_the_year) FROM player	video_game
SELECT count(*) FROM player WHERE Rank_of_the_year  <=  3	video_game
SELECT count(*) FROM player WHERE Rank_of_the_year  <=  3	video_game
SELECT Player_name FROM player ORDER BY Player_name ASC	video_game
SELECT Player_name FROM player ORDER BY Player_name ASC	video_game
SELECT Player_name ,  College FROM player ORDER BY Rank_of_the_year DESC	video_game
SELECT Player_name ,  College FROM player ORDER BY Rank_of_the_year DESC	video_game
SELECT T3.Player_name ,  T3.rank_of_the_year FROM game AS T1 JOIN game_player AS T2 ON T1.Game_ID  =  T2.Game_ID JOIN player AS T3 ON T2.Player_ID  =  T3.Player_ID WHERE T1.Title  =  "Super Mario World"	video_game
SELECT T3.Player_name ,  T3.rank_of_the_year FROM game AS T1 JOIN game_player AS T2 ON T1.Game_ID  =  T2.Game_ID JOIN player AS T3 ON T2.Player_ID  =  T3.Player_ID WHERE T1.Title  =  "Super Mario World"	video_game
SELECT DISTINCT T1.Developers FROM game AS T1 JOIN game_player AS T2 ON T1.Game_ID  =  T2.Game_ID JOIN player AS T3 ON T2.Player_ID  =  T3.Player_ID WHERE T3.College  =  "Auburn"	video_game
SELECT DISTINCT T1.Developers FROM game AS T1 JOIN game_player AS T2 ON T1.Game_ID  =  T2.Game_ID JOIN player AS T3 ON T2.Player_ID  =  T3.Player_ID WHERE T3.College  =  "Auburn"	video_game
SELECT avg(Units_sold_Millions) FROM game AS T1 JOIN game_player AS T2 ON T1.Game_ID  =  T2.Game_ID JOIN player AS T3 ON T2.Player_ID  =  T3.Player_ID WHERE T3.Position  =  "Guard"	video_game
SELECT avg(Units_sold_Millions) FROM game AS T1 JOIN game_player AS T2 ON T1.Game_ID  =  T2.Game_ID JOIN player AS T3 ON T2.Player_ID  =  T3.Player_ID WHERE T3.Position  =  "Guard"	video_game
SELECT T1.Title ,  T2.Platform_name FROM game AS T1 JOIN platform AS T2 ON T1.Platform_ID  =  T2.Platform_ID	video_game
SELECT T1.Title ,  T2.Platform_name FROM game AS T1 JOIN platform AS T2 ON T1.Platform_ID  =  T2.Platform_ID	video_game
SELECT T1.Title FROM game AS T1 JOIN platform AS T2 ON T1.Platform_ID  =  T2.Platform_ID WHERE T2.Market_district  =  "Asia" OR T2.Market_district  =  "USA"	video_game
SELECT T1.Title FROM game AS T1 JOIN platform AS T2 ON T1.Platform_ID  =  T2.Platform_ID WHERE T2.Market_district  =  "Asia" OR T2.Market_district  =  "USA"	video_game
SELECT Franchise ,  COUNT(*) FROM game GROUP BY Franchise	video_game
SELECT Franchise ,  COUNT(*) FROM game GROUP BY Franchise	video_game
SELECT Franchise FROM game GROUP BY Franchise ORDER BY COUNT(*) DESC LIMIT 1	video_game
SELECT Franchise FROM game GROUP BY Franchise ORDER BY COUNT(*) DESC LIMIT 1	video_game
SELECT Franchise FROM game GROUP BY Franchise HAVING COUNT(*)  >=  2	video_game
SELECT Franchise FROM game GROUP BY Franchise HAVING COUNT(*)  >=  2	video_game
SELECT Player_name FROM player WHERE Player_ID NOT IN (SELECT Player_ID FROM game_player)	video_game
SELECT Player_name FROM player WHERE Player_ID NOT IN (SELECT Player_ID FROM game_player)	video_game
SELECT T1.Title FROM game AS T1 JOIN game_player AS T2 ON T1.Game_ID  =  T2.Game_ID JOIN player AS T3 ON T2.Player_ID  =  T3.Player_ID WHERE T3.College  =  "Oklahoma" INTERSECT SELECT T1.Title FROM game AS T1 JOIN game_player AS T2 ON T1.Game_ID  =  T2.Game_ID JOIN player AS T3 ON T2.Player_ID  =  T3.Player_ID WHERE T3.College  =  "Auburn"	video_game
SELECT T1.Title FROM game AS T1 JOIN game_player AS T2 ON T1.Game_ID  =  T2.Game_ID JOIN player AS T3 ON T2.Player_ID  =  T3.Player_ID WHERE T3.College  =  "Oklahoma" INTERSECT SELECT T1.Title FROM game AS T1 JOIN game_player AS T2 ON T1.Game_ID  =  T2.Game_ID JOIN player AS T3 ON T2.Player_ID  =  T3.Player_ID WHERE T3.College  =  "Auburn"	video_game
SELECT DISTINCT Franchise FROM game	video_game
SELECT DISTINCT Franchise FROM game	video_game
SELECT Title FROM game EXCEPT SELECT T1.Title FROM game AS T1 JOIN game_player AS T2 ON T1.Game_ID  =  T2.Game_ID JOIN player AS T3 ON T2.Player_ID  =  T3.Player_ID WHERE T3.Position  =  "Guard"	video_game
SELECT Title FROM game EXCEPT SELECT T1.Title FROM game AS T1 JOIN game_player AS T2 ON T1.Game_ID  =  T2.Game_ID JOIN player AS T3 ON T2.Player_ID  =  T3.Player_ID WHERE T3.Position  =  "Guard"	video_game
SELECT name FROM press ORDER BY Year_Profits_billion DESC	book_press
SELECT name FROM press ORDER BY Year_Profits_billion DESC	book_press
SELECT name FROM press WHERE Year_Profits_billion  >  15 OR Month_Profits_billion  >  1	book_press
SELECT name FROM press WHERE Year_Profits_billion  >  15 OR Month_Profits_billion  >  1	book_press
SELECT avg(Year_Profits_billion) ,  max(Year_Profits_billion) FROM press	book_press
SELECT avg(Year_Profits_billion) ,  max(Year_Profits_billion) FROM press	book_press
SELECT name FROM press ORDER BY Month_Profits_billion DESC LIMIT 1	book_press
SELECT name FROM press ORDER BY Month_Profits_billion DESC LIMIT 1	book_press
SELECT name FROM press WHERE Month_Profits_billion  =  (SELECT min(Month_Profits_billion) FROM press) OR Month_Profits_billion  =  (SELECT max(Month_Profits_billion) FROM press)	book_press
SELECT name FROM press WHERE Month_Profits_billion  =  (SELECT min(Month_Profits_billion) FROM press) OR Month_Profits_billion  =  (SELECT max(Month_Profits_billion) FROM press)	book_press
SELECT count(*) FROM author WHERE age  <  30	book_press
SELECT count(*) FROM author WHERE age  <  30	book_press
SELECT avg(age) ,  gender FROM author GROUP BY gender	book_press
SELECT avg(age) ,  gender FROM author GROUP BY gender	book_press
SELECT count(*) ,  gender FROM author WHERE age  >  30 GROUP BY gender	book_press
SELECT count(*) ,  gender FROM author WHERE age  >  30 GROUP BY gender	book_press
SELECT title FROM book ORDER BY release_date DESC	book_press
SELECT title FROM book ORDER BY release_date DESC	book_press
SELECT count(*) ,  book_series FROM book GROUP BY book_series	book_press
SELECT count(*) ,  book_series FROM book GROUP BY book_series	book_press
SELECT title ,  release_date FROM book ORDER BY sale_amount DESC LIMIT 5	book_press
SELECT title ,  release_date FROM book ORDER BY sale_amount DESC LIMIT 5	book_press
SELECT book_series FROM book WHERE sale_amount  >  1000 INTERSECT SELECT book_series FROM book WHERE sale_amount  <  500	book_press
SELECT book_series FROM book WHERE sale_amount  >  1000 INTERSECT SELECT book_series FROM book WHERE sale_amount  <  500	book_press
SELECT t1.name FROM author AS t1 JOIN book AS t2 ON t1.author_id  =  t2.author_id WHERE t2.book_series  =  'MM' INTERSECT SELECT t1.name FROM author AS t1 JOIN book AS t2 ON t1.author_id  =  t2.author_id WHERE t2.book_series  =  'LT'	book_press
SELECT t1.name FROM author AS t1 JOIN book AS t2 ON t1.author_id  =  t2.author_id WHERE t2.book_series  =  'MM' INTERSECT SELECT t1.name FROM author AS t1 JOIN book AS t2 ON t1.author_id  =  t2.author_id WHERE t2.book_series  =  'LT'	book_press
SELECT name ,  age FROM author WHERE author_id NOT IN (SELECT author_id FROM book)	book_press
select name from author where author_id not in (select author_id from book)	book_press
SELECT t1.name FROM author AS t1 JOIN book AS t2 ON t1.author_id  =  t2.author_id GROUP BY t2.author_id HAVING count(*)  >  1	book_press
SELECT t1.name FROM author AS t1 JOIN book AS t2 ON t1.author_id  =  t2.author_id GROUP BY t2.author_id HAVING count(*)  >  1	book_press
SELECT t1.name ,  t2.title ,  t3.name FROM author AS t1 JOIN book AS t2 ON t1.author_id  =  t2.author_id JOIN press AS t3 ON t2.press_id  =  t3.press_id ORDER BY t2.sale_amount DESC LIMIT 3	book_press
SELECT t1.name ,  t2.title ,  t3.name FROM author AS t1 JOIN book AS t2 ON t1.author_id  =  t2.author_id JOIN press AS t3 ON t2.press_id  =  t3.press_id ORDER BY t2.sale_amount DESC LIMIT 3	book_press
SELECT sum(t1.sale_amount) ,  t2.name FROM book AS t1 JOIN press AS t2 ON t1.press_id  =  t2.press_id GROUP BY t1.press_id	book_press
SELECT sum(t1.sale_amount) ,  t2.name FROM book AS t1 JOIN press AS t2 ON t1.press_id  =  t2.press_id GROUP BY t1.press_id	book_press
SELECT count(*) ,  t2.name FROM book AS t1 JOIN press AS t2 ON t1.press_id  =  t2.press_id WHERE sale_amount  >  1000 GROUP BY t2.name	book_press
SELECT count(*) ,  t2.name FROM book AS t1 JOIN press AS t2 ON t1.press_id  =  t2.press_id WHERE sale_amount  >  1000 GROUP BY t2.name	book_press
SELECT t1.name FROM author AS t1 JOIN book AS t2 ON t1.author_id  =  t2.author_id ORDER BY t2.sale_amount DESC LIMIT 1	book_press
SELECT t1.name FROM author AS t1 JOIN book AS t2 ON t1.author_id  =  t2.author_id ORDER BY t2.sale_amount DESC LIMIT 1	book_press
SELECT t1.name ,  t1.gender FROM author AS t1 JOIN book AS t2 ON t1.author_id  =  t2.author_id GROUP BY t2.author_id ORDER BY count(*) DESC LIMIT 1	book_press
SELECT t1.name ,  t1.gender FROM author AS t1 JOIN book AS t2 ON t1.author_id  =  t2.author_id GROUP BY t2.author_id ORDER BY count(*) DESC LIMIT 1	book_press
SELECT name FROM author EXCEPT SELECT t1.name FROM author AS t1 JOIN book AS t2 ON t1.author_id  =  t2.author_id JOIN press AS t3 ON t2.press_id  =  t3.press_id WHERE t3.name  =  'Accor'	book_press
SELECT name FROM author EXCEPT SELECT t1.name FROM author AS t1 JOIN book AS t2 ON t1.author_id  =  t2.author_id JOIN press AS t3 ON t2.press_id  =  t3.press_id WHERE t3.name  =  'Accor'	book_press
SELECT t2.name ,  t2.Year_Profits_billion FROM book AS t1 JOIN press AS t2 ON t1.press_id  =  t2.press_id GROUP BY t2.press_id HAVING count(*)  >  2	book_press
SELECT t2.name ,  t2.Year_Profits_billion FROM book AS t1 JOIN press AS t2 ON t1.press_id  =  t2.press_id GROUP BY t2.press_id HAVING count(*)  >  2	book_press
SELECT count(*) FROM Authors	cre_Doc_Workflow
SELECT author_name FROM Authors	cre_Doc_Workflow
SELECT author_name ,  other_details FROM Authors	cre_Doc_Workflow
SELECT other_details FROM Authors WHERE author_name  =  "Addison Denesik"	cre_Doc_Workflow
SELECT count(*) FROM Documents	cre_Doc_Workflow
SELECT author_name FROM Documents WHERE document_id  =  4	cre_Doc_Workflow
SELECT author_name FROM Documents WHERE document_name  =  "Travel to Brazil"	cre_Doc_Workflow
SELECT count(*) FROM Documents WHERE author_name  =  "Era Kerluke"	cre_Doc_Workflow
SELECT document_name ,  document_description FROM Documents	cre_Doc_Workflow
SELECT document_id ,  document_name FROM Documents WHERE author_name  =  "Bianka Cummings"	cre_Doc_Workflow
SELECT T2.author_name ,  T2.other_details FROM Documents AS T1 JOIN Authors AS T2 ON T1.author_name  =  T2.author_name WHERE document_name  =  "Travel to China"	cre_Doc_Workflow
SELECT author_name ,  count(*) FROM Documents GROUP BY author_name	cre_Doc_Workflow
SELECT author_name FROM Documents GROUP BY author_name ORDER BY count(*) DESC LIMIT 1	cre_Doc_Workflow
SELECT author_name FROM Documents GROUP BY author_name HAVING count(*)  >=  2	cre_Doc_Workflow
SELECT count(*) FROM Business_processes	cre_Doc_Workflow
SELECT next_process_id ,  process_name ,  process_description FROM Business_processes WHERE process_id  =  9	cre_Doc_Workflow
SELECT process_name FROM Business_processes WHERE process_id  =  (SELECT next_process_id FROM Business_processes WHERE process_id  =  9)	cre_Doc_Workflow
SELECT count(*) FROM Process_outcomes	cre_Doc_Workflow
SELECT process_outcome_code ,  process_outcome_description FROM Process_outcomes	cre_Doc_Workflow
SELECT process_outcome_description FROM Process_outcomes WHERE process_outcome_code  =  "working"	cre_Doc_Workflow
SELECT count(*) FROM Process_status	cre_Doc_Workflow
SELECT process_status_code ,  process_status_description FROM Process_status	cre_Doc_Workflow
SELECT process_status_description FROM Process_status WHERE process_status_code  =  "ct"	cre_Doc_Workflow
SELECT count(*) FROM Staff	cre_Doc_Workflow
SELECT staff_id ,  staff_details FROM Staff	cre_Doc_Workflow
SELECT staff_details FROM Staff WHERE staff_id  =  100	cre_Doc_Workflow
SELECT count(*) FROM Ref_staff_roles	cre_Doc_Workflow
SELECT staff_role_code ,  staff_role_description FROM Ref_staff_roles	cre_Doc_Workflow
SELECT staff_role_description FROM Ref_staff_roles WHERE staff_role_code  =  "HR"	cre_Doc_Workflow
SELECT count(DISTINCT document_id) FROM Documents_processes	cre_Doc_Workflow
SELECT DISTINCT process_id FROM Documents_processes	cre_Doc_Workflow
SELECT document_id FROM Documents EXCEPT SELECT document_id FROM Documents_processes	cre_Doc_Workflow
SELECT process_id FROM Business_processes EXCEPT SELECT process_id FROM Documents_processes	cre_Doc_Workflow
SELECT T2.process_outcome_description ,  T3.process_status_description FROM Documents_processes AS T1 JOIN Process_outcomes AS T2 ON T1.process_outcome_code  =  T2.process_outcome_code JOIN Process_Status AS T3 ON T1.process_status_code  =  T3.process_status_code WHERE T1.document_id  =  0	cre_Doc_Workflow
SELECT T3.process_name FROM Documents_processes AS T1 JOIN Documents AS T2 ON T1.document_id  =  T2.document_id JOIN Business_processes AS T3 ON T1.process_id  =  T3.process_id WHERE T2.document_name  =  "Travel to Brazil"	cre_Doc_Workflow
SELECT process_id ,  count(*) FROM Documents_processes GROUP BY process_id	cre_Doc_Workflow
SELECT count(*) FROM Staff_in_processes WHERE document_id  =  0 AND process_id  =  9	cre_Doc_Workflow
SELECT staff_id ,  count(*) FROM Staff_in_processes GROUP BY staff_id	cre_Doc_Workflow
SELECT staff_role_code ,  count(*) FROM Staff_in_processes GROUP BY staff_role_code	cre_Doc_Workflow
SELECT count(DISTINCT staff_role_code) FROM Staff_in_processes WHERE staff_id  =  3	cre_Doc_Workflow
SELECT count(*) FROM Agencies	advertising_agencies
SELECT count(*) FROM Agencies	advertising_agencies
SELECT agency_id ,  agency_details FROM Agencies	advertising_agencies
SELECT agency_id ,  agency_details FROM Agencies	advertising_agencies
SELECT count(*) FROM Clients	advertising_agencies
SELECT count(*) FROM Clients	advertising_agencies
SELECT client_id ,  client_details FROM Clients	advertising_agencies
SELECT client_id ,  client_details FROM Clients	advertising_agencies
SELECT agency_id ,  count(*) FROM Clients GROUP BY agency_id	advertising_agencies
SELECT agency_id ,  count(*) FROM Clients GROUP BY agency_id	advertising_agencies
SELECT T1.agency_id ,  T1.agency_details FROM Agencies AS T1 JOIN Clients AS T2 ON T1.agency_id  =  T2.agency_id GROUP BY T1.agency_id ORDER BY count(*) DESC LIMIT 1	advertising_agencies
SELECT T1.agency_id ,  T1.agency_details FROM Agencies AS T1 JOIN Clients AS T2 ON T1.agency_id  =  T2.agency_id GROUP BY T1.agency_id ORDER BY count(*) DESC LIMIT 1	advertising_agencies
SELECT T1.agency_id ,  T1.agency_details FROM Agencies AS T1 JOIN Clients AS T2 ON T1.agency_id  =  T2.agency_id GROUP BY T1.agency_id HAVING count(*)  >=  2	advertising_agencies
SELECT T1.agency_id ,  T1.agency_details FROM Agencies AS T1 JOIN Clients AS T2 ON T1.agency_id  =  T2.agency_id GROUP BY T1.agency_id HAVING count(*)  >=  2	advertising_agencies
SELECT T2.agency_details FROM Clients AS T1 JOIN Agencies AS T2 ON T1.agency_id  =  T2.agency_id WHERE T1.client_details  =  'Mac'	advertising_agencies
SELECT T2.agency_details FROM Clients AS T1 JOIN Agencies AS T2 ON T1.agency_id  =  T2.agency_id WHERE T1.client_details  =  'Mac'	advertising_agencies
SELECT T1.client_details ,  T2.agency_details FROM Clients AS T1 JOIN Agencies AS T2 ON T1.agency_id  =  T2.agency_id	advertising_agencies
SELECT T1.client_details ,  T2.agency_details FROM Clients AS T1 JOIN Agencies AS T2 ON T1.agency_id  =  T2.agency_id	advertising_agencies
SELECT sic_code ,  count(*) FROM Clients GROUP BY sic_code	advertising_agencies
SELECT sic_code ,  count(*) FROM Clients GROUP BY sic_code	advertising_agencies
SELECT client_id ,  client_details FROM Clients WHERE sic_code  =  "Bad";	advertising_agencies
SELECT client_id ,  client_details FROM Clients WHERE sic_code  =  "Bad";	advertising_agencies
SELECT T1.agency_id ,  T1.agency_details FROM Agencies AS T1 JOIN Clients AS T2 ON T1.agency_id  =  T2.agency_id	advertising_agencies
SELECT T1.agency_id ,  T1.agency_details FROM Agencies AS T1 JOIN Clients AS T2 ON T1.agency_id  =  T2.agency_id	advertising_agencies
SELECT agency_id FROM Agencies EXCEPT SELECT agency_id FROM Clients	advertising_agencies
SELECT agency_id FROM Agencies EXCEPT SELECT agency_id FROM Clients	advertising_agencies
SELECT count(*) FROM Invoices	advertising_agencies
SELECT count(*) FROM Invoices	advertising_agencies
SELECT invoice_id ,  invoice_status ,  invoice_details FROM Invoices	advertising_agencies
SELECT invoice_id ,  invoice_status ,  invoice_details FROM Invoices	advertising_agencies
SELECT client_id ,  count(*) FROM Invoices GROUP BY client_id	advertising_agencies
SELECT client_id ,  count(*) FROM Invoices GROUP BY client_id	advertising_agencies
SELECT T1.client_id ,  T2.client_details FROM Invoices AS T1 JOIN Clients AS T2 ON T1.client_id  =  T2.client_id GROUP BY T1.client_id ORDER BY count(*) DESC LIMIT 1	advertising_agencies
SELECT T1.client_id ,  T2.client_details FROM Invoices AS T1 JOIN Clients AS T2 ON T1.client_id  =  T2.client_id GROUP BY T1.client_id ORDER BY count(*) DESC LIMIT 1	advertising_agencies
SELECT client_id FROM Invoices GROUP BY client_id HAVING count(*)  >=  2	advertising_agencies
SELECT client_id FROM Invoices GROUP BY client_id HAVING count(*)  >=  2	advertising_agencies
SELECT invoice_status ,  count(*) FROM Invoices GROUP BY invoice_status	advertising_agencies
SELECT invoice_status ,  count(*) FROM Invoices GROUP BY invoice_status	advertising_agencies
SELECT invoice_status FROM Invoices GROUP BY invoice_status ORDER BY count(*) DESC LIMIT 1	advertising_agencies
SELECT invoice_status FROM Invoices GROUP BY invoice_status ORDER BY count(*) DESC LIMIT 1	advertising_agencies
SELECT T1.invoice_status ,  T1.invoice_details ,  T2.client_id ,  T2.client_details ,  T3.agency_id ,  T3.agency_details FROM Invoices AS T1 JOIN Clients AS T2 ON T1.client_id  =  T2.client_id JOIN Agencies AS T3 ON T2.agency_id  =  T3.agency_id	advertising_agencies
SELECT T1.invoice_status ,  T1.invoice_details ,  T2.client_id ,  T2.client_details ,  T3.agency_id ,  T3.agency_details FROM Invoices AS T1 JOIN Clients AS T2 ON T1.client_id  =  T2.client_id JOIN Agencies AS T3 ON T2.agency_id  =  T3.agency_id	advertising_agencies
SELECT meeting_type ,  other_details FROM meetings	advertising_agencies
SELECT meeting_type ,  other_details FROM meetings	advertising_agencies
SELECT meeting_outcome ,  purpose_of_meeting FROM meetings	advertising_agencies
SELECT meeting_outcome ,  purpose_of_meeting FROM meetings	advertising_agencies
SELECT T1.payment_id ,  T1.payment_details FROM Payments AS T1 JOIN Invoices AS T2 ON T1.invoice_id  =  T2.invoice_id WHERE T2.invoice_status  =  'Working'	advertising_agencies
SELECT T1.payment_id ,  T1.payment_details FROM Payments AS T1 JOIN Invoices AS T2 ON T1.invoice_id  =  T2.invoice_id WHERE T2.invoice_status  =  'Working'	advertising_agencies
SELECT invoice_id ,  invoice_status FROM Invoices EXCEPT SELECT T1.invoice_id ,  T1.invoice_status FROM Invoices AS T1 JOIN Payments AS T2 ON T1.invoice_id  =  T2.invoice_id	advertising_agencies
SELECT invoice_id ,  invoice_status FROM Invoices EXCEPT SELECT T1.invoice_id ,  T1.invoice_status FROM Invoices AS T1 JOIN Payments AS T2 ON T1.invoice_id  =  T2.invoice_id	advertising_agencies
SELECT count(*) FROM Payments	advertising_agencies
SELECT count(*) FROM Payments	advertising_agencies
SELECT payment_id ,  invoice_id ,  payment_details FROM Payments	advertising_agencies
SELECT payment_id ,  invoice_id ,  payment_details FROM Payments	advertising_agencies
SELECT DISTINCT T1.invoice_id ,  T1.invoice_status FROM Invoices AS T1 JOIN Payments AS T2 ON T1.invoice_id  =  T2.invoice_id	advertising_agencies
SELECT DISTINCT T1.invoice_id ,  T1.invoice_status FROM Invoices AS T1 JOIN Payments AS T2 ON T1.invoice_id  =  T2.invoice_id	advertising_agencies
SELECT invoice_id ,  count(*) FROM Payments GROUP BY invoice_id	advertising_agencies
SELECT invoice_id ,  count(*) FROM Payments GROUP BY invoice_id	advertising_agencies
SELECT T1.invoice_id ,  T2.invoice_status ,  T2.invoice_details FROM Payments AS T1 JOIN Invoices AS T2 ON T1.invoice_id  =  T2.invoice_id GROUP BY T1.invoice_id ORDER BY count(*) DESC LIMIT 1	advertising_agencies
SELECT T1.invoice_id ,  T2.invoice_status ,  T2.invoice_details FROM Payments AS T1 JOIN Invoices AS T2 ON T1.invoice_id  =  T2.invoice_id GROUP BY T1.invoice_id ORDER BY count(*) DESC LIMIT 1	advertising_agencies
SELECT count(*) FROM Staff	advertising_agencies
SELECT count(*) FROM Staff	advertising_agencies
SELECT agency_id ,  count(*) FROM Staff GROUP BY agency_id	advertising_agencies
SELECT agency_id ,  count(*) FROM Staff GROUP BY agency_id	advertising_agencies
SELECT T1.agency_id ,  T2.agency_details FROM Staff AS T1 JOIN Agencies AS T2 ON T1.agency_id  =  T2.agency_id GROUP BY T1.agency_id ORDER BY count(*) DESC LIMIT 1	advertising_agencies
SELECT T1.agency_id ,  T2.agency_details FROM Staff AS T1 JOIN Agencies AS T2 ON T1.agency_id  =  T2.agency_id GROUP BY T1.agency_id ORDER BY count(*) DESC LIMIT 1	advertising_agencies
SELECT meeting_outcome ,  count(*) FROM Meetings GROUP BY meeting_outcome	advertising_agencies
SELECT meeting_outcome ,  count(*) FROM Meetings GROUP BY meeting_outcome	advertising_agencies
SELECT client_id ,  count(*) FROM Meetings GROUP BY client_id	advertising_agencies
SELECT client_id ,  count(*) FROM Meetings GROUP BY client_id	advertising_agencies
SELECT meeting_type ,  count(*) FROM Meetings GROUP BY meeting_type	advertising_agencies
SELECT meeting_type ,  count(*) FROM Meetings GROUP BY meeting_type	advertising_agencies
SELECT T1.meeting_id ,  T1.meeting_outcome ,  T1.meeting_type ,  T2.client_details FROM meetings AS T1 JOIN clients AS T2 ON T1.client_id  =  T2.client_id	advertising_agencies
SELECT T1.meeting_id ,  T1.meeting_outcome ,  T1.meeting_type ,  T2.client_details FROM meetings AS T1 JOIN clients AS T2 ON T1.client_id  =  T2.client_id	advertising_agencies
SELECT meeting_id ,  count(*) FROM Staff_in_meetings GROUP BY meeting_id	advertising_agencies
SELECT meeting_id ,  count(*) FROM Staff_in_meetings GROUP BY meeting_id	advertising_agencies
SELECT staff_id ,  count(*) FROM Staff_in_meetings GROUP BY staff_id ORDER BY count(*) ASC LIMIT 1;	advertising_agencies
SELECT staff_id ,  count(*) FROM Staff_in_meetings GROUP BY staff_id ORDER BY count(*) ASC LIMIT 1;	advertising_agencies
SELECT count(DISTINCT staff_id) FROM Staff_in_meetings	advertising_agencies
SELECT count(DISTINCT staff_id) FROM Staff_in_meetings	advertising_agencies
SELECT count(*) FROM Staff WHERE staff_id NOT IN ( SELECT staff_id FROM Staff_in_meetings )	advertising_agencies
SELECT count(*) FROM Staff WHERE staff_id NOT IN ( SELECT staff_id FROM Staff_in_meetings )	advertising_agencies
SELECT T1.client_id ,  T1.client_details FROM Clients AS T1 JOIN meetings AS T2 ON T1.client_id  =  T2.client_id UNION SELECT T1.client_id ,  T1.client_details FROM Clients AS T1 JOIN invoices AS T2 ON T1.client_id  =  T2.client_id	advertising_agencies
SELECT T1.client_id ,  T1.client_details FROM Clients AS T1 JOIN meetings AS T2 ON T1.client_id  =  T2.client_id UNION SELECT T1.client_id ,  T1.client_details FROM Clients AS T1 JOIN invoices AS T2 ON T1.client_id  =  T2.client_id	advertising_agencies
SELECT staff_id ,  staff_details FROM staff WHERE staff_details LIKE "%s%" GROUP BY staff_id HAVING count(*)  >=  1	advertising_agencies
SELECT staff_id ,  staff_details FROM staff WHERE staff_details LIKE "%s%" GROUP BY staff_id HAVING count(*)  >=  1	advertising_agencies
SELECT T1.client_id ,  T1.sic_code ,  T1.agency_id FROM clients AS T1 JOIN meetings AS T2 ON T1.client_id  =  T2.client_id GROUP BY T1.client_id HAVING count(*)  =  1 INTERSECT SELECT T1.client_id ,  T1.sic_code ,  T1.agency_id FROM clients AS T1 JOIN invoices AS T2 ON T1.client_id  =  T2.client_id	advertising_agencies
SELECT T1.client_id ,  T1.sic_code ,  T1.agency_id FROM clients AS T1 JOIN meetings AS T2 ON T1.client_id  =  T2.client_id GROUP BY T1.client_id HAVING count(*)  =  1 INTERSECT SELECT T1.client_id ,  T1.sic_code ,  T1.agency_id FROM clients AS T1 JOIN invoices AS T2 ON T1.client_id  =  T2.client_id	advertising_agencies
SELECT T1.start_date_time ,  T1.end_date_time ,  T2.client_details ,  T4.staff_details FROM meetings AS T1 JOIN clients AS T2 ON T1.client_id  =  T2.client_id JOIN staff_in_meetings AS T3 ON T1.meeting_id  =  T3.meeting_id JOIN staff AS T4 ON T3.staff_id  =  T4.staff_id	advertising_agencies
SELECT T1.start_date_time ,  T1.end_date_time ,  T2.client_details ,  T4.staff_details FROM meetings AS T1 JOIN clients AS T2 ON T1.client_id  =  T2.client_id JOIN staff_in_meetings AS T3 ON T1.meeting_id  =  T3.meeting_id JOIN staff AS T4 ON T3.staff_id  =  T4.staff_id	advertising_agencies
