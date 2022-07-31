SELECT count(c.customer_id), s.branch_name FROM cliente c , sucursal s 
WHERE c.branch_id = s.branch_id 
GROUP BY s.branch_name
ORDER BY count(c.customer_id) DESC;
---------------------------------------------

SELECT s.branch_id, s.branch_name, round(CAST(count(DISTINCT e.employee_id)as REAL)/count(DISTINCT c.customer_id),2) AS promedio 
FROM sucursal s  
INNER JOIN empleado e ON s.branch_id = e.branch_id
INNER JOIN cliente c ON s.branch_id = c.branch_id
GROUP by s.branch_id

------------------------------------------------

SELECT s.branch_name, count(t.card_id) FROM sucursal s 


-------------------------------------------------
CREATE VIEW prestamosCLientes_view
AS 
SELECT
	c.customer_id,
    c.branch_id,
    c.customer_name,
    c.customer_surname,
    c.customer_DNI,
    sum(p.loan_total) as prestamos_total
FROM
	cliente c
INNER JOIN prestamo p ON c.customer_id = p.customer_id
GROUP BY c.customer_id

SELECT avg(p.prestamos_total) AS promedioCredito, s.branch_name  FROM prestamosCLientes_view p, sucursal s 
WHERE p.branch_id = s.branch_id 
GROUP BY s.branch_name;
