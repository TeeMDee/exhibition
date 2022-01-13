/* Set 1 Question 1 Create a query that lists each movie,
 the film categoryit is classified in, 
 and the number of times it has been rented rented*/

SELECT  f.title film_title, c.name category_name,
       COUNT(r.rental_id) AS rental_count
FROM category c

JOIN film_category fc
ON c.category_id = fc.category_id
AND c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')

JOIN film f
ON f.film_id = fc.film_id

JOIN inventory i
ON f.film_id = i.film_id

JOIN rental r
ON i.inventory_id = r.inventory_id

GROUP BY  1, 2
ORDER BY  2, 1;







/* Set 1 Question 2: We need to */


//*    wrong code 
   
SELECT t.name, standard_quartile
       COUNT(*) rental_duartion
FROM
   (SELECT c.name, f.rental_duration,
          NTILE (4) OVER (ORDER BY f.rental_duration) AS standard_quartile
    
   FROM category c

   JOIN film_category fc
   ON c.category_id = fc.category_id
   AND c.name IN ('Animation', 'Children', 'Classic', 'Comedy', 'Family', 'Music')

   JOIN film f
   ON f.film_id = fc.film_id) t1

   GROUP BY 1, 2
   ORDER BY 2;    */
       







 
 /* Query 2 - the query used for the second insight*/
 
 
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




/* Query 2 Prototype */
 SELECT film_name, category, rental_duration, NTILE(4) OVER (ORDER BY rental_duration) AS standard_quartile
   
     FROM
      (SELECT f.title AS film_name, c.name AS category, fc.category_id,  AVG(f.rental_duration) AS rental_duration
        FROM category c
           JOIN film_category fc
           ON c.category_id = fc.category_id
           JOIN film f
           ON f.film_id = fc.film_id
      GROUP BY 1,2,3
      HAVING c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')) t1;



 /*  Query 2 prototype 2
   SELECT film_name, category, rental_duration, NTILE(4) OVER (ORDER BY rental_duration) AS standard_quartile
   
     FROM
      (SELECT MAX(f.title) AS film_name, c.name AS category, SUM(f.rental_duration) AS rental_duration
        FROM category c
           JOIN film_category fc
           ON c.category_id = fc.category_id
           JOIN film f
           ON f.film_id = fc.film_id
      GROUP BY 2
      HAVING c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')) t1
    GROUP BY  1, 2, 3; */
 



/* SET 1 QUESTION 3*/
/*
SELECT category, standard_quartile,
               COUNT (*)

        FROM
        (SELECT c.name category, f.rental_duration,
               NTILE (4) OVER (ORDER BY f.rental_duration) AS standard_quartile

           FROM category c
             JOIN film_category fc
             ON c.category_id = fc.category_id
             JOIN film f
             ON f.film_id = fc.film_id
             GROUP BY 1, 2
             HAVING c.name IN ('Animation', 'Children', 'Classics', 'Comedy', 'Family', 'Music')) t1

             GROUP BY 1, 2 */




 

/* Set 2 QUESTION 1 -- QUESTION 4*/

SELECT Rental_month, Rental_year, Store_ID,
         COUNT (*) Count_Rentals

  FROM
    (SELECT s.store_id Store_ID, rental_date Rental_date,
           DATE_PART ('month', rental_date) AS Rental_month,
           DATE_PART ('year', rental_date)  AS Rental_year
       FROM store s 
       JOIN staff st
       ON s.store_id = st.store_id
       JOIN rental r
       ON r.staff_id = st.staff_id) t1
   GROUP BY 1, 2, 3
   ORDER BY 4 DESC;



/* Set 2 Question 2

WITH t1 AS (SELECT (first_name || ' ' || last_name) AS name, 
                   c.customer_id,
                   p.amount, 
                   p.payment_date
              FROM customer AS c

                   JOIN payment AS p
                    ON c.customer_id = p.customer_id),

     t2 AS (SELECT t1.customer_id
              FROM t1
             GROUP BY 1
             ORDER BY SUM(t1.amount) DESC
             LIMIT 10)

SELECT t1.name, t1.payment_date,
       DATE_PART('month', t1.payment_date) AS payment_month, 
       DATE_PART('year', t1.payment_date) AS payment_year,
       COUNT (*),
       SUM(t1.amount)
  FROM t1
       JOIN t2
        ON t1.customer_id = t2.customer_id
 GROUP BY 1, 2, 3, 4
HAVING t1.payment_date BETWEEN '20070101' AND '20080101';  */


 


/*  Set 2 Question 2 */ 

  SELECT pay_month, fullname, COUNT(*) Pay_countpermonth, SUM(Pay_amount) Pay_amount

    FROM
          (SELECT c.first_name, c.last_name, P.payment_date,
                 c.first_name ||' '|| c.last_name AS fullname,
                 DATE_TRUNC ('month', p.payment_date) pay_month,
                 p.amount Pay_amount
          FROM customer c
          JOIN payment p 
          ON c.customer_id = p.customer_id)t1
   GROUP BY 1,2
   ORDER BY 4 DESC
   LIMIT 10;



   /* Golden DataScience 
   WITH t1 AS (SELECT (first_name || ' ' || last_name) AS name, 
                   c.customer_id, 
                   p.amount, 
                   p.payment_date
              FROM customer AS c
                   JOIN payment AS p
                    ON c.customer_id = p.customer_id),

     t2 AS (SELECT t1.customer_id
              FROM t1
             GROUP BY 1
             ORDER BY SUM(t1.amount) DESC
             LIMIT 10)

SELECT DATE_TRUNC('month', t1.payment_date) AS payment_date,
       t1.name,
	   COUNT (*),
       SUM(t1.amount)
  FROM t1
       JOIN t2
        ON t1.customer_id = t2.customer_id
 WHERE t1.payment_date BETWEEN '20070101' AND '20080101'
 GROUP BY 1, 2
 ORDER BY 2;
*/