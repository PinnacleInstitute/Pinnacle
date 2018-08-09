EXEC [dbo].pts_CheckProc 'pts_Title_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Title_Fetch ( 
   @TitleID int,
   @CompanyID int OUTPUT,
   @TitleName nvarchar (40) OUTPUT,
   @TitleNo int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = ti.CompanyID ,
   @TitleName = ti.TitleName ,
   @TitleNo = ti.TitleNo
FROM Title AS ti (NOLOCK)
WHERE ti.TitleID = @TitleID

GO