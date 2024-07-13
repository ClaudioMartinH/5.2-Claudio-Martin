-- Llista el nom de tots els productes que hi ha en la taula producto.
SELECT nombre FROM producto;
-- Llista els noms i els preus de tots els productes de la taula producto.
SELECT nombre, precio FROM producto;
-- Llista totes les columnes de la taula producto.
SELECT * FROM producto;
-- Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD).
SELECT nombre, CONCAT(precio, ' $') AS precio_dolares, CONCAT(precio * 0.92, ' €') AS precio_euros FROM producto;
-- Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD). Utilitza els següents àlies per a les columnes: nom de producto, euros, dòlars.
SELECT nombre AS nom_de_producte, CONCAT(precio, ' $') AS dolares, CONCAT(precio * 0.92, ' €') AS euros FROM producto;
-- Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a majúscula.
SELECT UPPER(nombre) AS nombre_mayusculas, precio FROM producto;
-- Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a minúscula.
SELECT LOWER(nombre) AS nombre_minusculas, precio FROM producto;
-- Llista el nom de tots els fabricants en una columna, i en una altra columna obtingui en majúscules els dos primers caràcters del nom del fabricant.
SELECT nombre AS nombre_producto, CONCAT(SUBSTRING(nombre, 1, 1), UPPER(SUBSTRING(nombre, 2, 2)), SUBSTRING(nombre, 4)) AS nombre_mayusculas FROM fabricante;
-- Llista els noms i els preus de tots els productes de la taula producto, arrodonint el valor del preu.
SELECT nombre AS nombre_producto, ROUND(precio) as precio_redondeado FROM producto;
-- Llista els noms i els preus de tots els productes de la taula producto, truncant el valor del preu per a mostrar-lo sense cap xifra decimal.
SELECT nombre AS nombre_producto, TRUNCATE(precio, 0) as precio_truncado FROM producto;
-- Llista el codi dels fabricants que tenen productes en la taula producto.
SELECT codigo FROM producto;
-- Llista el codi dels fabricants que tenen productes en la taula producto, eliminant els codis que apareixen repetits.
SELECT DISTINCT codigo FROM producto;
-- Llista els noms dels fabricants ordenats de manera ascendent.
SELECT nombre FROM fabricante ORDER BY nombre ASC;
-- Llista els noms dels fabricants ordenats de manera descendent.
SELECT nombre FROM fabricante ORDER BY nombre DESC;



