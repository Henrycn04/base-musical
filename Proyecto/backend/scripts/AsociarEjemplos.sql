-- Asociar ejemplo1.mp3 con Cadencias > Armónicas > Desviaciones cadenciales > Auténtica deceptiva
INSERT INTO EjemploCategorias (ejemplo_id, categoria_id) 
VALUES ((SELECT id FROM EjemplosMusicales WHERE nombre = 'ejemplo1.mp3'), 
        (SELECT id FROM Categorias WHERE nombre = 'Auténtica deceptiva'));

-- Asociar ejemplo2.mp3 con Cadencias > Armónicas > Semi-conclusivas > Semicadencia auténtica
INSERT INTO EjemploCategorias (ejemplo_id, categoria_id) 
VALUES ((SELECT id FROM EjemplosMusicales WHERE nombre = 'ejemplo2.mp3'), 
        (SELECT id FROM Categorias WHERE nombre = 'Semicadencia auténtica'));
