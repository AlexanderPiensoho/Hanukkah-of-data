SELECT    desc, 
          name, 
          birthdate,
          phone,
          citystatezip,
          orderid
FROM      products 
JOIN      orders_items USING (sku) 
JOIN      orders USING (orderid) 
JOIN      customers USING (customerid) 
WHERE     citystatezip LIKE '%staten island%' 
          AND orderid IN 
          (
            SELECT orderid FROM orders JOIN orders_items USING (orderid)
            JOIN products USING (sku)
            WHERE desc LIKE '%Cat%'
          )
          AND qty IN 
          (
            SELECT qty FROM orders JOIN orders_items USING (orderid)
            JOIN products USING (sku)
            WHERE qty > '8'
          ) 
ORDER BY name
;
