EXEC [dbo].pts_CheckProc 'pts_Title_Update'
 GO

CREATE PROCEDURE [dbo].pts_Title_Update ( 
   @TitleID int,
   @CompanyID int,
   @TitleName nvarchar (40),
   @TitleNo int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE ti
SET ti.CompanyID = @CompanyID ,
   ti.TitleName = @TitleName ,
   ti.TitleNo = @TitleNo
FROM Title AS ti
WHERE ti.TitleID = @TitleID

GO