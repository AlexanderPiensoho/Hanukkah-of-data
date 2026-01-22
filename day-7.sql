SELECT      name, 
            phone, 
            ordered,
            orderid,
            desc 
FROM        customers
JOIN        orders USING (customerid)
JOIN        orders_items USING (orderid)
JOIN        products USING (sku)
WHERE       (ordered BETWEEN '2018-12-31 12:20:00' AND '2018-12-31 12:30:00'
            OR ordered BETWEEN '2020-06-28 11:30:00' AND '2020-06-28 11:40:00'
            OR ordered BETWEEN '2021-10-07 14:52:00' AND '2021-10-07 15:02:00'
            OR ordered BETWEEN '2022-04-23 14:20:00' AND '2022-04-23 14:30:00')
AND         desc LIKE '%(%)%'
;


