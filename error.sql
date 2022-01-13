--1

SELECT film_name, category, rental_duration, NTILE(4) OVER (ORDER BY rental_duration) AS standard_quartile
   
     FROM
      (SELECT MAX(f.title) AS film_name, c.name AS category, fc.category_id, SUM(f.rental_duration) AS rental_duration
        FROM category c
           JOIN film_category fc
           ON c.category_id = fc.category_id
           JOIN film f
           ON f.film_id = fc.film_id
      GROUP BY 2,3
      HAVING c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')) t1
GROUP BY 1,2;


--2

   SELECT film_name, category, rental_duration, NTILE(4) OVER (ORDER BY rental_duration) AS standard_quartile
   
     FROM
      (SELECT f.title AS film_name, c.name AS category, SUM(f.rental_duration) AS rental_duration
        FROM category c
           JOIN film_category fc
           ON c.category_id = fc.category_id
           JOIN film f
           ON f.film_id = fc.film_id
      GROUP BY 1,2
      HAVING c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')) t1;


--3

 SELECT film_name, category, rental_duration, NTILE(4) OVER (ORDER BY rental_duration) AS standard_quartile
   
     FROM
      (SELECT fc.category_id AS film_name, c.name AS category, SUM(f.rental_duration) AS rental_duration
        FROM category c
           JOIN film_category fc
           ON c.category_id = fc.category_id
           JOIN film f
           ON f.film_id = fc.film_id
      GROUP BY 1,2
      HAVING c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')) t1
     GROUP BY 1,2,3;