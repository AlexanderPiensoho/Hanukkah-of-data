SELECT    name,
          phone,
          customerid,
          sku,
          desc,
          GROUP_CONCAT(desc) grp,
          COUNT(sku) AS cnt
FROM      products 
JOIN      orders_items USING (sku)
JOIN      orders USING (orderid)
JOIN      customers USING (customerid)
WHERE     desc LIKE 'noah%' AND sku LIKE 'COL%'
GROUP by customerid
ORDER BY cnt
DESC LIMIT 1
;
