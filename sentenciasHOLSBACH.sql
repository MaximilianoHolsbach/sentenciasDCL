use chaco_print_2;

-- #### CREAMOS EL USUARIO GERENCIA QUE SOLO PODRA LEER TODAS LAS TABLAS Y COLUMNAS ####

create user 'gerencia@localhost' identified with mysql_native_password by 'gerencia';

grant select on chaco_print_2.* to 'gerencia@localhost';

-- Realizamos la prueba de lectura, y ejecutamos la query en línea de comandos. Traemos la lectura de 5 registros

select * from cliente limit 5;

/* 
+------------+------------------------------------------+----------+---------------------+
| id_cliente | nombre                                   | cuit     | fecha               |
+------------+------------------------------------------+----------+---------------------+
|          1 | AGROPECUARIA DEL PARANA S.A.             | 44893122 | 2019-02-25 00:00:00 |
|          2 | CLUB DEPORTIVO MUNICIPALES               | 66547661 | 1992-04-02 00:00:00 |
|          3 | MUNICIPALIDAD DE PTO EVA PERON           | 48122802 | 1990-11-23 00:00:00 |
|          4 | MIDA CONSTRUCCIONES S.R.L.               | 40229613 | 2018-11-28 00:00:00 |
|          5 | BIANCHI LUZ                              | 85435516 | 2011-05-25 00:00:00 |
+------------+------------------------------------------+----------+---------------------+
*/

-- Realizamos una query de actualización en la línea de comando y obtenemos el siguiente error.

update cliente set nombre = 'AGROPECUARIA DEL PARANA' where id_cliente = 1;

/* 
mysql> update cliente set nombre = 'AGROPECUARIA DEL PARANA' where id_cliente = 1;
ERROR 1142 (42000): UPDATE command denied to user 'gerencia@localhost'@'localhost' for table 'cliente'
*/

-- #### CREAMOS EL USUARIO administrador EL MISMO TENDRA TODO LOS PERMISOS MENOS ELIMINAR ####

create user 'administrador@localhost' identified with mysql_native_password by 'administrador';

grant select, insert, update on chaco_print_2.* to 'administrador@localhost';

-- Realizamos la prueba de lectura, y ejecutamos la query en línea de comandos. Traemos la lectura de 5 registros

select * from cliente limit 5;

/*
+------------+------------------------------------------+----------+---------------------+
| id_cliente | nombre                                   | cuit     | fecha               |
+------------+------------------------------------------+----------+---------------------+
|          1 | AGROPECUARIA DEL PARANA S.A.             | 44893122 | 2019-02-25 00:00:00 |
|          2 | CLUB DEPORTIVO MUNICIPALES               | 66547661 | 1992-04-02 00:00:00 |
|          3 | MUNICIPALIDAD DE PTO EVA PERON           | 48122802 | 1990-11-23 00:00:00 |
|          4 | MIDA CONSTRUCCIONES S.R.L.               | 40229613 | 2018-11-28 00:00:00 |
|          5 | BIANCHI LUZ                              | 85435516 | 2011-05-25 00:00:00 |
+------------+------------------------------------------+----------+---------------------+
 */
 
 -- Realizamos la prueba de actualización, y ejecutamos la query en línea de comandos. El resultado nos da OK
 
 update cliente set nombre = 'AGROPECUARIA DEL PARANA' where id_cliente = 1;
 
 /*
 mysql> update cliente set nombre = 'AGROPECUARIA DEL PARANA' where id_cliente = 1;
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0
 */
 
  -- Realizamos la prueba de insert, y ejecutamos la query en línea de comandos. El resultado nos da OK
 
insert into empleado (nombre,cuil,puesto)
value('testinsert','12345678',5);

/*
mysql> insert into empleado (nombre,cuil,puesto)value('testinsert','12345678',5);
Query OK, 1 row affected (0.00 sec)
 */

-- Traemos el test de insert

select * from empleado where cuil = '12345678';

/* 
mysql> select * from empleado where cuil = '12345678';
+-------------+------------+----------+--------+---------------------+
| id_empleado | nombre     | cuil     | puesto | fecha               |
+-------------+------------+----------+--------+---------------------+
|          41 | testinsert | 12345678 |      5 | 2023-01-05 00:38:18 |
+-------------+------------+----------+--------+---------------------+
*/

-- Por último demostramos que por más que podamos realizar la mayoria de las sentencias del DML no podemos eliminar ningun registro. 

delete from empleado where cuil = '12345678';

/*
mysql> delete from empleado where cuil = '12345678';
ERROR 1142 (42000): DELETE command denied to user 'administrador@localhost'@'localhost' for table 'empleado'
 */
 
 