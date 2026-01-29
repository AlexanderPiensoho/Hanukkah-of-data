SELECT      name, 
            phone, 
            substr(shipped,12,20) as pickup_time,
            desc
FROM        customers 
JOIN        orders USING (customerid) 
JOIN        orders_items USING (orderid) 
JOIN        products USING (sku) 
WHERE       substr(sku,0,4) LIKE 'bky'
            AND pickup_time BETWEEN '02:00:00' AND '05:00:00' 
            AND ordered = shipped
            AND birthdate > '1980'
ORDER BY    name
;


