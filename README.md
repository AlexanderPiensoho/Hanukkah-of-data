# Thought process

This is just my notes from when i tried to solve the problems for Hannukah of data.
It's for our database class and its manditory to only use SQL and no other language.

---------------------------------------------------------------------------------
## Process solution Day 2

- Hitta JP, 2017 JP

- hitta orderdatum som är 2017 men en person som heter J.... P....
- Joina order och customers med customerid för att få fram namnen.

- SELECT ordered, name FROM orders JOIN customers USING (customerid);

- Plockade fram allt från 2017 

- SELECT ordered, name FROM orders JOIN customers USING (customerid) WHERE ordered LIKE '%2017%';

- Nu måste vi få fram förnamn som börjar på J och efternamn som börjar på P - vi tänker kanske 2 olika subqueries

- gav upp på subqueries just nu och kom på att vi kunde använda AND för att använda en till LIKE 

- SELECT ordered, name FROM orders JOIN customers USING (customerid) WHERE ordered LIKE '%2017%' AND name LIKE 'J%';

- nu ska vi lösa efternamn

- prompt för att hitta efternamn som börjar på P 

- SELECT substr(name, instr(name, ' ') +1) as last_name FROM customers WHERE last_name LIKE 'P%'; 

- Vi krånglade till det i onödan, det va bara att använda 3 LIKE...

- Nu vill vi hitta en JP som handlat kaffe + bagels. Så vi måste mappa ihop produkter.

- vi behöver JOIN products och order_items med sku

- SELECT sku, lower(desc) as items FROM products WHERE items LIKE '%bagel%' OR items LIKE '%coffe%';

- SELECT sku, lower(desc) as items FROM products JOIN orders_items USING (sku) WHERE items LIKE '%bagel%' OR items LIKE '%coffe%' GROUP BY items;

- VI vet vem det är men hittar inte sättet att bara få fram han.

- Vi gjorde lite manuellt för att få fram vilket orderid som stämmer med hans beställning och sökte på det

### Solution day 2 
- Phone-number: 332-274-4185

----------------------------------------------------------------------------------
## Process solution day 3
