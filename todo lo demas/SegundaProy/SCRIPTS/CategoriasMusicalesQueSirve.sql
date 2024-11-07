CREATE TABLE MusicalCategories (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(255) NOT NULL,
    ParentId INT NULL,
    FOREIGN KEY (ParentId) REFERENCES MusicalCategories(Id)
);

-- Insertar las categor�as principales
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('Escalas', NULL);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('Acordes (tipos)', NULL);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('Chord scales', NULL);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('Funciones arm�nicas', NULL);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('Cadencias', NULL);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('Texturas', NULL);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('Disposiciones', NULL);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('Notas ornamentales', NULL);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('Movimiento relativo', NULL);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('Progresiones arm�nicas', NULL);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('Modulaci�n', NULL);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('Transformaciones Neo-riemannianas', NULL);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('Conducci�n de voces tradicional', NULL);

-- Insertar subcategor�as de Escalas
DECLARE @EscalasId INT = (SELECT Id FROM MusicalCategories WHERE Name = 'Escalas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1. Pentat�nicas', @EscalasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2. Hexat�nicas', @EscalasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3. Heptat�nicas', @EscalasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('4. Octat�nicas', @EscalasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('5. Nonat�nicas', @EscalasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('6. Decat�nicas', @EscalasId);

-- Insertar subcategor�as de Pentat�nicas
DECLARE @PentatonicasId INT = (SELECT Id FROM MusicalCategories WHERE Name = '1. Pentat�nicas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.1. Modo I (mayor): 1 2 3 5 6', @PentatonicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.2. Modo II: 2 3 5 6 1', @PentatonicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.3. Modo III: 3 5 6 1 2', @PentatonicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.4. Modo IV: 5 6 1 2 3', @PentatonicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.5. Modo V (menor): 6 1 2 3 5', @PentatonicasId);

-- Insertar subcategor�as de Hexat�nicas
DECLARE @HexatonicasId INT = (SELECT Id FROM MusicalCategories WHERE Name = '2. Hexat�nicas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.1. Tonos enteros (Modo I de transposici�n limitada, Messian)', @HexatonicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.1.1. TE0 (0-2-4-6-8-10)', (SELECT Id FROM MusicalCategories WHERE Name = '2.1. Tonos enteros (Modo I de transposici�n limitada, Messian)'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.1.2. TE1 (1-3-5-7-9-11)', (SELECT Id FROM MusicalCategories WHERE Name = '2.1. Tonos enteros (Modo I de transposici�n limitada, Messian)'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.2. Escala de blues (1 b3 4 #4/b5 5 b7)', @HexatonicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.3. Aumentada', @HexatonicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.3.1. HEX 0,1 (0-1-4-5-8-9)', (SELECT Id FROM MusicalCategories WHERE Name = '2.3. Aumentada'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.3.2. HEX 1,2 (1-2-5-6-9-10)', (SELECT Id FROM MusicalCategories WHERE Name = '2.3. Aumentada'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.3.3. HEX 2,3 (2-3-6-7-10-11)', (SELECT Id FROM MusicalCategories WHERE Name = '2.3. Aumentada'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.3.4. HEX 3,4 (3-4-7-8-11-0)', (SELECT Id FROM MusicalCategories WHERE Name = '2.3. Aumentada'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.4. Modo de transposici�n limitada V, Messian (0-1-5-6-7-11)', @HexatonicasId);

-- Insertar subcategor�as de Heptat�nicas
DECLARE @HeptatonicasId INT = (SELECT Id FROM MusicalCategories WHERE Name = '3. Heptat�nicas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.1. Mayor', @HeptatonicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.2. Menor', @HeptatonicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.2.1. Natural', (SELECT Id FROM MusicalCategories WHERE Name = '3.2. Menor'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.2.2. Arm�nica', (SELECT Id FROM MusicalCategories WHERE Name = '3.2. Menor'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.2.3. Mel�dica', (SELECT Id FROM MusicalCategories WHERE Name = '3.2. Menor'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.3. Modos diat�nicos', @HeptatonicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.3.1. J�nica', (SELECT Id FROM MusicalCategories WHERE Name = '3.3. Modos diat�nicos'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.3.2. D�rica', (SELECT Id FROM MusicalCategories WHERE Name = '3.3. Modos diat�nicos'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.3.3. Lidia', (SELECT Id FROM MusicalCategories WHERE Name = '3.3. Modos diat�nicos'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.3.4. Mixolidia', (SELECT Id FROM MusicalCategories WHERE Name = '3.3. Modos diat�nicos'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.3.5. E�lica', (SELECT Id FROM MusicalCategories WHERE Name = '3.3. Modos diat�nicos'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.3.6. Locria', (SELECT Id FROM MusicalCategories WHERE Name = '3.3. Modos diat�nicos'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.4. Lidia-Mixolidia (1 2 3 #4 5 6 b7)', @HeptatonicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.5. Modos gregorianos', @HeptatonicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.5.1. Aut�nticos', (SELECT Id FROM MusicalCategories WHERE Name = '3.5. Modos gregorianos'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.5.2. Plagales', (SELECT Id FROM MusicalCategories WHERE Name = '3.5. Modos gregorianos'));

-- Insertar subcategor�as de Octat�nicas
DECLARE @OctatonicasId INT = (SELECT Id FROM MusicalCategories WHERE Name = '4. Octat�nicas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('4.1. Disminuida (Modo II de transposici�n limitada, Messian)', @OctatonicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('4.1.1. OCT 0,1 (0-1-3-4-6-7-9-10)', (SELECT Id FROM MusicalCategories WHERE Name = '4.1. Disminuida (Modo II de transposici�n limitada, Messian)'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('4.1.2. OCT 1,2 (1-2-4-5-7-8-10-11)', (SELECT Id FROM MusicalCategories WHERE Name = '4.1. Disminuida (Modo II de transposici�n limitada, Messian)'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('4.1.3. OCT 2,3 (2-3-5-6-8-9-11-0)', (SELECT Id FROM MusicalCategories WHERE Name = '4.1. Disminuida (Modo II de transposici�n limitada, Messian)'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('4.2. BeeBop (1 2 3 4 5 6 b7 7)', @OctatonicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('4.3. Modo de transposici�n limitada IV, Messian (0-1-2-5-6-7-8-11)', @OctatonicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('4.4. Modo de transposici�n limitada VI, Messian (0-2-4-5-6-8-10-11)', @OctatonicasId);

-- Insertar subcategor�as de Nonat�nicas
DECLARE @NonatonicasId INT = (SELECT Id FROM MusicalCategories WHERE Name = '5. Nonat�nicas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('5.1. Modo de transposici�n limitada III, Messian (0-2-3-4-6-7-8-10-11)', @NonatonicasId);

-- Insertar subcategor�as de Decat�nicas
DECLARE @DecatonicasId INT = (SELECT Id FROM MusicalCategories WHERE Name = '6. Decat�nicas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('6.1. Modo de transposici�n limitada VII, Messian (0-1-2-3-5-6-7-8-9-11)', @DecatonicasId);

-- Insertar subcategor�as de Acordes
DECLARE @AcordesId INT = (SELECT Id FROM MusicalCategories WHERE Name = 'Acordes (tipos)');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1. Triadas', @AcordesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2. Tetradas', @AcordesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3. Armon�a extendida', @AcordesId);

-- Insertar subcategor�as de Triadas
DECLARE @TriadasId INT = (SELECT Id FROM MusicalCategories WHERE Name = '1. Triadas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.1. Mayor', @TriadasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.2. Menor', @TriadasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.3. Aumentada', @TriadasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.4. Disminuida', @TriadasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.5. Sus4', @TriadasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.6. Sus2', @TriadasId);

-- Insertar subcategor�as de Tetradas
DECLARE @TetradasId INT = (SELECT Id FROM MusicalCategories WHERE Name = '2. Tetradas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.1. S�ptima mayor (mayor mayor)', @TetradasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.2. S�ptima menor (menor menor)', @TetradasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.3. S�ptima de dominante (mayor menor)', @TetradasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.4. Medio disminuida (disminuido menor)', @TetradasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.5. Disminuida (disminuido disminuido)', @TetradasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.6. Menor-Mayor', @TetradasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.7. Aumentada-Mayor', @TetradasId);

-- Insertar subcategor�as de Armon�a extendida
DECLARE @ArmoniaExtendidaId INT = (SELECT Id FROM MusicalCategories WHERE Name = '3. Armon�a extendida');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.1. Acordes de novena', @ArmoniaExtendidaId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.2. Acorde de und�cima', @ArmoniaExtendidaId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.3. Acordes decimotercera', @ArmoniaExtendidaId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.4. Acordes con sexta agregada', @ArmoniaExtendidaId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.5. Acordes sin tercera (power chords)', @ArmoniaExtendidaId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.6. Acordes cuartales', @ArmoniaExtendidaId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3.7. Poliacordes', @ArmoniaExtendidaId);

-- Insertar subcategor�as de Chord scales
DECLARE @ChordScalesId INT = (SELECT Id FROM MusicalCategories WHERE Name = 'Chord scales');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1. I7 y I6 (j�nico)', @ChordScalesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2. ii7 (d�rico)', @ChordScalesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3. iii7 (frigio)', @ChordScalesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('4. IV7 (lidio)', @ChordScalesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('5. V7 (mixolidio)', @ChordScalesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('6. vi7 (e�lico)', @ChordScalesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('7. vii7(b5) (locrio)', @ChordScalesId);

-- Insertar subcategor�as de Funciones arm�nicas
DECLARE @FuncionesArm�nicasId INT = (SELECT Id FROM MusicalCategories WHERE Name = 'Funciones arm�nicas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1. T�nica', @FuncionesArm�nicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2. Subdominante', @FuncionesArm�nicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3. Dominante', @FuncionesArm�nicasId);

-- Insertar subcategor�as de Cadencias
DECLARE @CadenciasId INT = (SELECT Id FROM MusicalCategories WHERE Name = 'Cadencias');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1. Arm�nicas', @CadenciasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2. Mel�dicas', @CadenciasId);

-- Insertar subcategor�as de Cadencias arm�nicas
DECLARE @CadenciasArm�nicasId INT = (SELECT Id FROM MusicalCategories WHERE Name = '1. Arm�nicas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.1. Conclusivas', @CadenciasArm�nicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.1.1. Aut�ntica perfecta', (SELECT Id FROM MusicalCategories WHERE Name = '1.1. Conclusivas'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.1.2. Aut�ntica imperfecta', (SELECT Id FROM MusicalCategories WHERE Name = '1.1. Conclusivas'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.1.3. Plagal', (SELECT Id FROM MusicalCategories WHERE Name = '1.1. Conclusivas'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.1.4. Landini', (SELECT Id FROM MusicalCategories WHERE Name = '1.1. Conclusivas'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.2. Semi-conclusivas', @CadenciasArm�nicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.2.1. Semicadencia aut�ntica', (SELECT Id FROM MusicalCategories WHERE Name = '1.2. Semi-conclusivas'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.2.2. Semicadencia plagal', (SELECT Id FROM MusicalCategories WHERE Name = '1.2. Semi-conclusivas'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.3. Desviaciones cadenciales', @CadenciasArm�nicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.3.1. Aut�ntica deceptiva (rota)', (SELECT Id FROM MusicalCategories WHERE Name = '1.3. Desviaciones cadenciales'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.3.2. Plagal deceptiva', (SELECT Id FROM MusicalCategories WHERE Name = '1.3. Desviaciones cadenciales'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.3.3. Evadida', (SELECT Id FROM MusicalCategories WHERE Name = '1.3. Desviaciones cadenciales'));
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.3.4. Abandonada', (SELECT Id FROM MusicalCategories WHERE Name = '1.3. Desviaciones cadenciales'));

-- Insertar subcategor�as de Cadencias mel�dicas
DECLARE @CadenciasMel�dicasId INT = (SELECT Id FROM MusicalCategories WHERE Name = '2. Mel�dicas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.1. Conclusivas', @CadenciasMel�dicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.2. Semi-conclusivas', @CadenciasMel�dicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.3. No-conclusivas', @CadenciasMel�dicasId);

-- Insertar subcategor�as de Texturas
DECLARE @TexturasId INT = (SELECT Id FROM MusicalCategories WHERE Name = 'Texturas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1. Monof�nica', @TexturasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2. Homof�nica', @TexturasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3. Polif�nica', @TexturasId);

-- Insertar subcategor�as de Disposiciones
DECLARE @DisposicionesId INT = (SELECT Id FROM MusicalCategories WHERE Name = 'Disposiciones');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1. 4 voces', @DisposicionesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2. 5 voces', @DisposicionesId);

-- Insertar subcategor�as de 4 voces
DECLARE @CuatroVocesId INT = (SELECT Id FROM MusicalCategories WHERE Name = '1. 4 voces');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.1. abierta', @CuatroVocesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.2. cerrada', @CuatroVocesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.3. mixta', @CuatroVocesId);

-- Insertar subcategor�as de 5 voces
DECLARE @CincoVocesId INT = (SELECT Id FROM MusicalCategories WHERE Name = '2. 5 voces');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.1. spread voicing', @CincoVocesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.2. close voicing', @CincoVocesId);

-- Insertar subcategor�as de Notas ornamentales
DECLARE @NotasOrnamentalesId INT = (SELECT Id FROM MusicalCategories WHERE Name = 'Notas ornamentales');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1. Notas de paso', @NotasOrnamentalesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2. Bordaduras', @NotasOrnamentalesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3. Anticipaciones', @NotasOrnamentalesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('4. Suspensiones', @NotasOrnamentalesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('5. Retardaciones', @NotasOrnamentalesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('6. Pedal', @NotasOrnamentalesId);

-- Insertar subcategor�as de Movimiento relativo
DECLARE @MovimientoRelativoId INT = (SELECT Id FROM MusicalCategories WHERE Name = 'Movimiento relativo');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1. paralelo', @MovimientoRelativoId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2. directo', @MovimientoRelativoId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3. contrario', @MovimientoRelativoId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('4. Oblicuo', @MovimientoRelativoId);

-- Insertar subcategor�as de Progresiones arm�nicas
DECLARE @ProgresionesArm�nicasId INT = (SELECT Id FROM MusicalCategories WHERE Name = 'Progresiones arm�nicas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1. Arquet�picas', @ProgresionesArm�nicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2. Secuenciales', @ProgresionesArm�nicasId);

-- Insertar subcategor�as de Arquet�picas
DECLARE @ArquetipicasId INT = (SELECT Id FROM MusicalCategories WHERE Name = '1. Arquet�picas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.1. �Two-five� (ii7-V7-I)', @ArquetipicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.2. "Turn around"(iii-vi-ii-V-I)', @ArquetipicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.3. C�rculo de quintas descendentes', @ArquetipicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.4. T-S-D-T (progresi�n aut�ntica)', @ArquetipicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.5. T-D-S-T (progresi�n plagal)', @ArquetipicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.6. �Double plagal� (I-bVII-IV-I)', @ArquetipicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.7. �Best seller� (I-V-vi-IV)', @ArquetipicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.8. i-bVII-bVI-bVII-i', @ArquetipicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.9. bVI-bVII-i', @ArquetipicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.10. 12-bar blues', @ArquetipicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.11. Prolongacional interpolado (EPM)', @ArquetipicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.12. Ciclos octat�nicos', @ArquetipicasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1.13. Ciclos hexat�nicos', @ArquetipicasId);

-- Insertar subcategor�as de Secuenciales
DECLARE @SecuencialesId INT = (SELECT Id FROM MusicalCategories WHERE Name = '2. Secuenciales');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.1. De quintas', @SecuencialesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.2. De segundas', @SecuencialesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.3. De terceras', @SecuencialesId);

-- Insertar subcategor�as de De quintas
DECLARE @DeQuintasId INT = (SELECT Id FROM MusicalCategories WHERE Name = '2.1. De quintas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.1.1. Ascendentes', @DeQuintasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.1.2. Descendentes', @DeQuintasId);

-- Insertar subcategor�as de De segundas
DECLARE @DeSegundasId INT = (SELECT Id FROM MusicalCategories WHERE Name = '2.2. De segundas');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.2.1. Ascendentes', @DeSegundasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.2.2. Descendentes', @DeSegundasId);

-- Insertar subcategor�as de De terceras
DECLARE @DeTercerasId INT = (SELECT Id FROM MusicalCategories WHERE Name = '2.3. De terceras');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.3.1. Ascendentes', @DeTercerasId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2.3.2. Descendentes', @DeTercerasId);

-- Insertar subcategor�as de Modulaci�n
DECLARE @ModulacionId INT = (SELECT Id FROM MusicalCategories WHERE Name = 'Modulaci�n');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1. Diat�nica (acorde com�n)', @ModulacionId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2. Crom�tica', @ModulacionId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3. Enarm�nica', @ModulacionId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('4. Directa', @ModulacionId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('5. Secuencial', @ModulacionId);
-- Insertar subcategor�as de Transformaciones Neo-riemannianas
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

-- Insertar subcategor�as de Conducci�n de voces tradicional
DECLARE @ConduccionVocesId INT = (SELECT Id FROM MusicalCategories WHERE Name = 'Conducci�n de voces tradicional');
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('1. Enlaces sin movimiento paralelo entre consonancias perfectas (i.e., 5tas y 8vas paralelas y antiparalelas)', @ConduccionVocesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('2. Enlaces sin movimiento directo hacia consonancias perfectas (i.e., 5tas y 8vas ocultas)', @ConduccionVocesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('3. Enlaces sin movimiento paralelo entre 5tas de distintas calidad (i.e. 5tas desiguales)', @ConduccionVocesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('4. Enlaces con tratamiento regular e irregular de la sensible', @ConduccionVocesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('5. Tratamiento regular de la disonancia', @ConduccionVocesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('6. Resoluci�n irregular de la disonancia (diferida e indirecta)', @ConduccionVocesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('7. Enlaces con y sin cruzamiento de voces', @ConduccionVocesId);
INSERT INTO MusicalCategories (Name, ParentId) VALUES ('8. Conducci�n arm�nica paralela (planning)', @ConduccionVocesId);

-- TENGO QUE AGREGAR LOS HANDLERS Y CONTROLLERS QUE ME RETORNEN LAS TUPLAS CON LOS IDS