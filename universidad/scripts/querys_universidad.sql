-- 1 Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = "alumno" ORDER BY apellido1 ASC, apellido2 ASC, nombre ASC;
-- 2 Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = "alumno" AND telefono IS NULL or telefono = 0;
-- 3 Retorna el llistat dels alumnes que van néixer en 1999.
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = "alumno" AND YEAR(fecha_nacimiento) = "1999";
-- 4 Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.
SELECT nombre, apellido1, apellido2 FROM persona WHERE telefono IS NULL AND tipo = "profesor" AND nif LIKE "%K";
-- 5 Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.
SELECT nombre FROM asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;
-- 6 Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.
SELECT p.apellido1, p.apellido2, p.nombre, d.nombre FROM persona p JOIN profesor pr ON p.id = pr.id_profesor JOIN departamento d ON pr.id_departamento = d.id ORDER BY p.apellido1 ASC, p.apellido2 ASC, p.nombre ASC;
-- 7 Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.
SELECT a.nombre, ce.anyo_inicio, ce.anyo_fin FROM asignatura a JOIN alumno_se_matricula_asignatura am ON a.id = am.id_asignatura JOIN curso_escolar ce ON am.id_curso_escolar = ce.id JOIN persona p ON am.id_alumno = p.id WHERE p.nif = "26902806M";
-- 8 Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).
SELECT DISTINCT d.nombre FROM departamento d JOIN profesor p ON d.id = p.id_departamento JOIN asignatura a ON p.id_profesor = a.id_profesor JOIN grado g ON a.id_grado = g.id WHERE g.nombre = "Grau en Enginyeria Informàtica (Pla 2015)";
-- 9 Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT DISTINCT p.nombre, p.apellido1, p.apellido2 FROM persona p JOIN alumno_se_matricula_asignatura am ON p.id = am.id_alumno JOIN curso_escolar ce ON am.id_curso_escolar = ce.id WHERE ce.anyo_inicio = "2018" AND ce.anyo_fin = "2019";
-- Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.

-- 1 Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.
SELECT p.nombre, p.apellido1, p.apellido2, d.nombre FROM persona p JOIN profesor pr ON p.id = pr.id_profesor LEFT JOIN departamento d ON pr.id_departamento = d.id ORDER BY d.nombre ASC, p.apellido1 ASC, p.apellido2 ASC, p.nombre ASC;
-- 2 Retorna un llistat amb els professors/es que no estan associats a un departament.
SELECT p.nombre, p.apellido1, p.apellido2 FROM persona p JOIN profesor pr ON p.id = pr.id_profesor LEFT JOIN departamento d ON pr.id_departamento = d.id WHERE d.id IS NULL;
-- 3 Retorna un llistat amb els departaments que no tenen professors/es associats.
SELECT d.nombre FROM departamento d LEFT JOIN profesor pr ON d.id = pr.id_departamento WHERE pr.id_profesor IS NULL;
-- 4 Retorna un llistat amb els professors/es que no imparteixen cap assignatura.
SELECT p.nombre, p.apellido1, p.apellido2 FROM persona p LEFT JOIN asignatura a ON p.id = a.id_profesor WHERE a.id IS NULL;
-- 5 Retorna un llistat amb les assignatures que no tenen un professor/a assignat.
SELECT a.nombre FROM asignatura a LEFT JOIN profesor pr  ON pr.id_profesor = a.id_profesor WHERE a.id_profesor IS NULL;
-- 6 Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.
SELECT d.id, d.nombre FROM departamento d WHERE d.id NOT IN (SELECT DISTINCT d.id FROM departamento d JOIN profesor p ON d.id = p.id_departamento JOIN asignatura a ON p.id_profesor = a.id_profesor JOIN curso_escolar c ON a.id = c.id_asignatura);
-- Consultes resum:
-- 1 Retorna el nombre total d'alumnes que hi ha.
SELECT COUNT(*) as total_alumnos FROM persona WHERE tipo = "alumno";
-- 2 Calcula quants alumnes van néixer en 1999.
SELECT COUNT(*) as alumnos_1999 FROM persona WHERE tipo = "alumno" AND YEAR(fecha_nacimiento) = "1999";
-- 3 Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.
SELECT departamento.nombre, COUNT(DISTINCT profesor.id_profesor) as numero_profesores FROM profesor JOIN departamento ON profesor.id_departamento = departamento.id GROUP BY departamento.nombre ORDER BY numero_profesores DESC;
-- 4 Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat.
SELECT d.nombre, p.nombre FROM departamento d, profesor , persona p WHERE p.id = pr.id_profesor AND d.id IN (SELECT id_departamento FROM profesor WHERE id_departamento IS NOT NULL OR id_departamento IS NULL);
-- 5 Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingues en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.
SELECT g.nombre, COUNT(a.id) FROM grado g LEFT JOIN asignatura a ON a.id_grado = g.id GROUP BY g.nombre ORDER BY COUNT(a.id) DESC;
-- 6 Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.
SELECT g.nombre, count(a.id) AS total FROM grado g LEFT JOIN asignatura a ON a.id_grado = g.id GROUP BY g.nombre HAVING COUNT(a.id) > 40 ORDER BY COUNT(a.id) DESC;
-- 7 Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.
SELECT g.nombre, a.tipo, SUM(a.creditos) FROM grado g LEFT JOIN asignatura a ON a.id_grado = g.id GROUP BY g.nombre, a.tipo;
-- 8 Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.
SELECT c.anyo_inicio, count(a.id_alumno) FROM curso_escolar c LEFT JOIN alumno_se_matricula_asignatura a ON c.id = a.id_curso_escolar GROUP BY c.anyo_inicio;
-- 9 Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.
SELECT pr.id_profesor, p.nombre, p.apellido1, p.apellido2, COUNT(a.id) FROM profesor pr LEFT JOIN persona p ON pr.id_profesor = p.id LEFT JOIN asignatura a ON a.id_profesor = pr.id_profesor GROUP BY pr.id_profesor ORDER BY COUNT(a.id) DESC;
-- 10 Retorna totes les dades de l'alumne/a més jove.
SELECT p.* FROM persona p JOIN (SELECT MAX(fecha_nacimiento) AS edad_mas_joven FROM persona pr WHERE pr.tipo = "alumno") AS anyo_mas_alto ON p.fecha_nacimiento = anyo_mas_alto.edad_mas_joven WHERE p.tipo = "alumno";
-- 11 Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.
SELECT p.nombre, p.apellido1, p.apellido2, d.nombre as nombre_departamento, a.nombre as nombre_asignatura from persona p LEFT JOIN profesor pr ON pr.id_profesor = p.id LEFT JOIN departamento d ON pr.id_departamento = d.id LEFT JOIN asignatura a ON a.id_profesor = p.id_profesor WHERE d.nombre IS NOT NULL AND a.nombre IS NULL;
