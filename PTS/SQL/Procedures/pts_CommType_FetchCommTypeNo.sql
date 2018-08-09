EXEC [dbo].pts_CheckProc 'pts_CommType_FetchCommTypeNo'
GO

CREATE PROCEDURE [dbo].pts_CommType_FetchCommTypeNo
   @CompanyID int ,
   @CommTypeNo int ,
   @CommTypeID int OUTPUT ,
   @CommTypeName nvarchar (40) OUTPUT
AS

SET NOCOUNT ON

SELECT      @CommTypeID = ct.CommTypeID, 
         @CommTypeName = ct.CommTypeName
FROM CommType AS ct (NOLOCK)
WHERE (ct.CompanyID = @CompanyID)
 AND (ct.CommTypeNo = @CommTypeNo)


GO