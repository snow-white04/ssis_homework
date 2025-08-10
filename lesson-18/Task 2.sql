-- TASK 2



SELECT  
    grantee.name AS grantee_name,
    dp.state_desc,                
    dp.permission_name,         
    dp.class_desc,              
    OBJECT_SCHEMA_NAME(dp.major_id) AS schema_name,
    OBJECT_NAME(dp.major_id) AS object_name,
    grantor.name AS grantor_name
FROM sys.database_permissions AS dp
JOIN sys.database_principals  AS grantee
  ON dp.grantee_principal_id = grantee.principal_id
JOIN sys.database_principals  AS grantor
  ON dp.grantor_principal_id = grantor.principal_id
WHERE dp.class_desc = 'OBJECT_OR_COLUMN'
  AND dp.major_id = OBJECT_ID('dbo.FactSales')
  AND grantee.name = 'report_user1';