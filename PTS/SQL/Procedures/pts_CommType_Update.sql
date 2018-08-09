EXEC [dbo].pts_CheckProc 'pts_CommType_Update'
 GO

CREATE PROCEDURE [dbo].pts_CommType_Update ( 
   @CommTypeID int,
   @CompanyID int,
   @CommTypeName nvarchar (40),
   @CommTypeNo int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE ct
SET ct.CompanyID = @CompanyID ,
   ct.CommTypeName = @CommTypeName ,
   ct.CommTypeNo = @CommTypeNo
FROM CommType AS ct
WHERE ct.CommTypeID = @CommTypeID

GO