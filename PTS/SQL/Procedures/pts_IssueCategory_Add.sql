EXEC [dbo].pts_CheckProc 'pts_IssueCategory_Add'
 GO

CREATE PROCEDURE [dbo].pts_IssueCategory_Add ( 
   @IssueCategoryID int OUTPUT,
   @CompanyID int,
   @IssueCategoryName nvarchar (40),
   @Seq int,
   @UserType int,
   @AssignedTo nvarchar (15),
   @InputOptions nvarchar (1000),
   @Email nvarchar (100),
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()

IF @Seq=0
BEGIN
   SELECT @Seq = ISNULL(MAX(Seq),0)
   FROM IssueCategory (NOLOCK)
   SET @Seq = @Seq + 10
END

INSERT INTO IssueCategory (
            CompanyID , 
            IssueCategoryName , 
            Seq , 
            UserType , 
            AssignedTo , 
            InputOptions , 
            Email
            )
VALUES (
            @CompanyID ,
            @IssueCategoryName ,
            @Seq ,
            @UserType ,
            @AssignedTo ,
            @InputOptions ,
            @Email            )

SET @mNewID = @@IDENTITY

SET @IssueCategoryID = @mNewID

GO