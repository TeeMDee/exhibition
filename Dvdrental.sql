/* practice quiz 1
 Write a query that create a table within 4 columns: actor's fullname, film title, length of movie, and a column name "filmlen_group" that classifies based on thier length. Filmlen_groups should include 4 categories: ! hour or less, Between 1-2hours, Between 2-3hours, more than 3hours*/

SELECT fullname, filmtitle, filmlen,
       CASE WHEN filmlen <= 60 THEN '1 hours or less'
       WHEN filmlen > 60 AND filmlen <= 120 THEN 'Between 1-2hours'
       WHEN filmlen > 120 AND filmlen <= 180 THEN 'Between 2-3hours'
       ELSE 'More than 3hours' END AS filmlen_group

FROM
        (SELECT a.first_name, a.last_name, a.first_name ||' ' || a.last_name AS fullname, f.title filmtitle, f.length filmlen
        FROM film_actor fa 
        JOIN actor a
        ON fa.actor_id = a.actor_id
        JOIN film f 
        ON f.film_id = fa.film_id)t1;



/* Practice quiz 2
   Write a query to create a count of movies in each of the 4 filmlen_groups: 1 hour or less, Between 1-2 hours, Between 2-3 hours, more than 3 hours*/

SELECT DISTINCT (Filmlen_groups)
       COUNT (title) OVER (PARTITION BY filmlen_group) AS filmcount

FROM
    (SELECT title, length,
       CASE WHEN length <= 60 THEN '1 hours or less'
       WHEN length > 60 AND length <= 120 THEN 'Between 1-2hours'
       WHEN length > 120 AND length <= 180 THEN 'Between 2-3hours'
       ELSE 'More than 3hours' END AS filmlen_groups
    FROM film) t1
    ORDER BY filmlen_groups;








    SELECT 