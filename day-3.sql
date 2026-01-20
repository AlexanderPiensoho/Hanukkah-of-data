SELECT        name, 
              phone, 
              birthdate, 
              citystatezip
FROM          customers 
WHERE         (birthdate BETWEEN '1939-06-21' AND '1939-07-22' 
              OR birthdate BETWEEN '1951-06-21' AND '1951-07-22' 
              OR birthdate BETWEEN '1963-06-21' AND '1963-07-22'
              OR birthdate BETWEEN '1975-06-21' AND '1975-07-22'
              OR birthdate BETWEEN '1987-06-21' AND '1987-07-22'
              OR birthdate BETWEEN '1999-06-21' AND '1999-07-22')
              AND citystatezip LIKE '%Jamaica%'
              ;

