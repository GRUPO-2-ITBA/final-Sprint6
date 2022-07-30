SELECT * FROM cuenta WHERE balance < 0;

SELECT customer_name, customer_surname, edad FROM clientes_view WHERE customer_surname LIKE '%z%';

SELECT c.customer_name, c.customer_surname, c.edad, s.branch_name FROM clientes_view c, sucursal s WHERE c.customer_name == 'Brendan' and c.branch_id = s.branch_id ORDER BY s.branch_id DESC;


SELECT * FROM prestamo where loan_type == "PRENDARIO"
INTERSECT
SELECT * FROM prestamo where loan_total > 8000000

SELECT avg(loan_total) AS PROMEDIO FROM prestamo where loan_total > PROMEDIO;
