EXEC [dbo].pts_CheckProc 'pts_Page_Add'
 GO

CREATE PROCEDURE [dbo].pts_Page_Add ( 
   @PageID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Page (
            CompanyID , 
            MemberID , 
            PageName , 
            Category , 
            PageType , 
            Status , 
            Language , 
            IsPrivate , 
            Form , 
            Fields , 
            IsShare , 
            Subject
            )
VALUES (
            @CompanyID ,
            @MemberID ,
            @PageName ,
            @Category ,
            @PageType ,
            @Status ,
            @Language ,
            @IsPrivate ,
            @Form ,
            @Fields ,
            @IsShare ,
            @Subject            )

SET @mNewID = @@IDENTITY

SET @PageID = @mNewID

GO