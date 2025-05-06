-- database: your_database_name;

WITH linking AS (
    SELECT 
        d.ProductID,
        ProductNumber,
        d.ProductName,
        d.Prod_Status,
        c.ComponentNumber,
        c.ComponentName,
        b.PartNumber,
        b.SupplierPartNumber,
        b.PartName,
        b.Part_Status,
        s.SupplierNumber,
        s.SupplierName,
        s.Archived
    FROM --insertlinkingtable a
    LEFT JOIN tblPart b ON a.PartID = b.PartID
    LEFT JOIN tblComponent c ON a.ComponentID = c.ComponentID
    LEFT JOIN tblProduct d ON a.ProductID = d.ProductID
    FULL OUTER JOIN Supplier s ON b.SupplierID = s.SupplierID
    WHERE b.Part_Status = 1
)

SELECT 
    p.ProductID,
    p.Name AS ProductName,
    p.ProductNumber,
    p.Prod_Status,
    l.ComponentNumber,
    l.ComponentName,
    l.PartNumber,
    l.SupplierPartNumber,
    l.PartName,
    l.Part_Status,
    l.SupplierName,
    l.SupplierNumber,
    l.Archived
FROM tblProduct p
LEFT JOIN linking l ON p.ProductID = l.ProductID

-- Optional: filter for specific products loaded in a temporary table
-- WHERE p.ProductNumber IN (SELECT [Product Number] FROM ##ProductList)

ORDER BY p.ProductID;
