CREATE TABLE Categories (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    parent_id INT NULL,
    level INT NOT NULL,
    FOREIGN KEY (parent_id) REFERENCES Categories(id) ON DELETE NO ACTION
);

CREATE TABLE Examples (
    id INT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    created_at DATETIME DEFAULT GETDATE(),
    updated_at DATETIME DEFAULT GETDATE() 
);

CREATE TABLE ExampleCategories (
    id INT IDENTITY(1,1) PRIMARY KEY,
    example_id INT NOT NULL,
    category_id INT NOT NULL,
    FOREIGN KEY (example_id) REFERENCES Examples(id) ON DELETE CASCADE,
    FOREIGN KEY (category_id) REFERENCES Categories(id) ON DELETE CASCADE,
    UNIQUE (example_id, category_id)  -- Evita duplicados en la relación
);
-- version más nueva
CREATE TABLE MusicalCategories (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    ParentId INT NULL,
    FOREIGN KEY (ParentId) REFERENCES MusicalCategories(Id)
);