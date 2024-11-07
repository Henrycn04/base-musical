CREATE TABLE Categorias (
    id INT IDENTITY(1,1) PRIMARY KEY,  -- Identificador único de la categoría con auto-increment
    nombre NVARCHAR(100) NOT NULL,     -- Nombre de la categoría
    padre_id INT,                      -- ID del padre para subcategorías (NULL si es de nivel superior)
    CONSTRAINT FK_Categorias_Padre FOREIGN KEY (padre_id) REFERENCES Categorias(id)
);
CREATE TABLE EjemplosMusicales (
    id INT IDENTITY(1,1) PRIMARY KEY,  -- Identificador único del ejemplo musical con auto-increment
    nombre NVARCHAR(100) NOT NULL,     -- Nombre descriptivo del ejemplo (ejemplo1.mp3)
    archivo NVARCHAR(255) NOT NULL     -- Ruta al archivo del ejemplo musical
);
CREATE TABLE EjemploCategorias (
    ejemplo_id INT,                    -- ID del ejemplo musical
    categoria_id INT,                  -- ID de la categoría asociada
    PRIMARY KEY (ejemplo_id, categoria_id),
    CONSTRAINT FK_Ejemplo_Categorias_Ejemplo FOREIGN KEY (ejemplo_id) 
        REFERENCES EjemplosMusicales(id) ON DELETE CASCADE,
    CONSTRAINT FK_Ejemplo_Categorias_Categoria FOREIGN KEY (categoria_id) 
        REFERENCES Categorias(id) ON DELETE CASCADE
);
