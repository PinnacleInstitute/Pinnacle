EXEC [dbo].pts_CheckProc 'pts_Page_Update'
 GO

CREATE PROCEDURE [dbo].pts_Page_Update ( 
   @PageID int,
   @CompanyID int,
   @MemberID int,
   @PageName nvarchar (60),
   @Category nvarchar (20),
   @PageType int,
   @Status int,
   @Language varchar (6),
   @IsPrivate bit,
   @Form int,
   @Fields varchar (1000),
   @IsShare bit,
   @Subject nvarchar (80),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE pg
SET pg.CompanyID = @CompanyID ,
   pg.MemberID = @MemberID ,
   pg.PageName = @PageName ,
   pg.Category = @Category ,
   pg.PageType = @PageType ,
   pg.Status = @Status ,
   pg.Language = @Language ,
   pg.IsPrivate = @IsPrivate ,
   pg.Form = @Form ,
   pg.Fields = @Fields ,
   pg.IsShare = @IsShare ,
   pg.Subject = @Subject
FROM Page AS pg
WHERE pg.PageID = @PageID

GO