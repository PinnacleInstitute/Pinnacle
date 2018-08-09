EXEC [dbo].pts_CheckProc 'pts_Title_Add'
 GO

CREATE PROCEDURE [dbo].pts_Title_Add ( 
   @TitleID int OUTPUT,
   @CompanyID int,
   @TitleName nvarchar (40),
   @TitleNo int,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Title (
            CompanyID , 
            TitleName , 
            TitleNo
            )
VALUES (
            @CompanyID ,
            @TitleName ,
            @TitleNo            )

SET @mNewID = @@IDENTITY

SET @TitleID = @mNewID

GO