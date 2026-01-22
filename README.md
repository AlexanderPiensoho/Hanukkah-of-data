# Hannukah of data 
This is my thought process and solutions for Hannukah of data hebrew year 5784:
https://hanukkah.bluebird.sh/5784/


# Thought process

This is just my notes from when i tried to solve the problems for Hannukah of data.
It's for our database class and its manditory to only use SQL and no other language.

## Solution day 1 
- 826-636-2286
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

- Använd WHERE ... LIKE 1939 '%1951%' OR 1963, 1975, 1987, 1999 
- Kanske finns en produkt som är spindelhatt eller liknande som också går att sortera på?

- Alla kräftor 1939 
- SELECT name, phone, birthdate  FROM customers WHERE birthdate BETWEEN '1939-06-21' AND '1939-07-22';

- Alla år utan specifika datum
- SELECT name, phone, birthdate  FROM customers WHERE birthdate LIKE '1939%' OR '1951%' OR '1963%' OR '1975%' OR '1987%' OR '1999%';

- Det här fungerade ej, men tror jag är något på spåret 
- SELECT name, phone, birthdate  FROM (SELECT name, phone, birthdate FROM customers WHERE birthdate BETWEEN '1939-06-21' AND '1999-07-22') WHERE birthdate LIKE '1939%' OR '1951%' OR '1963%' OR '1975%' OR '1987%' OR '1999%';

- Det här tar fram alla som är födda räckor på kaninens år

- Lösningen va att sortera alla år sedan plocka fram personen som bodde i samma område som han på dag 2

### Solution day 3 
- Phone: 917-288-9635

----------------------------------------------------------------------------------
## Process solution day 4 

- Kvinna som har handlat på Noahs innan 05.00, hon brukade handla dom första bakelserna från ugnen.
- kolla om Noahs säljer bike repair kits

- Tar fram alla bakverk på noahs 
- SELECT  substr(sku,0,4) AS bky, desc FROM products WHERE bky LIKE 'bky';

- plockar fram relevant information från rätt tabeller
- SELECT name, phone, ordered, shipped, desc FROM customers JOIN orders USING (customerid) JOIN orders_items USING (orderid) JOIN products USING (sku) LIMIT 10;

- dags att få ihop queries och sedan sortera det på tid också.
- jag fick sortera att ordered och shipped va samma tid (då hon inte förbeställde)
- och att hon inte skulle vara född för 1980 (killen hon träffade på tinder va född 1999, så det va ett antagande jag vågade göra)

### Solution day 4 
- phone: 607-231-3605
----------------------------------------------------------------------------------
## Process solution day 5 

- Kolla efter sweatshirts (jersey), person som troligtvis köper mycket kattmat och bort i Staten Island. 

- SELECT sku, desc FROM products WHERE desc LIKE '%jersey%';

- JOINAR alla bord för att få ihop inköp, produkter och kunder
- SELECT sku, desc, name, phone  FROM products JOIN orders_items USING (sku) JOIN orders USING (orderid) JOIN customers USING (customerid) WHERE desc LIKE '%jersey%';

- Det här va rätt så nära, men behöver smalna till det lite till
```
SELECT    sku, 
          desc, 
          name, 
          phone,
          citystatezip
FROM      products 
JOIN      orders_items USING (sku) 
JOIN      orders USING (orderid) 
JOIN      customers USING (customerid) 
WHERE     citystatezip LIKE '%stat%' AND
          desc LIKE '%jersey%'
;
```
- testade det här, och trodde verkligen att någon av namnen skulle vara rätt som va kvinna. Men ingen verkar fungera och just nu förstår jag inte varför.
```
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
          AND customerid IN 
          ( 
            SELECT customerid FROM orders JOIN orders_items USING (orderid)
            JOIN products USING (sku)
            WHERE desc LIKE '%jersey%'
          ) 
          AND customerid IN 
          (
            SELECT customerid FROM orders JOIN orders_items USING (orderid)
            JOIN products USING (sku)
            WHERE desc LIKE '%Cat%'
          )
GROUP BY name 
ORDER BY name
;
```
 - Nu löste jag det äntligen, jag skulle ju sortera på qty också... Något som jag totalt missat.

### Solution day 5 
- Phone: 631-507-6048
----------------------------------------------------------------------------------
## Process solution day 6 

- Kusinen handlar alltid på REA och med kuponger. Leta efter bra priser. 
- Matcha wholesale_cost från products med total från orders för att leta efter försäljningar där dom gör förlust?
- Det är en kvinna jag letar efter.
- Hitta en person som har handlat väldigt mycket på Noahs där noah har gått med förslust. Men det är fortfaranade väldigt mycket personer kvar och det är en chansning, måste försöka smalna av mer.
```
SELECT      name, 
            phone, 
            wholesale_cost,
            unit_price,
            total,
            qty,
            desc
FROM        customers
JOIN        orders USING (customerid)
JOIN        orders_items USING (orderid)
JOIN        products USING (sku)
WHERE wholesale_cost > unit_price 
ORDER BY name
;
```
- Kollade även vem som hade handlat väldigt mycket när Noahs gjort förlust och det va rätt person som handlade 54!! gånger.
### Solution day 6 
- phone: 585-838-9161
----------------------------------------------------------------------------------
## Process solution day 7

- Kollade alla köp som Sherri (från förra dagen) gjort med produkter som har olika färger.

- Sedan kollade vi alla köp på färgade produkter som gjorts samtidigt och matchade det.

- den här har gått snabbast hittils.

### Solution day 7

- phone: 838-335-7157
----------------------------------------------------------------------------------






