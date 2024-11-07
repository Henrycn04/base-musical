CREATE TABLE Ejemplos (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Nombre NVARCHAR(255) NOT NULL,  -- Nombre del ejemplo
    RutaArchivo NVARCHAR(255) NOT NULL,  -- Ruta del archivo relacionado
    Descripcion NVARCHAR(255) NULL  -- Descripción opcional
);
INSERT INTO Ejemplos (Nombre, RutaArchivo, Descripcion) VALUES ('Ejemplo 1', 'ruta/al/archivo1.mp3', 'Descripción del Ejemplo 1');
INSERT INTO Ejemplos (Nombre, RutaArchivo, Descripcion) VALUES ('Ejemplo 2', 'ruta/al/archivo2.mp3', 'Descripción del Ejemplo 2');
INSERT INTO Ejemplos (Nombre, RutaArchivo, Descripcion) VALUES ('Ejemplo 3', 'ruta/al/archivo3.mp3', 'Descripción del Ejemplo 3');

CREATE TABLE EjemploCategoria (
    Id INT PRIMARY KEY IDENTITY(1,1),
    EjemploId INT NOT NULL,
    CategoriaId INT NOT NULL,
    FOREIGN KEY (EjemploId) REFERENCES Ejemplos(Id),
    FOREIGN KEY (CategoriaId) REFERENCES MusicalCategories(Id)
);


INSERT INTO EjemploCategoria (EjemploId, CategoriaId)
VALUES 
(
    (SELECT Id FROM Ejemplos WHERE RutaArchivo = 'ruta/al/archivo1.mp3'),  -- Busca el EjemploId por RutaArchivo
    (SELECT Id FROM MusicalCategories WHERE Name = '1.1. Modo I (mayor): 1 2 3 5 6')  -- Busca el CategoriaId por Label
);
INSERT INTO EjemploCategoria (EjemploId, CategoriaId)
VALUES 
(
    (SELECT Id FROM Ejemplos WHERE RutaArchivo = 'ruta/al/archivo2.mp3'),  -- Busca el EjemploId por RutaArchivo
    (SELECT Id FROM MusicalCategories WHERE Name = '1.2. Modo II: 2 3 5 6 1')  -- Busca el CategoriaId por Label
);
INSERT INTO EjemploCategoria (EjemploId, CategoriaId)
VALUES 
(
    (SELECT Id FROM Ejemplos WHERE RutaArchivo = 'ruta/al/archivo3.mp3'),  -- Busca el EjemploId por RutaArchivo
    (SELECT Id FROM MusicalCategories WHERE Name = '1.3. Modo III: 3 5 6 1 2')  -- Busca el CategoriaId por Label
);
