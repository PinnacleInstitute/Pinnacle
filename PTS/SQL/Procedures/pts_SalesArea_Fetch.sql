EXEC [dbo].pts_CheckProc 'pts_SalesArea_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_SalesArea_Fetch ( 
   @SalesAreaID int,
   @ParentID int OUTPUT,
   @MemberID int OUTPUT,
   @NameLast nvarchar (30) OUTPUT,
   @NameFirst nvarchar (30) OUTPUT,
   @MemberName nvarchar (61) OUTPUT,
   @SalesAreaName varchar (40) OUTPUT,
   @Status int OUTPUT,
   @StatusDate datetime OUTPUT,
   @Level int OUTPUT,
   @Density int OUTPUT,
   @Population int OUTPUT,
   @FTE money OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @ParentID = sla.ParentID ,
   @MemberID = sla.MemberID ,
   @NameLast = me.NameLast ,
   @NameFirst = me.NameFirst ,
   @MemberName = LTRIM(RTRIM(me.NameFirst)) +  ' '  + LTRIM(RTRIM(me.NameLast)) ,
   @SalesAreaName = sla.SalesAreaName ,
   @Status = sla.Status ,
   @StatusDate = sla.StatusDate ,
   @Level = sla.Level ,
   @Density = sla.Density ,
   @Population = sla.Population ,
   @FTE = sla.FTE
FROM SalesArea AS sla (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (sla.MemberID = me.MemberID)
WHERE sla.SalesAreaID = @SalesAreaID

GO