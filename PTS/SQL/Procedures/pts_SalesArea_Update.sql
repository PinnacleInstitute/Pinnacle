EXEC [dbo].pts_CheckProc 'pts_SalesArea_Update'
 GO

CREATE PROCEDURE [dbo].pts_SalesArea_Update ( 
   @SalesAreaID int,
   @ParentID int,
   @MemberID int,
   @SalesAreaName varchar (40),
   @Status int,
   @StatusDate datetime,
   @Level int,
   @Density int,
   @Population int,
   @FTE money,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE sla
SET sla.ParentID = @ParentID ,
   sla.MemberID = @MemberID ,
   sla.SalesAreaName = @SalesAreaName ,
   sla.Status = @Status ,
   sla.StatusDate = @StatusDate ,
   sla.Level = @Level ,
   sla.Density = @Density ,
   sla.Population = @Population ,
   sla.FTE = @FTE
FROM SalesArea AS sla
WHERE sla.SalesAreaID = @SalesAreaID

GO