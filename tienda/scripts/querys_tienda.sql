-- 1 Llista el nom de tots els productes que hi ha en la taula producto.
SELECT nombre FROM producto;
-- 2 Llista els noms i els preus de tots els productes de la taula producto.
SELECT nombre, precio FROM producto;
-- 3 Llista totes les columnes de la taula producto.
SELECT * FROM producto;
-- 4 Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD).
SELECT nombre, CONCAT(precio, ' $') AS precio_dolares, CONCAT(precio * 0.92, ' €') AS precio_euros FROM producto;
-- 5 Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD). Utilitza els següents àlies per a les columnes: nom de producto, euros, dòlars.
SELECT nombre AS nom_de_producte, CONCAT(precio, ' $') AS dolares, CONCAT(precio * 0.92, ' €') AS euros FROM producto;
-- 6 Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a majúscula.
SELECT UPPER(nombre) AS nombre_mayusculas, precio FROM producto;
-- 7 Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a minúscula.
SELECT LOWER(nombre) AS nombre_minusculas, precio FROM producto;
-- 8 Llista el nom de tots els fabricants en una columna, i en una altra columna obtingui en majúscules els dos primers caràcters del nom del fabricant.
SELECT nombre AS nombre_producto, CONCAT(SUBSTRING(nombre, 1, 1), UPPER(SUBSTRING(nombre, 2, 2)), SUBSTRING(nombre, 4)) AS nombre_mayusculas FROM fabricante;
-- 9 Llista els noms i els preus de tots els productes de la taula producto, arrodonint el valor del preu.
SELECT nombre AS nombre_producto, ROUND(precio) as precio_redondeado FROM producto;
-- 10 Llista els noms i els preus de tots els productes de la taula producto, truncant el valor del preu per a mostrar-lo sense cap xifra decimal.
SELECT nombre AS nombre_producto, TRUNCATE(precio, 0) as precio_truncado FROM producto;
-- 11 Llista el codi dels fabricants que tenen productes en la taula producto.
SELECT f.codigo FROM fabricante f, producto p WHERE f.codigo = p.codigo_fabricante;
-- 12 Llista el codi dels fabricants que tenen productes en la taula producto, eliminant els codis que apareixen repetits.
SELECT DISTINCT f.codigo FROM fabricante f, producto p WHERE f.codigo = p.codigo_fabricante;
-- 13 Llista els noms dels fabricants ordenats de manera ascendent.
SELECT nombre FROM fabricante ORDER BY nombre ASC;
-- 14 Llista els noms dels fabricants ordenats de manera descendent.
SELECT nombre FROM fabricante ORDER BY nombre DESC;
-- 15 Llista els noms dels productes ordenats, en primer lloc, pel nom de manera ascendent i, en segon lloc, pel preu de manera descendent.
SELECT nombre FROM producto ORDER BY nombre ASC, precio DESC;
-- 16 Retorna una llista amb les 5 primeres files de la taula fabricante.
SELECT * FROM fabricante  LIMIT 5;
-- 17 Retorna una llista amb 2 files a partir de la quarta fila de la taula fabricante. La quarta fila també s'ha d'incloure en la resposta.
SELECT * FROM fabricante ORDER BY codigo LIMIT 2 OFFSET 3;
-- 18 Llista el nom i el preu del producte més barat. (Utilitza solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MIN(preu), necessitaria GROUP BY.
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;
-- 19 Llista el nom i el preu del producte més car. (Utilitza solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MAX(preu), necessitaria GROUP BY.
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;
-- 20 Llista el nom de tots els productes del fabricant el codi de fabricant del qual és igual a 2.
SELECT nombre FROM producto WHERE fabricante.codigo = 2;
-- 21 Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades.
SELECT a.nombre AS producto_nombre, a.precio, c.nombre AS fabricante_nombre FROM producto a INNER JOIN fabricante c ON a.codigo_fabricante = c.codigo; 
-- 22 Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades. Ordena el resultat pel nom del fabricant, per ordre alfabètic.
SELECT a.nombre AS producto_nombre, a.precio, c.nombre AS fabricante_nombre FROM producto a INNER JOIN fabricante c ON a.codigo_fabricante = c.codigo ORDER BY fabricante_nombre ASC;
-- 23 Retorna una llista amb el codi del producte, nom del producte, codi del fabricador i nom del fabricador, de tots els productes de la base de dades.
SELECT a.codigo AS producto_codigo, a.nombre AS producto_nombre, c.codigo AS fabricante_codigo, c.nombre AS fabricante_nombre FROM producto a INNER JOIN fabricante c ON a.codigo_fabricante = c.codigo;
-- 24 Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més barat.
SELECT p.nombre AS nombre_producto, p.precio AS precio_producto, f.nombre AS nombre_fabricante FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE p.precio = (SELECT MIN(precio) FROM producto);
-- 25 Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més car.
SELECT p.nombre AS nombre_producto, p.precio AS precio_producto, f.nombre AS nombre_fabricante FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE p.precio = (SELECT MAX(precio) FROM producto);
-- 26 Retorna una llista de tots els productes del fabricant Lenovo.
SELECT p.nombre, f.nombre  FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = "Lenovo";
-- 27 Retorna una llista de tots els productes del fabricant Crucial que tinguin un preu major que 200 €.
SELECT p.nombre, f.nombre  FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = "Crucial" AND p.precio > 200;
-- 28 Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packard y Seagate. Sense utilitzar l'operador IN.
SELECT p.nombre, f.nombre  FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = "Asus" OR f.nombre = "Hewlett-Packard" OR f.nombre = "Seagate";
-- 29 Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packard y Seagate. Fent servir l'operador IN.
SELECT p.nombre, f.nombre  FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre IN ("Asus", "Hewlett-Packard", "Seagate");
-- 30 Retorna un llistat amb el nom i el preu de tots els productes dels fabricants el nom dels quals acabi per la vocal e.
SELECT p.nombre AS producto_nombre, p.precio AS producto_precio, f.nombre AS fabricante_nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre LIKE "%e";
-- 31 Retorna un llistat amb el nom i el preu de tots els productes el nom de fabricant dels quals contingui el caràcter w en el seu nom.
SELECT p.nombre AS producto_nombre, p.precio AS producto_precio, f.nombre AS fabricante_nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre LIKE "%w%";
-- 32 Retorna un llistat amb el nom de producte, preu i nom de fabricant, de tots els productes que tinguin un preu major o igual a 180 €. Ordena el resultat, en primer lloc, pel preu (en ordre descendent) i, en segon lloc, pel nom (en ordre ascendent).
SELECT p.nombre AS producto_nombre, p.precio AS producto_precio, f.nombre AS fabricante_nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE p.precio >= 180 ORDER BY p.precio ASC, p.nombre ASC;
-- SELECT p.nombre AS producto_nombre, p.precio AS producto_precio, f.nombre AS fabricante_nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE p.precio >= 180 ORDER BY p.nombre ASC;
-- 33 Retorna un llistat amb el codi i el nom de fabricant, solament d'aquells fabricants que tenen productes associats en la base de dades.
SELECT f.codigo, f.nombre FROM fabricante f JOIN producto p ON f.codigo = p.codigo_fabricante; 
-- 34 Retorna un llistat de tots els fabricants que existeixen en la base de dades, juntament amb els productes que té cadascun d'ells. El llistat haurà de mostrar també aquells fabricants que no tenen productes associats.
SELECT f.nombre AS nombre_fabricante, COALESCE(p.nombre, "Sin productos") AS nombre_producto FROM fabricante f LEFT JOIN producto p ON f.codigo = p.codigo_fabricante;
--se puede hacer con codigo in y codigo not in
-- 35 Retorna un llistat on només apareguin aquells fabricants que no tenen cap producte associat.
SELECT f.nombre AS nombre_fabricante FROM fabricante f LEFT JOIN producto p ON f.codigo = p.codigo_fabricante WHERE p.nombre IS NULL;
-- 36 Retorna tots els productes del fabricador Lenovo. (Sense utilitzar INNER JOIN).
SELECT p.nombre AS nombre_producto, f.nombre AS nombre_fabricante FROM producto p, fabricante f WHERE p.codigo_fabricante = f.codigo AND f.nombre = "Lenovo";
-- 37 Retorna totes les dades dels productes que tenen el mateix preu que el producte més car del fabricant Lenovo. (Sense usar INNER JOIN).
SELECT p.* FROM producto p, fabricante f WHERE p.codigo_fabricante = f.codigo AND p.precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = f.codigo) AND f.nombre = "Lenovo";
-- 38 Llista el nom del producte més car del fabricant Lenovo.
SELECT p.nombre FROM producto p, fabricante f WHERE p.codigo_fabricante = f.codigo AND f.nombre = "Lenovo" AND p.precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = f.codigo);
-- 39 Llista el nom del producte més barat del fabricant Hewlett-Packard.
SELECT p.nombre FROM producto p, fabricante f WHERE p.codigo_fabricante = f.codigo AND f.nombre = "Hewlett-Packard" AND p.precio = (SELECT MIN(precio) FROM producto WHERE codigo_fabricante = f.codigo);
-- 40 Retorna tots els productes de la base de dades que tenen un preu major o igual al producte més car del fabricant Lenovo.
SELECT p.nombre, p.precio FROM producto p WHERE p.precio >= (SELECT MAX(precio) FROM producto pr JOIN fabricante f ON pr.codigo_fabricante = f.codigo WHERE f.nombre = "Lenovo");
-- 41 Llista tots els productes del fabricant Asus que tenen un preu superior al preu mitjà de tots els seus productes.
SELECT p.nombre, p.precio FROM producto p WHERE p.precio > (SELECT AVG(precio) FROM producto pr JOIN fabricante f ON pr.codigo_fabricante = f.codigo WHERE f.nombre = "Asus");