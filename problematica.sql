BEGIN TRANSACTION;

CREATE TABLE tipo_cliente (
  customer_type_id INTEGER NOT NULL PRIMARY KEY,
  type_description TEXT NOT NULL
);
INSERT INTO tipo_cliente (type_description) VALUES ('Classic'), ('Gold'), ('Black');

ALTER TABLE cliente ADD COLUMN customer_type_id INTEGER;
ALTER TABLE cliente RENAME TO cliente_old;


CREATE TABLE cliente
(
    customer_id INTEGER PRIMARY KEY AUTOINCREMENT,
    customer_name TEXT NOT NULL,
    customer_surname TEXT NOT NULL,
    customer_DNI TEXT NOT NULL,
    dob INTEGER NOT NULL,
    branch_id INTEGER NOT NULL,
    customer_type_id INTEGER,
    address_id INTEGER,
    FOREIGN KEY (customer_type_id) 
    REFERENCES tipo_cliente(customer_type_id) ON DELETE CASCADE,
    FOREIGN KEY (branch_id) 
    REFERENCES sucursal(branch_id) ON DELETE CASCADE
    FOREIGN KEY (address_id) REFERENCES direcciones(address_id)

);

INSERT INTO cliente SELECT * FROM cliente_old;
DROP TABLE cliente_old;
COMMIT;


BEGIN TRANSACTION;

CREATE TABLE tipo_cuenta (
  account_type_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  account_type_description TEXT NOT NULL,
);

INSERT INTO tipo_cuenta (account_type_description) 
VALUES ('Caja de ahorro en pesos'),
('Caja de ahorro en dolares'),
('Cuenta corriente en Pesos'),
('Cuenta corriente en dolares'),
('Cuenta inversion');

ALTER TABLE cuenta ADD COLUMN account_type_id INTEGER;
ALTER TABLE cuenta RENAME TO cuenta_old;

CREATE TABLE cuenta
(
  account_id INTEGER PRIMARY KEY AUTOINCREMENT,
  customer_id INTEGER NOT NULL,
  balance INTEGER NOT NULL,
  account_type_id INTEGER,
  FOREIGN KEY (account_type_id) 
  REFERENCES tipo_cuenta(account_type_id) ON DELETE CASCADE,
  FOREIGN KEY (customer_id) 
  REFERENCES cliente(customer_id) ON DELETE CASCADE
);

INSERT INTO cuenta SELECT * FROM cuenta_old;
DROP TABLE cuenta_old;
COMMIT;


BEGIN TRANSACTION;

ALTER TABLE prestamo RENAME TO prestamo_old;

CREATE TABLE prestamo
(
  loan_id INTEGER PRIMARY KEY,
  loan_payment char(50) NOT NULL,
  loan_date date NOT NULL,
  loan_total INTEGER NOT NULL,
  customer_id INTEGER NOT NULL,
  FOREIGN KEY (customer_id) 
  REFERENCES cliente(customer_id) ON DELETE CASCADE
);

INSERT INTO prestamo SELECT * FROM prestamo_old;
DROP TABLE prestamo_old;
COMMIT;

BEGIN TRANSACTION;
CREATE TABLE marca_tarjeta (
  card_brand_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  card_brand_description TEXT NOT NULL
);

INSERT INTO marca_tarjeta(card_brand_description)
VALUES ("Mastercard"), ("Visa"),("American Express");

CREATE TABLE tarjeta (
  card_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  card_number VARCHAR(20) UNIQUE NOT NULL,
  card_expiration_date DATE NOT NULL,
  card_issue_date DATE NOT NULL,
  card_cvv VARCHAR(3) NOT NULL,
  card_type TEXT NOT NULL,
  customer_id INTEGER NOT NULL,
  brand_card_id INTEGER NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES cliente(customer_id),
  FOREIGN KEY (brand_card_id) REFERENCES marca_tarjeta(card_brand_id)
);

INSERT INTO tarjeta (card_number, card_cvv,card_issue_date,card_expiration_date,card_type,brand_card_id,customer_id)
VALUES ("343549897659889","921","0122","0923","Debito","2",404);
COMMIT;


INSERT INTO tarjeta (card_number, card_cvv,card_issue_date,card_expiration_date,card_type,brand_card_id,customer_id)
VALUES ("343549897659887","921","0122","0923","credito","2",200);

BEGIN TRANSACTION;
CREATE TABLE direcciones (
  address_id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  address_street TEXT NOT NULL,
  address_number INTEGER NOT NULL,
  address_city TEXT NOT NULL,
  address_province TEXT NOT NULL,
  address_country TEXT NOT NULL,
  customer_id INTEGER NOT NULL
);


BEGIN TRANSACTION;

ALTER TABLE sucursal RENAME TO sucursal_old;

CREATE TABLE sucursal
(
  branch_id INTEGER NOT NULL PRIMARY KEY,
  branch_name char(50) NOT NULL,
  branch_address varchar(255) NOT NULL,
  FOREIGN KEY (branch_address) 
  REFERENCES direcciones(address_id) ON DELETE CASCADE
);

INSERT INTO sucursal SELECT * FROM sucursal_old;
DROP TABLE sucursal_old;
COMMIT;

BEGIN TRANSACTION;

ALTER TABLE empleado RENAME TO empleado_old;

CREATE TABLE empleado
(
  employee_id INTEGER NOT NULL PRIMARY KEY,
  employee_name char(50) NOT NULL,
  employee_surname char(50) NOT NULL,
  employee_hire_date DATE NOT NULL,
  employee_DNI char(50) NOT NULL,
  branch_id INTEGER NOT NULL,
  employee_address_id INTEGER NOT NULL,
  FOREIGN KEY (branch_id) 
  REFERENCES sucursal(branch_id) ON DELETE CASCADE,
  FOREIGN KEY (employee_address_id)
  REFERENCES direcciones(address_id) ON DELETE CASCADE
);

INSERT INTO empleado SELECT * FROM empleado_old;
DROP TABLE empleado_old;

UPDATE empleado 
SET employee_hire_date = (substr(employee_hire_date, 7, 4) || '-' || substr(employee_hire_date, 4, 2) || '-' || substr(employee_hire_date, 1, 2)) 
WHERE employee_hire_date <> ''
COMMIT;