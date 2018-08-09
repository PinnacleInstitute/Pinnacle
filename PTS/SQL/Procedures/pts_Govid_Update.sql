EXEC [dbo].pts_CheckProc 'pts_Govid_Update'
 GO

CREATE PROCEDURE [dbo].pts_Govid_Update ( 
   @GovidID int,
   @MemberID int,
   @CountryID int,
   @GType int,
   @GNumber nvarchar (50),
   @Issuer varchar (2),
   @IssueDate datetime,
   @ExpDate datetime,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE gi
SET gi.MemberID = @MemberID ,
   gi.CountryID = @CountryID ,
   gi.GType = @GType ,
   gi.GNumber = @GNumber ,
   gi.Issuer = @Issuer ,
   gi.IssueDate = @IssueDate ,
   gi.ExpDate = @ExpDate
FROM Govid AS gi
WHERE gi.GovidID = @GovidID

GO