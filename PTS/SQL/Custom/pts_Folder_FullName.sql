EXEC [dbo].pts_CheckProc 'pts_Folder_FullName'
GO
--DECLARE @Result varchar(1000) EXEC pts_Folder_FullName 6, @Result output print @Result
CREATE PROCEDURE [dbo].pts_Folder_FullName
   @FolderID int ,
   @Result nvarchar (1000) OUTPUT
AS

SET NOCOUNT ON

SELECT   @Result = CASE 
         WHEN f2.FolderID IS NULL THEN f1.FolderName
         WHEN f3.FolderID IS NULL THEN f2.FolderName+' / '+f1.FolderName
         WHEN f4.FolderID IS NULL THEN f3.FolderName+' / '+f2.FolderName+' / '+f1.FolderName
         ELSE f4.FolderName+' / '+f3.FolderName+' / '+f2.FolderName+' / '+f1.FolderName
         END 
FROM Folder AS f1 (NOLOCK)
LEFT OUTER JOIN Folder AS f2 ON f1.ParentID = f2.FolderID
LEFT OUTER JOIN Folder AS f3 ON f2.ParentID = f3.FolderID
LEFT OUTER JOIN Folder AS f4 ON f3.ParentID = f4.FolderID
WHERE f1.FolderID = @FolderID
 
GO