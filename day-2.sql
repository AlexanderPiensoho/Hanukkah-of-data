SELECT 
          name, 
          address,
          citystatezip,
          phone,
          ordered, 
          sku,
          orderid,
          lower(desc) AS items,
          substr(name, instr(name, ' ') +1) AS last_name 
FROM      customers 
JOIN      orders USING (customerid)
JOIN      orders_items USING (orderid)
JOIN      products USING (sku)

WHERE     orderid LIKE '%7459%'
AND       ordered LIKE '%2017%' 
AND       name LIKE 'J%' 
AND       last_name LIKE 'P%'
;


