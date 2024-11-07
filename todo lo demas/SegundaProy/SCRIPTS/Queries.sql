-- Insertar ejemplos
INSERT INTO Examples (name) VALUES 
('ejemplo1.mp4'),  -- Relacionado con Conclusivas
('ejemplo2.mp4'),  -- Relacionado con Semi-conclusivas
('ejemplo3.mp4');  -- Relacionado con Melódicas
-- Asignar ejemplos a categorías
-- Limpiar tabla de asignaciones para evitar duplicados (opcional)
DELETE FROM ExampleCategories;

-- Asignar ejemplos a categorías sin duplicados
INSERT INTO ExampleCategories (example_id, category_id) VALUES 
(1, 36),  -- ejemplo1.mp4 a Conclusivas
(1, 33),  -- ejemplo1.mp4 a Semi-conclusivas
(2, 43),  -- ejemplo2.mp4 a Conclusivas
(2, 44),  -- ejemplo2.mp4 a Semi-conclusivas
(3, 45);  -- ejemplo3.mp4 a Melódicas

SELECT * FROM Categories

SELECT e.name AS ExampleName, c.name AS CategoryName
FROM Examples e
JOIN ExampleCategories ec ON e.id = ec.example_id
JOIN Categories c ON ec.category_id = c.id;
