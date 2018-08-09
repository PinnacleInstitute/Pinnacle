EXEC [dbo].pts_CheckProc 'pts_Contest_Update'
 GO

CREATE PROCEDURE [dbo].pts_Contest_Update ( 
   @ContestID int,
   @CompanyID int,
   @MemberID int,
   @ContestName nvarchar (40),
   @Description nvarchar (1000),
   @Status int,
   @Metric int,
   @StartDate datetime,
   @EndDate datetime,
   @IsPrivate bit,
   @Custom1 int,
   @Custom2 int,
   @Custom3 int,
   @Custom4 int,
   @Custom5 int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE con
SET con.CompanyID = @CompanyID ,
   con.MemberID = @MemberID ,
   con.ContestName = @ContestName ,
   con.Description = @Description ,
   con.Status = @Status ,
   con.Metric = @Metric ,
   con.StartDate = @StartDate ,
   con.EndDate = @EndDate ,
   con.IsPrivate = @IsPrivate ,
   con.Custom1 = @Custom1 ,
   con.Custom2 = @Custom2 ,
   con.Custom3 = @Custom3 ,
   con.Custom4 = @Custom4 ,
   con.Custom5 = @Custom5
FROM Contest AS con
WHERE con.ContestID = @ContestID

GO