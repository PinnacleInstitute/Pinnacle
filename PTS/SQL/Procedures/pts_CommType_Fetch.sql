EXEC [dbo].pts_CheckProc 'pts_CommType_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_CommType_Fetch ( 
   @CommTypeID int,
   @CompanyID int OUTPUT,
   @CommTypeName nvarchar (40) OUTPUT,
   @CommTypeNo int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = ct.CompanyID ,
   @CommTypeName = ct.CommTypeName ,
   @CommTypeNo = ct.CommTypeNo
FROM CommType AS ct (NOLOCK)
WHERE ct.CommTypeID = @CommTypeID

GO