WITH CategoryHierarchy AS (
    SELECT Id, Name, ParentId
    FROM MusicalCategories
    WHERE ParentId IS NULL
    UNION ALL
    SELECT mc.Id, mc.Name, mc.ParentId
    FROM MusicalCategories mc
    INNER JOIN CategoryHierarchy ch ON mc.ParentId = ch.Id
)
SELECT * FROM CategoryHierarchy;
