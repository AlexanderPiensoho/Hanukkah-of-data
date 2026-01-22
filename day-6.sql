SELECT      name, 
            phone, 
            wholesale_cost,
            unit_price,
            total,
            COUNT(*) AS nr_orders,
            customerid,
            orderid
FROM        customers
JOIN        orders USING (customerid)
JOIN        orders_items USING (orderid)
JOIN        products USING (sku)
WHERE       wholesale_cost > unit_price 
GROUP BY    name
ORDER BY    nr_orders 
            DESC LIMIT 1
;
