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
  card_expiration_date TEXT NOT NULL,
  card_issue_date TEXT NOT NULL,
  card_cvv VARCHAR(3) NOT NULL,
  card_type TEXT NOT NULL,
  customer_id INTEGER NOT NULL,
  FOREIGN KEY (customer_id) REFERENCES cliente(customer_id)
);

INSERT INTO tarjeta (card_number, card_cvv,card_issue_date,card_expiration_date,card_type,customer_id)
VALUES ("343549897659889","921","01/20","09/23","debito",404);
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
  address_country TEXT NOT NULL
);
COMMIT;

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


-----------------------------------------------------------------

INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Nuevo León','10-3','Nueva Arabia Saudita','Tabasco','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Iowa','6208','Lake Jessica','Kansas','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Melilla','49093','Tarragona','Principado de Asturias','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Córdoba','99-2','Mocoa','Chocó','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Chihuahua','9-25','Nueva Rwanda','Querétaro','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('New Jersey','46731','Leslieland','Iowa','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Ceuta','7-70','Salamanca','Cataluña','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Cesar','6390','Versalles','Bogotá, D.C.','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Colima','7','Nueva Mongolia','Nayarit','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('California','72373','South Rogerhaven','Iowa','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('León','5008','La Rioja','Ciudad Autónoma de Melilla','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Meta','9-89','Anapoima','Cauca','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Aguascalientes','818','San Carolina los bajos','Puebla','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Nebraska','977','North Ernest','Maine','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Las Palmas','67808','Salamanca','Andalucía','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Bolívar','426','Mahates','Norte de Santander','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Guanajuato','2898','San Héctor de la Montaña','México','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Colorado','06092','Kellyborough','Wyoming','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Guadalajara','655','Guipúzcoa','La Rioja','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Cundinamarca','22315','Caramanta','Cundinamarca','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Puebla','4205','Vieja México','Tamaulipas','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Washington','528','East Robertshire','Montana','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Burgos','850','Guadalajara','Cataluña','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('La Guajira','4','Marsella','Vaupés','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Baja California','15921','Nueva Islas Salomón','Guanajuato','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Florida','90-32','Mccoybury','California','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('La Coruña','52Q-51','Salamanca','Galicia','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Cundinamarca','2054','Chámeza','Norte de Santander','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Nuevo León','977','San Rosalia los bajos','Guanajuato','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Michigan','75543','North Bryanview','Vermont','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Ciudad','367','Lugo','Castilla y León','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Huila','255','Guadalupe','Cundinamarca','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Chihuahua','972','San César de la Montaña','Sinaloa','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Iowa','4906','Lake Gary','Vermont','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Madrid','7L-34','Albacete','Ciudad Autónoma de Melilla','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Vaupés','3782','San Juan del Cesar','La Guajira','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Tlaxcala','18','Nueva Samoa','Tlaxcala','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Kansas','8763','Lorihaven','New Hampshire','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Salamanca','79B-9','Cádiz','Aragón','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Guainía','78146','Soracá','Quindío','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Morelos','3580','Vieja San Vicente y las Granadinas','Nayarit','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Missouri','84','Choiport','Hawaii','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Cáceres','3552','Sevilla','Comunitat Valenciana','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Caldas','00411','Puerto Santander','Atlántico','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Morelos','372','Vieja Malawi','México','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Colorado','800','Costaview','Kentucky','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Málaga','1701','Toledo','Comunitat Valenciana','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Vichada','66','Guaca','Caldas','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Nayarit','7709','Nueva Barbados','Zacatecas','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Wisconsin','60740','Hooverview','Arizona','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Badajoz','5-8','Valladolid','Cataluña','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Risaralda','8266','Valle del Guamuez','Santander','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Tamaulipas','5858','San Florencia los bajos','Chiapas','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Maine','91','Wolffurt','Oklahoma','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Badajoz','4201','Baleares','Cataluña','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Guainía','97','Palestina','Meta','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('México','43','San Emilio los bajos','Sinaloa','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('California','1-3','Lake Brian','Minnesota','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Valencia','278','Barcelona','Comunidad Foral de Navarra','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Arauca','1-52','Salamina','Meta','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Aguascalientes','3-93','Vieja Bhután','Zacatecas','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Iowa','5K-9','South Nathanchester','New York','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Lleida','69','Cádiz','La Rioja','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Valle del Cauca','2M-3','Concepción','Caquetá','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Veracruz de Ignacio de la Llave','6381','Nueva Kuwait','Tabasco','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Iowa','999','Ortizton','Missouri','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Ciudad','42-80','Alicante','Principado de Asturias','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Arauca','9854','Caucasia','Vaupés','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Durango','642','Nueva Chile','Zacatecas','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Alabama','33','Burkestad','Tennessee','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Córdoba','46-2','Cuenca','Extremadura','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Caldas','0500','Caramanta','La Guajira','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Coahuila de Zaragoza','9229','San Eduardo los bajos','Querétaro','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Mississippi','500','Johnsonberg','New Hampshire','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Pontevedra','47-8','Ciudad','Principado de Asturias','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Vichada','4691','San Carlos','Risaralda','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Yucatán','52','San Alma los bajos','Michoacán de Ocampo','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Mississippi','4465','West Josephberg','New York','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Madrid','181','Ciudad','Aragón','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Sucre','63','Sabanas de San Ángel','Amazonas','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Colima','21D-19','Vieja Camerún','Tabasco','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Ohio','4D-1','North Triciaville','Iowa','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Burgos','75C-2','Segovia','Ciudad Autónoma de Melilla','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Risaralda','24147','Armero','Magdalena','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Distrito Federal','524','San Beatriz los altos','Campeche','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Utah','46303','Christinebury','West Virginia','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Cuenca','512','Almería','Principado de Asturias','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Amazonas','1-2','Chachagüí','Valle del Cauca','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Querétaro','263','San Zoé de la Montaña','Veracruz de Ignacio de la Llave','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Washington','84-2','Perrystad','Connecticut','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Ávila','86025','Lleida','Comunidad Foral de Navarra','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Guainía','26803','Labranzagrande','Chocó','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Veracruz de Ignacio de la Llave','5-3','Nueva Santa Lucía','Puebla','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Pennsylvania','24012','Perezshire','Connecticut','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Lleida','1-95','Guipúzcoa','Cantabria','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Cesar','0467','Restrepo','Tolima','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Guanajuato','883','Vieja Israel','México','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Nebraska','8159','Coryberg','New Mexico','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Pontevedra','6','Valladolid','Cantabria','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Caldas','57','Tununguá','Casanare','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Querétaro','9-60','San Luz de la Montaña','Tlaxcala','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('New Jersey','362','Taylorport','New Jersey','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Málaga','2165','Valencia','Ciudad Autónoma de Ceuta','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Valle del Cauca','9995','Trujillo','Atlántico','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Chihuahua','82297','San Marcela los bajos','Yucatán','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Oregon','36S-81','Alexandraton','Kansas','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Albacete','32','Guadalajara','Cantabria','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Huila','63724','Calamar','Atlántico','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Michoacán de Ocampo','25373','San Inés los altos','Tlaxcala','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Colorado','91-4','New Bradleyfort','Illinois','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Baleares','76-62','Lleida','Región de Murcia','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Santander','523','Belén','Nariño','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Baja California Sur','11-5','San Nayeli los altos','Chiapas','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Idaho','13607','Smithville','Connecticut','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Burgos','4361','Barcelona','Canarias','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Boyacá','701','San Andrés','Chocó','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Nayarit','73','Nueva Arabia Saudita','Chihuahua','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Wyoming','803','West Stephanie','Montana','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Soria','0355','Zamora','Castilla y León','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Boyacá','31513','Palocabildo','Tolima','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Sonora','094','San Jesús de la Montaña','Campeche','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('West Virginia','484','East Samantha','New Mexico','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Sevilla','339','Lleida','Comunidad de Madrid','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Sucre','72-39','Sutatenza','Atlántico','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Sonora','4Z-4','San Esteban los bajos','Hidalgo','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Illinois','889','Port Davidshire','Idaho','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Ourense','1-9','Córdoba','Ciudad Autónoma de Ceuta','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Córdoba','59','Lorica','Risaralda','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Chihuahua','63-79','San René los bajos','Campeche','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Delaware','48015','Lamtown','Florida','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Almería','21968','Ciudad','Galicia','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Atlántico','28732','Bogotá, D.C.','Arauca','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('San Luis Potosí','9-16','Nueva Sudáfrica','Tabasco','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Nebraska','8555','North Brettview','Massachusetts','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Cuenca','4','Ceuta','Andalucía','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Magdalena','9-96','Támesis','Arauca','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Nayarit','54','San Gabriela de la Montaña','Hidalgo','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Kansas','5392','Hallshire','Nebraska','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Asturias','3645','Toledo','Castilla-La Mancha','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Boyacá','950','Sativanorte','Córdoba','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Chihuahua','486','Nueva Qatar','Yucatán','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Mississippi','2-9','East Shannon','New Mexico','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Navarra','91','Zaragoza','País Vasco','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Magdalena','5732','Castilla la Nueva','Nariño','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Zacatecas','58-6','San María del Carmen los bajos','Tabasco','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('North Dakota','1-60','Port Jenniferport','Texas','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Madrid','94-66','Alicante','Región de Murcia','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Vichada','23','Puerto Gaitán','Córdoba','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Durango','34605','Vieja Argelia','Veracruz de Ignacio de la Llave','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('North Carolina','04392','Sheriside','Pennsylvania','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Valladolid','7-3','Lugo','Ciudad Autónoma de Ceuta','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Córdoba','6209','Puerto Nare','Valle del Cauca','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('México','2-62','San Porfirio los altos','Yucatán','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Alabama','98414','Sethstad','Colorado','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Jaén','74','Tarragona','Aragón','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Nariño','9-55','Florián','Tolima','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Querétaro','4-2','Vieja Myanmar','Zacatecas','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Wisconsin','8516','Port Larry','New Mexico','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Salamanca','3-7','Cádiz','La Rioja','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Bogotá, D.C.','23-9','Muzo','Bolívar','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Nuevo León','4-9','San Carlos los altos','Querétaro','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Delaware','8N-31','Lake Matthewborough','Alabama','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Ciudad','3210','Asturias','Castilla y León','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Córdoba','21B-2','Tuta','Nariño','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Oaxaca','70008','Nueva República de Corea','Yucatán','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Delaware','27-67','West Amystad','Alaska','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Huesca','59','Tarragona','Castilla y León','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Putumayo','74192','Sopó','Nariño','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Morelos','60','Vieja Polonia','Hidalgo','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Utah','93A-23','Ellenburgh','South Carolina','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Vizcaya','90','Cádiz','Comunidad Foral de Navarra','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Cauca','9418','Sardinata','Cesar','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Morelos','74119','Nueva Kiribati','Yucatán','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('New Mexico','84946','West Candiceview','California','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('León','88445','Alicante','Canarias','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Atlántico','00186','Monterrey','Vaupés','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Tlaxcala','058','Nueva Belice','Tlaxcala','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Pennsylvania','25-1','Jonathanview','Massachusetts','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Lleida','5-9','Navarra','Aragón','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Nariño','71','El Copey','Cauca','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Baja California Sur','80','San Uriel los altos','Puebla','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('North Dakota','7S-55','Jonathanside','Arkansas','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Álava','36921','Cantabria','Cataluña','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Huila','22-73','Briceño','Cesar','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Colima','13088','Nueva Croacia','Guerrero','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Nebraska','57B-6','Brandonmouth','Florida','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Jaén','72583','Huelva','Ciudad Autónoma de Ceuta','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Nariño','3-7','Medio Atrato','Archipiélago de San Andrés, Providencia y Santa Catalina','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Yucatán','2B-1','San Raúl de la Montaña','Jalisco','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Texas','9-80','Woodmouth','Alabama','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Almería','18715','Madrid','Ciudad Autónoma de Ceuta','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Cesar','06134','Maicao','Sucre','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Chiapas','37','San Bernabé de la Montaña','Baja California Sur','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('New Hampshire','73989','Tylerbury','Ohio','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Baleares','285','Murcia','Illes Balears','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Norte de Santander','59105','Solita','Bolívar','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Tabasco','49970','Nueva Botswana','Zacatecas','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('South Carolina','30644','Allisonshire','Vermont','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Cáceres','4-62','Toledo','La Rioja','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Atlántico','344','Tota','Boyacá','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Baja California Sur','3-60','Nueva Djibouti','Hidalgo','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Vermont','7296','Jamesberg','Iowa','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Zaragoza','4-42','Ávila','Canarias','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Quindío','0483','San Vicente del Caguán','Cundinamarca','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Chiapas','1510','San Antonio los bajos','Chihuahua','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('New Mexico','62','Matthewport','South Carolina','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Girona','14','Zaragoza','Región de Murcia','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Antioquia','003','Pinillos','Archipiélago de San Andrés, Providencia y Santa Catalina','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Morelos','4U-84','San Juan de la Montaña','Guerrero','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('North Dakota','112','Bonillamouth','Minnesota','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Alicante','47331','Albacete','Aragón','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Chocó','23-2','Pijiño del Carmen','Arauca','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Michoacán de Ocampo','19X-9','Vieja Maldivas','Aguascalientes','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Hawaii','50463','South Alyssahaven','Wyoming','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Álava','8Q-99','Jaén','Cataluña','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Boyacá','5J-46','Mutiscua','Amazonas','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Michoacán de Ocampo','79058','San Isabela de la Montaña','Baja California','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Alaska','82','Elizabethtown','New Mexico','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Castellón','18B-2','Lugo','Ciudad Autónoma de Ceuta','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Cauca','87-3','Moniquirá','Putumayo','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('México','982','Nueva Suecia','Coahuila de Zaragoza','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Arizona','44-78','North Michele','Arizona','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Toledo','93','Ceuta','Comunidad Foral de Navarra','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Arauca','8-49','Calamar','Magdalena','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Hidalgo','577','Vieja Myanmar','Puebla','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Wisconsin','3-3','South Megan','Washington','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Soria','740','Madrid','Canarias','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Putumayo','8-98','Suárez','Cundinamarca','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Puebla','6753','Vieja Argelia','Baja California Sur','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('West Virginia','5-9','Moranhaven','Georgia','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Alicante','508','Sevilla','Comunitat Valenciana','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Caldas','8509','Tarapacá','La Guajira','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Colima','69053','Nueva Pakistán','Tlaxcala','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Tennessee','5708','North Dawnburgh','Illinois','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Valencia','6-43','Cáceres','País Vasco','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Tolima','71','Labateca','Guainía','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Yucatán','7','Nueva Guinea Ecuatorial','México','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Louisiana','19-4','Michaelside','Texas','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Ceuta','79347','Málaga','Región de Murcia','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Archipiélago de San Andrés, Providencia y Santa Catalina','6714','Copacabana','Guaviare','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Guanajuato','18581','San Judith de la Montaña','México','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Pennsylvania','78','Freemanhaven','Ohio','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Madrid','86571','Navarra','Andalucía','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Casanare','7-69','Repelón','Córdoba','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('México','5-87','San Marcela los bajos','Veracruz de Ignacio de la Llave','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Mississippi','76351','Rogerside','Montana','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Guipúzcoa','5','Álava','Canarias','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Nariño','43-95','Villanueva','Cesar','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Oaxaca','14','Nueva Rwanda','Quintana Roo','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Oregon','7199','Lake Carol','Florida','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Málaga','35-12','Ávila','Canarias','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Tolima','4T-7','Campamento','Cesar','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Aguascalientes','41-5','San Ángel los altos','Oaxaca','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Massachusetts','924','West Keithview','Texas','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Lleida','90-6','Teruel','La Rioja','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Vaupés','21','Miranda','Meta','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Jalisco','7','Nueva República Árabe Siria','Chiapas','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Wisconsin','08176','Frazierstad','Texas','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Zaragoza','2','Valladolid','Ciudad Autónoma de Ceuta','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Magdalena','925','Belén','Quindío','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Sinaloa','54','San Alejandra los altos','Chihuahua','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Maine','4-9','North Stephen','Florida','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Málaga','20-79','Lugo','Comunitat Valenciana','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Atlántico','723','Bajo Baudó','Tolima','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Oaxaca','569','Nueva Irán','Nayarit','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Georgia','9-8','Fordmouth','Vermont','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Pontevedra','488','Toledo','Castilla-La Mancha','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Santander','24892','Santa Bárbara','Sucre','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Baja California','3480','San Ivonne de la Montaña','Puebla','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Rhode Island','2-67','Port Oscar','South Dakota','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Cáceres','2161','Madrid','La Rioja','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Risaralda','2-2','Guapi','Archipiélago de San Andrés, Providencia y Santa Catalina','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Tlaxcala','0594','San Berta de la Montaña','Chihuahua','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Iowa','128','Allenchester','Louisiana','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Toledo','797','Vizcaya','País Vasco','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Tolima','6','Útica','Arauca','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Veracruz de Ignacio de la Llave','23180','San Francisco los bajos','Michoacán de Ocampo','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Texas','28-76','West Meghan','West Virginia','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Vizcaya','7O-56','Álava','Canarias','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Nariño','488','Suaita','Chocó','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Coahuila de Zaragoza','294','Nueva Rumania','Tlaxcala','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('North Carolina','73','Port James','Kentucky','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Ourense','119','Zamora','Principado de Asturias','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Meta','4175','Suan','Casanare','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Michoacán de Ocampo','679','Nueva Guatemala','Coahuila de Zaragoza','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Colorado','983','Michaelfurt','Oklahoma','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Segovia','67C-99','Toledo','Aragón','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Sucre','26-25','La Tola','Putumayo','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Morelos','5394','Nueva Afganistán','Campeche','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Montana','5-68','New Sean','Colorado','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('La Rioja','21-7','Álava','Cantabria','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Caquetá','4','Ponedera','Magdalena','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Durango','76-6','Nueva Australia','Querétaro','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Kansas','78295','Andrewside','Pennsylvania','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Madrid','670','Sevilla','Extremadura','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Valle del Cauca','285','Sotará Paispamba','Cauca','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Veracruz de Ignacio de la Llave','318','Nueva Alemania','Zacatecas','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Montana','0972','New Charlesport','Florida','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Asturias','82','Lleida','Cataluña','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Norte de Santander','4738','Soacha','Chocó','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('San Luis Potosí','5-1','Vieja España','Veracruz de Ignacio de la Llave','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Rhode Island','6','Port Sharonview','Nevada','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Zamora','14','Tarragona','Andalucía','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Cesar','4A-91','Milán','Bogotá, D.C.','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Puebla','1X-75','Nueva Sudáfrica','Yucatán','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Wisconsin','98079','Webbtown','Louisiana','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Melilla','5425','Lugo','Región de Murcia','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Cundinamarca','81605','Soracá','Santander','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Baja California','1-5','Vieja Côte d Ivoire','Puebla','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('New Jersey','6N-85','Lake Crystal','Maine','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Lleida','51-64','Huelva','Comunidad de Madrid','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Risaralda','069','Yacopí','Guainía','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Yucatán','49-6','San Ana Luisa de la Montaña','Jalisco','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('California','8-76','Port Josephmouth','Kansas','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Almería','197','Sevilla','Cantabria','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Sucre','2603','Belén de los Andaquíes','Magdalena','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Jalisco','65','Nueva Côte d Ivoire','Tabasco','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Montana','364','Mortonstad','Nevada','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Melilla','6','Córdoba','Principado de Asturias','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Putumayo','96-7','San Pablo de Borbur','Arauca','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Tlaxcala','7','San Eugenia los bajos','Tlaxcala','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Nevada','934','Richardborough','Maine','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Vizcaya','1-20','León','Comunidad de Madrid','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Amazonas','4Q-42','Boyacá','Sucre','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Zacatecas','49','San Alejandro de la Montaña','Nayarit','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Kansas','77-9','East Kathleenfort','North Carolina','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Burgos','101','Vizcaya','País Vasco','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Arauca','1-9','Pupiales','Huila','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Aguascalientes','490','Nueva Zimbabwe','Aguascalientes','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Delaware','90172','Lake Lisachester','Mississippi','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Lleida','626','Ourense','Canarias','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Cesar','93848','Nariño','Boyacá','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Guanajuato','3615','San Camila los bajos','Nayarit','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('North Dakota','77982','Shariview','Tennessee','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Valencia','1-29','Cuenca','Comunitat Valenciana','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Santander','9','Chimichagua','Norte de Santander','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Oaxaca','6T-67','San Esther los bajos','Jalisco','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Iowa','92','Ronaldburgh','Mississippi','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Toledo','65-5','Burgos','Aragón','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Cesar','1184','San Cayetano','Caldas','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Chihuahua','4426','San Raúl los altos','Yucatán','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Idaho','54','Whiteburgh','Massachusetts','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Vizcaya','8357','Salamanca','Comunitat Valenciana','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Archipiélago de San Andrés, Providencia y Santa Catalina','1-45','Cocorná','Putumayo','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Tabasco','827','San Uriel de la Montaña','Nuevo León','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Louisiana','22I-39','Stevenhaven','Mississippi','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Soria','470','Ciudad','Extremadura','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Cesar','9','Landázuri','Norte de Santander','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Tamaulipas','68497','San Emiliano los bajos','Campeche','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Florida','737','Kathyshire','Rhode Island','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Salamanca','96L-1','Toledo','Ciudad Autónoma de Ceuta','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Risaralda','92S-1','Berbeo','Tolima','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Michoacán de Ocampo','7738','San Mariana los altos','Guanajuato','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Wisconsin','85','Port Nancyton','Louisiana','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Sevilla','013','Cáceres','Comunidad Foral de Navarra','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Atlántico','59525','Santa Rosa de Viterbo','Atlántico','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Guanajuato','8-58','Nueva Saint Kitts y Nevis','Campeche','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Tennessee','30-26','Lake Jeffrey','North Carolina','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Badajoz','08088','Ávila','Illes Balears','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Atlántico','4-90','Palmas del Socorro','Arauca','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Campeche','20-87','Nueva Bolivia','Chiapas','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Alabama','5-54','Lake Alexandermouth','Nevada','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Tarragona','40035','Melilla','Castilla y León','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Caquetá','41-3','Guapotá','Norte de Santander','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Michoacán de Ocampo','4-4','Vieja Brasil','Chihuahua','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Minnesota','362','New Michaelland','New Jersey','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Cádiz','300','Lugo','Extremadura','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Sucre','982','Algeciras','Bogotá, D.C.','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Guanajuato','85764','San Cristian los altos','Michoacán de Ocampo','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Massachusetts','73','Gilesmouth','Idaho','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Valencia','2552','Cáceres','Andalucía','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('La Guajira','5-4','Paya','Valle del Cauca','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Distrito Federal','89','Nueva Singapur','Nayarit','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Louisiana','273','Rodriguezville','Tennessee','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Córdoba','63-87','Málaga','Castilla y León','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Chocó','23-3','Subachoque','Caquetá','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Zacatecas','48E-26','San Emiliano los altos','Sinaloa','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Connecticut','7-36','Lake Christianborough','Arizona','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('León','884','Córdoba','Cantabria','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Huila','7-29','Becerril','Bolívar','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Tabasco','7-8','Vieja Israel','Tamaulipas','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Mississippi','696','Allisonfurt','Michigan','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Cuenca','56-78','Cuenca','Canarias','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('La Guajira','34','Paime','Antioquia','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('México','6861','San Patricio los bajos','Yucatán','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Missouri','22-1','Josefurt','Wyoming','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Valencia','950','Soria','Extremadura','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Bogotá, D.C.','71-53','Florencia','Risaralda','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Tlaxcala','3612','San Raúl los altos','Guanajuato','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Washington','18E-47','East Dylanland','New Mexico','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Cuenca','26192','Zamora','Galicia','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Norte de Santander','2-61','Andes','Vaupés','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Michoacán de Ocampo','83-40','San Gilberto los bajos','Durango','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Massachusetts','1627','Lake Kennethshire','Idaho','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Álava','80-1','Zaragoza','Canarias','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Casanare','3597','Majagual','Guainía','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('México','61597','Nueva República Árabe Siria','Guerrero','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Montana','47','Kimberlyport','Florida','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Baleares','127','Málaga','La Rioja','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Cundinamarca','90558','San Juan Nepomuceno','Amazonas','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Colima','78','San Samuel los altos','Guerrero','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Kansas','86','Adrianchester','Utah','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Teruel','012','Asturias','Principado de Asturias','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Córdoba','51-64','Busbanzá','Archipiélago de San Andrés, Providencia y Santa Catalina','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Sinaloa','5Q-61','San Pascual los bajos','Chihuahua','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('North Dakota','36642','Rebeccaborough','Hawaii','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Asturias','10718','Burgos','Illes Balears','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Casanare','3','Guacamayas','Norte de Santander','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('México','200','San Dulce María de la Montaña','Veracruz de Ignacio de la Llave','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Pennsylvania','91','South Donnamouth','Illinois','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Burgos','44309','Guipúzcoa','Ciudad Autónoma de Melilla','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Bolívar','6604','Buenavista','Norte de Santander','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Oaxaca','591','Nueva República Democrática del Congo','Michoacán de Ocampo','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Missouri','414','New Shannon','Illinois','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Guadalajara','4-8','Barcelona','Cataluña','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Arauca','83-4','Santa Rosa de Osos','Norte de Santander','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('San Luis Potosí','75173','San Aldo los altos','Quintana Roo','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Minnesota','6599','West Jose','Wisconsin','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Alicante','98483','Guadalajara','Comunidad de Madrid','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Vaupés','105','Concordia','Boyacá','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Querétaro','32','San Hilda de la Montaña','Baja California Sur','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Arizona','2-2','Marquezborough','Oklahoma','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Teruel','722','Álava','La Rioja','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Atlántico','67','El Guamo','Boyacá','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Durango','10000','San Blanca los altos','Quintana Roo','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Alabama','94-49','Port Kevin','Connecticut','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Pontevedra','95522','Vizcaya','La Rioja','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Boyacá','41-58','Murillo','Archipiélago de San Andrés, Providencia y Santa Catalina','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Quintana Roo','22','San Jaqueline de la Montaña','Tlaxcala','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Nebraska','96','South Vincent','Tennessee','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Lugo','2288','Ourense','La Rioja','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Vichada','5894','Campoalegre','Cundinamarca','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('San Luis Potosí','0008','Vieja Luxemburgo','Morelos','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Tennessee','13922','Lake Sean','Maine','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Ourense','8-1','Cuenca','Ciudad Autónoma de Melilla','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Sucre','91-7','San José de Toluviejo','Caquetá','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Nuevo León','1986','San Mónica los bajos','San Luis Potosí','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Rhode Island','32','Toddtown','Missouri','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Murcia','068','Guadalajara','Aragón','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Vaupés','2','Tauramena','Huila','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Hidalgo','8-3','Nueva Croacia','San Luis Potosí','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('South Dakota','6-2','North Stephenfurt','Vermont','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Toledo','538','Ciudad','Extremadura','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Norte de Santander','924','Ricaurte','Putumayo','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Zacatecas','7347','San Emiliano de la Montaña','Baja California Sur','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Ohio','4839','East Andrew','South Dakota','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Toledo','823','Albacete','Extremadura','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Cesar','57','Piamonte','Amazonas','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Tlaxcala','6M-8','San Marisol los altos','Chiapas','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Nebraska','2-71','Port Dominiqueland','South Dakota','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Palencia','4','Soria','Comunidad Foral de Navarra','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Bolívar','22','Pitalito','Vichada','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('San Luis Potosí','5-11','San María Eugenia los bajos','Campeche','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Montana','83-6','Kevinhaven','Idaho','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Murcia','0459','Madrid','Comunidad Foral de Navarra','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Amazonas','4','Villapinzón','Caldas','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('México','61444','San Rolando los altos','Oaxaca','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Rhode Island','2007','Cookhaven','Mississippi','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Álava','537','Lugo','Galicia','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Norte de Santander','6560','Gachantivá','Nariño','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Sinaloa','6-79','Nueva Zambia','Veracruz de Ignacio de la Llave','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('California','77-6','New Tyler','South Dakota','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Huelva','14','Ourense','Comunidad de Madrid','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Amazonas','37118','Cisneros','Arauca','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Yucatán','84','Vieja San Marino','Sinaloa','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Nevada','34-85','Nathanton','New Mexico','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Badajoz','063','Cantabria','Andalucía','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Caquetá','2-1','Sogamoso','Guainía','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Aguascalientes','46','San Nayeli los bajos','Jalisco','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Maryland','773','Gatesport','Alabama','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Córdoba','0198','Teruel','Comunidad de Madrid','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Cesar','82-9','Cachipay','La Guajira','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Durango','8','Vieja Uganda','Tlaxcala','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('New Hampshire','81-80','Sylviahaven','Georgia','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Toledo','94-6','Ceuta','Región de Murcia','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Córdoba','5','San Jacinto del Cauca','Amazonas','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Campeche','3864','San Federico los altos','Morelos','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Georgia','756','New Michaelport','Ohio','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('La Coruña','85','Girona','Principado de Asturias','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Casanare','65-36','Olaya','Boyacá','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Distrito Federal','13','Vieja Jordania','Tlaxcala','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Utah','69U-27','Lake Kimbury','Colorado','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('León','6729','Soria','Castilla y León','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Boyacá','08644','La Unión','Tolima','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Oaxaca','76','Vieja Angola','Campeche','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Oklahoma','57-6','Mollymouth','Tennessee','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Guadalajara','63-1','Santa Cruz de Tenerife','Castilla-La Mancha','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Bolívar','96-95','Guamal','Chocó','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Zacatecas','27-86','San Gonzalo de la Montaña','Jalisco','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Arkansas','6414','North Brittney','Arizona','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Almería','20098','Ciudad','Castilla y León','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Vaupés','323','Barranca de Upía','Amazonas','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Yucatán','449','Nueva Eslovenia','Tabasco','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Louisiana','48603','New Steven','Washington','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Baleares','5-6','Ciudad','Comunidad Foral de Navarra','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Vaupés','31F-69','Albania','Magdalena','Colombia');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Sonora','30591','Vieja Barbados','Guanajuato','Mexico');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Alabama','094','Staceyhaven','Montana','EEUU');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Tarragona','447','Cádiz','Comunidad Foral de Navarra','España');
INSERT INTO direcciones(address_street,address_number,address_city,address_province,address_country) VALUES ('Norte de Santander','903','Altamira','Cauca','Colombia');

---------------------------------------------------------------

INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3591509102917613','419','09/28','01/15',3,411);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4734237012908011','831','04/32','06/20',2,372);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('639047913376','613','02/31','03/11',3,194);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4631745486025','917','03/30','03/03',3,483);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4490710316402380','207','07/28','11/01',2,206);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4285632075514','747','09/23','07/09',2,41);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4873785773005071','481','07/29','05/91',3,203);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4368437265593952038','494','08/26','11/95',1,325);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4134123598487','801','10/30','03/08',3,330);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6501355971277008','302','11/25','05/76',2,218);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('676374911946','849','10/23','09/73',3,429);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2244776479659127','563','03/30','12/86',3,249);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('340567107654144','391','03/28','09/87',3,226);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6569673985070238','365','10/30','10/17',1,356);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6523098190083104','326','07/23','01/75',2,330);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3583500578759514','9729','09/31','06/72',3,188);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3537696481435205','062','08/27','03/93',2,125);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('560864241339','513','10/27','06/15',1,335);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2251764219460303','438','05/24','09/07',1,370);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('340131130424924','473','08/29','06/93',2,400);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2276419772842592','655','12/31','03/74',2,353);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4847874612666005','265','06/24','11/21',2,186);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('378267723173083','679','09/30','11/75',1,404);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4596478208567784','403','08/23','06/77',3,181);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('577574601347','057','01/31','10/71',1,292);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4557445383248','404','04/28','01/11',2,248);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4597176919787928','079','06/25','08/98',3,333);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4530248378183939','061','10/31','03/78',1,189);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3551389942028824','855','06/28','08/17',3,449);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4280767422749348','709','10/22','09/86',2,350);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('372568055468215','687','11/23','12/04',1,404);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4090074393650','899','08/27','08/78',1,182);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3555091141040057','806','12/31','09/96',3,166);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3526666155258954','1299','06/25','02/14',2,169);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3591919609471446','427','12/29','10/15',3,42);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('213128306233885','581','09/23','09/73',3,97);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4036026272696197875','239','09/27','01/05',2,219);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3530557820899682','557','01/25','07/81',1,270);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2278986674594685','558','12/30','01/88',3,412);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4437521472436633','782','06/32','05/05',2,160);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4532530770906','835','04/28','04/80',2,461);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4628902303659180','379','03/30','10/99',2,308);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4832011284868','594','09/27','05/05',1,332);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('675929706116','8330','11/31','09/89',3,117);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3568286908682563','235','04/23','06/20',1,11);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('180007612454097','023','11/29','11/02',3,147);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('213123658859981','387','10/24','03/02',1,47);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('30223914720422','8181','07/31','08/85',1,64);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4450163406182785','741','09/23','08/05',3,178);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('675942649194','805','03/23','05/73',3,370);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3536914415689297','941','03/28','04/86',3,284);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('30570437601186','518','09/24','02/01',2,105);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6011538753657264','8943','03/32','11/19',2,148);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3599276349586138','902','11/23','10/95',3,273);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('213198438687571','622','09/28','02/71',2,85);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4433006351112525','885','01/23','07/05',3,352);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3591342022706647','622','01/25','12/74',2,455);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('676103198955','717','03/26','10/73',3,125);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('180059343487599','288','09/29','11/14',3,35);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6531266640528313','470','07/26','09/98',1,58);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('30202309072680','094','12/31','01/88',2,102);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4617669363209','215','04/29','06/99',3,69);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('30376069176442','702','11/31','05/95',1,449);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4548719321943488','701','09/22','11/01',2,455);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('30004842973378','212','03/29','09/12',1,362);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('213198840880111','076','05/23','05/89',1,213);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4203176629244921912','659','02/28','09/70',2,283);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4594291566516038888','036','11/22','09/89',2,209);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('213156273877137','234','07/31','05/74',3,129);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6573807601122890','8330','04/25','07/81',1,425);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('348293123251524','616','11/25','01/72',2,470);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4698287354853725','764','06/25','09/84',1,450);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('340397300039905','904','04/31','05/79',3,25);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4101235892520','8430','05/26','04/88',1,301);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('565883988521','3028','06/27','10/14',3,468);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('213188729085825','759','03/32','03/08',2,342);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4153984829519265','270','01/30','07/81',2,115);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('5289884379043910','993','02/26','05/14',2,126);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6011393163648069','334','03/29','12/93',1,187);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('30201454268259','403','03/27','08/86',3,275);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3547718723912839','459','09/30','05/84',1,276);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6011447562027505','772','08/28','01/80',1,479);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4587915563664','420','08/26','11/88',3,447);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3523559199959575','940','05/23','09/10',1,63);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2294576329236061','673','09/22','08/99',2,108);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3559386066455991','863','06/24','05/71',3,223);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2703907178974798','000','06/31','01/13',2,492);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('36023411484397','907','12/30','01/88',3,252);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4211316733583378','626','02/25','12/19',3,288);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('180088929561907','229','08/23','05/83',3,259);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4223036905002','667','05/29','02/89',2,307);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4633944955075276','404','02/29','03/97',1,322);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('375057381025573','381','08/23','07/96',1,100);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3547483161676459','867','03/27','04/97',1,62);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3545617335559222','207','02/24','11/83',1,470);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('30447734727735','206','05/24','08/07',2,414);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('180071439610596','639','03/26','12/13',2,183);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4250681920011422','462','05/24','02/08',1,115);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4346962214413292','671','06/30','08/90',3,86);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4601888847034330','718','05/30','12/98',1,389);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4434371782457645','7974','01/27','11/88',3,72);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4355735009114','040','05/27','10/87',2,339);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6503743555549058','219','09/22','06/90',1,486);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3559151429204555','704','04/28','10/72',2,189);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4498051882512315285','234','08/30','07/76',1,223);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('5194787546645331','280','12/22','03/04',3,133);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2244896812019696','606','11/27','05/20',1,351);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4538006858943','670','02/30','05/76',3,280);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2423054859376115','542','02/32','05/03',3,413);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('38029198705704','455','10/28','03/03',3,490);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('5419159729113066','885','09/22','01/20',1,43);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4169637701788196049','488','08/28','03/15',1,101);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('36656143097225','853','02/30','05/04',1,206);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('589910217993','778','01/28','12/79',2,123);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4009172134934099280','556','05/23','05/81',3,346);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('213133806311330','307','05/26','03/06',2,93);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('503896676593','376','07/29','10/18',2,476);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('373281830820275','110','08/24','12/96',3,134);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4140315844258','352','12/25','01/82',3,126);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('676234617188','626','01/27','01/21',2,425);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6513119857415421','8421','04/29','08/89',3,496);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3515849386176053','599','07/32','06/96',1,298);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('30168088333835','654','06/29','10/96',1,250);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4186407143772858','896','05/26','05/91',1,360);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('372170791663264','475','01/25','07/07',3,171);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4675932702417601','113','04/25','08/19',3,280);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2720422783717979','073','11/25','01/91',3,28);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3562996272899215','873','02/28','07/97',3,115);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6011083001490838','925','10/30','03/20',1,256);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6011229733475924','458','05/32','02/82',3,204);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('676151926265','052','04/30','09/11',1,225);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2247319130800314','278','11/22','08/84',3,413);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('38348140977629','656','02/31','10/17',3,49);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('180084510186345','013','09/29','07/95',2,132);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2280313613168297','529','03/25','04/20',1,271);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3524003260723130','530','10/26','10/02',2,224);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2718549255658275','708','04/28','12/94',1,372);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4685645450743881','1074','12/22','07/85',3,24);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3507935538754101','755','06/27','07/88',1,258);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4340274014725','696','01/25','05/97',2,69);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3556485931578590','910','01/26','10/82',3,135);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3569004194982244','800','05/25','03/10',1,285);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4048409177982','575','04/23','07/07',3,3);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('36174577654529','629','05/26','10/82',3,13);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3571442043783007','814','03/31','12/91',1,89);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4434198022919369','980','03/31','10/78',3,147);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4289441580032654','525','07/24','07/72',2,440);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3546727726352811','212','10/31','06/85',2,219);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('503802765332','707','09/26','11/94',1,454);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3586037661610855','799','02/28','10/70',1,388);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4636398728243096537','9371','02/26','08/79',3,97);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4264831847983450','079','09/24','09/06',3,137);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('340982022765109','579','09/23','07/86',3,79);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6533391773231085','387','08/24','02/82',2,441);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4752529308085323','524','12/24','11/90',2,211);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3510075194635651','148','12/25','05/96',1,448);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3594741029852220','260','05/31','09/20',3,272);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2453337840689396','877','09/23','05/98',3,484);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6011943375073165','921','01/24','02/08',1,120);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6011104732033075','967','01/26','09/18',1,319);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4196466043507721','516','01/23','01/01',3,224);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('639098947562','480','04/31','09/73',1,188);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('5385013934694834','103','12/26','12/16',3,89);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6011745149031662','532','11/29','05/03',3,190);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('180087403574444','831','12/31','02/78',2,360);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6011559961713004','313','12/23','01/92',2,193);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('343366311342373','310','11/26','08/17',3,487);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4250570964312903143','719','07/26','02/14',2,270);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3582974514753173','102','08/31','10/92',3,344);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('30060543067241','566','12/27','05/09',1,297);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2246372875369103','034','02/32','07/72',1,128);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6011668661818821','175','01/30','02/07',1,338);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3572662459967443','374','06/27','09/01',1,39);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3579664592211740','585','02/31','02/17',3,38);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('370251651223662','700','11/24','03/10',3,61);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('36010985124764','990','01/26','08/13',2,355);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('213121333751839','017','02/28','01/11',3,141);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4343668928559','375','12/29','07/76',1,393);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4233604471081935','852','07/28','09/88',1,222);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6534500294644308','931','04/28','05/70',2,392);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4190105074648220','533','03/31','11/05',3,386);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2666732967761627','280','03/31','06/13',2,211);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('36161569657958','810','06/25','08/71',1,113);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('503872929982','506','07/29','07/18',3,261);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4721875772227','371','05/25','11/01',1,293);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('675945855913','468','09/27','02/96',2,410);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6599409841025148','836','08/27','04/80',1,271);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3563928581261539','716','10/31','04/05',1,44);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6011103256853702','293','07/31','11/75',2,3);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4441648255035128','589','07/24','09/83',1,289);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('30196760459412','809','03/26','05/93',1,122);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4127124431294','008','08/25','03/87',1,452);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4518883362606929','228','11/26','03/98',3,431);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4127662714160071','826','05/25','10/19',3,140);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4942676400549978','777','12/27','10/03',1,396);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4589070715634','874','08/22','01/83',3,161);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('569515957375','099','06/23','01/88',1,447);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2587382701989245','674','05/30','03/83',3,492);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('213102536823823','481','11/31','06/84',2,20);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4892740006216885','407','10/22','09/97',2,246);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('376530598366641','029','05/30','06/86',3,154);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6011739838232947','756','12/23','09/20',2,53);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3564210712800140','482','08/24','04/16',3,415);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3567774946196077','770','09/29','05/95',2,282);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4206504006072','067','11/30','05/15',3,452);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4638086925181746','775','03/30','05/95',3,451);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('38287850317891','625','07/24','05/96',2,172);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('36496140555267','519','08/26','03/95',3,453);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('502009926986','029','08/23','10/82',2,328);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2266477082466611','201','03/29','07/85',3,213);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3557726326956811','253','06/29','12/20',1,82);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6562237832293729','436','07/29','02/79',3,445);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4730024889238','414','04/27','11/97',1,386);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4046676276247033','012','10/28','11/77',3,19);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4487564619189151','749','07/25','04/14',2,469);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4011220786191','156','05/23','08/92',3,377);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3555679939403857','826','03/25','05/95',2,318);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4612415400272011','138','10/27','11/17',2,33);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('502016041639','440','10/25','06/96',3,392);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4682329656496754692','181','09/22','09/97',2,368);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3532463313609134','265','11/26','01/84',3,399);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4099843941152','823','09/24','05/77',3,388);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6563199687325502','518','05/32','10/97',1,484);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3554294488258545','885','08/31','03/06',3,80);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4335802464236','554','06/25','05/00',2,470);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4396390622098670158','6387','05/29','10/10',1,127);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('30445173993057','0082','03/24','01/88',2,251);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6577506213581057','493','02/24','12/96',1,378);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4693777281255486','952','08/31','03/08',2,176);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2709882102391639','927','07/25','02/71',1,77);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('346532067102041','189','01/31','03/08',2,406);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3547078309814986','014','11/26','08/73',1,136);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('180030889977236','422','12/31','10/71',1,59);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('180048849757936','845','05/32','07/73',3,249);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('30068952990324','497','08/25','09/00',1,29);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4680324994802353217','022','03/30','10/85',1,67);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('378517006483348','875','06/32','11/99',3,209);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('379204799430211','0504','12/29','05/19',1,447);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4865822979883744','393','09/29','01/72',1,275);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4483256439518','697','04/28','08/70',3,373);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('213115928160539','369','03/32','06/06',1,486);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4854475442288869718','586','10/28','04/70',2,444);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4687150544951101','821','04/29','11/19',3,100);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4818096429452','674','06/28','12/77',1,341);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4444955032201841','877','09/25','11/91',1,128);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('378501124173403','390','05/29','04/07',2,413);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4478525354822646','098','11/28','02/88',1,200);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4855290777416822','150','10/28','12/92',1,394);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4096892450721','843','07/23','02/73',2,251);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3509951244512442','800','05/25','09/91',3,22);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3530651892815690','935','05/26','04/78',1,1);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('213195240049099','2436','06/25','03/91',3,215);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('060460774049','289','09/30','11/93',1,361);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('38429833347161','012','05/26','01/17',1,343);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4927273787602601','880','12/25','09/17',1,280);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4534076114133892','051','07/24','01/81',1,315);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4136626417799260','126','10/26','04/19',2,226);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3520685845157810','070','08/24','09/89',2,453);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3591188114715719','804','02/28','07/05',3,47);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('373363663119874','990','02/28','06/99',1,314);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3597458881688538','502','06/30','05/89',1,434);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6011079546615590','854','11/29','03/19',2,365);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('213180863943489','499','08/23','09/79',1,492);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4649393807529035','367','10/27','07/90',1,485);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4340814987135832','059','06/25','12/11',1,315);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4894945863829278','481','12/26','05/06',3,468);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4532720075381683','114','12/23','01/76',1,355);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2275501618000450','615','04/24','03/97',1,153);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4135772644748984','954','09/22','09/88',2,64);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('180097871550776','771','12/29','07/12',1,359);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4462251766738886','076','02/32','01/15',1,214);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('30050534161483','574','03/28','05/10',1,211);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('585683889174','395','11/23','06/83',1,260);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('676175674289','788','07/25','07/18',3,359);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4342676943510053','004','05/26','07/91',1,475);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2267614397130123','5207','10/26','10/99',2,255);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4720819538520','631','04/30','05/18',3,98);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2266106327425468','535','01/32','11/12',2,468);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3551602050477900','643','03/31','12/07',1,151);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('376488740610996','014','08/26','07/90',1,85);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('38225165877084','929','11/31','11/93',1,401);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2266182778592841','878','02/27','11/74',1,382);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3570647065060362','725','01/30','07/94',3,216);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('30179272799798','426','06/23','03/06',1,216);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4845642790492307800','332','10/29','03/15',1,374);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3584161937776324','4827','01/28','08/97',3,265);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4792753038452','214','11/22','07/98',3,357);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('676128603468','824','05/24','12/03',1,227);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('501844995875','072','09/30','10/18',3,184);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4437833479256769','522','10/23','08/89',3,448);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3530429206252813','257','03/31','04/87',2,63);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4285325726117731','528','04/24','02/97',3,322);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3517143128379201','508','08/22','09/71',1,174);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3518568446399698','855','04/27','06/77',3,254);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4154952439716505','534','05/28','08/91',3,253);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('342512607809929','921','07/24','01/95',3,229);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('30438827639929','845','01/26','07/17',3,383);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('370127177865691','178','07/24','11/80',1,412);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4562067307814','805','04/31','10/71',1,15);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4953587638884531','606','09/31','07/75',1,22);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('38926688192881','502','02/31','12/99',2,323);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('213141695767074','774','08/29','08/88',2,132);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3520348994032108','262','05/29','07/17',3,155);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4780588037124544','760','12/23','02/02',1,249);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3514018512196853','535','09/28','11/87',1,38);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4965594902439','482','09/30','08/06',1,453);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4988117681231','084','03/24','01/17',1,462);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6011578333709045','858','07/31','10/04',1,152);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4123924514610265','740','05/25','01/11',3,482);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4646069260265829','840','07/29','06/12',2,184);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('213154859064956','368','10/28','04/21',1,333);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4858804829803865','863','03/29','10/13',1,421);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4686807209749358','815','03/27','10/08',2,43);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4003514057264','334','08/24','05/13',2,481);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6573906287084802','067','09/24','10/09',3,57);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4502688645954950236','550','07/28','04/83',1,487);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6011836124579369','204','09/23','06/78',2,81);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('36703819980316','302','10/22','03/12',1,319);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('180051111821539','077','09/31','05/83',2,384);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4090664301832','597','06/29','04/00',1,430);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4550714535341','038','02/30','05/12',2,66);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4507529907229629538','269','04/27','07/08',3,123);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4974633431510678','9853','01/28','03/97',3,451);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6533225860223953','5951','06/23','08/95',2,393);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3514802560688501','417','06/32','07/85',2,338);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3524576123286411','7290','07/25','01/14',2,166);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3505094869857919','205','07/32','09/11',1,293);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4549369454410','239','06/32','09/16',3,100);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('36006066102083','063','05/26','07/84',1,359);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6548630441261211','490','07/26','11/72',1,334);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('180053451846803','680','09/29','06/04',3,417);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('676102541262','949','06/25','06/05',1,157);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6011378835797691','591','03/31','11/03',3,434);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3588537433530354','509','05/27','12/02',1,348);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('30449820046632','262','04/25','08/90',2,263);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3574385005203752','355','04/32','10/87',1,242);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('502063142553','222','08/23','09/81',1,391);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('180073368688585','535','02/29','08/02',3,301);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4487229878739001','289','02/28','03/85',3,267);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4535191580758129','190','01/25','02/83',3,219);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('213188028554992','227','04/31','02/85',2,306);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3594287990091026','402','09/29','08/05',3,417);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4988643427577510','221','01/23','04/17',2,292);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('349438968479842','330','07/27','08/16',2,421);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6011358123854768','568','12/28','03/77',3,334);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4306249948502261','551','07/30','11/12',2,470);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3578943785749869','124','05/26','03/80',2,307);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('213196905774427','186','05/31','10/98',1,231);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3524551811834665','9249','11/22','11/16',3,100);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6558778733321073','343','01/25','12/08',1,90);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('370502452276287','052','06/32','05/05',1,333);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4405131026970471','004','06/28','03/72',2,372);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2224740457790308','533','01/26','04/73',3,367);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('213115302231781','334','06/31','08/16',3,434);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4037836043551106','673','10/29','05/10',3,217);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3586795736579344','064','09/28','06/06',1,365);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3582384078428016','692','10/25','10/12',3,347);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('180064999347113','861','03/28','03/07',3,350);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4300545555732','497','09/22','08/90',1,54);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4037277268854944201','080','07/31','11/93',3,332);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4874761401730','017','08/26','08/74',3,485);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2294047702028145','2201','11/30','11/10',1,452);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3522988723752886','851','10/28','05/10',3,266);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('213182516592960','9139','08/29','02/14',2,96);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('346689736186159','293','12/26','04/20',3,147);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4928907991017699036','720','07/28','12/76',1,87);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4274708565114039310','334','12/24','02/02',2,128);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('378432341123700','368','10/31','09/16',2,54);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3518389833234657','846','06/32','05/93',3,449);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('180043151972074','730','03/26','01/11',2,417);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('213102834486711','317','01/30','05/75',1,158);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4839904523167834790','556','05/25','07/03',1,27);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('30289115561162','3523','11/31','10/13',3,342);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('348708225089936','579','03/23','11/76',3,485);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4820163434092','624','10/26','12/04',1,145);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4238330003213','893','04/26','06/99',1,323);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('639046623216','575','02/26','07/10',2,11);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('180020082716598','674','08/24','10/83',2,122);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6587109789526677','193','06/29','08/93',2,227);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('501879916457','404','10/28','09/12',2,327);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('180038016373161','0173','04/27','12/01',1,134);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('5537464918373845','866','01/25','09/16',1,317);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6011183828791960','389','11/22','08/77',1,467);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('345885960943361','5247','05/24','02/89',1,471);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4276602800918452','602','10/28','02/73',2,82);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3540215302628008','100','12/22','10/73',3,380);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('379020354467848','982','12/23','04/80',2,331);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('180050814684236','412','08/29','06/21',2,479);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3538362666042790','5655','10/30','12/08',2,65);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4876668576985649','362','08/28','04/98',2,264);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3500707455751122','913','12/27','12/76',2,499);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3530975963885641','734','05/23','05/75',3,217);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('30373698913212','803','10/29','12/76',2,154);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('676252377145','756','01/27','05/02',3,195);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6011799610295454','965','06/28','01/98',3,319);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('639075472311','415','12/26','05/02',2,33);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6011921599992246','067','07/28','02/16',1,70);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('30093948936546','014','03/32','08/82',1,102);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4627624279097883906','480','07/30','02/02',2,311);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('213140809847244','681','01/28','06/71',1,146);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('180061937624116','529','05/28','06/81',3,52);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4828783247763553','346','09/26','04/91',3,476);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4542142655796695291','397','09/27','03/12',1,466);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2299464807824143','157','12/28','05/81',1,353);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6510980444009586','992','10/30','10/07',2,375);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2337224256087202','021','12/31','01/81',2,485);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4530698396045256','196','07/29','04/14',1,212);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4161740632473714','496','09/24','10/13',2,114);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('36590538583558','623','03/30','10/75',3,89);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('213107458459084','430','06/23','02/82',3,122);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('349121260607399','492','01/30','12/79',1,397);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4192425447778076','237','04/26','07/85',1,391);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('349365910711131','728','06/29','01/22',3,493);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6575569406576633','120','01/23','02/90',1,312);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4544380444503008','601','11/23','11/10',3,117);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4753966798149384','701','04/31','01/08',2,370);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4142278957788314443','619','10/24','03/96',1,339);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('213158004263900','914','03/26','11/84',2,67);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('379956611295136','9576','06/25','04/16',2,302);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4475730152826764','798','01/32','07/15',1,451);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2248231846301991','444','05/27','05/17',2,397);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4421921611996','609','08/28','05/83',1,162);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4369336909651460','083','06/32','12/70',3,177);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2232617160730500','137','11/26','07/08',2,222);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3564403986056818','269','08/23','04/73',3,498);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('30088749088489','640','01/23','11/87',2,273);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('345712689291940','250','09/24','10/70',3,334);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2507180823408061','629','06/32','03/81',2,317);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3524373552899702','152','06/25','07/86',2,211);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('676295794397','631','05/30','08/13',3,420);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('374755277362171','397','07/24','04/21',2,43);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3597957631991225','062','10/30','03/10',3,182);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('30355449421157','880','07/29','01/11',3,239);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3571884147670889','1668','07/29','01/01',1,218);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6011988875245375','570','04/29','02/08',3,27);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6582411083553893','335','05/27','04/85',2,398);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('30349069733306','911','03/29','06/71',3,324);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4478668019605366563','259','03/25','11/07',2,16);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('213187408780896','600','04/29','11/92',2,9);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4105503272182','553','06/27','06/99',3,211);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3511679292227243','532','10/29','12/21',3,140);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('180060143814974','811','12/26','03/06',3,410);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3533140712539406','2780','08/27','03/74',2,130);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4052203019421934532','089','02/30','02/10',3,103);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('503831218006','869','05/26','04/20',1,58);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3591514075734334','414','03/28','02/72',1,102);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('345422208120931','833','02/29','02/75',3,165);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6597243079931640','221','05/24','10/84',3,127);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6581857274886917','697','04/28','06/94',1,129);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4303952594599746','349','04/23','01/77',1,178);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('30008013147001','634','01/32','08/91',2,281);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('180030327464136','530','03/29','04/06',1,406);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4504158397607893416','626','08/25','07/96',3,23);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4612437978586','438','06/27','12/14',1,471);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('30369749133891','651','09/22','12/12',1,202);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4967974809192','596','08/26','04/92',1,395);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3566092831630105','153','09/22','12/08',2,270);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('5524794350016139','760','06/30','12/08',2,202);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4021042151649','367','03/32','05/12',2,452);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3564122699278135','784','03/26','08/83',1,189);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4268848399550533','245','05/32','09/80',2,51);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3506729316862462','347','04/26','04/08',2,44);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2720707113789643','979','12/30','07/77',1,97);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4672045494426','0391','12/30','07/16',3,27);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6011476410040550','948','02/30','10/76',1,360);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3528629495759196','928','06/24','12/73',1,487);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('346978992271429','815','06/30','11/09',1,297);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4929907186218663307','187','04/26','01/20',1,496);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4235340194422274520','799','10/24','04/93',3,36);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4358605308972682','530','01/30','04/05',3,110);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3530204309185222','761','11/23','03/70',2,7);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4222609357072462299','705','04/27','12/95',1,75);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('347518622442666','963','10/29','06/04',3,458);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2288228124801875','169','03/28','04/71',3,447);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4199846689469814','804','10/24','06/89',3,260);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4522565438412507','631','07/27','10/88',3,264);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6011508771886476','7321','07/27','09/93',2,106);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2690952572545021','373','06/23','06/15',1,65);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('180083577563438','679','12/29','03/95',2,474);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('180093267701743','595','12/27','03/04',2,483);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3523046726399699','773','09/29','08/74',1,45);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4220539945119207','2855','07/28','07/00',3,339);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3578084445331192','063','07/29','07/91',3,211);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('30520228923554','9320','10/24','05/03',2,147);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2244669652767157','445','05/31','12/17',3,81);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6520168843254221','192','09/28','05/18',3,7);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('376723847368829','221','10/30','05/20',3,460);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6596563704662471','447','09/23','01/19',1,416);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('180052569249322','645','11/30','04/99',1,5);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4569575728712','347','11/27','09/99',1,282);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4049551871985765','807','05/30','01/96',1,336);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('2720300320275893','784','03/25','05/93',3,405);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('30033965597771','754','03/32','04/99',3,41);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('348545572019532','416','08/25','09/77',3,124);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4846987130257926810','130','07/27','04/99',3,379);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('3502088991922651','378','09/28','02/16',2,401);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4737809125329496','064','07/28','09/19',2,37);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('6011205180511387','073','09/25','09/82',1,15);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4668265740001080','549','05/25','11/95',2,433);
INSERT INTO tarjeta('card_number','card_cvv','card_expiration_date','card_issue_date','card_type','customer_id') VALUES ('4713180030979','727','04/27','08/11',3,25);

