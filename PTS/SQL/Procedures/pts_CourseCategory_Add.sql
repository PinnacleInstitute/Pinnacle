EXEC [dbo].pts_CheckProc 'pts_CourseCategory_Add'
 GO

CREATE PROCEDURE [dbo].pts_CourseCategory_Add ( 
   @CourseCategoryID int OUTPUT,
   @ParentCategoryID int,
   @ForumID int,
   @CourseCategoryName nvarchar (60),
   @Seq int,
   @CourseCount int,
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
   FROM CourseCategory (NOLOCK)
   WHERE ParentCategoryID = @ParentCategoryID
   SET @Seq = @Seq + 10
END

INSERT INTO CourseCategory (
            ParentCategoryID , 
            ForumID , 
            CourseCategoryName , 
            Seq , 
            CourseCount
            )
VALUES (
            @ParentCategoryID ,
            @ForumID ,
            @CourseCategoryName ,
            @Seq ,
            @CourseCount            )

SET @mNewID = @@IDENTITY

SET @CourseCategoryID = @mNewID

GO