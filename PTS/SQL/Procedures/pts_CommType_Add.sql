EXEC [dbo].pts_CheckProc 'pts_CommType_Add'
 GO

CREATE PROCEDURE [dbo].pts_CommType_Add ( 
   @CommTypeID int OUTPUT,
   @CompanyID int,
   @CommTypeName nvarchar (40),
   @CommTypeNo int,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO CommType (
            CompanyID , 
            CommTypeName , 
            CommTypeNo
            )
VALUES (
            @CompanyID ,
            @CommTypeName ,
            @CommTypeNo            )

SET @mNewID = @@IDENTITY

SET @CommTypeID = @mNewID

GO