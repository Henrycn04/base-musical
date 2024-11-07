CREATE TABLE MusicalCategories (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    ParentId INT NULL,
    FOREIGN KEY (ParentId) REFERENCES MusicalCategories(Id)
);

-- Insertar las categorías principales
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('Escalas', NULL);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('Acordes (tipos)', NULL);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('Chord scales', NULL);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('Funciones armónicas', NULL);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('Cadencias', NULL);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('Texturas', NULL);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('Disposiciones', NULL);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('Notas ornamentales', NULL);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('Movimiento relativo', NULL);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('Progresiones armónicas', NULL);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('Modulación', NULL);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('Transformaciones Neo-riemannianas', NULL);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('Conducción de voces tradicional', NULL);

-- Insertar subcategorías de Escalas
DECLARE @EscalasId INT = (SELECT Id FROM MusicalCategories WHERE Name = 'Escalas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1. Pentatónicas', @EscalasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2. Hexatónicas', @EscalasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3. Heptatónicas', @EscalasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('4. Octatónicas', @EscalasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('5. Nonatónicas', @EscalasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('6. Decatónicas', @EscalasId);

-- Insertar subcategorías de Pentatónicas
DECLARE @PentatonicasId INT = (SELECT Id FROM MusicalCategories WHERE Name = '1. Pentatónicas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.1. Modo I (mayor): 1 2 3 5 6', @PentatonicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.2. Modo II: 2 3 5 6 1', @PentatonicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.3. Modo III: 3 5 6 1 2', @PentatonicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.4. Modo IV: 5 6 1 2 3', @PentatonicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.5. Modo V (menor): 6 1 2 3 5', @PentatonicasId);

-- Insertar subcategorías de Hexatónicas
DECLARE @HexatonicasId INT = (SELECT Id FROM MusicalCategories WHERE Name = '2. Hexatónicas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.1. Tonos enteros (Modo I de transposición limitada, Messian)', @HexatonicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.1.1. TE0 (0-2-4-6-8-10)', (SELECT Id FROM MusicalCategories WHERE Name = '2.1. Tonos enteros (Modo I de transposición limitada, Messian)'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.1.2. TE1 (1-3-5-7-9-11)', (SELECT Id FROM MusicalCategories WHERE Name = '2.1. Tonos enteros (Modo I de transposición limitada, Messian)'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.2. Escala de blues (1 b3 4 #4/b5 5 b7)', @HexatonicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.3. Aumentada', @HexatonicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.3.1. HEX 0,1 (0-1-4-5-8-9)', (SELECT Id FROM MusicalCategories WHERE Name = '2.3. Aumentada'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.3.2. HEX 1,2 (1-2-5-6-9-10)', (SELECT Id FROM MusicalCategories WHERE Name = '2.3. Aumentada'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.3.3. HEX 2,3 (2-3-6-7-10-11)', (SELECT Id FROM MusicalCategories WHERE Name = '2.3. Aumentada'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.3.4. HEX 3,4 (3-4-7-8-11-0)', (SELECT Id FROM MusicalCategories WHERE Name = '2.3. Aumentada'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.4. Modo de transposición limitada V, Messian (0-1-5-6-7-11)', @HexatonicasId);

-- Insertar subcategorías de Heptatónicas
DECLARE @HeptatonicasId INT = (SELECT Id FROM MusicalCategories WHERE Name = '3. Heptatónicas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.1. Mayor', @HeptatonicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.2. Menor', @HeptatonicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.2.1. Natural', (SELECT Id FROM MusicalCategories WHERE Name = '3.2. Menor'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.2.2. Armónica', (SELECT Id FROM MusicalCategories WHERE Name = '3.2. Menor'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.2.3. Melódica', (SELECT Id FROM MusicalCategories WHERE Name = '3.2. Menor'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.3. Modos diatónicos', @HeptatonicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.3.1. Jónica', (SELECT Id FROM MusicalCategories WHERE Name = '3.3. Modos diatónicos'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.3.2. Dórica', (SELECT Id FROM MusicalCategories WHERE Name = '3.3. Modos diatónicos'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.3.3. Lidia', (SELECT Id FROM MusicalCategories WHERE Name = '3.3. Modos diatónicos'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.3.4. Mixolidia', (SELECT Id FROM MusicalCategories WHERE Name = '3.3. Modos diatónicos'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.3.5. Eólica', (SELECT Id FROM MusicalCategories WHERE Name = '3.3. Modos diatónicos'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.3.6. Locria', (SELECT Id FROM MusicalCategories WHERE Name = '3.3. Modos diatónicos'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.4. Lidia-Mixolidia (1 2 3 #4 5 6 b7)', @HeptatonicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.5. Modos gregorianos', @HeptatonicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.5.1. Auténticos', (SELECT Id FROM MusicalCategories WHERE Name = '3.5. Modos gregorianos'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.5.2. Plagales', (SELECT Id FROM MusicalCategories WHERE Name = '3.5. Modos gregorianos'));

-- Insertar subcategorías de Octatónicas
DECLARE @OctatonicasId INT = (SELECT Id FROM MusicalCategories WHERE Name = '4. Octatónicas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('4.1. Disminuida (Modo II de transposición limitada, Messian)', @OctatonicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('4.1.1. OCT 0,1 (0-1-3-4-6-7-9-10)', (SELECT Id FROM MusicalCategories WHERE Name = '4.1. Disminuida (Modo II de transposición limitada, Messian)'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('4.1.2. OCT 1,2 (1-2-4-5-7-8-10-11)', (SELECT Id FROM MusicalCategories WHERE Name = '4.1. Disminuida (Modo II de transposición limitada, Messian)'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('4.1.3. OCT 2,3 (2-3-5-6-8-9-11-0)', (SELECT Id FROM MusicalCategories WHERE Name = '4.1. Disminuida (Modo II de transposición limitada, Messian)'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('4.2. BeeBop (1 2 3 4 5 6 b7 7)', @OctatonicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('4.3. Modo de transposición limitada IV, Messian (0-1-2-5-6-7-8-11)', @OctatonicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('4.4. Modo de transposición limitada VI, Messian (0-2-4-5-6-8-10-11)', @OctatonicasId);

-- Insertar subcategorías de Nonatónicas
DECLARE @NonatonicasId INT = (SELECT Id FROM MusicalCategories WHERE Name = '5. Nonatónicas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('5.1. Modo de transposición limitada III, Messian (0-2-3-4-6-7-8-10-11)', @NonatonicasId);

-- Insertar subcategorías de Decatónicas
DECLARE @DecatonicasId INT = (SELECT Id FROM MusicalCategories WHERE Name = '6. Decatónicas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('6.1. Modo de transposición limitada VII, Messian (0-1-2-3-5-6-7-8-9-11)', @DecatonicasId);

-- Insertar subcategorías de Acordes
DECLARE @AcordesId INT = (SELECT Id FROM MusicalCategories WHERE Name = 'Acordes (tipos)');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1. Triadas', @AcordesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2. Tetradas', @AcordesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3. Armonía extendida', @AcordesId);

-- Insertar subcategorías de Triadas
DECLARE @TriadasId INT = (SELECT Id FROM MusicalCategories WHERE Name = '1. Triadas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.1. Mayor', @TriadasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.2. Menor', @TriadasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.3. Aumentada', @TriadasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.4. Disminuida', @TriadasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.5. Sus4', @TriadasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.6. Sus2', @TriadasId);

-- Insertar subcategorías de Tetradas
DECLARE @TetradasId INT = (SELECT Id FROM MusicalCategories WHERE Name = '2. Tetradas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.1. Séptima mayor (mayor mayor)', @TetradasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.2. Séptima menor (menor menor)', @TetradasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.3. Séptima de dominante (mayor menor)', @TetradasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.4. Medio disminuida (disminuido menor)', @TetradasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.5. Disminuida (disminuido disminuido)', @TetradasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.6. Menor-Mayor', @TetradasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.7. Aumentada-Mayor', @TetradasId);

-- Insertar subcategorías de Armonía extendida
DECLARE @ArmoniaExtendidaId INT = (SELECT Id FROM MusicalCategories WHERE Name = '3. Armonía extendida');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.1. Acordes de novena', @ArmoniaExtendidaId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.2. Acorde de undécima', @ArmoniaExtendidaId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.3. Acordes decimotercera', @ArmoniaExtendidaId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.4. Acordes con sexta agregada', @ArmoniaExtendidaId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.5. Acordes sin tercera (power chords)', @ArmoniaExtendidaId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.6. Acordes cuartales', @ArmoniaExtendidaId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.7. Poliacordes', @ArmoniaExtendidaId);

-- Insertar subcategorías de Chord scales
DECLARE @ChordScalesId INT = (SELECT Id FROM MusicalCategories WHERE Name = 'Chord scales');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1. I7 y I6 (jónico)', @ChordScalesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2. ii7 (dórico)', @ChordScalesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3. iii7 (frigio)', @ChordScalesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('4. IV7 (lidio)', @ChordScalesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('5. V7 (mixolidio)', @ChordScalesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('6. vi7 (eólico)', @ChordScalesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('7. vii7(b5) (locrio)', @ChordScalesId);

-- Insertar subcategorías de Funciones armónicas
DECLARE @FuncionesArmónicasId INT = (SELECT Id FROM MusicalCategories WHERE Name = 'Funciones armónicas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1. Tónica', @FuncionesArmónicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2. Subdominante', @FuncionesArmónicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3. Dominante', @FuncionesArmónicasId);

-- Insertar subcategorías de Cadencias
DECLARE @CadenciasId INT = (SELECT Id FROM MusicalCategories WHERE Name = 'Cadencias');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1. Armónicas', @CadenciasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2. Melódicas', @CadenciasId);

-- Insertar subcategorías de Cadencias armónicas
DECLARE @CadenciasArmónicasId INT = (SELECT Id FROM MusicalCategories WHERE Name = '1. Armónicas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.1. Conclusivas', @CadenciasArmónicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.1.1. Auténtica perfecta', (SELECT Id FROM MusicalCategories WHERE Name = '1.1. Conclusivas'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.1.2. Auténtica imperfecta', (SELECT Id FROM MusicalCategories WHERE Name = '1.1. Conclusivas'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.1.3. Plagal', (SELECT Id FROM MusicalCategories WHERE Name = '1.1. Conclusivas'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.1.4. Landini', (SELECT Id FROM MusicalCategories WHERE Name = '1.1. Conclusivas'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.2. Semi-conclusivas', @CadenciasArmónicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.2.1. Semicadencia auténtica', (SELECT Id FROM MusicalCategories WHERE Name = '1.2. Semi-conclusivas'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.2.2. Semicadencia plagal', (SELECT Id FROM MusicalCategories WHERE Name = '1.2. Semi-conclusivas'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.3. Desviaciones cadenciales', @CadenciasArmónicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.3.1. Auténtica deceptiva (rota)', (SELECT Id FROM MusicalCategories WHERE Name = '1.3. Desviaciones cadenciales'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.3.2. Plagal deceptiva', (SELECT Id FROM MusicalCategories WHERE Name = '1.3. Desviaciones cadenciales'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.3.3. Evadida', (SELECT Id FROM MusicalCategories WHERE Name = '1.3. Desviaciones cadenciales'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.3.4. Abandonada', (SELECT Id FROM MusicalCategories WHERE Name = '1.3. Desviaciones cadenciales'));

-- Insertar subcategorías de Cadencias melódicas
DECLARE @CadenciasMelódicasId INT = (SELECT Id FROM MusicalCategories WHERE Name = '2. Melódicas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.1. Conclusivas', @CadenciasMelódicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.2. Semi-conclusivas', @CadenciasMelódicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.3. No-conclusivas', @CadenciasMelódicasId);

-- Insertar subcategorías de Texturas
DECLARE @TexturasId INT = (SELECT Id FROM MusicalCategories WHERE Name = 'Texturas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1. Monofónica', @TexturasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2. Homofónica', @TexturasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3. Polifónica', @TexturasId);

-- Insertar subcategorías de Disposiciones
DECLARE @DisposicionesId INT = (SELECT Id FROM MusicalCategories WHERE Name = 'Disposiciones');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1. 4 voces', @DisposicionesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2. 5 voces', @DisposicionesId);

-- Insertar subcategorías de 4 voces
DECLARE @CuatroVocesId INT = (SELECT Id FROM MusicalCategories WHERE Name = '1. 4 voces');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.1. abierta', @CuatroVocesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.2. cerrada', @CuatroVocesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.3. mixta', @CuatroVocesId);

-- Insertar subcategorías de 5 voces
DECLARE @CincoVocesId INT = (SELECT Id FROM MusicalCategories WHERE Name = '2. 5 voces');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.1. spread voicing', @CincoVocesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.2. close voicing', @CincoVocesId);

-- Insertar subcategorías de Notas ornamentales
DECLARE @NotasOrnamentalesId INT = (SELECT Id FROM MusicalCategories WHERE Name = 'Notas ornamentales');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1. Notas de paso', @NotasOrnamentalesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2. Bordaduras', @NotasOrnamentalesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3. Anticipaciones', @NotasOrnamentalesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('4. Suspensiones', @NotasOrnamentalesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('5. Retardaciones', @NotasOrnamentalesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('6. Pedal', @NotasOrnamentalesId);

-- Insertar subcategorías de Movimiento relativo
DECLARE @MovimientoRelativoId INT = (SELECT Id FROM MusicalCategories WHERE Name = 'Movimiento relativo');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1. paralelo', @MovimientoRelativoId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2. directo', @MovimientoRelativoId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3. contrario', @MovimientoRelativoId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('4. Oblicuo', @MovimientoRelativoId);

-- Insertar subcategorías de Progresiones armónicas
DECLARE @ProgresionesArmónicasId INT = (SELECT Id FROM MusicalCategories WHERE Name = 'Progresiones armónicas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1. Arquetípicas', @ProgresionesArmónicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2. Secuenciales', @ProgresionesArmónicasId);

-- Insertar subcategorías de Arquetípicas
DECLARE @ArquetipicasId INT = (SELECT Id FROM MusicalCategories WHERE Name = '1. Arquetípicas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.1. “Two-five” (ii7-V7-I)', @ArquetipicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.2. "Turn around"(iii-vi-ii-V-I)', @ArquetipicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.3. Círculo de quintas descendentes', @ArquetipicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.4. T-S-D-T (progresión auténtica)', @ArquetipicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.5. T-D-S-T (progresión plagal)', @ArquetipicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.6. “Double plagal” (I-bVII-IV-I)', @ArquetipicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.7. “Best seller” (I-V-vi-IV)', @ArquetipicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.8. i-bVII-bVI-bVII-i', @ArquetipicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.9. bVI-bVII-i', @ArquetipicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.10. 12-bar blues', @ArquetipicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.11. Prolongacional interpolado (EPM)', @ArquetipicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.12. Ciclos octatónicos', @ArquetipicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.13. Ciclos hexatónicos', @ArquetipicasId);

-- Insertar subcategorías de Secuenciales
DECLARE @SecuencialesId INT = (SELECT Id FROM MusicalCategories WHERE Name = '2. Secuenciales');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.1. De quintas', @SecuencialesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.2. De segundas', @SecuencialesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.3. De terceras', @SecuencialesId);

-- Insertar subcategorías de De quintas
DECLARE @DeQuintasId INT = (SELECT Id FROM MusicalCategories WHERE Name = '2.1. De quintas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.1.1. Ascendentes', @DeQuintasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.1.2. Descendentes', @DeQuintasId);

-- Insertar subcategorías de De segundas
DECLARE @DeSegundasId INT = (SELECT Id FROM MusicalCategories WHERE Name = '2.2. De segundas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.2.1. Ascendentes', @DeSegundasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.2.2. Descendentes', @DeSegundasId);

-- Insertar subcategorías de De terceras
DECLARE @DeTercerasId INT = (SELECT Id FROM MusicalCategories WHERE Name = '2.3. De terceras');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.3.1. Ascendentes', @DeTercerasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.3.2. Descendentes', @DeTercerasId);

-- Insertar subcategorías de Modulación
DECLARE @ModulacionId INT = (SELECT Id FROM MusicalCategories WHERE Name = 'Modulación');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1. Diatónica (acorde común)', @ModulacionId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2. Cromática', @ModulacionId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3. Enarmónica', @ModulacionId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('4. Directa', @ModulacionId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('5. Secuencial', @ModulacionId);
-- Insertar subcategorías de Transformaciones Neo-riemannianas
DECLARE @TransformacionesNeoRId INT = (SELECT Id FROM MusicalCategories WHERE Name = 'Transformaciones Neo-riemannianas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1. Simples', @TransformacionesNeoRId);
DECLARE @SimplesId INT = (SELECT Id FROM MusicalCategories WHERE Name = '1. Simples');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.1. Primarias', @SimplesId);
DECLARE @PrimariasId INT = (SELECT Id FROM MusicalCategories WHERE Name = '1.1. Primarias');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.1.1. P', @PrimariasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.1.2. L', @PrimariasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.1.3. R', @PrimariasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.2. Secundarias', @SimplesId);
DECLARE @SecundariasId INT = (SELECT Id FROM MusicalCategories WHERE Name = '1.2. Secundarias');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.2.1. S', @SecundariasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.2.2. N', @SecundariasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.2.3. R1', @SecundariasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.2.4. H', @SecundariasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2. Compuestas', @TransformacionesNeoRId);

-- Insertar subcategorías de Conducción de voces tradicional
DECLARE @ConduccionVocesId INT = (SELECT Id FROM MusicalCategories WHERE Name = 'Conducción de voces tradicional');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1. Enlaces sin movimiento paralelo entre consonancias perfectas (i.e., 5tas y 8vas paralelas y antiparalelas)', @ConduccionVocesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2. Enlaces sin movimiento directo hacia consonancias perfectas (i.e., 5tas y 8vas ocultas)', @ConduccionVocesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3. Enlaces sin movimiento paralelo entre 5tas de distintas calidad (i.e. 5tas desiguales)', @ConduccionVocesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('4. Enlaces con tratamiento regular e irregular de la sensible', @ConduccionVocesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('5. Tratamiento regular de la disonancia', @ConduccionVocesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('6. Resolución irregular de la disonancia (diferida e indirecta)', @ConduccionVocesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('7. Enlaces con y sin cruzamiento de voces', @ConduccionVocesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('8. Conducción armónica paralela (planning)', @ConduccionVocesId);

-- TENGO QUE AGREGAR LOS HANDLERS Y CONTROLLERS QUE ME RETORNEN LAS TUPLAS CON LOS IDS