WITH CategoriaRecursiva AS (
    SELECT id
    FROM Categorias
    WHERE nombre = 'Armónicas'
    
    UNION ALL

    SELECT c.id
    FROM Categorias c
    INNER JOIN CategoriaRecursiva cr ON c.padre_id = cr.id
)
SELECT e.nombre, e.archivo
FROM EjemplosMusicales e
JOIN EjemploCategorias ec ON e.id = ec.ejemplo_id
JOIN Categorias c ON ec.categoria_id = c.id
WHERE c.id IN (SELECT id FROM CategoriaRecursiva);
