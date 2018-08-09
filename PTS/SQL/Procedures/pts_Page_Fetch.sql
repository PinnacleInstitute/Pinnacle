EXEC [dbo].pts_CheckProc 'pts_Page_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Page_Fetch ( 
   @PageID int,
   @CompanyID int OUTPUT,
   @MemberID int OUTPUT,
   @PageName nvarchar (60) OUTPUT,
   @Category nvarchar (20) OUTPUT,
   @PageType int OUTPUT,
   @Status int OUTPUT,
   @Language varchar (6) OUTPUT,
   @IsPrivate bit OUTPUT,
   @Form int OUTPUT,
   @Fields varchar (1000) OUTPUT,
   @IsShare bit OUTPUT,
   @Subject nvarchar (80) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = pg.CompanyID ,
   @MemberID = pg.MemberID ,
   @PageName = pg.PageName ,
   @Category = pg.Category ,
   @PageType = pg.PageType ,
   @Status = pg.Status ,
   @Language = pg.Language ,
   @IsPrivate = pg.IsPrivate ,
   @Form = pg.Form ,
   @Fields = pg.Fields ,
   @IsShare = pg.IsShare ,
   @Subject = pg.Subject
FROM Page AS pg (NOLOCK)
WHERE pg.PageID = @PageID

GO