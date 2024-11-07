-- 1. Cadencias
INSERT INTO Categorias (nombre, padre_id) VALUES ('Cadencias', NULL);

-- 1.1. Armónicas
INSERT INTO Categorias (nombre, padre_id) 
VALUES ('Armónicas', (SELECT id FROM Categorias WHERE nombre = 'Cadencias'));

-- 1.1.1. Conclusivas
INSERT INTO Categorias (nombre, padre_id) 
VALUES ('Conclusivas', (SELECT id FROM Categorias WHERE nombre = 'Armónicas'));

-- 1.1.1.1. Auténtica perfecta
INSERT INTO Categorias (nombre, padre_id) 
VALUES ('Auténtica perfecta', (SELECT id FROM Categorias WHERE nombre = 'Conclusivas'));

-- 1.1.1.2. Auténtica imperfecta
INSERT INTO Categorias (nombre, padre_id) 
VALUES ('Auténtica imperfecta', (SELECT id FROM Categorias WHERE nombre = 'Conclusivas'));

-- 1.1.1.3. Plagal
INSERT INTO Categorias (nombre, padre_id) 
VALUES ('Plagal', (SELECT id FROM Categorias WHERE nombre = 'Conclusivas'));

-- 1.1.1.4. Landini
INSERT INTO Categorias (nombre, padre_id) 
VALUES ('Landini', (SELECT id FROM Categorias WHERE nombre = 'Conclusivas'));

-- 1.1.2. Semi-conclusivas
INSERT INTO Categorias (nombre, padre_id) 
VALUES ('Semi-conclusivas', (SELECT id FROM Categorias WHERE nombre = 'Armónicas'));

-- 1.1.2.1. Semicadencia auténtica
INSERT INTO Categorias (nombre, padre_id) 
VALUES ('Semicadencia auténtica', (SELECT id FROM Categorias WHERE nombre = 'Semi-conclusivas'));

-- 1.1.2.2. Semicadencia plagal
INSERT INTO Categorias (nombre, padre_id) 
VALUES ('Semicadencia plagal', (SELECT id FROM Categorias WHERE nombre = 'Semi-conclusivas'));

-- 1.1.3. Desviaciones cadenciales
INSERT INTO Categorias (nombre, padre_id) 
VALUES ('Desviaciones cadenciales', (SELECT id FROM Categorias WHERE nombre = 'Armónicas'));

-- 1.1.3.1. Auténtica deceptiva (rota)
INSERT INTO Categorias (nombre, padre_id) 
VALUES ('Auténtica deceptiva (rota)', (SELECT id FROM Categorias WHERE nombre = 'Desviaciones cadenciales'));

-- 1.1.3.2. Plagal deceptiva
INSERT INTO Categorias (nombre, padre_id) 
VALUES ('Plagal deceptiva', (SELECT id FROM Categorias WHERE nombre = 'Desviaciones cadenciales'));

-- 1.1.3.3. Evadida
INSERT INTO Categorias (nombre, padre_id) 
VALUES ('Evadida', (SELECT id FROM Categorias WHERE nombre = 'Desviaciones cadenciales'));

-- 1.1.3.4. Abandonada
INSERT INTO Categorias (nombre, padre_id) 
VALUES ('Abandonada', (SELECT id FROM Categorias WHERE nombre = 'Desviaciones cadenciales'));

-- 1.2. Melódicas
INSERT INTO Categorias (nombre, padre_id) 
VALUES ('Melódicas', (SELECT id FROM Categorias WHERE nombre = 'Cadencias'));

-- 1.2.1. Conclusivas
INSERT INTO Categorias (nombre, padre_id) 
VALUES ('Conclusivas', (SELECT id FROM Categorias WHERE nombre = 'Melódicas'));

-- 1.2.2. Semi-conclusivas
INSERT INTO Categorias (nombre, padre_id) 
VALUES ('Semi-conclusivas', (SELECT id FROM Categorias WHERE nombre = 'Melódicas'));

-- 1.2.3. No-conclusivas
INSERT INTO Categorias (nombre, padre_id) 
VALUES ('No-conclusivas', (SELECT id FROM Categorias WHERE nombre = 'Melódicas'));


