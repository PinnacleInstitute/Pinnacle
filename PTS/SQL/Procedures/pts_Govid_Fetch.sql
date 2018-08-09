EXEC [dbo].pts_CheckProc 'pts_Govid_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Govid_Fetch ( 
   @GovidID int,
   @MemberID int OUTPUT,
   @CountryID int OUTPUT,
   @GType int OUTPUT,
   @GNumber nvarchar (50) OUTPUT,
   @Issuer varchar (2) OUTPUT,
   @IssueDate datetime OUTPUT,
   @ExpDate datetime OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = gi.MemberID ,
   @CountryID = gi.CountryID ,
   @GType = gi.GType ,
   @GNumber = gi.GNumber ,
   @Issuer = gi.Issuer ,
   @IssueDate = gi.IssueDate ,
   @ExpDate = gi.ExpDate
FROM Govid AS gi (NOLOCK)
WHERE gi.GovidID = @GovidID

GO