EXEC [dbo].pts_CheckProc 'pts_Contest_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Contest_Fetch ( 
   @ContestID int,
   @CompanyID int OUTPUT,
   @MemberID int OUTPUT,
   @ContestName nvarchar (40) OUTPUT,
   @Description nvarchar (1000) OUTPUT,
   @Status int OUTPUT,
   @Metric int OUTPUT,
   @StartDate datetime OUTPUT,
   @EndDate datetime OUTPUT,
   @IsPrivate bit OUTPUT,
   @Custom1 int OUTPUT,
   @Custom2 int OUTPUT,
   @Custom3 int OUTPUT,
   @Custom4 int OUTPUT,
   @Custom5 int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = con.CompanyID ,
   @MemberID = con.MemberID ,
   @ContestName = con.ContestName ,
   @Description = con.Description ,
   @Status = con.Status ,
   @Metric = con.Metric ,
   @StartDate = con.StartDate ,
   @EndDate = con.EndDate ,
   @IsPrivate = con.IsPrivate ,
   @Custom1 = con.Custom1 ,
   @Custom2 = con.Custom2 ,
   @Custom3 = con.Custom3 ,
   @Custom4 = con.Custom4 ,
   @Custom5 = con.Custom5
FROM Contest AS con (NOLOCK)
WHERE con.ContestID = @ContestID

GO